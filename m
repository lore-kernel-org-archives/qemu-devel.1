Received: from eggs.gnu.org ([2001:4830:134:3::10]:35914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRc4P-0007G6-LC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:57:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRc4K-0008R5-3D
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:57:53 -0500
Date: Wed, 20 Dec 2017 10:57:40 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171220105740.GQ21216@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
	<20171220104436.fzucmsombnpyxoke@eukaryote>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220104436.fzucmsombnpyxoke@eukaryote>
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
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Dec 20, 2017 at 11:44:36AM +0100, Kashyap Chamarthy wrote:
> On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:
> > Max Reitz <mreitz@redhat.com> writes:
> 
> [...]
> 
> Thanks, Max, for the detailed notes.
> 
> > > Image creation in qemu-system-* vs. qemu-img:
> > >   In order to get proper introspection for qemu-img create, we need a
> > >   QAPI schema.  If we have a QAPI schema, we might as well add
> > >   blockdev-create to QMP.
> > >   As long as we do not have a really-none (null, void, ...) machine type
> > >   for qemu-system-*, launching such a process just for creating an image
> > >   will bring quite a bit of overhead (e.g. with -M none -accel qtest).
> > >   However, as for libvirt, this is not exactly a regression since
> > >   libvirt currently cannot create images at all (apart from implicitly
> > >   through drive-mirror etc.).  Further work on voidifying qemu-system-*
> > >   will improve performance.
> > 
> > Another thought: do we want to give qemu-system-* the necessary
> > privileges for creating images?  Two cases: running with and without a
> > guest.
> 
> Related: Just curious -- was it an explicit design decision to not give
> `qemu-system-*` permissions to create disk images?

Our security model considers QEMU broadly untrustworthy, and so any resources
it needs to use must either be passed in by libvirt, or have permissions
explicitly assigned to permit usage by QEMU. QEMU is allowed to create tmp
files, and create RAM files for memory backing, but in general we don't want
to have QEMU able to create arbitrary files, only open things that are
already created.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
