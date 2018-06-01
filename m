Received: from eggs.gnu.org ([2001:4830:134:3::10]:37621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fOp9P-0003l2-25
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fOp9L-00041n-3Y
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:51:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fOp9K-0003zS-Rw
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 14:51:43 -0400
Date: Fri, 1 Jun 2018 14:51:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180601185139.GA25837@flamenco>
References: <20180313224719.4954-1-pbonzini@redhat.com>
	<20180313224719.4954-51-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180313224719.4954-51-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PULL 50/69] hw/alpha/dp264: Use the
 TYPE_SMC37C669_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>

On Tue, Mar 13, 2018 at 23:47:00 +0100, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Message-Id: <20180308223946.26784-25-f4bug@amsat.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  default-configs/alpha-softmmu.mak |  3 +++
>  hw/alpha/dp264.c                  | 10 ++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)

This commit breaks alpha-softmmu bootup for me. I get no console
output whatsoever -- not even the green "Hello" when invoking
the alpha-softmmu binary with no arguments.

Did anybody else notice this?

Thanks,

		Emilio
