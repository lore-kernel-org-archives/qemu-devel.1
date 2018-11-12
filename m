Received: from eggs.gnu.org ([2001:4830:134:3::10]:43232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMJO4-0000Ec-Tb
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gMJO1-0003yd-MJ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:04:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1gMJNu-0003sk-Uq
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 16:04:41 -0500
Date: Mon, 12 Nov 2018 21:04:24 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181112210424.GF8217@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ANNOUNCE: nbdkit 1.8 - an NBD server toolkit with
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

I=E2=80=99m pleased to announce the next stable release of nbdkit.

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
 * You can write plugins in C, Lua, Perl, Python, OCaml, Ruby,
   [new!] shell script or Tcl.
 * Filters can be stacked in front of plugins to transform the output.

    Clone source: https://github.com/libguestfs/nbdkit
Download tarball: http://download.libguestfs.org/nbdkit/1.8-stable/
(other downloads: http://download.libguestfs.org/nbdkit/ )

New in this release:

- New plugin: =E2=80=98sh=E2=80=99 for running shell scripts and other ex=
ternal programs.
  (https://rwmj.wordpress.com/2018/09/09/write-nbdkit-plugins-in-shell-sc=
ript/)

- New plugin: =E2=80=98partitioning=E2=80=99 which creates a partitioned =
disk from a
  list of partitions in files.

- New plugin: =E2=80=98iso=E2=80=99 which creates an ISO (CD-ROM) image o=
n the fly
  from a directory of files.
  (https://rwmj.wordpress.com/2018/10/18/new-in-nbdkit-create-an-iso-imag=
e-on-the-fly/)

- New plugin: =E2=80=98floppy=E2=80=99 which creates a virtual FAT-format=
ted floppy
  disk from a directory of files.
  (https://rwmj.wordpress.com/2018/10/29/new-in-nbdkit-create-a-virtual-f=
loppy-disk/)

- Magic config key allows simpler invocation of many plugins, eg:
    nbdkit file file=3Dfoo
  becomes:
    nbdkit file foo

- data: Add disk2data.pl script to generate data parameters.

- data: Use =E2=80=98<file=E2=80=99 to inline a file.

- vddk: Use =E2=80=98-D vddk.diskinfo=3D1=E2=80=99 to enable extra debug =
information.

- tests: Use a helper function to refactor and simplify most tests.

- partition filter: Can handle > 128 GPT partitions.

- nbdkit can be compiled on the Haiku operating system
  (Fran=C3=A7ois Revol).

- New nbdkit_parse_bool API for parsing boolean parameters (Eric Blake).

- log: Add logappend=3D[true|false] (Eric Blake).

- ocaml: New set_error and debug calls.

- Analyze code under AddressSanitizer and ThreadSanitizer and fix bugs
  (Eric Blake).

- Analyze code under Coverity and fix bugs.

- Tests now run more quickly.


Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
