Received: from eggs.gnu.org ([2001:4830:134:3::10]:57845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eUJXO-0000go-E0
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eUJXL-0004hk-5W
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:46:58 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:44523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1eUJXK-0004gW-OB
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:46:54 -0500
Received: by mail-it0-x243.google.com with SMTP id b5so26382167itc.3
	for <qemu-devel@nongnu.org>; Wed, 27 Dec 2017 13:46:54 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
In-Reply-To: <20171222092308.GF30605@redhat.com>
References: <CACaajQsL3e+XWR0hBDLThmG_fd=ih-n+HJVz++XcnwLhhVstgg@mail.gmail.com>
	<56c5bcbb-02c0-a3f7-4363-e3141476b2f8@redhat.com>
	<20171222092308.GF30605@redhat.com>
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Thu, 28 Dec 2017 00:46:33 +0300
Message-ID: <CACaajQsUQao1AVfvORQ-3h4nNF-AzkomsimigdcN+WTiHiitkQ@mail.gmail.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

2017-12-22 12:23 GMT+03:00 Daniel P. Berrange <berrange@redhat.com>:
> On Thu, Dec 21, 2017 at 05:58:47PM -0500, John Snow wrote:
>>
>>
>> On 12/21/2017 05:13 PM, Vasiliy Tolstov wrote:
>> > Hi! Today my server have forced reboot and one of my vm can't start
>> > with message:
>> > qcow2: Marking image as corrupt: L2 table offset 0x3f786d6c207600
>> > unaligned (L1 index: 0); further corruption events will be suppressed
>> >
>> > i'm use debian jessie with hand builded qemu 2.9.0, i'm try to
>> > qemu-img check but it not helps. How can i recover data inside qcow2
>> > file? (i'm not use compression or encryption inside it).
>> >
>>
>> Not looking good if you're missing the very first L2 table in its entirety.
>>
>> You might be able to go through this thing by hand and learn for
>> yourself where the L2 table is (it will be a 64KiB region, aligned to a
>> 64KiB boundary, that all contain 64bit, 64KiB aligned pointers that will
>> be less than the size of the file. the offset of this missing region is
>> not likely to be referenced elsewhere in your file.)

Too hard, client restored backup because he don't want to wait for me =))

>
> Fun. That rather makes you wish that every single distinct type of table
> in QCow2 files had a unique UUID value stored in it, to make forensics
> like this easier :-)
>

=)

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
