Received: from eggs.gnu.org ([2001:4830:134:3::10]:37235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMage-0007nC-20
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gMagZ-0001Ls-RD
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:33:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gMagZ-0001Ku-Gp
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:33:03 -0500
Date: Tue, 13 Nov 2018 10:32:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181113103232-mutt-send-email-mst@kernel.org>
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
	<CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
	<b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
	<CAOEp5OeNpxdmuNqSTr8C2NZ=oSOY6S4TO3Y5PY+1dKDbap4zDw@mail.gmail.com>
	<20181112155208-mutt-send-email-mst@kernel.org>
	<CAOEp5OfOkkGErqyH5NaiZF24KpHbj_AXd+GoMbZhTR-qbUZvFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOEp5OfOkkGErqyH5NaiZF24KpHbj_AXd+GoMbZhTR-qbUZvFw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: support RSC v4/v6 tcp traffic
 for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Tue, Nov 13, 2018 at 10:21:07AM +0200, Yuri Benditovich wrote:
>=20
>=20
> On Mon, Nov 12, 2018 at 10:53 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>=20
>     On Mon, Nov 12, 2018 at 01:31:36PM +0200, Yuri Benditovich wrote:
>     >
>     >
>     > On Mon, Nov 12, 2018 at 11:26 AM Jason Wang <jasowang@redhat.com>=
 wrote:
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 2018/11/12 =E4=B8=8B=E5=8D=884:57, Yuri Ben=
ditovich wrote:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> On Mon, Nov 12, 2018 at 4:54 AM Michael S. T=
sirkin <mst@redhat.com
>     >=C2=A0 =C2=A0 =C2=A0> <mailto:mst@redhat.com>> wrote:
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0On Sun, Nov 11, 2018 at 1=
2:18:54PM +0200, Yuri Benditovich
>     wrote:
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> @@=
 -66,12 +143,16 @@ typedef struct VirtIONet {
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=
=A0 =C2=A0 =C2=A0 VirtIONetQueue *vqs;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=
=A0 =C2=A0 =C2=A0 VirtQueue *ctrl_vq;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=
=A0 =C2=A0 =C2=A0 NICState *nic;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> +=C2=
=A0 =C2=A0 QTAILQ_HEAD(, NetRscChain) rsc_chains;
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0what=
 exactly happens with these chains on migration?
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> This feature (software =
implementation of RSC in QEMU) is
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0intended to be used in
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0> the environment of cert=
ification tests which never uses
>     migration.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>=C2=A0 =C2=A0 =C2=A0Should this feature disab=
le migration then?
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> IMO, this should not. But if you find it man=
datory, please respond
>     and
>     >=C2=A0 =C2=A0 =C2=A0> I will add the migration blocker.
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0So if my understanding is correct, it's safe t=
o do nothing even if we
>     >=C2=A0 =C2=A0 =C2=A0allow migration for RSC?
>     >
>     >
>     > This does not create any unrecoverable failure (assertion, BSOD),
>     although
>     > some data (coalesced parts of packets not delivered yet to guest)=
 will be
>     lost.
>=20
>     If guest has no way to detect none of these packets were ever
>     received by card, then I guess it's fine. Needs a
>     comment in case we start caring about packet loss around
>     migration.
>=20
>=20
>=20
> Where is the best place to place such a comment in the code?

Maybe where we add the fields that we don't bother migrating.


> Are there more notes toward v3 of the patch?
>=20

Not yet.

>=20
>     >
>     >
>     >=C2=A0 =C2=A0 =C2=A0Thanks
>     >
>     >
>     >
>=20
