Received: from eggs.gnu.org ([2001:4830:134:3::10]:43272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gMARd-0002lu-9s
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1gMARc-0001hY-6K
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:31:53 -0500
Received: from mail-yw1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1gMARb-0001fg-Rf
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:31:52 -0500
Received: by mail-yw1-xc2f.google.com with SMTP id i65-v6so4230331ywc.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 03:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
	<20181109125947-mutt-send-email-mst@kernel.org>
	<CAOEp5OdXFYYDB_7vNFsrtf=iwpL+ys9Hf_0gR-JXJ+wLnmDw5g@mail.gmail.com>
	<20181111215232-mutt-send-email-mst@kernel.org>
	<CAOEp5Oe_TFTpQ_yBGJ-OyCw_Zne7bF0nUGV8XpG+4Fd+TJ7i8g@mail.gmail.com>
	<b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
In-Reply-To: <b800852b-e81e-459c-c6e1-15d4c99fc0eb@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Mon, 12 Nov 2018 13:31:36 +0200
Message-ID: <CAOEp5OeNpxdmuNqSTr8C2NZ=oSOY6S4TO3Y5PY+1dKDbap4zDw@mail.gmail.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>

On Mon, Nov 12, 2018 at 11:26 AM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2018/11/12 =E4=B8=8B=E5=8D=884:57, Yuri Benditovich wrote:
> >
> > On Mon, Nov 12, 2018 at 4:54 AM Michael S. Tsirkin <mst@redhat.com
> > <mailto:mst@redhat.com>> wrote:
> >
> >     On Sun, Nov 11, 2018 at 12:18:54PM +0200, Yuri Benditovich wrote:
> >     >     > @@ -66,12 +143,16 @@ typedef struct VirtIONet {
> >     >     >      VirtIONetQueue *vqs;
> >     >     >      VirtQueue *ctrl_vq;
> >     >     >      NICState *nic;
> >     >     > +    QTAILQ_HEAD(, NetRscChain) rsc_chains;
> >     >
> >     >     what exactly happens with these chains on migration?
> >     >
> >     >
> >     > This feature (software implementation of RSC in QEMU) is
> >     intended to be used in
> >     > the environment of certification tests which never uses migration=
.
> >
> >     Should this feature disable migration then?
> >
> >
> > IMO, this should not. But if you find it mandatory, please respond and
> > I will add the migration blocker.
>
>
> So if my understanding is correct, it's safe to do nothing even if we
> allow migration for RSC?
>

This does not create any unrecoverable failure (assertion, BSOD), although
some data (coalesced parts of packets not delivered yet to guest) will be
lost.


>
> Thanks
>
>
>
