Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A42BC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:31:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D522076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 15:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4k+i26i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D522076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRHLO-0007X1-Ik
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 11:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHJg-0005g9-HH
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jRHJf-0001Uw-IP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:29:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1jRHJf-0001T6-3x
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 11:29:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id y24so2883351wma.4
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=zEBgg6jL2k9MthZmD3na92e7fWZW5AcFlMbTEZrfPgc=;
 b=Z4k+i26iaFptLqrhm0lpND2hxRFiFJpGN66LZ3a1u+Q85O53VcJ31yyYG5UjqB8RTr
 XZUv+FCISwDl09lYQp6bgHP7VUuYb7JzlyvZMmxKxYhS5g/cEJNw0eEiEHFNTMzgyKeP
 1afg5Ku57jNiOM92AM9lbwpcRoEViuHcw6fiEEM8pMVra1So1zF2rrnDO85a1M7kp3oh
 vDQR+N65x1115h6VN2McpasmORvMLxyzOKTWgLxX1oYw1ISK9r+9v2+A3ChhQMO5TEXJ
 foE79hD1QfknAC+f9hJW1rjV38vY7Fh467lKjKsZghUgv23Oyn2druYgNI2pHJP4ugeN
 kIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zEBgg6jL2k9MthZmD3na92e7fWZW5AcFlMbTEZrfPgc=;
 b=JjtrMFnms/KPVUdaZ9DVsLialMtBm0qKIKue73i6Q5Gs0tnGAEEh6bWSE9lX4BE6Mq
 wGkFcRrfGC66uECBBoE3sy/R0e5hbUBwPUa1Rkrzyx1Ci+Z2qXEuoyZdEPBHqybKGjjx
 gnTwmb2Ip+//+I0z8cOe4NxQVU8iyUJhRS7w+oYuHGGnokQOYCf0uUnr+ouc/EyeR9c/
 +Ehrc7XN2MyHKL9SK84f3IAIduxuGE0EAk9Mkz3cYNV3PWSC6IwCBvMVp00K2qpqFO7m
 vKbqkzC1s3EF6k2RFSAmIUWkuOdEsjS/y2NymY4oJUewA5Lti0aGjNmo7p/QbtMa+Xuy
 3TLQ==
X-Gm-Message-State: AGi0PuaHJ96eUyW94ZRiGBkKZLm4GRQlBNktTHiqoh3q2Jtgy68wA1Ph
 LFNZRvjIIjkSiqyds3gY1iU=
X-Google-Smtp-Source: APiQypLW5E0PwZK0AbIadSYljTCkdqdSfjjHTL88wXtxm2b1Xihzw2TWRwk1v+ey5SS94iEd+040Sw==
X-Received: by 2002:a05:600c:24cf:: with SMTP id
 15mr10929204wmu.94.1587569372890; 
 Wed, 22 Apr 2020 08:29:32 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id s8sm7902193wru.38.2020.04.22.08.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 08:29:31 -0700 (PDT)
Date: Wed, 22 Apr 2020 16:29:30 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Thanos Makatos <thanos.makatos@nutanix.com>
Subject: Re: RFC: use VFIO over a UNIX domain socket to implement device
 offloading
Message-ID: <20200422152930.GC47385@stefanha-x1.localdomain>
References: <MN2PR02MB62052E54C752229C115EAD898BCF0@MN2PR02MB6205.namprd02.prod.outlook.com>
 <20200401091712.GA221892@stefanha-x1.localdomain>
 <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Content-Disposition: inline
In-Reply-To: <MW2PR02MB372349E25A0842DE045B95F58BD40@MW2PR02MB3723.namprd02.prod.outlook.com>
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
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, Jag Raman <jag.raman@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "Harris,
 James R" <james.r.harris@intel.com>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Felipe Franciosi <felipe@nutanix.com>,
 Kanth Ghatraju <Kanth.Ghatraju@oracle.com>, "Zhang,
 Tina" <tina.zhang@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 11:05:25AM +0000, Thanos Makatos wrote:
> > In order to interoperate we'll need to maintain a protocol
> > specification.  Mayb You and JJ could put that together and CC the vfio,
> > rust-vmm, and QEMU communities for discussion?
> >=20
> > It should cover the UNIX domain socket connection semantics (does a
> > listen socket only accept 1 connection at a time?  What happens when the
> > client disconnects?  What happens when the server disconnects?), how
> > VFIO structs are exchanged, any vfio-over-socket specific protocol
> > messages, etc.  Basically everything needed to write an implementation
> > (although it's not necessary to copy the VFIO struct definitions from
> > the kernel headers into the spec or even document their semantics if
> > they are identical to kernel VFIO).
> >=20
> > The next step beyond the LD_PRELOAD library is a native vfio-over-socket
> > client implementation in QEMU.  There is a prototype here:
> > https://github.com/elmarco/qemu/blob/wip/vfio-user/hw/vfio/libvfio-
> > user.c
> >=20
> > If there are any volunteers for working on that then this would be a
> > good time to discuss it.
>=20
> Hi,
>=20
> I've just shared with you the Google doc we've working on with John where=
 we've
> been drafting the protocol specification, we think it's time for some fir=
st
> comments. Please feel free to comment/edit and suggest more people to be =
on the
> reviewers list.
>=20
> You can also find the Google doc here:
>=20
> https://docs.google.com/document/d/1FspkL0hVEnZqHbdoqGLUpyC38rSk_7HhY471T=
sVwyK8/edit?usp=3Dsharing
>=20
> If a Google doc doesn't work for you we're open to suggestions.

I can't add comments to the document so I've inlined them here:

The spec assumes the reader is already familiar with VFIO and does not
explain concepts like the device lifecycle, regions, interrupts, etc.
We don't need to duplicate detailed VFIO information, but I think the
device model should be explained so that anyone can start from the
VFIO-user spec and begin working on an implementation.  Right now I
think they would have to do some serious investigation of VFIO first in
order to be able to write code.

"only the source header files are used"
I notice the current <linux/vfio.h> header is licensed "GPL-2.0 WITH
Linux-syscall-note".  I'm not a lawyer but I guess this means there are
some restrictions on using this header file.  The <linux/virtio*.h>
header files were explicitly licensed under the BSD license to make it
easy to use the non __KERNEL__ parts.

VFIO-user Command Types: please indicate for each request type whether
it is client->server, server->client, or both.  Also is it a "command"
or "request"?

vfio_user_req_type <-- is this an extension on top of <linux/vfio.h>?
Please make it clear what is part of the base <linux/vfio.h> protocol
and what is specific to vfio-user.

VFIO_USER_READ/WRITE serve completely different purposes depending on
whether they are sent client->server or server->client.  I suggest
defining separate request type constants instead of overloading them.

What is the difference between VFIO_USER_MAP_DMA and VFIO_USER_REG_MEM?
They both seem to be client->server messages for setting up memory but
I'm not sure why two request types are needed.

struct vfio_user_req->data.  Is this really a union so that every
message has the same size, regardless of how many parameters are passed
in the data field?

"a framebuffer where the guest does multiple stores to the virtual
device."  Do you mean in SMP guests?  Or even in a single CPU guest?

Also, is there any concurrency requirement on the client and server
side?  Can I implement a client/server that processes requests
sequentially and completes them before moving on to the next request or
would that deadlock for certain message types?

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6gYtoACgkQnKSrs4Gr
c8hCmQgAxVUuC//86Q8ylZfQDZ7oSwoWDSuAuT83CAeQxplv8np4RCRfRE74OwBE
hOJKl+vRweuNe3N/xAzv1UiUlL9g++/f7/8v9NasODh/CZXOCK5b4ZpQF9Ab1Uc3
l64cGzzz6aGgUcQohPpK08aFbRjJGTDsqObOtxf15fFLRM6ojxm+5ILm5HSj6J1n
jUOjmxGegUj+oKi9o0KAZ2WAlSCQwrq9Cp5+M/SMNcNM2UkTrYmzjGnr0lRlY6Ue
JtDdYNYpQY8ItPy2nEYHUGeMbE+pwtjCqvsCxzRa6HNrIR0y/ehkluFTbeg5MiQb
kz1eBzqttpt9kpuGZijm8CSrFsvySw==
=FsAh
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--

