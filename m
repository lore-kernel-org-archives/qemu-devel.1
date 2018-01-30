Received: from eggs.gnu.org ([2001:4830:134:3::10]:42902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1egX0G-00080t-BV
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1egX06-0002cL-EW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 09:35:15 -0500
Date: Tue, 30 Jan 2018 15:34:47 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180130143447.quqbwpitu3iau2qv@eukaryote>
References: <20180130063433.11605-1-famz@redhat.com>
	<20180130063433.11605-3-famz@redhat.com>
	<b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b552c5fb-f79a-98f1-bac7-26cf6e106f06@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Jan 30, 2018 at 08:23:50AM -0600, Eric Blake wrote:
> On 01/30/2018 12:34 AM, Fam Zheng wrote:

[...]

> > +If specified, @code{qemu-img} will open the image in shared mode, allowing
> > +concurrent writers. For example, this can be used to get the image information
> 
> Actually, we only permit one writer at a time.  Would it be better to
> say "allowing a concurrent writer"?

Definitely worth rewording.  Otherwise the two sentences:

    "If specified, @code{qemu-img} will open the image in shared mode,
     allowing concurrent writers."

    "This option is only allowed when opening images in read-only mode."

are at odds with each other --- it says "concurrent writers" are
allowed, BUT "allowed only when opening images in 'read-only' mode".

> > +(with 'info' subcommand) when the image is used by a running guest.  Note that
> > +this could produce inconsistent results because of concurrent metadata changes,
> > +etc. This option is only allowed when opening images in read-only mode.
> 
> After all, we are stating that this process (which must be read-only,
> because we can't have two writers at once) is permitting some other
> process to be the concurrent writer (but not multiple processes to be
> concurrent writers)

Precisely.  So it's worth being clearer.

With the rewording suggested by Eric:

    Reviewed-by: Kashyap Chamarthy <kchamart@redhat.com>

-- 
/kashyap
