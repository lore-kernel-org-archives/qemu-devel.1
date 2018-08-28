Received: from eggs.gnu.org ([2001:4830:134:3::10]:55170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fugPd-0007eX-V3
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fugPa-0006CT-NO
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fugPa-00068Y-Bz
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:00:10 -0400
Date: Tue, 28 Aug 2018 16:59:59 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180828155959.GA16050@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ANNOUNCE: nbdkit 1.6 - an NBD server toolkit with
 stable plugin API and permissive license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libguestfs@redhat.com, virt-tools-list@redhat.com, nbd@other.debian.org, qemu-devel@nongnu.org

NBD =E2=80=94 Network Block Device =E2=80=94 is a protocol for accessing =
Block Devices
(hard disks and disk-like things) over a Network.  nbdkit is a toolkit
for creating NBD servers.

The key features are:

 * Multithreaded NBD server written in C with good performance.
 * Minimal dependencies for the basic server.
 * Liberal license (BSD) allows nbdkit to be linked to proprietary
   libraries or included in proprietary code.
 * Well-documented, simple plugin API with a stable ABI guarantee.
   Lets you export =E2=80=9Cunconventional=E2=80=9D block devices easily.
 * You can write plugins in C, [new!] Lua, Perl, Python, OCaml, Ruby or T=
cl.
 * Filters can be stacked in front of plugins to transform the output.

https://github.com/libguestfs/nbdkit
http://download.libguestfs.org/nbdkit/1.6-stable/
(other downloads: http://download.libguestfs.org/nbdkit/ )

New in the 1.6 release:

 * You can now write plugins in the Lua scripting language.

 * nbdkit and common plugins are now "63 bit clean": the maximum disk
   size supported is 2^63-1 bytes, and the core server and plugins now
   have additional tests to check this works, even on 32 bit machines.

 * Multiple improvements to the =E2=80=98file=E2=80=99 plugin to make zer=
oing and
   trimming perform better, work correctly with block devices, and
   work on older Linux kernels [Nir Soffer, Eric Blake].

 * New =E2=80=98pattern=E2=80=99 plugin generates a simple, fixed test pa=
ttern for
   testing nbdkit filters and NBD clients.

 * New =E2=80=98truncate=E2=80=99 filter can: truncate or extend the size=
 of plugins,
   or round up or down the size to next multiple of a power of 2.
   Useful for NBD clients like qemu which can only handle NBD sizes
   which are a multiple of 512 bytes.

 * New =E2=80=98error=E2=80=99 filter which can be used to inject errors =
into the
   protocol for testing how clients can handle and recover from
   errors.

 * New =E2=80=98data=E2=80=99 plugin allows you to specify (small) disk i=
mages
   directly on the command line.

 * Enhanced error reporting in the Python plugin so full tracebacks
   from errors are now displayed instead of being lost as before.

 * NBD_OPT_GO now supported, so we can return errors when negotiating
   the export name.

 * Support for logging error messages to syslog.

 * nbdkit can now be compiled with Clang (as well as GCC).

 * nbdkit can now be compiled on FreeBSD.

 * The VDDK plugin is compiled unconditionally.  You no longer need to
   install the proprietary VDDK to compile it.

 * Debug messages now include the name of the filter when invoked from
   a filter context.

 * Debug flags (-D option) provides lightweight debugging for plugin
   authors.

Thanks to all who contributed, especially Nir Soffer and Eric Blake.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
