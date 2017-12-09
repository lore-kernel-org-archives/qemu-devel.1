Received: from eggs.gnu.org ([2001:4830:134:3::10]:38520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eNTdB-0004yO-Dk
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eNTdA-0000bt-FH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 20:08:41 -0500
Date: Fri, 8 Dec 2017 23:08:33 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171209010833.GK3037@localhost.localdomain>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
	<1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/arm/virt: Check that the CPU
 realize method succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, "Richard W . M . Jones" <rjones@redhat.com>

On Thu, Dec 07, 2017 at 06:14:48PM +0000, Peter Maydell wrote:
> We were passing a NULL error pointer to the object_property_set_bool()
> call that realizes the CPU object. This meant that we wouldn't detect
> failure, and would plough blindly on to crash later trying to use a
> NULL CPU object pointer. Detect errors and fail instead.
> 
> In particular, this will be necessary to detect the user error
> of using "-cpu host" without "-enable-kvm" once we make the host
> CPU type be registered unconditionally rather than only in
> kvm_arch_init().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
