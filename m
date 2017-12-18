Received: from eggs.gnu.org ([2001:4830:134:3::10]:37558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eQz3p-0000i4-0t
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1eQz3k-0001Sr-T2
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46010
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1eQz3k-0001P5-Mg
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:18:36 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIHA8Al177263
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:18:32 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exehhaur4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 12:18:32 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 12:18:31 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 11:18:16 -0600
Message-Id: <151361749627.29324.10469653565413888010@sif>
Subject: [Qemu-devel] [ANNOUNCE] QEMU 2.10.2 Stable released
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi everyone,

I am pleased to announce that the QEMU v2.10.2 stable release is now
available:

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

v2.10.2 is now tagged in the official qemu.git repository,
and the stable-2.10 branch has been updated accordingly:

  https://git.qemu.org/?p=3Dqemu.git;a=3Dshortlog;h=3Drefs/heads/stable-2.10

This update contains security fixes addressing potential buffer overruns
when using cirrus VGA or NBD (CVE-2017-13672 and CVE-2017-15118,
respectively) and potential host DoS through client-induced memory
exhaustion when using VNC websockets or NBD (CVE-2017-15268 and
CVE-2017-15119, respectively).

There are also the normal range of general fixes. Please see the
changelog for additional details and update accordingly.

Thank you to everyone involved!

CHANGELOG:

ba87166e14: Update version for 2.10.2 release (Michael Roth)
b7d059b91f: spapr: don't initialize PATB entry if max-cpu-compat < power9 (=
Laurent Vivier)
2f3e3890c4: target/ppc: Update setting of cpu features to account for compa=
t modes (Suraj Jitindar Singh)
26c1b49d56: vfio: Fix vfio-kvm group registration (Alex Williamson)
5f214279d4: spapr: Include "pre-plugged" DIMMS in ram size calculation at r=
eset (David Gibson)
9c7714afd7: vga: handle cirrus vbe mode wraparounds. (Gerd Hoffmann)
a0ad811956: vga: drop line_offset variable (Gerd Hoffmann)
b81833fe7d: nbd/client: Don't hard-disconnect on ESHUTDOWN from server (Eri=
c Blake)
0fd80ef569: nbd-client: Refuse read-only client with BDRV_O_RDWR (Eric Blak=
e)
b01b1609e6: nbd/server: fix nbd_negotiate_handle_info (Vladimir Sementsov-O=
gievskiy)
82ded5166b: vhost: fix error check in vhost_verify_ring_mappings() (Greg Ku=
rz)
227196c1e7: nbd/server: CVE-2017-15118 Stack smash on large export name (Er=
ic Blake)
2ce8993512: nbd/server: CVE-2017-15119 Reject options larger than 32M (Eric=
 Blake)
c2269a0b54: virtio-net: don't touch virtqueue if vm is stopped (Jason Wang)
30e499bdc9: block/nfs: fix nfs_client_open for filesize greater than 1TB (P=
eter Lieven)
e1a2a27327: scripts/make-release: ship u-boot source as a tarball (Michael =
Roth)
a77c5873fe: spapr: reset DRCs after devices (Greg Kurz)
0a5a2b938a: hw/ppc: clear pending_events on machine reset (Daniel Henrique =
Barboza)
0bc76c8d08: vhost: restore avail index from vring used index on disconnecti=
on (Maxime Coquelin)
059422ddbc: virtio: Add queue interface to restore avail index from vring u=
sed index (Maxime Coquelin)
d6c99e8ff5: util/stats64: Fix min/max comparisons (Max Reitz)
56a10ff664: nbd/client: Use error_prepend() correctly (Eric Blake)
69f562ad9e: net: fix check for number of parameters to -netdev socket (Jens=
 Freimann)
957bd48acf: net/socket: fix coverity issue (Jens Freimann)
3a82a03a2e: hw/intc/arm_gicv3_its: Don't abort on table save failure (Eric =
Auger)
b637b865ed: translate.c: Fix usermode big-endian AArch32 LDREXD and STREXD =
(Peter Maydell)
3342fd0286: ppc: fix setting of compat mode (Greg Kurz)
e0809fcc4b: io: monitor encoutput buffer size from websocket GSource (Danie=
l P. Berrange)
e31942b486: nios2: define tcg_env (Paolo Bonzini)
5aa698ab5f: iotests: Add cluster_size=3D64k to 125 (Max Reitz)
39475b8805: qcow2: Always execute preallocate() in a coroutine (Max Reitz)
a25aca75f8: qcow2: Fix unaligned preallocated truncation (Max Reitz)
64f62e4e90: hw/sd: fix out-of-bounds check for multi block reads (Michael O=
lbrich)
d765c5e577: memory: fix off-by-one error in memory_region_notify_one() (Max=
ime Coquelin)
ae13e2cfa8: exec: simplify address_space_get_iotlb_entry (Peter Xu)
c9dbe3e0fc: exec: add page_mask for flatview_do_translate (Peter Xu)
496f97293e: memory: Share special empty FlatView (Alexey Kardashevskiy)
639701e4f2: memory: seek FlatView sharing candidates among children subregi=
ons (Paolo Bonzini)
5dbd1f7884: memory: trace FlatView creation and destruction (Paolo Bonzini)
5b5e49ab5f: memory: Create FlatView directly (Alexey Kardashevskiy)
a7bb94e784: memory: Get rid of address_space_init_shareable (Alexey Kardash=
evskiy)
7dd7f7ef44: memory: Do not allocate FlatView in address_space_init (Alexey =
Kardashevskiy)
e8c7ea3e75: memory: Share FlatView's and dispatch trees between address spa=
ces (Alexey Kardashevskiy)
c943efe8b5: memory: Move address_space_update_ioeventfds (Alexey Kardashevs=
kiy)
c14ce078b2: memory: Alloc dispatch tree where topology is generared (Alexey=
 Kardashevskiy)
260d3646b0: memory: Store physical root MR in FlatView (Alexey Kardashevski=
y)
08101db63b: memory: Rename mem_begin/mem_commit/mem_add helpers (Alexey Kar=
dashevskiy)
eff5ed4ae9: memory: Cleanup after switching to FlatView (Alexey Kardashevsk=
iy)
f7774e329b: memory: Switch memory from using AddressSpace to FlatView (Alex=
ey Kardashevskiy)
3568e11940: memory: avoid "resurrection" of dead FlatViews (Paolo Bonzini)
d0136db812: memory: Remove AddressSpace pointer from AddressSpaceDispatch (=
Alexey Kardashevskiy)
4d2f8abb22: memory: Move AddressSpaceDispatch from AddressSpace to FlatView=
 (Alexey Kardashevskiy)
de7e6815b8: memory: Move FlatView allocation to a helper (Alexey Kardashevs=
kiy)
1b04a15809: memory: Open code FlatView rendering (Alexey Kardashevskiy)
6424975ce9: exec: Explicitly export target AS from address_space_translate_=
internal (Alexey Kardashevskiy)
4af42e3cf1: block: Perform copy-on-read in loop (Eric Blake)
26914ce48d: kvmclock: use the updated system_timer_msr (Jim Somerville)
49958d37e7: block/mirror: check backing in bdrv_mirror_top_flush (Vladimir =
Sementsov-Ogievskiy)
b234266086: hw/usb/bus: Remove bad object_unparent() from usb_try_create_si=
mple() (Thomas Huth)
62695f60c3: hw/ppc: CAS reset on early device hotplug (Daniel Henrique Barb=
oza)
