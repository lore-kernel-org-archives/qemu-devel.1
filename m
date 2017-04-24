Received: from eggs.gnu.org ([2001:4830:134:3::10]:51378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2dMW-0005pg-CT
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d2dMS-00089q-LW
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:45:04 -0400
MIME-Version: 1.0
In-Reply-To: <20170424123659.GI14416@lemon.lan>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
	<20170417034925.GC6717@lemon.lan>
	<CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
	<CAOGPPbc44H-oaY2Smm5kgNNbaP44C3rksi9_=0ocAXAnGdWdCg@mail.gmail.com>
	<CAOGPPbfx_FoOwHMa96w_EioAApDs08_=saFRGr-5XdOrj60HNw@mail.gmail.com>
	<20170424120906.GG14416@lemon.lan> <20170424121933.GH14416@lemon.lan>
	<CAOGPPbfQBy0szAxDeynehtPkXUUjdpgQpfb155XtUdF07UCGxQ@mail.gmail.com>
	<20170424123659.GI14416@lemon.lan>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Mon, 24 Apr 2017 20:44:57 +0800
Message-ID: <CAOGPPbdF-4NJerVk1-BobnbAgZeDms7QtoROU18fWOQ-5Wp01g@mail.gmail.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, Apr 24, 2017 at 8:36 PM, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 04/24 20:26, 858585 jemmy wrote:
>> > 2) qcow2 with cluster_size = 512 is probably too uncommon to be optimized for.
>> if culster_size is very small, should disable metadata check default?
>>
>
> No, I don't think it's worth the inconsistent behavior. People who want
> performance shouldn't use 512 bytes anyway.
ok,thanks.

>
> Fam
