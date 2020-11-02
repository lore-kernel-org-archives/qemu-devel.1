Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F62C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7794322268
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/82/vbY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7794322268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZcwr-00010U-Hl
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 11:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZcw3-0000XS-Kr
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kZcw1-0002YO-R6
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 11:43:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604335436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73MmbBP04jHrh9bnc8eUM9/q01CAFumiJPNJEOP0N2k=;
 b=L/82/vbYt2Cndqjr/wgw2QZqPgo02a/cwfi3L6Ov5ydO4RzKK/8vy5Dv5m1unPmGhZ7Owt
 fhVNALXmt7CkW+73O/Bs+U2UnMi48OlV+BT1JL50NXz/SbTPP1q+qaLElQz0AF8vJyGjRs
 dbam5v/ERSQwU8CkOsl8d6uvjMwaSHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-q8A_AbGkP-iLwgmPJE9CEQ-1; Mon, 02 Nov 2020 11:43:49 -0500
X-MC-Unique: q8A_AbGkP-iLwgmPJE9CEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5698159;
 Mon,  2 Nov 2020 16:43:48 +0000 (UTC)
Received: from localhost (ovpn-114-65.ams2.redhat.com [10.36.114.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E29068433;
 Mon,  2 Nov 2020 16:43:44 +0000 (UTC)
Date: Mon, 2 Nov 2020 16:43:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] virtiofsd: Seccomp: Add 'send' for syslog
Message-ID: <20201102164343.GB212231@stefanha-x1.localdomain>
References: <20201102150750.34565-1-dgilbert@redhat.com>
 <e1a007ed-7a9f-38cd-4003-144d0e99dd6e@redhat.com>
 <20201102151824.GG138796@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102151824.GG138796@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 03:02:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: virtio-fs@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, amulmek1@in.ibm.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 03:18:24PM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Nov 02, 2020 at 04:11:44PM +0100, Philippe Mathieu-Daud=E9 wrote:
> > On 11/2/20 4:07 PM, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > >=20
> > > On ppc it looks like syslog ends up using 'send' rather than 'sendto'=
.
> > >=20
> > > Reference: https://github.com/kata-containers/kata-containers/issues/=
1050
> > >=20
> > > Reported-by: amulmek1@in.ibm.com
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > ---
> > >  tools/virtiofsd/passthrough_seccomp.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/tools/virtiofsd/passthrough_seccomp.c b/tools/virtiofsd/=
passthrough_seccomp.c
> > > index eb9af8265f..672fb72a31 100644
> > > --- a/tools/virtiofsd/passthrough_seccomp.c
> > > +++ b/tools/virtiofsd/passthrough_seccomp.c
> > > @@ -118,6 +118,7 @@ static const int syscall_whitelist[] =3D {
> > > =20
> > >  /* Syscalls used when --syslog is enabled */
> > >  static const int syscall_whitelist_syslog[] =3D {
> >=20
> > Is it worth restricting the syscall to POWER?
>=20
> That would be wrong, as this is needed on multiple arches.
>=20
> There is no real security benefit to restricting it either, as both
> syscalls give you broadly equivalent abilities.

Restricting send to architectures where glibc slightly decreases the
host kernel attack surface. I think it makes sense from a security
perspective. There could be a send(2)-only bug in Linux isn't present in
sendto(2).

But there are other issues with seccomp - are we really sure send(2) is
never called? Since we don't control the entire binary (share libraries
are used, virtiofsd could be linked against another libc, etc) we may
not have enough information to conclude that can be eliminated send(2).

Stefan

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+gNz8ACgkQnKSrs4Gr
c8j72gf/drygV4GANWvaE8KMazNylXTmrnhpTQcjvPERlSMKFfLEsKiO/YhX6uEm
Y3ltnGLb2hgLp8je9MPstvFmveChTCYWxxDwlu+MpK+4V31wQUoTB67oh0dehEI5
C08QDiK7cDjarfObjlQStIoJyR2wXrd0ydoYUuiQhgf6NYTXSdb6pmVQgAHtwFIm
x43nLaXyFNP0B0YL4POt8QOCWnBzThDqCUpqqQsx16fjHFB28U4n+I7KXk1cU0Qg
9KvFKhVZo5WfKOYqtGT4D/O3uFsIhu6UuLa6wbw51Ws3hbjPcenipF3wRO8wSSAk
oL4Ua+Qk4XmOmx3cIURrCSajpuY7Sw==
=xwO6
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--


