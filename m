Received: from eggs.gnu.org ([2001:4830:134:3::10]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2YbR-0005Hs-3r
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2YbQ-0001Kg-9e
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 03:40:09 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
	<20170417034925.GC6717@lemon.lan>
	<CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 24 Apr 2017 15:40:05 +0800
Message-ID: <CAOGPPbc44H-oaY2Smm5kgNNbaP44C3rksi9_=0ocAXAnGdWdCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 17, 2017 at 12:00 PM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Mon, Apr 17, 2017 at 11:49 AM, Fam Zheng <famz@redhat.com> wrote:
>> On Fri, 04/14 14:30, 858585 jemmy wrote:
>>> Do you know some other format which have very small cluster size?
>>
>> 64k is the default cluster size for qcow2 but it can be configured at image
>> creation time, as 512 bytes, for example:
>>
>>     $ qemu-img create -f qcow2 test.qcow2 -o cluster_size=512 1G
>
> Thanks, i will test the performance again.

I find the performance reduce when cluster size is 512.
I will optimize the performance and submit a patch later.
Thanks.

>>
>> Fam
