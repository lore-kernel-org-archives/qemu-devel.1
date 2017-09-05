Received: from eggs.gnu.org ([2001:4830:134:3::10]:39338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpDU6-0000na-JY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpDU1-0008Cj-Vd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 09:01:42 -0400
Date: Tue, 5 Sep 2017 15:01:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170905130107.GJ4633@localhost.localdomain>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
	<20170828025706.GA18194@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828025706.GA18194@lemon.lan>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

Am 28.08.2017 um 04:57 hat Fam Zheng geschrieben:
> On Fri, 08/25 15:44, Max Reitz wrote:
> > Well, OK.  The main argument against supporting anything but qcow2 is
> > "if you want features, use qcow2; and we are working on making qcow2 as
> > fast as possible."  I think that's a very good argument still.  At some
> > point I (and probably others, too) had the idea of making qcow2 files in
> > raw layout: 
> 
> Yes! I think this idea makes a whole lot of sense, too. Metadata tables can be
> generated so old implementation can still use it.

Maybe a nice way to attack this would be "huge pages", i.e. have a L1
entry flag that tells "this points directly to a huge cluster instead of
an L2 table". Gives us 512 MB clusters with a 64k cluster size, or a
maximum of 512 GB clusters with a 2 MB cluster size.

Huge clusters would only be used by qemu-img create if the respective
option is given, and only with preallocation.

Kevin
