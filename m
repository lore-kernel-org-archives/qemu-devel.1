Received: from eggs.gnu.org ([2001:4830:134:3::10]:49315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmAEq-0002sK-Kz
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 22:57:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dmAEp-0007E1-Vs
	for qemu-devel@nongnu.org; Sun, 27 Aug 2017 22:57:20 -0400
Date: Mon, 28 Aug 2017 10:57:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170828025706.GA18194@lemon.lan>
References: <f5ef1341-cfe2-6e20-3f98-b08ef2f7d373@redhat.com>
	<a81c8dfb-3d98-57ad-8159-5147283433fa@virtuozzo.com>
	<cb783ebb-198e-1814-2f9c-aec93c83b17a@virtuozzo.com>
	<0988b4ef-56e2-5ce9-ed25-40a742eadbd4@redhat.com>
	<b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d72a26-2052-ecc6-67f5-d32572804ebf@redhat.com>
Subject: Re: [Qemu-devel] Persistent bitmaps for non-qcow2 formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>

On Fri, 08/25 15:44, Max Reitz wrote:
> Well, OK.  The main argument against supporting anything but qcow2 is
> "if you want features, use qcow2; and we are working on making qcow2 as
> fast as possible."  I think that's a very good argument still.  At some
> point I (and probably others, too) had the idea of making qcow2 files in
> raw layout: 


Yes! I think this idea makes a whole lot of sense, too. Metadata tables can be
generated so old implementation can still use it.

Fam

> Have the data as a blob, just like a raw file, padded by
> metadata around it.  An autoclear flag would specify that the qcow2 file
> is in this format, and if so, you could simply access it like a raw file
> and should have exactly the same speed as a raw file.  Maybe that would
> solve this whole issue, too?
