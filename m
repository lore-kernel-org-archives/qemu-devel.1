Received: from eggs.gnu.org ([2001:4830:134:3::10]:41448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgMF-0005hf-1L
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgMA-0006p9-O7
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:05:07 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgMA-0006ol-IK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:05:02 -0500
Received: by mail-wm0-x235.google.com with SMTP id r141so33789039wmg.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 08:05:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <caaf64ffc72f6ae183015337b7afdbd4b8989cb6.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<caaf64ffc72f6ae183015337b7afdbd4b8989cb6.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 16:04:39 +0000
Message-ID: <CAFEAcA9=BmsakUA_XbBT-FMCJbmFeCrMChQDfCu_fDNoypFdXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 7/7] ARM BE32 watchpoint fix.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:32, Julian Brown <julian@codesourcery.com> wrote:
> In BE32 mode, sub-word size watchpoints can fail to trigger because the
> address of the access is adjusted in the opcode helpers before being
> compared with the watchpoint registers.  This patch reverses the address
> adjustment before performing the comparison with the help of a new CPUClass
> hook.
>
> This version of the patch augments and tidies up comments a little.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
