Received: from eggs.gnu.org ([2001:4830:134:3::10]:41224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg8U-0005uw-Kq
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg8I-0001DK-3o
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:45:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:42001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJg86-000120-CX
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:45:28 -0500
Received: by mail-ot1-x344.google.com with SMTP id n46so3909321otb.9
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:45:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181017145546.GG31479@localhost.localdomain>
References: <20181016172503.27814-1-peter.maydell@linaro.org>
	<20181017145546.GG31479@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 14:45:02 +0000
Message-ID: <CAFEAcA-0jjvTy_T-bs+d9HHnd4bRV4M5N4SeqNQTFerW4+34sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/vdi: Don't take address of fields in
 packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Weil <sw@weilnetz.de>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On 17 October 2018 at 15:55, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 16.10.2018 um 19:25 hat Peter Maydell geschrieben:
>> Taking the address of a field in a packed struct is a bad idea, because
>> it might not be actually aligned enough for that pointer type (and
>> thus cause a crash on dereference on some host architectures). Newer
>> versions of clang warn about this. Avoid the bug by not using the
>> "modify in place" byte swapping functions.
>>
>> There are a few places where the in-place swap function is
>> used on something other than a packed struct field; we convert
>> those anyway, for consistency.
>>
>> Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.
>>
>> There are other places where we take the address of a packed member
>> in this file for other purposes than passing it to a byteswap
>> function (all the calls to qemu_uuid_*()); we leave those for now.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Thanks, applied to the block branch.

This also hasn't made it into master.

thanks
-- PMM
