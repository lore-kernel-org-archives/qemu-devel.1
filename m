Received: from eggs.gnu.org ([2001:4830:134:3::10]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg7c-0005Rb-Jp
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg7b-0000cr-Tk
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:44:56 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJg7b-0000c5-Ms
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:44:55 -0500
Received: by mail-oi1-x243.google.com with SMTP id i138-v6so4640016oib.1
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:44:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181017143643.GF31479@localhost.localdomain>
References: <20181016170938.29303-1-peter.maydell@linaro.org>
	<20181017143643.GF31479@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 14:44:34 +0000
Message-ID: <CAFEAcA9uCg3Eq_KoHomoxmscUGWWAR8Mpjy+a=cW9U5ubKT2=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] block/vhdx: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Jeff Cody <codyprime@gmail.com>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On 17 October 2018 at 15:36, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 16.10.2018 um 19:09 hat Peter Maydell geschrieben:
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
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Usual disclaimer: produced with "make check" only, but purely
>> automated conversion should be safe.
>
> More relevant, qemu-iotests for vhdx passes, too. I don't think "make
> check" would run any of the modified code.
>
> Thanks, applied to the block branch

Ping? This doesn't seem to have reached master.

thanks
-- PMM
