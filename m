Received: from eggs.gnu.org ([2001:4830:134:3::10]:58906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eUJYJ-0001GG-NF
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:47:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eUJYI-0005jP-TI
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:47:55 -0500
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:46764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1eUJYI-0005ir-L6
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:47:54 -0500
Received: by mail-io0-x22d.google.com with SMTP id x129so36561160iod.13
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 13:47:54 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
In-Reply-To: <56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
References: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
	<56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Thu, 28 Dec 2017 00:47:33 +0300
Message-ID: <CACaajQvYee3-=859D8t-QLiYdTE8SL-M5zztP4QsjRm5xCnvBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu 2.9.0 qcow2 file failed to open after hard
 server reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

2017-12-22 1:58 GMT+03:00 John Snow <jsnow@redhat.com>:
>
>
> On 12/21/2017 05:13 PM, Vasiliy Tolstov wrote:
>> Hi! Today my server have forced reboot and one of my vm can't start
>> with message:
>> qcow2: Marking image as corrupt: L2 table offset 0x3f786d6c207600
>> unaligned (L1 index: 0); further corruption events will be suppressed
>>
>> i'm use debian jessie with hand builded qemu 2.9.0, i'm try to
>> qemu-img check but it not helps. How can i recover data inside qcow2
>> file? (i'm not use compression or encryption inside it).
>>
>
> Not looking good if you're missing the very first L2 table in its entirety.
>
> You might be able to go through this thing by hand and learn for
> yourself where the L2 table is (it will be a 64KiB region, aligned to a
> 64KiB boundary, that all contain 64bit, 64KiB aligned pointers that will
> be less than the size of the file. the offset of this missing region is
> not likely to be referenced elsewhere in your file.)
>
> and then, once you've found it, you can update the pointer that's wrong.
> However, where there's smoke there's often fire, so...
>
> best of luck.
>
> --js

If i use raw image as i understand this corruption can't happening in raw?

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
