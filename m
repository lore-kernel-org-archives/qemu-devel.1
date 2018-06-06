Received: from eggs.gnu.org ([2001:4830:134:3::10]:35503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQfYT-000297-Db
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQfYS-0006ar-Oq
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 17:01:17 -0400
Date: Wed, 6 Jun 2018 23:01:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180606210102.q7lfarlidgjn4gbl@sirius.home.kraxel.org>
References: <20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606173140-mutt-send-email-mst@kernel.org>
	<60c9b327-6503-0950-0720-3ccbb4637ad4@redhat.com>
	<0de83ab1-070e-f12a-def4-404868d05a80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de83ab1-070e-f12a-def4-404868d05a80@redhat.com>
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>

  Hi,

> our actual qcow2v3 improvements, so no one ended up switching to that. So,
> to some extent, various high-level consumers still have the notion that
> 'raw' files are better/safer/faster than 'qcow2' files because of an
> anecdote from years ago, even if we have since fixed the speed parity and
> added locking to eliminate careless data loss.

When I use raw images the reasons are different ones.  Most of the time
it is that I want use the image with something which isn't qemu and thus
doesn't understand qcow2.  Booting a image as container for example
(systemd-nspawn -i $image.raw).

cheers,
  Gerd
