Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A176C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:28:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8009206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 09:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t799YKpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8009206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i15rn-0001q4-03
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 05:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1i15pU-0007Cq-W4
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1i15pT-0002iX-LN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:25:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1i15pT-0002i2-EQ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 05:25:55 -0400
Received: by mail-wm1-x344.google.com with SMTP id p74so8251801wme.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Nmde1gDUhIoxevUR9BImVk18TVlzBKWkwG2u+y8zT5A=;
 b=t799YKpIbhoUMaNFfixxJV09wt5YYNrl5ySXPAKegCGeL35p7YwdKVzGy278FHOE2I
 3apMO1n78ylBiHuv6p6r4aezcL3bzlYVRb+OYGPsVy1tzB0Y6RJAyDhjWMutqjuqAYcS
 dlMcDjbBxcbXptH6sPoLHWlA5XNAQbDIrxfE5rAoZMbsLTTridzqgyWkC5wz5k6Jd0Vv
 RA54BGdLogJfKp4TGhCX3EhOc7yqiK1dBNcoYIaj2ykXjgp3T5W8+cUvhJaTp1vOUNiq
 JYM6LBov5lqNLxnvqSGLOIeoG9xjU+5NZsFzSQH06+u0GLsG/Tm+d6q+ooBEdpy0LJSd
 bl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Nmde1gDUhIoxevUR9BImVk18TVlzBKWkwG2u+y8zT5A=;
 b=sjaVM/YHkCbWhp08II7UZDjG0HqoB2vJ6DC1W2XLJxKSzPtStBjfSWorSPNxEgoBwx
 RrN/RImL4nCMbOs3Hk9k2iO4ZVILpIRbXEjlShUHt/+XERSKiY2bHhP1F9g6iO6UVbl2
 DMnjl93KP52dWrVPhm6TnRO3tNlB92UIUfZA4/Y4QBr/YmTo05MzCrU1vTWANX/VwkX6
 EOXzoasRv4QFmt/J35EOFQbtWPX4uJHLoxIf5KogqjiWT8/MzbK4QnSZrITQn/80gVQj
 dP6/xYg0vCc5ZXjEFaUwghdR6i6jeohfOeKfbY8R9QFaj8846uEJ3qGzt21sZknfSM8E
 JqGQ==
X-Gm-Message-State: APjAAAWbo6ISNXmMODKAycLc6iu1qO6F4/zXTES09VIv4Qjl9WNZUPeC
 KqXnoSMUhtU5PQZxzSI/wL4=
X-Google-Smtp-Source: APXvYqw2f6reymGirp1bzKKxQVoIeiXbiQry1mPsP+thfk58M6hn+UApeYvFrxEg1aFJM0EVNsbJzA==
X-Received: by 2002:a1c:f110:: with SMTP id p16mr3857885wmh.59.1566552353775; 
 Fri, 23 Aug 2019 02:25:53 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id r123sm3274198wme.7.2019.08.23.02.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2019 02:25:52 -0700 (PDT)
Date: Fri, 23 Aug 2019 10:25:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190823092551.GA12092@stefanha-x1.localdomain>
References: <20190816143321.20903-1-dgilbert@redhat.com>
 <20190816143321.20903-2-dgilbert@redhat.com>
 <20190818065944-mutt-send-email-mst@kernel.org>
 <20190821191118.GN3309@work-vm>
 <20190822085237.GA20491@stefanha-x1.localdomain>
 <20190822111916.735fd3ce.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <20190822111916.735fd3ce.cohuck@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: add vhost-user-fs base device
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
Cc: qemu-devel@nongnu.org, vgoyal@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 11:19:16AM +0200, Cornelia Huck wrote:
> On Thu, 22 Aug 2019 09:52:37 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > On Wed, Aug 21, 2019 at 08:11:18PM +0100, Dr. David Alan Gilbert wrote:
> > > * Michael S. Tsirkin (mst@redhat.com) wrote: =20
> > > > On Fri, Aug 16, 2019 at 03:33:20PM +0100, Dr. David Alan Gilbert (g=
it) wrote: =20
>=20
> > > > > +static void vuf_device_realize(DeviceState *dev, Error **errp)
> > > > > +{
> > > > > +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> > > > > +    VHostUserFS *fs =3D VHOST_USER_FS(dev);
> > > > > +    unsigned int i;
> > > > > +    size_t len;
> > > > > +    int ret;
> > > > > +
> > > > > +    if (!fs->conf.chardev.chr) {
> > > > > +        error_setg(errp, "missing chardev");
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    if (!fs->conf.tag) {
> > > > > +        error_setg(errp, "missing tag property");
> > > > > +        return;
> > > > > +    }
> > > > > +    len =3D strlen(fs->conf.tag);
> > > > > +    if (len =3D=3D 0) {
> > > > > +        error_setg(errp, "tag property cannot be empty");
> > > > > +        return;
> > > > > +    }
> > > > > +    if (len > sizeof_field(struct virtio_fs_config, tag)) {
> > > > > +        error_setg(errp, "tag property must be %zu bytes or less=
",
> > > > > +                   sizeof_field(struct virtio_fs_config, tag));
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > > +    if (fs->conf.num_queues =3D=3D 0) {
> > > > > +        error_setg(errp, "num-queues property must be larger tha=
n 0");
> > > > > +        return;
> > > > > +    } =20
> > > >=20
> > > > The strange thing is that actual # of queues is this number + 2.
> > > > And this affects an optimal number of vectors (see patch 2).
> > > > Not sure what a good solution is - include the
> > > > mandatory queues in the number?
> > > > Needs to be documented in some way. =20
> > >=20
> > > Should we be doing nvectors the same way virtio-scsi-pci does it;
> > > with a magic 'unspecified' default where it sets the nvectors based on
> > > the number of queues?
> > >=20
> > > I think my preference is not to show the users the mandatory queues. =
=20
> >=20
> > I agree.  Users want to control multiqueue, not on the absolute number
> > of virtqueues including mandatory queues.
>=20
> I agree as well, but let me advocate again for renaming this to
> 'num_request_queues' or similar to make it more obvious what this number
> actually means.

Good idea.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1fsR8ACgkQnKSrs4Gr
c8iJCQgAvn5W7gEuUzLIwhDooyDkxG1/Nw3NODBPrMDC2TPOGHVMHbF9i/u53Ecj
svWTz2trU3FDTdsfHVPYy/iaXN4JkenRxevJKFHktC831hU/vdvu5lOhWlLWcw2o
wG4huti8QrKBXXV4dFdbeeGA5SR3LwcV5htIPEd/gsIOvP/3ovp9m8MIq0xORe5S
B3bnTMd1U6fTcWkWL+iOOoQbuagwnz3+lcQcCi7kD10MvPJ0T6DaWV+l0P3lHoXO
JevfE6pMzDlnjARnv+me/jSoX7hdTdDdUKFCK/8dgUJHTYKq1nMPI3WoCR4LAPbM
ILASX+4R+ddtb855CnteRhitGjbRwA==
=nvkl
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

