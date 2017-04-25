Received: from eggs.gnu.org ([2001:4830:134:3::10]:42463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vcg-0006vw-1B
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2vcf-0001RS-6A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:14:58 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2vce-0001R4-Vl
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 04:14:57 -0400
Received: by mail-wr0-x235.google.com with SMTP id w50so80927544wrc.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 01:14:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
References: <C6D1F9E0-0379-4DC5-927A-A32D2281937D@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 09:14:35 +0100
Message-ID: <CAFEAcA8dxiTdoWryTNDi347Cuwf3wULaWCSxJo9FsSaoTPJWHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/9] Add ppc.risu file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 25 April 2017 at 04:17, G 3 <programmingkidx@gmail.com> wrote:
> Add the ppc.risu file. It defines the format for various PowerPC
> instructions.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ppc.risu | 527
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 527 insertions(+)
>  create mode 100644 ppc.risu
>
> diff --git a/ppc.risu b/ppc.risu
> new file mode 100644
> index 0000000..b6d6aee
> --- /dev/null
> +++ b/ppc.risu
> @@ -0,0 +1,527 @@
> +###############################################################################
> +# File: ppc.risu
> +# Date: 3-27-2017
> +# Description: Specifies PowerPC instruction test patterns.
> +###############################################################################

Missing copyright and license statement.

> +
> +.mode ppc
> +
> +# Note: register r1 cannot be used because it is the stack pointer.
> +# The branching, VEA, and OEA instructions cannot be used here currently.
> +
> +ADD PPC 011111 rD:5 rA:5 rB:5 OE:1 100001010 Rc:1 \
> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }
> +
> +ADDC PPC 011111 rD:5 rA:5 rB:5 OE:1 000001010 Rc:1 \
> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }
> +
> +ADDE PPC 011111 rD:5 rA:5 rB:5 OE:1 010001010 Rc:1 \
> +!constraints { $rD != 1 && $rA != 1 && $rB != 1; }


There's an awful lot of duplication with ppc64 here. Is it
worth trying to share?


thanks
-- PMM
