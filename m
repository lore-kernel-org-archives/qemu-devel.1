Received: from eggs.gnu.org ([2001:4830:134:3::10]:46872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdg4Y-0003PN-RM
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdg4W-0001fX-M1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:35:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cdg4W-0001fC-Cy
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:35:20 -0500
Date: Tue, 14 Feb 2017 11:35:17 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170214163517.GQ27752@localhost.localdomain>
References: <1478566785-4002-1-git-send-email-ashish.mittal@veritas.com>
	<1478566785-4002-3-git-send-email-ashish.mittal@veritas.com>
	<20161108204413.GA6353@localhost.localdomain>
	<CAAo6VWMyTjV1Fn8-BSex7Fx8OcEcuEyK2rQJ6L=wZZXDiB5A4w@mail.gmail.com>
	<20170213133725.GA10361@stefanha-x1.localdomain>
	<20170213163232.GN27752@localhost.localdomain>
	<B3F9860E-E786-48A5-8BBD-918833905E73@veritas.com>
	<20170213232302.GP27752@localhost.localdomain>
	<983C87E0-DE5B-4147-82CD-CE6A8D093B6C@veritas.com>
	<CAAo6VWNYZG5fc7Z9_u+9Qew5VgbTRA_cRfTu8wqPpOXzTrjvfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo6VWNYZG5fc7Z9_u+9Qew5VgbTRA_cRfTu8wqPpOXzTrjvfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 2/2] block/vxhs.c: Add qemu-iotests for
 new block device type "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Ashish Mittal <Ashish.Mittal@veritas.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>

On Mon, Feb 13, 2017 at 11:43:17PM -0800, ashish mittal wrote:
> On Mon, Feb 13, 2017 at 7:02 PM, Ketan Nilangekar
> <Ketan.Nilangekar@veritas.com> wrote:
> >
> >
> > On 2/13/17, 3:23 PM, "Jeff Cody" <jcody@redhat.com> wrote:
> >
> >     On Mon, Feb 13, 2017 at 10:36:53PM +0000, Ketan Nilangekar wrote:
> >     >
> >     >
> >     > On 2/13/17, 8:32 AM, "Jeff Cody" <jcody@redhat.com> wrote:
> >     >
> >     >     On Mon, Feb 13, 2017 at 01:37:25PM +0000, Stefan Hajnoczi wrote:
> >     >     > On Tue, Feb 07, 2017 at 03:12:36PM -0800, ashish mittal wrote:
> >     >     > > On Tue, Nov 8, 2016 at 12:44 PM, Jeff Cody <jcody@redhat.com> wrote:
> >     >     > > > On Mon, Nov 07, 2016 at 04:59:45PM -0800, Ashish Mittal wrote:
> >     >     > > >> These changes use a vxhs test server that is a part of the following
> >     >     > > >> repository:
> >     >     > > >> https://github.com/MittalAshish/libqnio.git
> >     >     > > >>
> >     >     > > >> Signed-off-by: Ashish Mittal <ashish.mittal@veritas.com>
> >     >     > > >> ---
> >     >     > > >> v6 changelog:
> >     >     > > >> (1) Added iotests for VxHS block device.
> >     >     > > >>
> >     >     > > >>  tests/qemu-iotests/common        |  6 ++++++
> >     >     > > >>  tests/qemu-iotests/common.config | 13 +++++++++++++
> >     >     > > >>  tests/qemu-iotests/common.filter |  1 +
> >     >     > > >>  tests/qemu-iotests/common.rc     | 19 +++++++++++++++++++
> >     >     > > >>  4 files changed, 39 insertions(+)
> >     >     > > >>
> >     >     > > >> diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
> >     >     > > >> index d60ea2c..41430d8 100644
> >     >     > > >> --- a/tests/qemu-iotests/common
> >     >     > > >> +++ b/tests/qemu-iotests/common
> >     >     > > >
> >     >     > > > When using raw format, I was able to run the test successfully for all
> >     >     > > > supported test cases (26 of them).
> >     >     > > >
> >     >     > > > With qcow2, they fail - but not the fault of this patch, I think; but
> >     >     > > > rather, the fault of the test server.  Can qnio_server be modified so that
> >     >     > > > it does not work on just raw files?
> >     >     > > >
> >     >     > > >
> >     >     > >
> >     >     > > VxHS supports and uses only the raw format.
> >     >     >
> >     >     > That's like saying only ext4 guest file systems are supported on VxHS
> >     >     > and not ZFS.  The VxHS driver should not care what file system is used,
> >     >     > it just does block I/O without interpreting the data.
> >     >     >
> >     >     > It must be possible to use any format on top of the VxHS protocol.
> >     >     > After all, the image format drivers just do block I/O.  If there is a
> >     >     > case where qcow2 on VxHS fails then it needs to be investigated.
> >     >     >
> >     >     > The VxHS driver can't be merged until we at least understand the cause
> >     >     > of the qcow2 test failures.
> >     >     >
> >     >
> >     >     A quick run with the test server and a QEMU process showed an abort() in the
> >     >     test server, so I just sent a pull req to libqnio to fix that.
> >     >
> >     >     But playing with it in gdb right now with a test qcow2 file, I see that we
> >     >     are waiting in aio_poll() forever for the test server to respond to a read
> >     >     request, when using qcow2 format.
> >     >
> >     >     As Stefan said, this doesn't really make any sense - why would VXHS behave
> >     >     differently based on the file contents?
> >     >
> >     > [Ketan] To read/write a qcow2 backed device VxHS server implementation
> >     > will need to understand the qcow2 format. This is not just block IO but
> >     > actually does involve interpreting the qcow2 header and cluster formats.
> >     > Clearly the test server implementation does not handle it as it was never
> >     > intended to. VxHS backend won't handle it either because VxHS virtual
> >     > disks are written as non-sparse files.  There are space savings with the
> >     > qcow2 format but performance penalties as well because of the metadata
> >     > overhead. As a block storage provider, VxHS does not support sparse file
> >     > formats like qcow2 primarily because of performance reasons.  Implementing
> >     > a qcow2 backend in the test server would be a non-trivial and non-useful
> >     > exercise since the VxHS server won't support it.
> >     >
> >
> >     What?  Why would the backend need to know anything about qcow2 formats; are
> >     you manipulating the guest image data directly yourself?  But regardless,
> >     since the test server is naive and just reads and writes data, the fact that
> >     the test server breaks on qcow2 image formats means that the test server is
> >     broken for raw images, as well [1].
> >
> >     The backend should not need to know anything about the image file format in
> >     order to serve data, as the backend is essentially serving bytes. (I guess
> >     the only thing the backend would need to be aware of is how to invoke
> >     qemu-img to create a qcow2 image file initially).
> >
> >
> >     QEMU is what interprets the qcow2 format (or any image format).  Every read
> >     from QEMU will look like a raw file read from the perspective of libqnio /
> >     vxhs.  I can't see any reason why vxhs would need to know anything about the
> >     contents of the image file itself.
> >
> >     The only thing the test server needs to do, in order to be able to serve
> >     qcow2 files correctly, is to be able to serve raw files correctly.
> >
> >     Looking at the libqnio implementation from the test server with gdb, I think
> >     that the reason why qcow2 format does not work is that the current
> >     libqnio implementation does not handle short reads correctly.  For instance,
> >     if the file is not a even multiple of the read size, and we try to read 512
> >     bytes at the end of the file, it appears libqnio hangs on the short read.  I
> >     am not sure if this is a bug exclusive to the test server, or in the libqnio
> >     implementation.
> >
> >     [1]
> >     This bug isn't limited to qcow2, since as mentioned above, QEMU is just
> >     relying on libqnio to read raw bytes.  So, you can reproduce this bug with a
> >     raw image file, as well:
> >
> >     # dd if=/dev/zero of=test.raw bs=1 count=196616
> >
> >     # qemu-io -c "read 196608 512" vxhs://localhost:9999/test.raw
> >
> >     The above qemu-io process will hang in aio_poll, because libqnio never
> >     processes the callback. This is because process_incoming_messages() thinks
> >     it needs a full 512 bytes before it will call the registered callback, even
> >     though there will only ever be 8 bytes read.
> >
> >     The above scenario is also exactly what is happening when I try to use a
> >     qcow2 format; QEMU issues a read for 8 bytes at offset 196608, and the file
> >     is 196616 bytes long.
> >
> >     (The sparse image thing seems shouldn't be an issue - first, the test server
> >     works just fine with sparse raw images... as matter of fact, the
> >     "create_vdisk.sh" script in the libqnio repository does exactly that.  Also,
> >     if you choose to not use sparse images for whatever reason on the backend,
> >     qcow2 does not require it to be sparse, as image files can be created with
> >     the "-o preallocation=full" option).
> >
> > [Ketan] You are correct. We have identified the problem with test server
> > and have a patch for it which returns zero filled reads to align the
> > read buffers to requested block size. We could also fix this in libvxhs
> > by not expecting/waiting for requested block size in case the reads are
> > partial.  Ashish will upload the patch for the test server fix. Please
> > let us know how the qcow tests go.
> >
> >     -Jeff
> >
> >
> 
> Changes per the above suggestion present in branch ashish_securify.
> Thanks!


All the qemu-iotests that I would expect to pass now, with vxhs, seem to
pass (tests that try to create a qemu image through the protocol obviously
fail; I submitted a patch upstream that should make it easier to exclude
those tests).

Once the patches I've submitted upstream are in master, you should be able
to use them like so (feel free to just pull this into your branch and send
it out with your patches if/when the patches I just sent are in master):


>From 7c135439fd0151860cb0f6ef1a857dfbee6e6317 Mon Sep 17 00:00:00 2001
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 09:51:42 -0500
Subject: [PATCH] qemu-iotests: exclude vxhs from image creation via protocol

The protocol VXHS does not support image creation.  Some tests expect
to be able to create images through the protocol.  Exclude VXHS from
these tests.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/017 | 1 +
 tests/qemu-iotests/020 | 1 +
 tests/qemu-iotests/029 | 1 +
 tests/qemu-iotests/073 | 1 +
 tests/qemu-iotests/114 | 1 +
 tests/qemu-iotests/130 | 1 +
 tests/qemu-iotests/134 | 1 +
 tests/qemu-iotests/156 | 1 +
 tests/qemu-iotests/158 | 1 +
 9 files changed, 9 insertions(+)

diff --git a/tests/qemu-iotests/017 b/tests/qemu-iotests/017
index e3f9e75..4f9302d 100755
--- a/tests/qemu-iotests/017
+++ b/tests/qemu-iotests/017
@@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" "subformat=twoGbMaxExtentFlat"
 
diff --git a/tests/qemu-iotests/020 b/tests/qemu-iotests/020
index 9c4a68c..7a11110 100755
--- a/tests/qemu-iotests/020
+++ b/tests/qemu-iotests/020
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 _unsupported_imgopts "subformat=monolithicFlat" \
                      "subformat=twoGbMaxExtentFlat" \
diff --git a/tests/qemu-iotests/029 b/tests/qemu-iotests/029
index e639ac0..30bab24 100755
--- a/tests/qemu-iotests/029
+++ b/tests/qemu-iotests/029
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting intenal snapshots
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1
 _unsupported_imgopts 'refcount_bits=1[^0-9]'
diff --git a/tests/qemu-iotests/073 b/tests/qemu-iotests/073
index ad37a61..40f85b1 100755
--- a/tests/qemu-iotests/073
+++ b/tests/qemu-iotests/073
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 CLUSTER_SIZE=64k
diff --git a/tests/qemu-iotests/114 b/tests/qemu-iotests/114
index f110d4f..5b7dc54 100755
--- a/tests/qemu-iotests/114
+++ b/tests/qemu-iotests/114
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/130 b/tests/qemu-iotests/130
index ecc8a5b..f941fc9 100755
--- a/tests/qemu-iotests/130
+++ b/tests/qemu-iotests/130
@@ -42,6 +42,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 qemu_comm_method="monitor"
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index af618b8..acce946 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index cc95ff1..78deaff 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -48,6 +48,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2 qed
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 # Create source disk
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index a6cdd6d..ef8d70f 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -39,6 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 _supported_fmt qcow2
 _supported_proto generic
+_unsupported_proto vxhs
 _supported_os Linux
 
 
-- 
2.9.3
