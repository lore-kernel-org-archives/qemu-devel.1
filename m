Received: from eggs.gnu.org ([2001:4830:134:3::10]:42850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2cyA-00009l-AS
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2cy9-000899-FW
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:19:54 -0400
Date: Mon, 24 Apr 2017 20:19:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170424121933.GH14416@lemon.lan>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAOGPPbeUkBskJfFX9=Of62pDrt6U-KAjbFZ-r=yVNNeb+ceAuA@mail.gmail.com>
	<20170417034925.GC6717@lemon.lan>
	<CAOGPPbd_Y6m42EpuedngTWfGzt+MDvOwbPSmwp-OG5hVpMNBkA@mail.gmail.com>
	<CAOGPPbc44H-oaY2Smm5kgNNbaP44C3rksi9_=0ocAXAnGdWdCg@mail.gmail.com>
	<CAOGPPbfx_FoOwHMa96w_EioAApDs08_=saFRGr-5XdOrj60HNw@mail.gmail.com>
	<20170424120906.GG14416@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424120906.GG14416@lemon.lan>
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
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Mon, 04/24 20:09, Fam Zheng wrote:
> It's a separate problem.

To be specific:

1) there is an option "overlap-check" that one can use to
disable the costly metadata check;

2) qcow2 with cluster_size = 512 is probably too uncommon to be optimized for.

Both are irrelevant to why and how this patch can be improved, IMO.

Fam
