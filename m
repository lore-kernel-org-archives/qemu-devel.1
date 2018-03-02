Received: from eggs.gnu.org ([2001:4830:134:3::10]:44059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1ernQ4-0002m5-RL
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1ernQ1-0004zY-4p
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:20:28 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1ernQ0-0004z1-TQ
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 11:20:25 -0500
Received: by mail-wr0-f193.google.com with SMTP id z12so10667678wrg.4
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 08:20:24 -0800 (PST)
Date: Fri, 2 Mar 2018 17:20:21 +0100
From: Sergio Lopez <slp@redhat.com>
Message-ID: <20180302162021.5iyghu5by2qyw6uy@dritchie>
References: <1513690383-27269-1-git-send-email-sochin.jiang@huawei.com>
	<CAJSP0QW1OKnRwwvxvmYaBQ3uLgvU-p9_RQqMLqj7ydwOKyevMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QW1OKnRwwvxvmYaBQ3uLgvU-p9_RQqMLqj7ydwOKyevMw@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: notify guest
 directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "sochin.jiang" <sochin.jiang@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>, Yi Fang <eric.fangyi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Mar 02, 2018 at 01:38:52PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 19, 2017 at 1:33 PM, sochin.jiang <sochin.jiang@huawei.com> wrote:
> >  Till now, we've already notify guest as a batch mostly, an
> >  extra BH won't decrease guest interrupts much, but cause a
> >  significant notification loss. Generally, we could have 15%
> >  or so performance lost in single queue IO models, as I tested.
> 
> Recent performance testing has shown that virtio-blk can underperform
> virtio-scsi due to the extra latency added by the BH.
> 
> The virtqueue EVENT_IDX feature mitigates interrupts when the guest
> interrupt handler has not had a chance to run yet.  Therefore, virtio
> already offers one level of interrupt mitigation and the BH adds
> additional latency on top.

FWIW, I'm writing a patch that disables the BH (notifying after each completion
instead) when EVENT_IDX is present. I'll send both the patch and some fio
numbers next week.

Sergio.
