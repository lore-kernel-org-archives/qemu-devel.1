Received: from eggs.gnu.org ([2001:4830:134:3::10]:51058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHWgp-0006ev-Bh
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cHWgk-0005vw-Dp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:19 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:35525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cHWgk-0005vl-9a
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 09:07:14 -0500
Received: by mail-it0-f54.google.com with SMTP id c20so26314655itb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 06:07:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
References: <b1ac8aec-e9cc-99f8-0881-bef03acc2954@linux.vnet.ibm.com>
	<20161215105257.GD2509@work-vm>
	<b2ad9903-95b4-bf08-f314-c2b250cebb0a@linux.vnet.ibm.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 15 Dec 2016 14:06:12 +0000
Message-ID: <CAJSP0QUcAS4SAN3+gB4BZZkE+eArfwqjNCnTC2H_pTG=h5grFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] commit virtio: recalculate vq->inuse after
 migration might cause last_avail_idx vs. used_idx failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Dec 15, 2016 at 11:32 AM, Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> On 12/15/2016 11:52 AM, Dr. David Alan Gilbert wrote:
>>> We got a bugreport with this log for a live migration target.
>>>
>>> 2016-12-13T18:59:03.647309Z qemu-system-s390x: VQ 1 size 0x100 < last_avail_idx 0x2f76 - used_idx 0x762f
>> Is this actually an endian problem - 2f76 vs 762f ?
>>
>> Dave
>>
>
> Thanks! It seems you are right:

Please still submit the uint16_t -> int conversion fix because what
you discovered is a real bug.

Stefan
