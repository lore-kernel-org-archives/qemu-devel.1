Received: from eggs.gnu.org ([2001:4830:134:3::10]:54194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxdt-0000wP-E1
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1czxds-000545-NU
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 23:47:57 -0400
Date: Mon, 17 Apr 2017 11:47:44 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170417034744.GB6717@lemon.lan>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
	<20170414060015.GA12191@lemon>
	<CAJSP0QX=qjXpurNkhPbb14hGizj3tjf-E_iZ6ULuyvs=o3vtPQ@mail.gmail.com>
	<CAOGPPbeKhfPg92GZ+rNmZdz6G59HK+pJFTrps7Nc0x1O41oGTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbeKhfPg92GZ+rNmZdz6G59HK+pJFTrps7Nc0x1O41oGTQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v6] migration/block: use
 blk_pwrite_zeroes for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, Dave Gilbert <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Fri, 04/14 14:48, 858585 jemmy wrote:
> >> Effectively, if no cluster is zero, this patch still splits a big write into
> >> small ones, which is the opposition of usual performance optimizations (i.e.
> >> trying to coalesce requests).
> >
> > Good point!
> >
> > Another patch can modify the loop to perform the largest writes
> > possible.  In other words, do not perform the write immediately and
> > keep a cluster counter instead.  When the zero/non-zero state changes,
> > perform the write for the accumulated cluster count.
> 
> if the zero/non-zero state changes very frequently, it will not work.

It will work, but just not improving anything. I think this is a worthwhile
optimzation to do.

Fam
