Received: from eggs.gnu.org ([2001:4830:134:3::10]:40601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gMTx8-0000up-Bo
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:21:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gMTwy-0000Wb-AT
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:21:37 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:35947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gMTwo-00008n-O3
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 03:21:23 -0500
Received: by mail-yb1-xb41.google.com with SMTP id g192-v6so5039445ybf.3
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 00:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
	<CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
	<b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
	<CAOEp5OeNpxdmuNqSTr8C2NZ=oSOY6S4TO3Y5PY+1dKDbap4zDw@mail.gmail.com>
	<20181112155208-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181112155208-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Nov 2018 10:21:07 +0200
Message-ID: <CAOEp5OfOkkGErqyH5NaiZF24KpHbj_AXd+GoMbZhTR-qbUZvFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Nov 12, 2018 at 10:53 PM Michael S. Tsirkin <mst@redhat.com> wrote:

> On Mon, Nov 12, 2018 at 01:31:36PM +0200, Yuri Benditovich wrote:
> >
> >
> > On Mon, Nov 12, 2018 at 11:26 AM Jason Wang <jasowang@redhat.com> wrote=
:
> >
> >
> >     On 2018/11/12 =E4=B8=8B=E5=8D=884:57, Yuri Benditovich wrote:
> >     >
> >     > On Mon, Nov 12, 2018 at 4:54 AM Michael S. Tsirkin <mst@redhat.co=
m
> >     > <mailto:mst@redhat.com>> wrote:
> >     >
> >     >     On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri Benditovich
> wrote:
> >     >     >     > @@ -66,12 +143,16 @@ typedef struct VirtIONet {
> >     >     >     >      VirtIONetQueue *vqs;
> >     >     >     >      VirtQueue *ctrl_vq;
> >     >     >     >      NICState *nic;
> >     >     >     > +    QTAILQ_HEAD(, NetRscChain) rsc_chains;
> >     >     >
> >     >     >     what exactly happens with these chains on migration?
> >     >     >
> >     >     >
> >     >     > This feature (software implementation of RSC in QEMU) is
> >     >     intended to be used in
> >     >     > the environment of certification tests which never uses
> migration.
> >     >
> >     >     Should this feature disable migration then?
> >     >
> >     >
> >     > IMO, this should not. But if you find it mandatory, please respon=
d
> and
> >     > I will add the migration blocker.
> >
> >
> >     So if my understanding is correct, it's safe to do nothing even if =
we
> >     allow migration for RSC?
> >
> >
> > This does not create any unrecoverable failure (assertion, BSOD),
> although
> > some data (coalesced parts of packets not delivered yet to guest) will
> be lost.
>
> If guest has no way to detect none of these packets were ever
> received by card, then I guess it's fine. Needs a
> comment in case we start caring about packet loss around
> migration.
>
>
Where is the best place to place such a comment in the code?
Are there more notes toward v3 of the patch?



> >
> >
> >     Thanks
> >
> >
> >
>
