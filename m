Received: from eggs.gnu.org ([2001:4830:134:3::10]:39992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg4Z-0004Fu-1e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:41:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJg4Y-0005gv-0K
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:41:46 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJg4W-0005dV-K6
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:41:44 -0500
Received: by mail-ot1-x344.google.com with SMTP id q5so8097055otl.13
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 06:41:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181010105515.GA4134@localhost.localdomain>
References: <20181009172501.17353-1-peter.maydell@linaro.org>
	<20181010105515.GA4134@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 14:41:21 +0000
Message-ID: <CAFEAcA-CDyMOfk_O2=9gGk1LyDd6UB8npy68-d3tD5edJ7MNVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] block/qcow*: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>

On 10 October 2018 at 11:55, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 09.10.2018 um 19:24 hat Peter Maydell geschrieben:
>> Taking the address of a field in a packed struct is a bad idea, because
>> it might not be actually aligned enough for that pointer type (and
>> thus cause a crash on dereference on some host architectures). Newer
>> versions of clang warn about this. Avoid the bug by not using the
>> "modify in place" byte swapping functions.
>>
>> There are a few places in the affected files where the in-place swap
>> function is used on something other than a packed struct field; we
>> convert those anyway, for consistency.
>>
>> Patches produced mechanically using spatch; in one case I also
>> did a little hand-editing to wrap overlong lines that checkpatch
>> would otherwise complain about.
>>
>> (clang also complains about other files in block: vdi.c, vpc.c,
>> vhdx.h, vhdx.c, vhdx-endian.c, vhdx-log.c -- I may produce patches
>> for those later if nobody else gets there first.)
>>
>> thanks
>> -- PMM
>>
>> Peter Maydell (3):
>>   block/qcow2: Don't take address of fields in packed structs
>>   block/qcow: Don't take address of fields in packed structs
>>   block/qcow2-bitmap: Don't take address of fields in packed structs
>
> Thanks, applied to the block branch.

Ping? This doesn't seem to have made it into master, unless
I've missed it...

thanks
-- PMM
