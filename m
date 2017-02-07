Received: from eggs.gnu.org ([2001:4830:134:3::10]:47629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8He-0001ps-V8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb8Hd-0002SU-SG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:06:22 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb8Hd-0002Rz-Lb
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 11:06:21 -0500
Received: by mail-wm0-x22c.google.com with SMTP id r141so158100231wmg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 08:06:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486454676-29112-2-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1486454676-29112-2-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 16:05:58 +0000
Message-ID: <CAFEAcA-MErKH5N+9dWrKsJUEQBkcuhUnAnY6ycCK23cSf5RR5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v1 1/2] softfloat: Add
 float128_to_uint64_round_to_zero()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 7 February 2017 at 08:04, Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
> Implement float128_to_uint64() and use that to implement
> float128_to_uint64_round_to_zero()
>
> This is required by xscvqpudz instruction of PowerPC ISA 3.0.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
