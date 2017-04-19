Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0pz3-0005GI-25
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1d0pyy-0008KM-K9
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:49:25 -0400
Received: from mailpro.odiso.net ([89.248.211.110]:41988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1d0pyy-0008Jf-AM
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 09:49:20 -0400
Date: Wed, 19 Apr 2017 15:48:39 +0200 (CEST)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <854566934.11020438.1492609719869.JavaMail.zimbra@oxygem.tv>
In-Reply-To: <708656279.11020244.1492609008406.JavaMail.zimbra@oxygem.tv>
References: <1009091132.10984059.1492585700295.JavaMail.zimbra@oxygem.tv>
	<20170419104300.gousbztqfl5j4k7q@eukaryote>
	<111400435.11010636.1492604926409.JavaMail.zimbra@oxygem.tv>
	<20170419125801.ort44uiuepmklm5j@eukaryote>
	<708656279.11020244.1492609008406.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] blockdev-mirror ,
 how to replace old nodename by new nodename ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

>>What I don't understand is how do you map device to the blockdev ?

Ah,ok, got it.

info qtree show me that device drive is now the new nodename !

So it's working fine.

Thanks for help.



----- Mail original -----
De: "aderumier" <aderumier@odiso.com>
=C3=80: "Kashyap Chamarthy" <kchamart@redhat.com>
Cc: "qemu-devel" <qemu-devel@nongnu.org>
Envoy=C3=A9: Mercredi 19 Avril 2017 15:36:48
Objet: Re: [Qemu-devel] blockdev-mirror , how to replace old nodename by ne=
w nodename ?

Ok, I have same result than my test:=20

{"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 1073741824=
, "filename": "base.raw", "format": "raw", "actual-size": 0, "dirty-flag": =
false}, "iops_wr": 0, "ro": false, "node-name": "node1", "backing_file_dept=
h": 0, "drv": "raw", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypt=
ed": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": f=
alse, "writeback": true}, "file": "base.qcow2, "encryption_key_missing": fa=
lse}, {"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 1073=
741824, "filename": "base.qcow2", "format": "file", "actual-size": 0, "dirt=
y-flag": false}, "iops_wr": 0, "ro": false, "node-name": "#block194", "back=
ing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold=
": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": fals=
e, "direct": false, "writeback": true}, "file": "base.qcow2", "encryption_k=
ey_missing": false},=20


{"iops_rd": 0, "detect_zeroes": "off", "image": {"virtual-size": 1073741824=
, "filename": "target.qcow2", "cluster-size": 65536, "format": "qcow2", "ac=
tual-size": 352256, "format-specific": {"type": "qcow2", "data": {"compat":=
 "1.1", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false}}, "=
dirty-flag": false}, "iops_wr": 0, "ro": false, "node-name": "foo", "backin=
g_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold"=
: 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false=
, "direct": false, "writeback": true}, "file": "target.qcow2", "encryption_=
key_missing": false}, {"iops_rd": 0, "detect_zeroes": "off", "image": {"vir=
tual-size": 1074135040, "filename": "target.qcow2", "format": "file", "actu=
al-size": 352256, "dirty-flag": false}, "iops_wr": 0, "ro": false, "node-na=
me": "#block008", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_w=
r": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "ca=
che": {"no-flush": false, "direct": false, "writeback": true}, "file": "tar=
get.qcow2", "encryption_key_missing": false}]}=20


What I don't understand is how do you map device to the blockdev ?=20

qemu doc said something like=20

-device virtio-blk,drive=3Dblk0 where blk0 is the nodename.=20

but when I blockdev-mirror, the target blockdev has a new nodename.=20
So how does it work ?=20


----- Mail original -----=20
De: "Kashyap Chamarthy" <kchamart@redhat.com>=20
=C3=80: "aderumier" <aderumier@odiso.com>=20
Cc: "qemu-devel" <qemu-devel@nongnu.org>=20
Envoy=C3=A9: Mercredi 19 Avril 2017 14:58:01=20
Objet: Re: [Qemu-devel] blockdev-mirror , how to replace old nodename by ne=
w nodename ?=20

On Wed, Apr 19, 2017 at 02:28:46PM +0200, Alexandre DERUMIER wrote:=20
> Thanks I'll try. (I'm on 2.9.0-rc4)=20
>=20
> can you send your initial qemu command line ?=20

$ ~/build/qemu-upstream/x86_64-softmmu/qemu-system-x86_64 \=20
-display none -nodefconfig -nodefaults -m 512 \=20
-device virtio-scsi-pci,id=3Dscsi -device virtio-serial-pci \=20
-blockdev node-name=3Dfoo,driver=3Dqcow2,file.driver=3Dfile,file.filename=
=3D./base.qcow2 \=20
-monitor stdio -qmp unix:./qmp-sock,server,nowait=20

> also :=20
>=20
> >>"execute":"blockdev-add",=20
> >>"arguments":{=20
> >>"driver":"qcow2",=20
> >>"node-name":"node1",=20

Oops, it should be 'node2'. Copy / paste mistake, sorry.=20

> ...=20
>=20
> then=20
>=20
>=20
> >>"execute":"blockdev-mirror",=20
> >>"arguments":{=20
> >>"device":"foo",=20
> >>"job-id":"job-2",=20
> >>"target":"node2", --> node2 ?=20
> >>"sync":"full"=20

With the above copy / paste error I noted in the `blockdev-add` command,=20
the commands I noted in my previous email should work as expected.=20

Regards,=20
Kashyap=20

> ----- Mail original -----=20
> De: "Kashyap Chamarthy" <kchamart@redhat.com>=20
> =C3=80: "aderumier" <aderumier@odiso.com>=20
> Cc: "qemu-devel" <qemu-devel@nongnu.org>=20
> Envoy=C3=A9: Mercredi 19 Avril 2017 12:43:00=20
> Objet: Re: [Qemu-devel] blockdev-mirror , how to replace old nodename by =
new nodename ?=20
>=20
> On Wed, Apr 19, 2017 at 09:08:20AM +0200, Alexandre DERUMIER wrote:=20
> > Hi,=20
> >=20
> > I'm trying to implement blockdev-mirror, to replace drive-mirror as we=
=20
> > can pass more options with blockdev-mirror.=20
> >=20
> >=20
> > I would like to mirror an attached blockdev to a new blockdev, then=20
> > switch at the end of block-job-complete, like for drive-mirror.=20
>=20
> [...]=20
>=20
> > blockdev-mirror:=20
> >=20
> > {"arguments":{"job-id":"drive-virtio0","target":"tempmirror","sync":"fu=
ll","replaces":"drive-virtio0","device":"drive-virtio0"},"execute":"blockde=
v-mirror"}=20
> >=20
> > (I have try with or without replaces option)=20
> >=20
> > then query-name-block-nodes, show vm-138-disk-2.raw file on tempmirror=
=20
> > "node-name", and vm-138-disk1.qcow2 on "drive-virtio0" node-name=20
> >=20
> > I expected that both was switched, like for drive-mirror.=20
>=20
> For me, 'blockdev-mirror' does do the switch when I issue=20
> 'block-job-complete' (similar to 'drive-mirror')=20
>=20
> The below is my test from Git:=20
>=20
> I was here (on Git):=20
>=20
> $ git describe=20
> v2.9.0-rc5=20
>=20
> -----------------------------------------------------------------------=
=20
> $ qemu-img create -f qcow2 /export/target2.qcow2 1G=20
> Formatting '/export/target2.qcow2', fmt=3Dqcow2 size=3D1073741824 encrypt=
ion=3Doff cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"blockdev-add",=20
> "arguments":{=20
> "driver":"qcow2",=20
> "node-name":"node1",=20
> "file":{=20
> "driver":"file",=20
> "filename":"/export/target2.qcow2"=20
> }=20
> }=20
> }=20
> {"return": {}}=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {"execute":"query-named-block-nodes"}=20
> [...]=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"blockdev-mirror",=20
> "arguments":{=20
> "device":"foo",=20
> "job-id":"job-2",=20
> "target":"node2",=20
> "sync":"full"=20
> }=20
> }=20
> {"return": {}}=20
> {"timestamp": {"seconds": 1492598410, "microseconds": 35946}, "event": "B=
LOCK_JOB_READY", "data": {"device": "job-2", "len": 24182784, "offset": 241=
82784, "speed": 0, "type": "mirror"}}=20
> -----------------------------------------------------------------------=
=20
> QMP>=20
> {=20
> "execute":"block-job-complete",=20
> "arguments":{=20
> "device":"job-2"=20
> }=20
> }=20
> {"return": {}}=20
> {"timestamp": {"seconds": 1492598419, "microseconds": 115458}, "event": "=
BLOCK_JOB_COMPLETED", "data": {"device": "job-2", "len": 24182784, "offset"=
: 24182784, "speed": 0, "type": "mirror"}}=20
> -----------------------------------------------------------------------=
=20
>=20
>=20
> [...]=20
>=20
>=20
> --=20
> /kashyap=20
>=20
