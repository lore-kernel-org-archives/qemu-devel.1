Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1128C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0582120759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 15:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMaIzgR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0582120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNe2P-0001kI-Us
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 11:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdaP-0000Py-Gi
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kNdaM-0004qv-UO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 11:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601478001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oaxIrjAAZuND/5ibAxHZym3FBLBB5xpRBUY0DxobS2A=;
 b=JMaIzgR/GMcm/dXyGnWUhEyv+Qo3hU5CSvsO5cz9z3ibwjD2bqIo+NOFIh2SE4qtCkgK8Z
 ZNDxwSLbJ1Ozrfkbdr8MPhqqGOs1rT2Ek39eHB3/5mjB4Cg1k/gqqH5w+nQcx68ZVBIbUv
 A5J3UcgSduepaLaHBrlZ3VjY07nRfig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-nmOQ-SmEOE6hcJzDmReWOA-1; Wed, 30 Sep 2020 10:59:57 -0400
X-MC-Unique: nmOQ-SmEOE6hcJzDmReWOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B8364155;
 Wed, 30 Sep 2020 14:59:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-128.ams2.redhat.com [10.36.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D53D6100239A;
 Wed, 30 Sep 2020 14:59:55 +0000 (UTC)
Date: Wed, 30 Sep 2020 16:59:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qemu-storage-daemon: Fix help line for --export
Message-ID: <20200930145954.GE9292@linux.fritz.box>
References: <20200930133909.58820-1-kwolf@redhat.com>
 <e775522e-560c-5aa7-71d6-16303068bef1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e775522e-560c-5aa7-71d6-16303068bef1@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 30.09.2020 um 15:48 hat Eric Blake geschrieben:
> On 9/30/20 8:39 AM, Kevin Wolf wrote:
> > Commit 5f479a8d renamed the 'device' option of --export into
> > 'node-name', but forgot to update the help in qemu-storage-daemon.
> >=20
> > Fixes: 5f479a8dc086bfa42c9f94e9ab69962f256e207f
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  storage-daemon/qemu-storage-daemon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu=
-storage-daemon.c
> > index 7cbdbf0b23..42839c981f 100644
> > --- a/storage-daemon/qemu-storage-daemon.c
> > +++ b/storage-daemon/qemu-storage-daemon.c
> > @@ -92,7 +92,7 @@ static void help(void)
> >  "  --chardev <options>    configure a character device backend\n"
> >  "                         (see the qemu(1) man page for possible optio=
ns)\n"
> >  "\n"
> > -"  --export [type=3D]nbd,device=3D<node-name>,id=3D<id>,[,name=3D<expo=
rt-name>]\n"
> > +"  --export [type=3D]nbd,id=3D<id>,node-name=3D<node-name>,[,name=3D<e=
xport-name>]\n"
>=20
> While touching this, get rid of the doubled comma before the optional
> name key (s/,\[,/\[,/)

Somehow I didn't even notice even though I reordered the options before
it. I'm removing the extra comma now.

> With that,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied.

Kevin

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl90nWoACgkQfwmycsiP
L9YdBRAAqJnDxRj+4v20c+8wfJbf1kjRhnZF9NpVTsmw7hz4+7LZS7kcAnrWvMd9
htMkmvQiuZbWAgewHCz7Pr9bj8YEWDVXOuv2bEoz3pZ6fQImxpWLJR2h6t6sVPEv
qftsE6CZLQfMDTWbf8GkvFRDgo5RifzB4wgevGQW25VCUXNZ7pE7ThGxEErFIT4s
B4Hp1+Jh9Mu3qUdgbIhxWNpyt6bjZQfjdTTpJ8zjDLiAr431fgvQxuJIvbEEQL7I
8gKufQSS0X5oEeD5x4e/4lRk9RoBFq7DkhsAVmCYpIsHgG53YbnCy+lWuOqhFAtX
+rR7UxBDO/rMG7L6jDd+1ZZGkYIdsChFjYOP39Jazo4q1QdwX7IsQDFjlH/mhhd3
gVY9bbfsZ6jOXu6lxg7AGgLIQ04szPKw8LGouLObYuEGOD+cDlYtCeSEmwb+2Dwc
f9gNrhIgmFh6VYeHUrPgRs5bKW7RkOlIDmXzpMLhZ6E49L0dDd5KiKSBROzzo4Sy
VbQWoamJaNDWimQ7zjLlDTGjWfi/RTtxw7OaI0Q+p9xCHhRMXT83H+hNB1AVti7D
7hkd9dl8ZjN0kzqwo9UGL4GwE0hoR0LlhsV47sCMd/Yu2Hmmeq4rhmDKv/bbHpA3
7a3ebDa2b97+Lh7j47zdrcdZpe36TdbI5BBtZmxrGqYDOnX7at8=
=tpC0
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--


