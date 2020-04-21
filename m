Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D843BC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C6B02064C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXny1Qlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C6B02064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQv9u-0001Tk-SC
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 11:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jQv8v-0000bd-GD
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:49:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jQv8r-0000c5-Iq
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:49:01 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40137)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jQv8r-0000b2-4D
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 11:48:57 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so4241921wmc.5
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=C+N4SGmnDiVF7RY+rbNoZ50HoX2fb1nnIIoeuSDfDWA=;
 b=IXny1QlvexJIsbQMMhnqKeJu8KLIEOz0IYC41OhS2cYpSQ2pn0QmJzjNo7YXzbdz4X
 vVHY/le/J1FKuyvyQ3JyrkoxsHrZBkmcTfxOE+jmudAjyYxnB/fSw0FEziApOQ9TdJe3
 FozRlQnxKXuiNuHM+o5prBDC/oBn4T20SCUY+Sq61Erv/o+pkaOCOUU/5q6tt7gFoZmc
 3mKJHSWTL6N1F/AVXlG+iGfz+047BWxPYIFn9SfXo1pmn8U140MGFBwhwkRDfdXiEUcc
 nSy9qE/r6AlwTeMgR7hvBDQ4/CZa7sZO7NCZrU7C3slV5qp9rzFPjkXq6NiKMENee5B2
 K18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=C+N4SGmnDiVF7RY+rbNoZ50HoX2fb1nnIIoeuSDfDWA=;
 b=trwPj75o4gpl6TMtKwlXX1KihSkRFOWPmeDwaQMLvVfyYBlJxC26Qa8qzQmf56s7b8
 8/BsPquAO/UO//+pv50WF2+f6hYou0LICdG6UN/zO+tUoTJdlQRJ+3yvwFJq21npG6bH
 uBBHXOluegYaY5WmF/nXywArZLD9rOy4ISDoxMaKhrUf5XGApZNDBi7KYb2xzcgf8wES
 K3vudwNz4fefAFNJnnYDNDZyj3/yppYnjG0ADnCxj6r8Ewu9Soh777ZCFJKW2pNkQWgp
 ST5jI4cPqyWO/i9FvED1KeNy0JSFdqHLe0svRHLunZHz42JZmf6+h9ql/Zp0XlytlY9V
 yNxw==
X-Gm-Message-State: AGi0PubT07/3JPG9ZqUELq1t9XtexGP+uYRiVvkrMXqBWZZnOStw4FOF
 iomY3sd6IwaDWegC9EtevWk=
X-Google-Smtp-Source: APiQypKXwi5mBFvJfOFFzhEm1q80eYmhBZuElOOXffICC1RcztvvXpFxhvKURZVQW9rO5xl/JaGvQA==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr5431111wma.162.1587484135583; 
 Tue, 21 Apr 2020 08:48:55 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b12sm4602048wro.18.2020.04.21.08.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 08:48:53 -0700 (PDT)
Date: Tue, 21 Apr 2020 16:48:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user backends?
Message-ID: <20200421154852.GB47385@stefanha-x1.localdomain>
References: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
 <20190703100431.GA17523@stefanha-x1.localdomain>
 <20200410002116.GA7478@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <20200410002116.GA7478@localhost.localdomain>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: dgilbert@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2020 at 08:21:16PM -0400, Raphael Norwitz wrote:
> On Wed, Jul 03, 2019 at 11:04:31AM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jul 02, 2019 at 10:08:54PM +0000, Raphael Norwitz wrote:
> > > For background I am trying to work around a ram slot limit imposed by=
 the vhost-user protocol. We are having trouble reconciling the comment her=
e: https://github.com/qemu/qemu/blob/master/hw/virtio/vhost-user.c#L333  th=
at =E2=80=9CFor non-vring specific requests, like VHOST_USER_SET_MEM_TABLE.=
, we just need to send it once the first time=E2=80=9D and the high level i=
mplementation of memory hot-add, which calls set_mem_table every time a VM =
hot adds memory.
> > >=20
> > > A few questions:
> > > 1.
> > > What exactly is the check `if (vhost_user_one_time_request(msg->hdr.r=
equest) && dev->vq_index !=3D 0)` for? In the message for commit b931bfbf04=
2983f311b3b09894d8030b2755a638, which introduced the check, I see it says =
=E2=80=9Cnon-vring specific messages[, which should] be sent only once=E2=
=80=9D and gives VHOST_USER_SET_MEM_TABLE as an example one such message. T=
he `vhost_user_one_time_request()` call clearly checks whether this type of=
 message is the kind of message is supposed to be sent once of which VHOST_=
USER_SET_MEM_TABLE is one. Why, then, does this commit add the check if `de=
v->vq_index !=3D 0`? It seems like there is a latent assumption that after =
the first call dev->vq_index should be set to some value greater than one, =
however for many cases such as vhost-user-scsi devices we can see this is c=
learly not the case https://github.com/qemu/qemu/blob/master/hw/scsi/vhost-=
user-scsi.c#L95. Is this check then =E2=80=98broken=E2=80=99 for such devic=
es?
> > >=20
> > > 2.
> > > If this check is indeed broken for such devices, and set_mem_table ca=
ll is only supposed to be run once for such devices, is the ability to call=
 it multiple times technically a bug for devices such as vhost-user-scsci d=
evices? If so, this would imply that the existing ability to hot add memory=
 to vhost-user-scsi devices is by extension technically a bug/unintended be=
havior. Is this the case?
> >=20
> > Hi Raphael,
> > David Gilbert and I recently came to the conclusion that memory hotplug
> > is not safe in vhost-user device backends built using libvhost-user.
>=20
> Hi David, Sefan,
>=20
> Just want to follow up here. Sorry - I know this was a while ago.
>=20
> I am looking to add postcopy migration support for my patch set lifting
> the vhost-user max ram slots limitation
> (https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06641.html)
> and it seems the most convienient way to do this would be to add support
> for my new protocol feature in libvhost-user and then test with
> vhost-user-bridge.
>=20
> I've briefly looked through the libvhost-user code and the hot-add path
> looks safe enough to me (or at least no more broken than the regular
> vhost-user memory hot-add path).
>=20
> Can you elaborate a little more about why memory hot-add is unsafe with
> vhost-user device backends built with libvhost-user, as opposed to those
> using the raw vhost-user protocol semantics?

The libvhost-user problem is that the library is mostly designed for a
single-threaded event loop that handles all virtqueue and vhost-user
protocol activity.

As soon as virtqueues are handled by dedicated threads there are race
conditions between the virtqueue threads and the vhost-user protocol
thread.

A virtqueue thread may or may not have an up-to-date view of memory
translation.  This can result in it missing memory that is currently
being hotplugged and continuing to access memory that has been removed.

Dave might have additional comments.

Stefan

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6fFeQACgkQnKSrs4Gr
c8h86QgAuh/UQjyUh26yDUG1Bp4TVpFYQ3kX7cpKUiBuiJhtACumqsZ0kI9rl37r
I+ZGb1GA8stdvz9cgflI1Rt0xbCYRe5thVayvVcNLBNsILL8BbP5sVsN1wd7CzEb
mW8teF/1n4v50YzMLGGSqjW+yAd6mwGOrN6obUKzexfHUHg8+E/LuQieiz1PU+mA
uzHNxW2jx19fK8SCXx7LdncArSzwefwxuKqsCY42yl78kBPtMtHHDs2eRe2jbI1G
v1dB3toLZaFWGPmSczawUJ1SSlyR5mN6mMJQXoJ5q98hrWWOUAtiH9t4fdFroTXL
dPlLRmflOCf+Wo5GMETRWFrO7g+BOw==
=W10g
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--

