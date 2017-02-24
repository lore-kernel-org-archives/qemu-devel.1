Received: from eggs.gnu.org ([2001:4830:134:3::10]:41193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chILb-0001Ue-QH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chILa-0002ia-Qy
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:03:55 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:36526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chILa-0002iQ-KJ
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:03:54 -0500
Received: by mail-wm0-x235.google.com with SMTP id v77so17888600wmv.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 08:03:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486976352-549-2-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1486976352-549-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1486976352-549-2-git-send-email-nikunj@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 16:03:33 +0000
Message-ID: <CAFEAcA8X873FLQxF_n_KZ-jc0hrKcqAj_tjNm6SO0hpPxbF75w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 2/2] risu_ppc64le: distinguish real illegal
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, "bharata@linux.vnet.ibm.com" <bharata@linux.vnet.ibm.com>

On 13 February 2017 at 08:59, Nikunj A Dadhania
<nikunj@linux.vnet.ibm.com> wrote:
> While executing qemu_ppc64le, found an issue that the real illegal
> instructions are handled as risu_op which results in wrong info at the
> master end. Even the master needs to distinguish real illegal
> instructions versus risu_op.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

No, this is deliberate. Otherwise you can't test illegal
instructions. What should happen is that both master and
apprentice ends end up in the default case, which does
a register info compare and continues having stepped the
PC past the illegal insn.

(If only one end thinks the insn is illegal then there will
be a register mismatch on the PC.)

thanks
-- PMM
