Received: from eggs.gnu.org ([2001:4830:134:3::10]:47023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eRbrk-0004ii-Ux
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eRbrk-0007KM-5i
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:44:49 -0500
Date: Wed, 20 Dec 2017 11:44:36 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171220104436.fzucmsombnpyxoke@eukaryote>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ind4gxcb.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block] Raw notes from a small block
 layer/QAPI/something pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:

[...]

Thanks, Max, for the detailed notes.

> > Image creation in qemu-system-* vs. qemu-img:
> >   In order to get proper introspection for qemu-img create, we need a
> >   QAPI schema.  If we have a QAPI schema, we might as well add
> >   blockdev-create to QMP.
> >   As long as we do not have a really-none (null, void, ...) machine type
> >   for qemu-system-*, launching such a process just for creating an image
> >   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
> >   However, as for libvirt, this is not exactly a regression since
> >   libvirt currently cannot create images at all (apart from implicitly
> >   through drive-mirror etc.).  Further work on voidifying qemu-system-*
> >   will improve performance.
> 
> Another thought: do we want to give qemu-system-* the necessary
> privileges for creating images?  Two cases: running with and without a
> guest.

Related: Just curious -- was it an explicit design decision to not give
`qemu-system-*` permissions to create disk images?

[...]

-- 
/kashyap
