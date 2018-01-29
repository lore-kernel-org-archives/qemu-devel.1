Received: from eggs.gnu.org ([2001:4830:134:3::10]:50771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1egCRQ-00021P-Iz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1egCRK-000500-Pb
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:37:56 -0500
Date: Mon, 29 Jan 2018 17:37:25 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180129163725.lhovxm6mjjtzceao@eukaryote>
References: <20171226025247.11082-1-famz@redhat.com>
	<20171226025247.11082-3-famz@redhat.com>
	<7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c728aa5-4623-79c6-3e6a-04e2b19aefba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/2] qemu-img: Document --force-share /
 -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com

On Mon, Jan 29, 2018 at 05:01:41PM +0100, Max Reitz wrote:
> On 2017-12-26 03:52, Fam Zheng wrote:

[...]

> So the previous patch makes the use of blank lines consistent and this
> one breaks it again? :-)
> 
> > +If specified, @code{qemu-img} will open the image with shared permissions,
> > +which makes it less likely to conflict with a running guest's permissions due
> > +to image locking. For example, this can be used to get the image information
> > +(with 'info' subcommand) when the image is used by a running guest. Note that
> > +this could produce inconsistent results because of concurrent metadata changes,
> > +etc. This option is only allowed when opening images in read-only mode.
> 
> I personally don't quite like the "makes it less likely to conflict",
> because that makes it sound like qemu would be stupid and need a nudge
> in the right direction -- when it's actually the user who does something
> a bit risky (and qemu is right in forbidding it by default).  But since
> it's only a read-only thing, I won't actually object to it.
> 
> (Maybe it should document more exactly what's happening, i.e. that this
> option will allow concurrent writers (as a standard user, I wouldn't
> know what "shared permissions" is supposed to mean).)

Eerie -- Although I reviewed it, I was just mulling over this wording
yesterday (while I was tweaking the wording of '--force-share' on a
slide for a public conference).  

Indeed, "concurrent writers" is much clearer.


[...]


-- 
/kashyap
