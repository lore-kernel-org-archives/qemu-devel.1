Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F80208CE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 12:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZbb3TuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F80208CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXlt0-0005HQ-LC
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 07:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXlrC-0003v9-39
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:46:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXlr9-0001mf-Lu
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:46:45 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXlr7-0001ij-H1
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 07:46:42 -0500
Received: by mail-wr1-x443.google.com with SMTP id s5so4282289wrw.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=V1DSIJHr/+2ToaCZYe6SDT5zl17ZJk8rtZuxtrwlRAs=;
 b=rZbb3TuPnu16r0Zs1vm3sTaA7IxpfIhxu1oWIHhHEwepUkt3kvQYC2CHZpSBub4C5M
 0ia4GV8HwA8lq9NUvs2Yop8iRqsmS7+gBskuUl7C9hf2Gw2vVYSTOtHiaPx6P/cFLxDH
 bmSaziyLqf1AU0BXmq4qtAxuyaHTpKxiFJDCkXwHM1eDXJokitfBJ1JVxVo/WGDvyKd5
 h+wMMHI1eirc23ronS5TUUJ14MOQPry8am6++TizP/wsxsS7ATnHam3ZnOOz9zOzukGS
 1sYUcqpyzHZUELIRa3+0z4Yye+Vce6Xog1Ff3exTZDPnwSEFVwwt5L47kruF+4axDw9R
 tHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=V1DSIJHr/+2ToaCZYe6SDT5zl17ZJk8rtZuxtrwlRAs=;
 b=KKnO1qZjzs0NORZROwtcEeQiKFOMVu4KBnKNYdIRscsVj8n6c1JDQa02xvrfIpBh3k
 YrJh2x4kYThnW4CSen0k8YnUe5akP0OFVHB6kDpEp/blhks50/pCqHef3B8z8Lot8MiK
 mI1t8pHR5kYzgMdER3iYbpYabnioi4CSlz2oDE1LaoJoXCyt3PAnyLln4PuSDSgMVSF1
 WQk8Lk90KMU+i83mRApFKBp0vxwfKqYqKIDOFKAwUuvBQQyu+K+mIZUqZbYMMNf5/34x
 YI18LAginOHOaVayqQnYj2Dnm9UuD2Mawn4K1SkDjq3fge34h5GJiqkesNHNXr6eUL+2
 DYLw==
X-Gm-Message-State: APjAAAWK+O4XHSLoTbayXSUvN/1br7JiZXhSTCS5CIm7lOu28bLwxE+P
 SExqd4G79a4XxLA5yZR7N3A=
X-Google-Smtp-Source: APXvYqyh/+ym5lj05nr2YYOAh0hn6Hx1EzH6+AqGA/l7t6gCvXyJowFlLz9A4ZV2SQWvq5B4yMrcqA==
X-Received: by 2002:a5d:474c:: with SMTP id o12mr8433077wrs.152.1574340399993; 
 Thu, 21 Nov 2019 04:46:39 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id t12sm3024754wrx.93.2019.11.21.04.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 04:46:38 -0800 (PST)
Date: Thu, 21 Nov 2019 12:46:37 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu
Message-ID: <20191121124637.GR439743@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a+0P3INHs7aeI7wh"
Content-Disposition: inline
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--a+0P3INHs7aeI7wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2019 at 05:08:41AM -0400, Jagannathan Raman wrote:
> Started with the presentation in October 2017 made by Marc-Andre (Red Hat)
> and Konrad Wilk (Oracle) [1], and continued by Jag's BoF at KVM Forum 201=
8,
> the multi-process project is now a prototype and presented in this patchs=
et.
> John & Elena will present the status of this project in KVM Forum 2019.
>=20
> This first series enables the emulation of lsi53c895a in a separate proce=
ss.
>=20
> We posted the Proof Of Concept patches [2] before the BoF session in 2018.
> Subsequently, we posted RFC v1 [3], RFC v2 [4] and RFC v3 [5] of this ser=
ies.=20
>=20
> We want to present version 4 of this series, which incorporates the feedb=
ack
> we received for v3 & adds support for live migrating the remote process.
>=20
> Following people contributed to this patchset:
>=20
> John G Johnson <john.g.johnson@oracle.com>
> Jagannathan Raman <jag.raman@oracle.com>
> Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Kanth Ghatraju <kanth.ghatraju@oracle.com>
>=20
> For full concept writeup about QEMU disaggregation refer to
> docs/devel/qemu-multiprocess.rst. Please refer to=20
> docs/qemu-multiprocess.txt for usage information.
>=20
> We are planning on making the following improvements in the future:
>  - Performance improvements
>  - Libvirt support
>  - Enforcement of security policies
>  - blockdev support
>=20
> We welcome all your ideas, concerns, and questions for this patchset.
>=20
> Thank you!

I've wrapped up for v4.  There is more to review in detail but I've
posted enough comments so that I'd like to see the next revision before
investing more time.

The main topics:

1. It's possible to have just one proxy device per bus type (PCI, USB,
   etc).  The proxy device instance can be initialized by communicating
   with the remote process to inquire about its memory regions,
   interrupts, etc.  This removes the need to hardcode that information
   into per-device proxy objects, which is tedious and can get
   out-of-sync with the real device emulation code.

   This is becoming similar to doing VFIO or muser over a socket...

2. Security and code quality.  Missing input validation and resource
   leaks don't inspire confidence :(.

   Please run scripts/checkpatch.pl on the code.

Stefan

--a+0P3INHs7aeI7wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3Why0ACgkQnKSrs4Gr
c8hcwwf9HzmVf1zDyeqLs4BUMtZ6y3pyztyYzC90ickH0Lh2SZtPT0zuLNf/WKTY
mjNEOdUl69XEOtBbMP4O6Io+P2JURYG9quVwSEdblk+tZ6pku2O0J2K/450xR0yQ
riC2Z0xWbTruwrh1PaQunXV2aBPR5ZyC+Nd4dOPnTF551O/VxFvKI73nJQv1p9TJ
1R2mAsAaZzr+grlwL45V2PtHht/33NhwN11fUneKrCczbWb6h2xzp4IpwKzL9qOP
/w27Y+ZEs/3kv8JoOPcLdws0urEeVkrQZFprmgADoCYkeNlz7KXdotCAUWXHoIfQ
bQWjoe8MgtADiD23ezs2M1v0E57VNg==
=wK33
-----END PGP SIGNATURE-----

--a+0P3INHs7aeI7wh--

