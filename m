Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FBEC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25322206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 09:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXlIlzkv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25322206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibhtB-0007ZT-9g
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 04:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ibhsW-00071U-K5
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:20:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ibhsV-0001Vh-Fl
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:20:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21461
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ibhsV-0001VL-C7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 04:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575278422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iXAsXxCpXIHCHiJEsy87qQELS4LbzjgowCnPml8IDc0=;
 b=cXlIlzkvsUmcP7NRH5CHJkrUVvSSUXMAi3th9pUoFTXAsChWGVH8l24DA5hs200J6CK1pz
 u2V8JAA/PP1qglELR2FNZcYGfx6+TOKP2oymy5bJOIZUzUGOqzzq+xdDRqkqV8KDUk5Zzf
 AW/dmfl11GVMDxp5dCOJc3R8gn7uU8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-4OlTwCksPwybUU0y8JD5YA-1; Mon, 02 Dec 2019 04:20:19 -0500
X-MC-Unique: 4OlTwCksPwybUU0y8JD5YA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0317E800D4E;
 Mon,  2 Dec 2019 09:20:18 +0000 (UTC)
Received: from gondolin (ovpn-116-41.ams2.redhat.com [10.36.116.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 847531001281;
 Mon,  2 Dec 2019 09:20:13 +0000 (UTC)
Date: Mon, 2 Dec 2019 10:20:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 01/13] s390x: protvirt: Add diag308 subcodes 8 - 10
Message-ID: <20191202102001.57898eca.cohuck@redhat.com>
In-Reply-To: <0dadfe48-d92f-4a54-1590-3aa4b5fbc1aa@linux.ibm.com>
References: <20191129094809.26684-1-frankja@linux.ibm.com>
 <20191129094809.26684-2-frankja@linux.ibm.com>
 <97db1c4b-bc9e-9db0-424d-6cd3ba348e78@redhat.com>
 <0dadfe48-d92f-4a54-1590-3aa4b5fbc1aa@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/xjEyJ86o8ZJl0N7OcqVJShJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: Thomas Huth <thuth@redhat.com>, pmorel@linux.ibm.com, david@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/xjEyJ86o8ZJl0N7OcqVJShJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Nov 2019 15:08:58 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/29/19 1:40 PM, Thomas Huth wrote:
> > On 29/11/2019 10.47, Janosch Frank wrote:
> > [...] =20
> >> Subcodes 8-10 are not valid in protected mode, we have to do a subcode
> >> 3 and then the 8 and 10 combination for a protected reboot. =20
> >=20
> > So if 8-10 are not valid in protected mode...
> >  =20
> >> @@ -59,6 +61,9 @@ int handle_diag_288(CPUS390XState *env, uint64_t r1,=
 uint64_t r3)
> >>  #define DIAG308_LOAD_NORMAL_DUMP    4
> >>  #define DIAG308_SET                 5
> >>  #define DIAG308_STORE               6
> >> +#define DIAG308_PV_SET              8
> >> +#define DIAG308_PV_STORE            9
> >> +#define DIAG308_PV_START            10
> >> =20
> >>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64=
_t addr,
> >>                                uintptr_t ra, bool write)
> >> @@ -105,6 +110,7 @@ void handle_diag_308(CPUS390XState *env, uint64_t =
r1, uint64_t r3, uintptr_t ra)
> >>          s390_ipl_reset_request(cs, S390_RESET_REIPL);
> >>          break;
> >>      case DIAG308_SET:
> >> +    case DIAG308_PV_SET: =20
> >=20
> > ... should you maybe add a check here (and the other cases) to make sur=
e
> > that the guest is currently not running in PV mode? Or is this taken
> > care of by the Ultravisor already? =20
>=20
> The Ultravisor takes care of that.

I'm wondering whether we should add some asserts. If the uv is broken,
we're hosed anyway; but it might make the code flow more obvious?

--Sig_/xjEyJ86o8ZJl0N7OcqVJShJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3k10EACgkQ3s9rk8bw
L69ZoA//bINXLjElg2RTkbKnJzU1V27er9wPvSzV1a+p2+XJ25A3ewCYvcFUqxIM
cFZf9hUv9pBDGFeY8q3PZ8H21C84w+rvgQuMsc54IwjCa8MHe8NdxHh8AagGYhZu
17sthvOqjff/wsddw5pL6SZexnG535xoGXjN6XMfj1Enr7pkX/8rwBgsms6UgkhA
CJXg5wcHA8cn/JOXA5hH3YrXEJmgu7wByB7CWNTZl16oDjiO+vDNdCYJM6F+BBBX
EMLVPOqkicjhQkoI6WzNQKjd48YKgzTwvrNeqlqJER3Qi/LPSxbN3wiq+Ts1BlJE
RwHzA8U0xCjPdt/MRyBDdbiTCFGV5Jaq/4CYv+0UZv/3MtcV0j6hOiOm/nyFrVot
JfZGIizlTnUGvYPq0BNXucJEbqnxszdqxJC9unn9Y9wvqDBopv1iomDA3Wkmw0O4
gomKjbCOIa9QystWNc3Ra3Q2+gIpuxzNmvb1dMRt8FlUZPqmJO6WijFelSmpwcJF
+PYYOLTqrh8uN36pRY3WF+iRlVhxY9tUrBCGYW5DwfvgFcNOBTEJ/j7PiBJpQrCr
5rMfbs9yqL6+vX1Cec8Nw7htl2Wmd6Dkp5tRIsQFcOQawV+fvix1fLhr5HIdVSqP
ytV63BQPbnvJN9CFepVJcgPU12Rz0QvSG3h80ofUp0T41NjJnco=
=m50p
-----END PGP SIGNATURE-----

--Sig_/xjEyJ86o8ZJl0N7OcqVJShJ--


