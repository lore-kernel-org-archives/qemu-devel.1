Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FCCC32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39615207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqAF2O+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39615207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioP9q-0006pR-AI
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59965)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ioP9E-00067x-Hj
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ioP9B-0004i7-Fw
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:58:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ioP9B-0004gx-BQ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578304684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LNlCJBWJPATvWPsS82+/NWD0HbofVteiRNygFg343+U=;
 b=cqAF2O+F8M4rGSGXeqLllhKTlIOL98cVYXv9cXkDtS7vcgX3RogzRvXBZpwEmz1JF5sMC7
 uwo4sevtGvVsOTc3GFHNfOl4vYakGkFZZ+FqwTQxTz77Pw0JMyom0S3XoZLmK5ojoxMrni
 RK2J4dZxZpUfC3lg7q8ac6hN2VHVOhY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Hwf8ThAIN82GcfkepWvwYg-1; Mon, 06 Jan 2020 04:58:00 -0500
Received: by mail-qk1-f198.google.com with SMTP id x127so29071676qkb.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 01:58:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=td1ZYZa3KyvUVU0VaAQ+9Hf9EcjjZqMSwFwwiTXYdgk=;
 b=Wzs6wSJ+neO+31AL6HIM0yQdhF5/xu6rBQ6b5EUYlxfm/94frDcLC8X/eKEWh69hZl
 JCT4wT4XIJlQqFvXuTlz581qnmgMMevNDUytMXKOIMlrxCIAaJoBhdlxRceN2TkzjEO5
 H6lmgt0NSz230t2uaWQ9SnR20c+rV3UcnS6BJa4aAWfNTLk2M4etSEbAEZAyjHwKbi+2
 CrTxbnSuIWbRko1bN+oLpggY6/MzYti9C9EmdxaXDn7RriOgkrkCEf0R5W6lSr97lCSP
 r+h7uAgLgn/Ab4U9JDTvDo+EvvxOJZdVEbzflDNFoU9gPwfYtrMDuVvCpZ7u4fKLbqqE
 FO4g==
X-Gm-Message-State: APjAAAXUZ4OA7YdkNlkWK9fxyxD1USheRanosCbabBHlD+1ZSX72HruL
 Wu2dBmHhky2l08nMpLFtAxn0fUpeZzP8vpSXMWs439SfQiAnBemK4K8oKlUYTvimdY1vfHLiucm
 ols08ANFKOVoK6D8=
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr76653954qvq.113.1578304680428; 
 Mon, 06 Jan 2020 01:58:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEVGyY5zJfYKnykZwYNKicJs6dZw/pTcGvD0regnFwcpuODKgNLdj/QfbAQ4Jr/EU5ROj4Jw==
X-Received: by 2002:ad4:51cc:: with SMTP id p12mr76653936qvq.113.1578304680132; 
 Mon, 06 Jan 2020 01:58:00 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id 17sm47230qkl.106.2020.01.06.01.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 01:57:59 -0800 (PST)
Date: Mon, 6 Jan 2020 04:57:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH 1/2] virtio: reset region cache when on queue deletion
Message-ID: <20200106044351-mutt-send-email-mst@kernel.org>
References: <20191226043649.14481-1-yuri.benditovich@daynix.com>
 <20191226043649.14481-2-yuri.benditovich@daynix.com>
 <05ead321-e93f-1b07-01cc-e0b023be8168@redhat.com>
 <CAOEp5OdDj_=c_75FsM45iQnqDYBPz=Fn48FbR2FHcY=5D3rB-Q@mail.gmail.com>
 <20200101184425-mutt-send-email-mst@kernel.org>
 <CAOEp5Oefmj5dM5auk1QpQ3F+CeJXQy+0aXJC1VNmUOj1KHp8aw@mail.gmail.com>
 <20200105063518-mutt-send-email-mst@kernel.org>
 <CAOEp5Of0PYiCu9kPyi7W84ToHrGzTHFkPFBGd0A7AVFkwzVZOg@mail.gmail.com>
 <CAOEp5Oec3x71vPVKDcTBWT4TkgrbSbUZmyDkd2bGF84sXEHUyQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5Oec3x71vPVKDcTBWT4TkgrbSbUZmyDkd2bGF84sXEHUyQ@mail.gmail.com>
X-MC-Unique: Hwf8ThAIN82GcfkepWvwYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Yan Vugenfirer <yan@daynix.com>, pbonzini@redhat.com,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I guess it somehow has to do with the following:

    if (proxy->disable_legacy =3D=3D ON_OFF_AUTO_AUTO) {
        proxy->disable_legacy =3D pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_=
OFF;
    }

so by default device on an express port does not have a legacy interface.

Somehow having a legacy interface fixes things?
Does enabling legacy on q35 without this patch fix things?
And does disabling legacy on PIIX without this patch break thing?

How can having a legacy interface fix things if it's not
even active? I don't know. Is there a chance windows drivers use the
legacy interface on a transitional device by mistake?


On Mon, Jan 06, 2020 at 11:10:18AM +0200, Yuri Benditovich wrote:
> Michael,
> Can you please comment on Jason's question: why we have a problem only wi=
th q35
> and not with legacy pc?
> If you have a simple answer, it will help us in further work with other h=
ot
> plug/unplug problems.
>=20
> Thanks,
> Yuri Benditovich
>=20
> On Sun, Jan 5, 2020 at 6:21 PM Yuri Benditovich <yuri.benditovich@daynix.=
com>
> wrote:
>=20
>=20
>=20
>     On Sun, Jan 5, 2020 at 1:39 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>=20
>         On Thu, Jan 02, 2020 at 09:09:04AM +0200, Yuri Benditovich wrote:
>         >
>         >
>         > On Thu, Jan 2, 2020 at 1:50 AM Michael S. Tsirkin <mst@redhat.c=
om>
>         wrote:
>         >
>         >=C2=A0 =C2=A0 =C2=A0On Thu, Dec 26, 2019 at 11:29:50AM +0200, Yu=
ri Benditovich wrote:
>         >=C2=A0 =C2=A0 =C2=A0> On Thu, Dec 26, 2019 at 10:58 AM Jason Wan=
g <
>         jasowang@redhat.com> wrote:
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > On 2019/12/26 =E4=B8=8B=E5=8D=8812:36, Y=
uri Benditovich wrote:
>         >=C2=A0 =C2=A0 =C2=A0> > > https://bugzilla.redhat.com/show_bug.c=
gi?id=3D1708480
>         >=C2=A0 =C2=A0 =C2=A0> > > Fix leak of region reference that prev=
ents complete
>         >=C2=A0 =C2=A0 =C2=A0> > > device deletion on hot unplug.
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > More information is needed here, the bug=
 said only q35 can
>         meet this
>         >=C2=A0 =C2=A0 =C2=A0> > issue. What makes q35 different here?
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0>
>         >=C2=A0 =C2=A0 =C2=A0> I do not have any ready answer, I did not =
dig into it too much.
>         >=C2=A0 =C2=A0 =C2=A0> Probably Michael Tsirkin or Paolo Bonzini =
can answer without
>         digging.
>         >
>         >
>         >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > >
>         >=C2=A0 =C2=A0 =C2=A0> > > Signed-off-by: Yuri Benditovich <
>         yuri.benditovich@daynix.com>
>         >=C2=A0 =C2=A0 =C2=A0> > > ---
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0hw/virtio/virtio.c | 5 +++=
++
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A01 file changed, 5 insertio=
ns(+)
>         >=C2=A0 =C2=A0 =C2=A0> > >
>         >=C2=A0 =C2=A0 =C2=A0> > > diff --git a/hw/virtio/virtio.c b/hw/v=
irtio/virtio.c
>         >=C2=A0 =C2=A0 =C2=A0> > > index 04716b5f6c..baadec8abc 100644
>         >=C2=A0 =C2=A0 =C2=A0> > > --- a/hw/virtio/virtio.c
>         >=C2=A0 =C2=A0 =C2=A0> > > +++ b/hw/virtio/virtio.c
>         >=C2=A0 =C2=A0 =C2=A0> > > @@ -2340,6 +2340,11 @@ void virtio_del=
_queue(VirtIODevice
>         *vdev, int
>         >=C2=A0 =C2=A0 =C2=A0n)
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].=
vring.num_default =3D 0;
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].=
handle_output =3D NULL;
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0vdev->vq[n].=
handle_aio_output =3D NULL;
>         >=C2=A0 =C2=A0 =C2=A0> > > +=C2=A0 =C2=A0 /*
>         >=C2=A0 =C2=A0 =C2=A0> > > +=C2=A0 =C2=A0 =C2=A0* with vring.num =
=3D 0 the queue will be ignored
>         >=C2=A0 =C2=A0 =C2=A0> > > +=C2=A0 =C2=A0 =C2=A0* in later loops =
of region cache reset
>         >=C2=A0 =C2=A0 =C2=A0> > > +=C2=A0 =C2=A0 =C2=A0*/
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > I can't get the meaning of this comment.
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > Thanks
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >=C2=A0 =C2=A0 =C2=A0> > > +=C2=A0 =C2=A0 virtio_virtqueue_reset_=
region_cache(&vdev->vq[n]);
>         >
>         >
>         >=C2=A0 =C2=A0 =C2=A0Do we need to drop this from virtio_device_f=
ree_virtqueues then?
>         >
>         >
>         >
>         > Not mandatory. Repetitive=C2=A0 virtio_virtqueue_reset_region_c=
ache=C2=A0does
>         not do
>         > anything bad.
>         > Some of virtio devices do not do 'virtio_del_queue' at all.
>         Currently=C2=A0
>         > virtio_device_free_virtqueues resets region cache for them.
>         > IMO, not calling 'virtio_del_queue' is a bug, but not in the sc=
ope of
>         current
>         > series, I'll take care of that later.
>=20
>         Maybe we should just del all queues in virtio_device_unrealize?
>         Will allow us to drop some logic tracking which vqs were created.
>=20
>=20
>=20
>     Yes, this is also possible with some rework of
>     virtio_device_free_virtqueues.
>     virtio-net has some additional operations around queue deletion, it d=
eletes
>     queues when switches from single queue to multiple.
>     =C2=A0
>=20
>=20
>         >
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(vdev-=
>vq[n].used_elems);
>         >=C2=A0 =C2=A0 =C2=A0> > >=C2=A0 =C2=A0}
>         >=C2=A0 =C2=A0 =C2=A0> > >
>         >=C2=A0 =C2=A0 =C2=A0> >
>         >
>         >
>=20
>=20


