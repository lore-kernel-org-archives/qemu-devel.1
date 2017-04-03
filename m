Received: from eggs.gnu.org ([2001:4830:134:3::10]:39325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2DN-0002Ug-Vf
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2DN-0002dA-1O
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:40:14 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:33221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv2DM-0002cu-R1
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:40:12 -0400
Received: by mail-wr0-x235.google.com with SMTP id w43so169568435wrb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 06:40:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170331155933.GG9606@toto>
References: <1490970671-20560-1-git-send-email-peter.maydell@linaro.org>
	<20170331155933.GG9606@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 14:39:51 +0100
Message-ID: <CAFEAcA9Aa0mmfioS-0b8zmfRPQ4jwA2dF3hZVmtwD3bTqM9wFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Avoid unintentional sign
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 31 March 2017 at 16:59, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Fri, Mar 31, 2017 at 03:31:11PM +0100, Peter Maydell wrote:
>> Commit 001ebaca7b11 fixed some unintended sign extension issues
>> spotted by Coverity (CID 1005402, 1005403), but didn't catch
>> all of them. Fix the rest, so we behave consistently whether
>> 'long' is 32 bit or 64 bit.
>
> Thanks!
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>

Applied to master; thanks.

-- PMM
