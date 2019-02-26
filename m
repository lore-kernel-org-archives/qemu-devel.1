Received: from eggs.gnu.org ([209.51.188.92]:37448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gyaEA-0001PJ-Jq
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gyaE8-0001NW-5z
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:44:46 -0500
Date: Tue, 26 Feb 2019 07:44:19 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190226104419.GB4925@habkost.net>
References: <1550834773-873512-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<20190225202630.GA4925@habkost.net>
	<CAMRbyysWcfctB8AeSZrQ9x9HRAKut7mWYFqVP=oQ5uVoQgvh0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyysWcfctB8AeSZrQ9x9HRAKut7mWYFqVP=oQ5uVoQgvh0w@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] iotests: handle TypeError
 for Python3 in test 242
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nsoffer@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block <qemu-block@nongnu.org>, philmd@redhat.com, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, den@openvz.org

On Tue, Feb 26, 2019 at 03:42:11AM +0200, Nir Soffer wrote:
> On Mon, Feb 25, 2019 at 10:36 PM Eduardo Habkost <ehabkost@redhat.com>
[...]
> > -        c = f.read(1)
> > -        toggled = chr(ord(c) ^ bitmap_flag_unknown)
> > +        # The casts to bytearray() below are only necessary
> > +        # for Python 2 compatibility
> > +        c = bytearray(f.read(1))[0]
> >
> 
> This is simpler and makes the intent of the code more clear:
> 
>     flag, = struct.unpack("B", f.read(1))
> 
> 
> > +        toggled = c ^ bitmap_flag_unknown
> >          f.seek(-1, 1)
> > -        f.write(toggled)
> > +        f.write(bytearray([toggled]))
> >
> 
> For consistency, we can use struct.pack here:
> 
>     f.write(struct.pack("B", toggled))

That's perfect.  Thanks for the suggestion!

-- 
Eduardo
