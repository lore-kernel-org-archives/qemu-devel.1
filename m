Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D24EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEE62065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 11:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVimL8qk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEE62065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZCNw-0004oi-0V
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 07:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZCMr-0004Jo-QD
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:49:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23298
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jZCMq-0003a8-E7
 for qemu-devel@nongnu.org; Thu, 14 May 2020 07:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589456975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wB17iRsFq0Qw2UDeSR0g6yzgroKZsIkuZ+IDAn892e4=;
 b=YVimL8qk933omKGYFZyq/KFBgTmjg7r/3ktqyMqNTGwUsqwu5TzDU0JlWZzeqbZkcRht0N
 gOXNm3tmzDkOvHeThSMwViNk4m1YJfZDmtDSJ85/WMgCHeaO/sFCpfO16uUjV8HQTI+gpF
 CSPV2Kc568SxJE4KtdMnfd2Svw29K/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-dYnrwGT4Md-4eKdse5wgrg-1; Thu, 14 May 2020 07:49:33 -0400
X-MC-Unique: dYnrwGT4Md-4eKdse5wgrg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35B7E81CBEF;
 Thu, 14 May 2020 11:49:32 +0000 (UTC)
Received: from gondolin (unknown [10.40.192.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFEB45C1BE;
 Thu, 14 May 2020 11:49:27 +0000 (UTC)
Date: Thu, 14 May 2020 13:49:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 5/8] pc-bios: s390x: Move panic() into header and add
 infinite loop
Message-ID: <20200514134914.410cdbf3.cohuck@redhat.com>
In-Reply-To: <099848cc-afd1-c5ad-8b8d-e2e2703ada4a@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
 <20200324150847.10476-6-frankja@linux.ibm.com>
 <20200407092534.2edb0276.cohuck@redhat.com>
 <099848cc-afd1-c5ad-8b8d-e2e2703ada4a@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_//hIj5MkxKWyoZLZoqzvic97";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

--Sig_//hIj5MkxKWyoZLZoqzvic97
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 May 2020 13:27:20 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 4/7/20 9:25 AM, Cornelia Huck wrote:
> > On Tue, 24 Mar 2020 11:08:44 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> panic() was defined for the ccw and net bios, i.e. twice, so it's
> >> cleaner to rather put it into the header. =20
> >=20
> > They were also slightly different, so unifying them makes sense.
> >  =20
> >>
> >> Also let's add an infinite loop into the assembly of disabled_wait() s=
o
> >> the caller doesn't need to take care of it.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>  pc-bios/s390-ccw/main.c     | 7 -------
> >>  pc-bios/s390-ccw/netmain.c  | 8 --------
> >>  pc-bios/s390-ccw/s390-ccw.h | 7 ++++++-
> >>  pc-bios/s390-ccw/start.S    | 5 +++--
> >>  4 files changed, 9 insertions(+), 18 deletions(-)
> >> =20
> >  =20
> >> @@ -91,6 +90,12 @@ bool menu_is_enabled_enum(void);
> >> =20
> >>  #define MAX_BOOT_ENTRIES  31
> >> =20
> >> +static inline void panic(const char *string)
> >> +{
> >> +    sclp_print(string);
> >> +    disabled_wait();
> >> +}
> >> +
> >>  static inline void fill_hex(char *out, unsigned char val)
> >>  {
> >>      const char hex[] =3D "0123456789abcdef";
> >> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> >> index aa8fceb19da2164a..35be141d8da38d07 100644
> >> --- a/pc-bios/s390-ccw/start.S
> >> +++ b/pc-bios/s390-ccw/start.S
> >> @@ -47,8 +47,9 @@ memsetxc:
> >>   */
> >>  =09.globl disabled_wait
> >>  disabled_wait:
> >> -        larl %r1,disabled_wait_psw
> >> -        lpswe   0(%r1)
> >> +        larl=09%r1,disabled_wait_psw
> >> +        lpswe=090(%r1)
> >> +1:=09j=091b
> >> =20
> >> =20
> >>  /* =20
> >=20
> > Possibly dumb question: Does checking code now figure out correctly
> > that code flow does not continue after disabled_wait()?
> >  =20
>=20
> Which checking code?

Things like e.g. Coverity.

> I could certainly add "__attribute__ ((__noreturn__))" if needed.

Probably would not hurt.

--Sig_//hIj5MkxKWyoZLZoqzvic97
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl69MDoACgkQ3s9rk8bw
L68E0Q//fZLZfgs+lvsFiMB2Rhbps4kysZ8yT/Wafvtrq+DVArxOlzcc86NdrOua
7Deyav1jiUsA+TvI+aAdktOPGvMOnrIuj2rdswlentZJSmW3i3KM/H43l8wOevfv
WefanAUX77trlOUuJtxMUjM8VOBJov0CNwMLWkSJRETxI3dOi/wndypuljIjH/7o
U71reIqk2o2boNr8uQMDJa04aceTHWmzr7liAW/2j9POZ9whowZHrT6gByUnXMIF
tUXQzrOqKS8+Hi7UCcRj/pVwO3H2mTXkHhFFseaz69PsDgI4O7jM2qlVMS9RogAn
u0RswMGUMCYR3pKPAXA1soe1JpsQJMt+YHEaTwUJ8Qh4XLTClPa048HsVY1pBUXt
SQSqIBBohVi64M6E839XK7ynPGXhBSO1a755MRuwh6pztYVaB/B/zO0smde8fvGn
tZ/yfnRHauv0la7EfNHUwRT/Z7tNF5umUonaAaEh5XdHJj1tgdaVLi1YTrT/3cQT
T10LG6wePw3sKgafI01L2oXWZE9pDrgqI/VHxf3SIMSTqNPQZz+23x7BD9kv2HlE
9SeS3/37x/5blXO1K0m16HL2Asag4gtKQrYX5oSgXDuAyBzZbhZq66GuI7XBr/Fa
wly6tAztOkT0AUEjeBMTLceFBgNINLzAMS4iQwTZah0Rd7AcwPI=
=+AW0
-----END PGP SIGNATURE-----

--Sig_//hIj5MkxKWyoZLZoqzvic97--


