Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7D9C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1735C2245D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nliv547j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1735C2245D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXOmH-00055W-W3
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXOkU-0002Xs-2F
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:06:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXOkO-0001Kh-EE
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:06:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXOkN-00012F-37
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574251564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoMcg2xsD9yk1CY0qvuod3fCF7oNTL2PMFSmXUlF5Rg=;
 b=Nliv547j1z8/hdv7jH6GR8HuhBs3qLVJYgkNPaThmWGbJdc2btCgbFM+Pz431TQGwI8kif
 eKiKrO6rwAvurwEdvkoIUNoFl5BrTRE2021GNZ6ljwxT+oPRxNgR9dRMtd+XAadYtiz8nr
 pweXdSeYf7/wReRx63+Dohpu9E7edx4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-HZoHVwBiMAWUzDhbNzAiUw-1; Wed, 20 Nov 2019 07:06:00 -0500
Received: by mail-qk1-f200.google.com with SMTP id 6so15727189qkc.4
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 04:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tQDV3WEObcUPEQTGj6kf0G1kZ+qpBjNye3KoHQYcQik=;
 b=RU6VS9AAt57WizhGxRxWTl3tZXWANXhekhULt8cNqpHI1d0SlD63f9x8xvX2av0UJO
 ISZ0IMZ3/csjEsmICsC/dlPHkR8iAiET34n4jrEv2favYVw+ilTbkYRLqXm7yVZEoSMz
 fJwVKQIYDlGnummpD3TTppNB0VtazUPZSyxFPgpJqbAo0h9iRjU7jbh+ozCRrCTkKfp6
 2FNocszhYRl5RzxxYbioQ+714fo8Hx0YKtaGyOMdOgJ+alwFB3ApSLG9hzmVzE6Sn6Vk
 OEsoKgK7SPoh3sX/aUEv9GP2080tJynf+7W6ribCs9cfinQLkhQzZM06AIEB401BB2sz
 WvpQ==
X-Gm-Message-State: APjAAAUpgI4VY64lj+h47VNAd9+5wSBZE01mYv2PRdpweeADfZRKMyeA
 Hb1N45/qfrLATPzklbPqd6kUX1zQZR/zfH7koEsgefkcwbq07T4bTdeq1NpW9Dz8i28HYhHpSnP
 xKOtoAs35Y2vTLFE=
X-Received: by 2002:ac8:2441:: with SMTP id d1mr2230386qtd.386.1574251560146; 
 Wed, 20 Nov 2019 04:06:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwB3GzgMp1/N+xXfyALbzsejgUSnN+An4WWcHSuc+3tsHoHlh2swo0WaVQSX21qzk2W6eIVpQ==
X-Received: by 2002:ac8:2441:: with SMTP id d1mr2230367qtd.386.1574251559949; 
 Wed, 20 Nov 2019 04:05:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id d139sm11633409qkb.36.2019.11.20.04.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 04:05:59 -0800 (PST)
Date: Wed, 20 Nov 2019 07:05:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 3/4] net/virtio: avoid passing NULL to qdev_set_parent_bus
Message-ID: <20191120070506-mutt-send-email-mst@kernel.org>
References: <20191114141613.15804-1-jfreimann@redhat.com>
 <20191114141613.15804-3-jfreimann@redhat.com>
 <20191120054036-mutt-send-email-mst@kernel.org>
 <20191120120357.brcmoseo46lbc4js@jenstp.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191120120357.brcmoseo46lbc4js@jenstp.localdomain>
X-MC-Unique: HZoHVwBiMAWUzDhbNzAiUw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 20, 2019 at 01:03:57PM +0100, Jens Freimann wrote:
> On Wed, Nov 20, 2019 at 05:46:36AM -0500, Michael S. Tsirkin wrote:
> > On Thu, Nov 14, 2019 at 03:16:12PM +0100, Jens Freimann wrote:
> > > Make sure no arguments for qdev_set_parent_bus are NULL.
> > > This fixes CID 1407224.
> > >=20
> > > Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
> > > ---
> > >  hw/net/virtio-net.c | 14 ++++++++++----
> > >  1 file changed, 10 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > > index ac4d19109e..81650d4dc0 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -2809,8 +2809,16 @@ static bool failover_replug_primary(VirtIONet =
*n, Error **errp)
> > >      if (n->primary_device_opts) {
> > >          if (n->primary_dev) {
> > >              n->primary_bus =3D n->primary_dev->parent_bus;
> > > +            if (n->primary_bus) {
> > > +                qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> > > +            } else  {
> > > +                error_setg(errp, "virtio_net: couldn't set bus for p=
rimary");
> > > +                goto out;
> > > +            }
> > > +        } else {
> > > +            error_setg(errp, "virtio_net: couldn't find primary devi=
ce");
> > > +            goto out;
> > >          }
> >=20
> >=20
> > A bit less messy:
> >=20
> > if (!n->primary_dev) {
> >            error_setg(errp, "virtio_net: couldn't find primary device")=
;
> >            goto err;
> > }
> >=20
> > n->primary_bus =3D n->primary_dev->parent_bus;
> > if (!n->primary_bus) {
> >      error_setg(errp, "virtio_net: couldn't find primary device");
> >          goto err;
> > }
> >=20
> > qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> >=20
> > err:
> > =09return false;
> >=20
> > also is it valid for primary_device_opts to not be present at all?
> > Maybe we should check that too.
> >=20
> >=20
> >=20
> > > -        qdev_set_parent_bus(n->primary_dev, n->primary_bus);
> > >          n->primary_should_be_hidden =3D false;
> > >          qemu_opt_set_bool(n->primary_device_opts,
> > >                  "partially_hotplugged", true, errp);
> > > @@ -2819,10 +2827,8 @@ static bool failover_replug_primary(VirtIONet =
*n, Error **errp)
> > >              hotplug_handler_pre_plug(hotplug_ctrl, n->primary_dev, e=
rrp);
> > >              hotplug_handler_plug(hotplug_ctrl, n->primary_dev, errp)=
;
> > >          }
> > > -        if (!n->primary_dev) {
> > > -            error_setg(errp, "virtio_net: couldn't find primary devi=
ce");
> > > -        }
> > >      }
> > > +out:
> > >      return *errp !=3D NULL;
> > >  }
> >=20
> > I'd handle errors separately from good path.
> > BTW I don't understand something here:
> > *errp !=3D NULL is true on error, no?
> > Why are we returning success?
> > Confused.
> > Just return true would be cleaner imho.
>=20
> I'll fix this and sent a new version as a single patch. As you said
> this is not really a series, just individual patches.
>=20
> Thanks!
>=20
> regards
> Jens

I'd just repost them all then. The series was also threaded weirdly
(e.g. there's no cover letter instead patches 2 and on link to patch 1).

--=20
MST


