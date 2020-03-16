Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B73C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADE320719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3ROfnq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADE320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsjk-0004KC-BC
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jDr9D-0001VB-63
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jDr9B-0003sx-VP
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:55:19 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jDr9B-0003pS-Q4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584370517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2yAv05UUII7yW7CNYqRQPL/lsrT7GZbfavzM4uvF/4=;
 b=B3ROfnq+CsmKkLMuejg2CGS+d/PNX+YG2RGclyMx4Jxm0f1AMG/Qag+cMzi7OmO1rJl97b
 bLKE81mAHHvwNESmDfthp1OpQIO0mGtP2KOzkdbdptqubBLW1tfZNubPQOQeyF3rsJNiyT
 FYo8ImrRGZKsiYiEaLm95i/vo0j9rV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-J91LzoqYNZ6-Zf16fG04Xg-1; Mon, 16 Mar 2020 10:55:13 -0400
X-MC-Unique: J91LzoqYNZ6-Zf16fG04Xg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B6B7108AF56;
 Mon, 16 Mar 2020 14:55:12 +0000 (UTC)
Received: from gondolin (ovpn-117-70.ams2.redhat.com [10.36.117.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98F7360BE2;
 Mon, 16 Mar 2020 14:55:08 +0000 (UTC)
Date: Mon, 16 Mar 2020 15:54:57 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v9] fixup! Fix subcode/pbt
Message-ID: <20200316155457.73e97d9c.cohuck@redhat.com>
In-Reply-To: <bbbabbb0-2325-406d-a619-f2d03f447c8c@linux.ibm.com>
References: <a1ed33c4-91c0-90fa-2f95-417e320e172c@de.ibm.com>
 <20200313095232.2392-1-frankja@linux.ibm.com>
 <20200316152738.4c1c65ee.cohuck@redhat.com>
 <bbbabbb0-2325-406d-a619-f2d03f447c8c@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/LH/l=TAuQzaScMvmZzww_XR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/LH/l=TAuQzaScMvmZzww_XR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Mar 2020 15:47:41 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/16/20 3:27 PM, Cornelia Huck wrote:
> > On Fri, 13 Mar 2020 05:52:32 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> ---
> >>  hw/s390x/ipl.h      | 11 +++++++----
> >>  target/s390x/diag.c |  2 +-
> >>  2 files changed, 8 insertions(+), 5 deletions(-)


> >> @@ -118,7 +118,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
> >> =20
> >>          cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
> >> =20
> >> -        if (!iplb_valid(iplb)) {
> >> +        if (!iplb_valid(iplb, subcode)) {
> >>              env->regs[r1 + 1] =3D DIAG_308_RC_INVALID;
> >>              goto out;
> >>          } =20
> >=20
> > ...because you're basically checking whether you either have a valid
> > normal iplb, or a valid pv iplb, with the two being mutually exclusive,
> > IIUC. So what about introducing iplb_valid_pv and calling that for the
> > pv case? Would be a bit nicer to read, I think, and also matches what
> > you do for the STORE case.
> >  =20
>=20
> The idea was to get rid of all of these ifs and elses and only have one
> iplb_valid function. Your suggestion would defeat hiding that complexity
> behind this function.

I'd argue that this is a complexity we should not hide; for non-pv, we
can have several formats, for pv, only one, and we cannot use a pv iplb
in a non-pv context and vice versa.

--Sig_/LH/l=TAuQzaScMvmZzww_XR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5vk0EACgkQ3s9rk8bw
L68+iA//XC1x/zZDD+lNKh6qE7w8ixdOeH/2MOuTe5xxSkOIxuPlD1sY0AhT/NTj
SsU7raQwL1FTjCvqXcno2kcioxQ9dGDD+TNk0kG/0i/rMCPq94oV5hOWSizROXp8
rufbpFki4FQv0NOItpIhRnsUJ+NoCbQkyoJo+576leN30iYTkHIrWtivRp7eCGBR
CLqmdyRTak/NUP3HLO+VDO8RNHUqIpH/n3h38iW256Tqknrsv8smf+8QMvM7BMHn
W1YR73AOsHiOHLnqDpi8I3/wPF6xCS+JquFwkVWWWZwz8OepEPXK3owEijjD1Ht6
9WppBZdWobFW2NYPsvEoBzm+A3AvjJePzCnwU+L9NX56X7oF64XJD6/4l9rZJ5F3
Xtc2sPqRj7+ldMcaSHUv/+ic41uNL4RXd4mfl4w/oavQ1TfEWYwC4Q0cTM24zXqJ
DMwfwzvox3E5lQwY+PhBgrftivQ+s4RdAH0n/hbiEQaWybpf7G1i3nfp8eByjUSp
xqHgAXVbBuxpTEshZF4EowvcDAck6AxhkdMjXEBd0kjYf3/+xIuukfb6f/TF7eZJ
KNRNJOcHOb8ErpFgC5CZSa7EVdsD9CbIU9Rrh0BAuBnDiuSGNzurQ6eE1KATwaQa
EeGURLkL3LXqiL/DP9X5791yZHKb/BhzOoGTOrkZe9fSv/LuhDE=
=1gDy
-----END PGP SIGNATURE-----

--Sig_/LH/l=TAuQzaScMvmZzww_XR--


