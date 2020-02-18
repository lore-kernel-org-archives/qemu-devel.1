Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7725BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FDD2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0V6c02K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FDD2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42sR-0004Z5-Gm
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j42rs-00046q-CD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:24:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j42rr-00022y-Da
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:24:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44474
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j42rr-00022Y-9h
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582032290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AbMlemMewGH1yjlVCwW6rJeJUbox05exjwWTzZcgJew=;
 b=B0V6c02KgA8V7rtxWz1csDtQaywf0OELCf3nQeuYMkZQr8rtU6TRVIZsaycf2B277DGXWp
 6sIUT3whZBW4l05a0XwT5QXCJ1ZISudPH7zDhYoP8HMMjyy0w+nagxGHYvngJgHaU2mkxK
 xsubAsZwYss4O2xu3L4DgLfPJcyOn70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-hLtTabLNO-Gyh7lLJHlKKA-1; Tue, 18 Feb 2020 08:24:46 -0500
X-MC-Unique: hLtTabLNO-Gyh7lLJHlKKA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD21F100550E;
 Tue, 18 Feb 2020 13:24:44 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D4ED8B740;
 Tue, 18 Feb 2020 13:24:40 +0000 (UTC)
Date: Tue, 18 Feb 2020 14:24:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v3 00/17] s390x: Protected Virtualization support
Message-ID: <20200218142429.220b9b41.cohuck@redhat.com>
In-Reply-To: <eb666097-dab1-c545-22ca-d270155bd752@linux.ibm.com>
References: <20200214151636.8764-1-frankja@linux.ibm.com>
 <20200218141304.1c6f82b0.cohuck@redhat.com>
 <eb666097-dab1-c545-22ca-d270155bd752@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/Rz.KrIDAR4/jm4goek3ShWP";
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
Cc: qemu-s390x@nongnu.org, mihajlov@linux.ibm.com, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Rz.KrIDAR4/jm4goek3ShWP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Feb 2020 14:15:32 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/18/20 2:13 PM, Cornelia Huck wrote:

> > -ENODOC; can you add something under docs/ that describes how you
> > configure a pv guest and what the initialization/teardown flow is? =20
>=20
> Sure, but could you give me a bit more detail?
> What do you mean by configure?
> Command line options?

Basically: What does someone using QEMU need to know if they want to
set it up to run pv guests? So a quick overview, command line options,
prereqs, etc.

(Maybe you can also lift some stuff from the kernel doc?)

--Sig_/Rz.KrIDAR4/jm4goek3ShWP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5L5Y0ACgkQ3s9rk8bw
L6+9eBAAlErNdI1f+AHZXkQ/NMzN2wu3MebZw85iFZYaW2wbYpRtPJWAPM1eovpI
mRiZ0nLKbECEaZDYRvpIFUKwQg99NdnhDLzqzsD2fAQyfn/2Yzf5T9O+KriUkIpx
TnVqR1E119UB0hU4Fgzxk7YRZMu+HBMYIgDAvRcjGD0w1D+9c2ze6VsRok9In68q
gOou70ibXkH+L9EAWLtK0ABKex3kGvqdBJkgrXVdmh4DWvwlt+zILXx5NZ1+dVV6
zUVsz9pKPrtT5XdaVRpn0vSa55lt766xlMqjS8sp37CpZ5WuqStG8WnR6KmhhU8o
UG7nt9B5vXbuujIeoQdf9YtC7VidCMd1Qe6oZOvykI94HzdJ1DWKFD3mdBxy76Tx
ixlLTx0YSoQzzWNDwFQCnQIpTJ6EhXzTuwBTfZIVYbxJ2TBeD4z1DKEfnINUh7EU
41iOMOOkhJ5ncvk1JLlK61LH9q9qo10ZoRpS30rrXUX4OK3h1ut5Ka7BvbRARD8c
PpAyrR+3koK2EmcPX1941M0Oeo+vc7BNostZK4Fj83d6iQK8/Uit8PnyGw9io1hJ
TIgvM8QjAF7V907eCH53UktD0tACDRYxmvJdA4TiXNSrv53HwpMREv7hgEVtWsga
UTZb73vdwHCAm61p5AXO5BY8v+e832ipnX1lOFm2yQdTEX/FY+w=
=JwSB
-----END PGP SIGNATURE-----

--Sig_/Rz.KrIDAR4/jm4goek3ShWP--


