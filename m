Received: from eggs.gnu.org ([2001:4830:134:3::10]:40561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eFGDK-0000xC-Gr
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1eFGDF-0001Nf-Mc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:12:02 -0500
Received: from mail-it0-x231.google.com ([2607:f8b0:4001:c0b::231]:40375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1eFGDF-0001K6-Dc
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:11:57 -0500
Received: by mail-it0-x231.google.com with SMTP id 72so5109607itl.5
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 01:11:57 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
In-Reply-To: <20171116082729.GE14771@lemon>
References: <CACaajQsXUMwo-bLF4q+pRjjUDn=Eo9xQ=SB9ucDX8cuP9VQzNQ@mail.gmail.com>
	<20171116082729.GE14771@lemon>
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Thu, 16 Nov 2017 12:11:36 +0300
Message-ID: <CACaajQtWYfpGHwBR4Rk5QNM1bmq0OHn=jYwPQr9x3w291dssXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] sheepdog block driver and read write error policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

2017-11-16 11:27 GMT+03:00 Fam Zheng <famz@redhat.com>:
> On Thu, 11/16 11:11, Vasiliy Tolstov wrote:
>> Hi. I'm try to write own sheepdog compatible daemon and test it with qemu.
>> Sometimes ago in qemu added read write error policy to allow to stop
>> domain or continue or something else. As i see in case of sheepdog
>> this policy is ignored and qemu try to reconnect to sheepdog daemon.
>> If nobody wants i can try to fix this, and if policy is not specified
>> work like now.
>> Where i need to start to easy understand how this works in case of file raw ?
>
> The driver callbacks (sd_co_readv/sd_co_writev) should simply return error
> instead of retrying.
>


Thanks,  how can i pass options to block driver? (as i understand
read/write policy affects concrete hardware - scsi/ide and need to be
passed down to lower level)

Also about sheepdog driver, i'm re-read discussion
https://patchwork.ozlabs.org/patch/501533/ and have a question - if
all logic about overlapping requests and oids calculation go from qemu
to sheepdog daemon,
does this be slowdown or not in case of iops? (I think that if qemu
driver only read/write/discard some block data it can be more simplify
and have less errors, and sheepdog daemon can handle internally all
overlapping and inode updates)
I'm understand that this may be completely new sheepdog qemu driver,
but i think that if sheepdog driver is more like nbd/rbd it can be
more simple...


-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
