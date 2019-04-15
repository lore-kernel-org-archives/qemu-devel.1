Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50DDC10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 193FC20693
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 08:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQsiV4LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 193FC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFxDQ-0000yh-5L
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 04:43:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFxCb-0000dP-HC
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hFxCa-0000A1-CV
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 04:42:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41581)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>)
	id 1hFxCX-00006Z-1R; Mon, 15 Apr 2019 04:42:53 -0400
Received: by mail-wr1-x434.google.com with SMTP id r4so20731952wrq.8;
	Mon, 15 Apr 2019 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=b0luPt+0s1YmwnuzT62wjzVtRyFazSLZRY5ljvPYX3Y=;
	b=sQsiV4LL4FwVyRdxlgHiNpldxnO8UbyB1wx3IfbNmhrXU/CTk8ES1+XYjGy1BqvH/j
	j4IEFNPKkuy5yyb2IOGxn5UeTFfod78yEozHieZHSM6Ko0PdcrtkFOBYVo3MSQTRJW3Q
	rCyo3cSEDcORxgGf8s8WAtBWc4wwSs/VjaEUmwCOByNb6MZ1/Rq2DuZv82sdY9okXBcV
	/uvd1FOWqZ8y2XckWG28AnvZFFnm5g4suqnTSipevQOhfYVWIQY/7yMvxm3BXK6zNglk
	d0IHcIv8/hyoHONkgagqp39qQxwbagiivrGFghFbw3AXBmVv7hFUWLLWvaxx85drBckH
	TSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=b0luPt+0s1YmwnuzT62wjzVtRyFazSLZRY5ljvPYX3Y=;
	b=pyLgIvX8Rrm/UlCcVsSu3ffOWthsGYfy4/SRHj3D/wTkhhSRMYiQdZ8frsGCVtwvm+
	iR7LQ1lTJht/Bbu8ZER1JWScPmgn9LXZtfZ1gDF2SAoVWWEDTXqaFytbFf3o3fh0k0Ri
	6vyPWoptZGPDUn3uOqK6EtUJlmBKi2RoE+X80+Op8DMypvge65/k8+9nUnW4vfeIsmfs
	an99Aaeyk/fXpxegCO3/xilEoIkesqMWIqCStufgWogFf1gwSmd2xLxsUQ4OICW2J0aq
	/KntrOZPRbp3KmGO15c7sKJoMGRsM+qGoNcUtiD/FiFglQ1/sScRQ6iFa3VdGc3CnK1b
	e6hw==
X-Gm-Message-State: APjAAAWsfUTZuerCYEfXz6gCcP6W6WksqKZDfimSuDiWWMnQVFE4oe3H
	c2uwm9KkFIUsfcJDQwLH/Bs=
X-Google-Smtp-Source: APXvYqwYeoMr5Xz0aKd4HQwgKSu6pUA1EMzbUge05IoMoaqD+xyejoNnPNLRd3d9pIA8hWN64t3Diw==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr6367326wrl.214.1555317771382; 
	Mon, 15 Apr 2019 01:42:51 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	y1sm139708897wrd.34.2019.04.15.01.42.50
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 01:42:50 -0700 (PDT)
Date: Mon, 15 Apr 2019 09:42:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paul Durrant <Paul.Durrant@citrix.com>
Message-ID: <20190415084249.GA29134@stefanha-x1.localdomain>
References: <20190408151617.13025-1-paul.durrant@citrix.com>
	<20190408151617.13025-3-paul.durrant@citrix.com>
	<20190410125708.GE1435@perard.uk.xensource.com>
	<582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <582f92f1ddf24985b75c32fe913784df@AMSPEX02CL01.citrite.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] xen-bus: allow AioContext
 to be specified for each event channel
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	Anthony Perard <anthony.perard@citrix.com>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415084249.dHbV9NK4R-bLMx_eYX0rc4xBoVHZYHkFvlLxsIqjNaw@z>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 03:20:05PM +0000, Paul Durrant wrote:
> > -----Original Message-----
> > From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> > Sent: 10 April 2019 13:57
> > To: Paul Durrant <Paul.Durrant@citrix.com>
> > Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-devel@lists.xenpr=
oject.org; Stefano Stabellini
> > <sstabellini@kernel.org>; Stefan Hajnoczi <stefanha@redhat.com>; Kevin =
Wolf <kwolf@redhat.com>; Max
> > Reitz <mreitz@redhat.com>
> > Subject: Re: [PATCH 2/3] xen-bus: allow AioContext to be specified for =
each event channel
> >=20
> > On Mon, Apr 08, 2019 at 04:16:16PM +0100, Paul Durrant wrote:
> > > This patch adds an AioContext parameter to xen_device_bind_event_chan=
nel()
> > > and then uses aio_set_fd_handler() to set the callback rather than
> > > qemu_set_fd_handler().
> > >
> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > > ---
> > > @@ -943,6 +944,7 @@ static void xen_device_event(void *opaque)
> > >  }
> > >
> > >  XenEventChannel *xen_device_bind_event_channel(XenDevice *xendev,
> > > +                                               AioContext *ctx,
> > >                                                 unsigned int port,
> > >                                                 XenEventHandler handl=
er,
> > >                                                 void *opaque, Error *=
*errp)
> > > @@ -968,8 +970,9 @@ XenEventChannel *xen_device_bind_event_channel(Xe=
nDevice *xendev,
> > >      channel->handler =3D handler;
> > >      channel->opaque =3D opaque;
> > >
> > > -    qemu_set_fd_handler(xenevtchn_fd(channel->xeh), xen_device_event=
, NULL,
> > > -                        channel);
> > > +    channel->ctx =3D ctx;
> > > +    aio_set_fd_handler(channel->ctx, xenevtchn_fd(channel->xeh), fal=
se,
> > > +                       xen_device_event, NULL, NULL, channel);
> >=20
> > I wonder if the `'is_external' parameter of aio_set_fd_handler shoud be
> > `true' here, instead. That flag seems to be used when making a snapshot
> > of a blockdev, for example.
> >=20
> > That was introduced by:
> > dca21ef23ba48f6f1428c59f295a857e5dc203c8^..c07bc2c1658fffeee08eb46402b2=
f66d55b07586
> >=20
> > What do you think?
>=20
> Interesting. I admit I was merely transcribing what qemu_set_fd_handler()=
 passes without really looking into the values. Looking at the arguments th=
at virtio-blk passes to aio_set_event_notifier() though, and what 'is_exter=
nal' means, it would appear that setting it to true is probably the right t=
hing to do. Do you want me to send a v2 of the series or can you fix it up?

Hi,
Handlers are invoked by the aio_poll() event loop.  Some handlers are
considered "external" in the sense that they submit new I/O requests
=66rom the guest or outside world.  Others are considered "internal" in
the sense that they are part of the block layer and not an entry point
into the block layer.

There are points where the block layer wants to run the event loop but
new requests must not be submitted.  In this case aio_disable_external()
will be called so that "external" handlers are not processed.

For example, see virtio's virtio_queue_aio_set_host_notifier_handler().
This is the virtqueue kick ioeventfd and it shouldn't be processed when
aio_disable_external() has been called.

Stefan

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJctEQJAAoJEJykq7OBq3PIu0sH/j33XBML1ks0HDKmv3/DT/bM
RTx2pqg/l3kxLGJo6fB7nrtfgjMjlR066YVR3XTC2NigraF1YD/lJkdOHOUOcKXP
abr/QnY5IrHIY+n4+xapM5uozs4K+thrSmKK6CGFh+KkZdBGy5FT9csPUie7198N
oXf0fhVGjxTwJc+hMvbzJrryWFKOlH+AIUR/Hb9E1ExbssvddXh63jyetSnk48f6
Orjl6O8ddKDdSs7yoJVcuVhJ+0ZtcmaYvwbhcdUSoOQ6lFMezkihsrxb8VmGG86T
wMjjhmVPIv5IiU61AiVCkCNT0OlKCeUf3eEwdn8GfWWyJpmNz+BTblUfQ1ecPVA=
=0fKF
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

