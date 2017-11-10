Received: from eggs.gnu.org ([2001:4830:134:3::10]:53339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eDFqI-0006Tq-58
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eDFqH-0001Nu-9m
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 15:23:58 -0500
Date: Fri, 10 Nov 2017 18:23:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171110202345.GU3111@localhost.localdomain>
References: <1510343626-25861-1-git-send-email-cota@braap.org>
	<1510343626-25861-2-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510343626-25861-2-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH for 2.11 1/5] qom: move
 CPUClass.tcg_initialize to a global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Nov 10, 2017 at 02:53:42PM -0500, Emilio G. Cota wrote:
> 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
> introduces a per-CPUClass bool that we check so that the target CPU
> is initialized for TCG only once. This works well except when
> we end up creating more than one CPUClass, in which case we end
> up incorrectly initializing TCG more than once, i.e. once for
> each CPUClass.
> 
> This can be replicated with:
>   $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
>       -global driver=xlnx,,zynqmp,property=has_rpu,value=on
> In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
> whereas the "regular" CPUs are prefixed by "cortex-a53-". This
> results in two CPUClass instances being created.
> 
> Fix it by introducing a static variable, so that only the first
> target CPU being initialized will initialize the target-dependent
> part of TCG, regardless of CPUClass instances.
> 
> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
