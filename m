Received: from eggs.gnu.org ([2001:4830:134:3::10]:45370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb89B-0001Z2-Kg
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:57:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb89A-0005Jb-RG
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:57:37 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:37343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb89A-0005Im-J8
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 10:57:36 -0500
Received: by mail-wm0-x236.google.com with SMTP id v77so160744149wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 07:57:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
References: <1486454676-29112-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1486454676-29112-3-git-send-email-bharata@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 15:57:14 +0000
Message-ID: <CAFEAcA-hOLokM5KWKrUkT1mu0vH2HnZD_xZxd2E0bdGbr_cjfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/2] softfloat: Add
 float128_to_uint32_round_to_zero()
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
> float128_to_uint32_round_to_zero() is needed by xscvqpuwz instruction
> of PowerPC ISA 3.0.
>
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  fpu/softfloat.c         | 28 ++++++++++++++++++++++++++++
>  include/fpu/softfloat.h |  1 +
>  2 files changed, 29 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
