Received: from eggs.gnu.org ([2001:4830:134:3::10]:37195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkBM-0005EW-Qx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBkBK-0005Cm-6N
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:51:12 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBkBJ-0005CX-Qr
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:51:10 -0400
Received: by mail-wr0-x244.google.com with SMTP id g12so3360851wrg.2
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:51:09 -0700 (PDT)
Date: Fri, 19 May 2017 16:51:05 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519155105.GE30573@stefanha-x1.localdomain>
References: <1495192872-27667-1-git-send-email-pbonzini@redhat.com>
	<149519768822.696.3542847712358809127@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <149519768822.696.3542847712358809127@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 05:41:28AM -0700, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:

Yikes, on second thought I've dropped the pull request for now.

Please look at these coding style violations.

Thanks,
Stefan

>=20
> Message-id: 1495192872-27667-1-git-send-email-pbonzini@redhat.com
> Type: series
> Subject: [Qemu-devel] [PULL 00/20] Misc patches for 2017-05-19
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 6fce4cd target/i386: use multiple CPU AddressSpaces
> a04ba9d target/i386: enable A20 automatically in system management mode
> 87c38d5 vhost-user-scsi: Introduce a vhost-user-scsi sample application
> a63728e vhost-user-scsi: Introduce vhost-user-scsi host device
> bda4194 virtio-scsi: Unset hotplug handler when unrealize
> ca14443 exec: simplify phys_page_find() params
> 7eee4fd nbd/client.c: use errp instead of LOG
> 388beda nbd: add errp to read_sync, write_sync and drop_sync
> 0032273 nbd: add errp parameter to nbd_wr_syncv()
> bdf25c9 nbd: read_sync and friends: return 0 on success
> b61d7d1 nbd: strict nbd_wr_syncv
> cc100d3 Check the return value of fcntl in qemu_set_cloexec
> 94297c6 kvm: irqchip: skip update msi when disabled
> f8f04f1 msix: trace control bit write op
> 11bfe30 kvm: irqchip: trace changes on msi add/remove
> 192c432 mc146818rtc: embrace all x86 specific code
> 6e1b003 mc146818rtc: drop unnecessary '#ifdef TARGET_I386'
> cb9a45b mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only enabled on TARG=
ET_I386
> 98a508b mc146818rtc: precisely count the clock for periodic timer
> b9744f3 mc146818rtc: update periodic timer only if it is needed
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/20: mc146818rtc: update periodic timer only if it is nee=
ded...
> Checking PATCH 2/20: mc146818rtc: precisely count the clock for periodic =
timer...
> ERROR: braces {} are necessary for all arms of this statement
> #129: FILE: hw/timer/mc146818rtc.c:216:
> +        if (s->lost_tick_policy =3D=3D LOST_TICK_POLICY_SLEW) {
> [...]
> +        } else
> [...]
>=20
> total: 1 errors, 0 warnings, 181 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 3/20: mc146818rtc: ensure LOST_TICK_POLICY_SLEW is only en=
abled on TARGET_I386...
> Checking PATCH 4/20: mc146818rtc: drop unnecessary '#ifdef TARGET_I386'...
> Checking PATCH 5/20: mc146818rtc: embrace all x86 specific code...
> Checking PATCH 6/20: kvm: irqchip: trace changes on msi add/remove...
> Checking PATCH 7/20: msix: trace control bit write op...
> Checking PATCH 8/20: kvm: irqchip: skip update msi when disabled...
> Checking PATCH 9/20: Check the return value of fcntl in qemu_set_cloexec.=
=2E.
> Checking PATCH 10/20: nbd: strict nbd_wr_syncv...
> Checking PATCH 11/20: nbd: read_sync and friends: return 0 on success...
> Checking PATCH 12/20: nbd: add errp parameter to nbd_wr_syncv()...
> Checking PATCH 13/20: nbd: add errp to read_sync, write_sync and drop_syn=
c...
> Checking PATCH 14/20: nbd/client.c: use errp instead of LOG...
> ERROR: code indent should never use tabs
> #126: FILE: nbd/client.c:729:
> +^I     Error **errp)$
>=20
> total: 1 errors, 0 warnings, 146 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 15/20: exec: simplify phys_page_find() params...
> Checking PATCH 16/20: virtio-scsi: Unset hotplug handler when unrealize...
> Checking PATCH 17/20: vhost-user-scsi: Introduce vhost-user-scsi host dev=
ice...
> ERROR: do not use C99 // comments
> #216: FILE: hw/scsi/vhost-user-scsi.c:145:
> +    // Turn on predefined features supported by this device
>=20
> ERROR: do not use C99 // comments
> #261: FILE: hw/scsi/vhost-user-scsi.c:190:
> +    // Add the bootindex property for this object
>=20
> ERROR: do not use C99 // comments
> #265: FILE: hw/scsi/vhost-user-scsi.c:194:
> +    // Set boot index according the the device config
>=20
> total: 3 errors, 0 warnings, 382 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 18/20: vhost-user-scsi: Introduce a vhost-user-scsi sample=
 application...
> ERROR: do not use C99 // comments
> #109: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:28:
> +//#define VUS_DEBUG 1
>=20
> ERROR: spaces required around that '/' (ctx:VxV)
> #123: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:42:
> +            timebuf, ts.tv_nsec/1000,                                 \
>                                 ^
>=20
> ERROR: __func__ should be used instead of gcc specific __FUNCTION__
> #124: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:43:
> +            __FILE__, __FUNCTION__, __LINE__, ## __VA_ARGS__);        \
>=20
> ERROR: space required before the open parenthesis '('
> #125: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:44:
> +} while(0)
>=20
> ERROR: spaces required around that '/' (ctx:VxV)
> #130: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:49:
> +            timebuf, ts.tv_nsec/1000, ## __VA_ARGS__);                \
>                                 ^
>=20
> ERROR: space required before the open parenthesis '('
> #131: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:50:
> +} while(0);
>=20
> ERROR: do not use C99 // comments
> #145: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:64:
> +#define VUS_MAX_LUNS 1 // Only 1 lun supported today
>=20
> ERROR: do not use C99 // comments
> #146: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:65:
> +#define VUS_MAX_DEVS 1 // Only 1 devices supported today
>=20
> ERROR: do not use C99 // comments
> #159: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:78:
> +    GTree *fdmap;   // maps fd to gsource context id
>=20
> ERROR: trailing statements should be on next line
> #176: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:95:
> +    if (b > a) return 1;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #176: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:95:
> +    if (b > a) return 1;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #177: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:96:
> +    if (b < a) return -1;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #177: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:96:
> +    if (b < a) return -1;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #213: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:132:
> +        if (vus_src->gfd.events & G_IO_IN)  vu_evt |=3D VU_WATCH_IN;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #213: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:132:
> +        if (vus_src->gfd.events & G_IO_IN)  vu_evt |=3D VU_WATCH_IN;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #214: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:133:
> +        if (vus_src->gfd.events & G_IO_OUT) vu_evt |=3D VU_WATCH_OUT;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #214: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:133:
> +        if (vus_src->gfd.events & G_IO_OUT) vu_evt |=3D VU_WATCH_OUT;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #215: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:134:
> +        if (vus_src->gfd.events & G_IO_PRI) vu_evt |=3D VU_WATCH_PRI;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #215: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:134:
> +        if (vus_src->gfd.events & G_IO_PRI) vu_evt |=3D VU_WATCH_PRI;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #216: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:135:
> +        if (vus_src->gfd.events & G_IO_ERR) vu_evt |=3D VU_WATCH_ERR;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #216: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:135:
> +        if (vus_src->gfd.events & G_IO_ERR) vu_evt |=3D VU_WATCH_ERR;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #217: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:136:
> +        if (vus_src->gfd.events & G_IO_HUP) vu_evt |=3D VU_WATCH_HUP;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #217: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:136:
> +        if (vus_src->gfd.events & G_IO_HUP) vu_evt |=3D VU_WATCH_HUP;
> [...]
>=20
> ERROR: use QEMU instead of Qemu or QEmu
> #277: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:196:
> + *     Qemu's scsi.h also defines "SCSI_XFER_NONE".
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #358: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:277:
> +static int iscsi_add_lun(iscsi_lun_t *lun, char *iscsi_uri) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #423: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:342:
> +static int get_cdb_len(uint8_t *cdb) {
>=20
> ERROR: spaces required around that '>>' (ctx:VxV)
> #433: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:352:
> +    PERR("Unable to determine cdb len (0x%02hhX)", cdb[0]>>5);
>                                                           ^
>=20
> ERROR: do not use C99 // comments
> #453: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:372:
> +        // Ignore anything different than target=3D0, lun=3D0
>=20
> ERROR: spaces required around that '=3D' (ctx:VxV)
> #477: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:396:
> +        for (i=3D0; i<out_len; i++) {
>                ^
>=20
> ERROR: spaces required around that '<' (ctx:VxV)
> #477: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:396:
> +        for (i=3D0; i<out_len; i++) {
>                     ^
>=20
> ERROR: spaces required around that '=3D' (ctx:VxV)
> #482: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:401:
> +        for (i=3D0; i<in_len; i++) {
>                ^
>=20
> ERROR: spaces required around that '<' (ctx:VxV)
> #482: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:401:
> +        for (i=3D0; i<in_len; i++) {
>                     ^
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #532: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:451:
> +static void vus_panic_cb(VuDev *vu_dev, const char *buf) {
>=20
> ERROR: trailing statements should be on next line
> #574: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:493:
> +    if (vu_evt & VU_WATCH_IN)  conds |=3D G_IO_IN;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #574: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:493:
> +    if (vu_evt & VU_WATCH_IN)  conds |=3D G_IO_IN;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #575: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:494:
> +    if (vu_evt & VU_WATCH_OUT) conds |=3D G_IO_OUT;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #575: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:494:
> +    if (vu_evt & VU_WATCH_OUT) conds |=3D G_IO_OUT;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #576: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:495:
> +    if (vu_evt & VU_WATCH_PRI) conds |=3D G_IO_PRI;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #576: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:495:
> +    if (vu_evt & VU_WATCH_PRI) conds |=3D G_IO_PRI;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #577: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:496:
> +    if (vu_evt & VU_WATCH_ERR) conds |=3D G_IO_ERR;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #577: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:496:
> +    if (vu_evt & VU_WATCH_ERR) conds |=3D G_IO_ERR;
> [...]
>=20
> ERROR: trailing statements should be on next line
> #578: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:497:
> +    if (vu_evt & VU_WATCH_HUP) conds |=3D G_IO_HUP;
>=20
> ERROR: braces {} are necessary for all arms of this statement
> #578: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:497:
> +    if (vu_evt & VU_WATCH_HUP) conds |=3D G_IO_HUP;
> [...]
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #585: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:504:
> +static void vus_del_watch_cb(VuDev *vu_dev, int fd) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #608: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:527:
> +static void vus_proc_ctl(VuDev *vu_dev, int idx) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #612: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:531:
> +static void vus_proc_evt(VuDev *vu_dev, int idx) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #616: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:535:
> +static void vus_proc_req(VuDev *vu_dev, int idx) {
>=20
> ERROR: space required before the open parenthesis '('
> #643: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:562:
> +    while(1) {
>=20
> ERROR: spaces required around that '-' (ctx:VxV)
> #673: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:592:
> +                            req, &elem->out_sg[1], elem->out_num-1,
>                                                                  ^
>=20
> ERROR: spaces required around that '-' (ctx:VxV)
> #674: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:593:
> +                            rsp, &elem->in_sg[1], elem->in_num-1) !=3D 0=
) {
>                                                                ^
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #686: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:605:
> +static void vus_queue_set_started(VuDev *vu_dev, int idx, bool started) {
>=20
> ERROR: space required before the open parenthesis '('
> #699: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:618:
> +    switch(idx) {
>=20
> ERROR: spaces required around that '?' (ctx:VxV)
> #701: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:620:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_ctl:NULL);
>                                                  ^
>=20
> ERROR: spaces required around that ':' (ctx:VxV)
> #701: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:620:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_ctl:NULL);
>                                                               ^
>=20
> ERROR: spaces required around that '?' (ctx:VxV)
> #704: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:623:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_evt:NULL);
>                                                  ^
>=20
> ERROR: spaces required around that ':' (ctx:VxV)
> #704: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:623:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_evt:NULL);
>                                                               ^
>=20
> ERROR: spaces required around that '?' (ctx:VxV)
> #707: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:626:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_req:NULL);
>                                                  ^
>=20
> ERROR: spaces required around that ':' (ctx:VxV)
> #707: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:626:
> +        vu_set_queue_handler(vu_dev, vq, started?vus_proc_req:NULL);
>                                                               ^
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #715: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:634:
> +static gboolean vus_vhost_cb(gpointer data) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #731: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:650:
> +static int unix_sock_new(char *unix_fn) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #769: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:688:
> +static vhost_scsi_dev_t *vdev_scsi_find_by_vu(VuDev *vu_dev) {
>=20
> ERROR: spaces required around that '=3D' (ctx:VxV)
> #774: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:693:
> +    for (i=3D0; i<VUS_MAX_DEVS; i++) {
>            ^
>=20
> ERROR: spaces required around that '<' (ctx:VxV)
> #774: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:693:
> +    for (i=3D0; i<VUS_MAX_DEVS; i++) {
>                 ^
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #784: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:703:
> +static void vdev_scsi_deinit(vhost_scsi_dev_t *vdev_scsi) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #809: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:728:
> +static vhost_scsi_dev_t *vdev_scsi_new(char *unix_fn) {
>=20
> ERROR: open brace '{' following function declarations go on the next line
> #864: FILE: contrib/vhost-user-scsi/vhost-user-scsi.c:783:
> +static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi) {
>=20
> total: 66 errors, 0 warnings, 912 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> Checking PATCH 19/20: target/i386: enable A20 automatically in system man=
agement mode...
> Checking PATCH 20/20: target/i386: use multiple CPU AddressSpaces...
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxRpAAoJEJykq7OBq3PImDEH/3VdrjTNfwhkR6BHukcUneF7
Usoe4n3IV3N/rS8yBnQKTUfDfA2Ml7ceypR2VU7BPK/PbXnOXUm1RYarvWBwNi2l
GCgR5d/r9OKPzd6HY9W760FxRrAaFGozHwND2MGJZk6VEfTz8f5V7hS1B5OO1oGO
4kavPSx5dfxKM9bnoZCP/O72xz9dMQv3p6j/dfIin6N0gfLGfoIb/pufxZuOej8Z
6piRsENX0zNyGJYwQKLFOuPM0sJ6Rz1H4rEMAZ8VBi7NL4jOeq9rI9AaCZxVn61a
Q15riGEFoPVMbUuBXUqS1EevPv6lOb7EbkRMVbyNifG9mRMp/4SjHuLDOKDpi+M=
=ABZH
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
