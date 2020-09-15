Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61D5C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2365820735
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAMFIvbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2365820735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kICei-0006mM-1z
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICbV-00034C-3A
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:10:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40030
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kICbP-0000BH-Mz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600182638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fRJDbv20ZC4HqGGx3jF/+5WwhTFzfl4JgyQ5PHtiHbU=;
 b=NAMFIvbxFZ2oX/Ve9KYqQpP1lntpP1+rrjT+83ICIt8bDpDOue/rD6e1uEW8hUO/dk2qiP
 r334vA2VpvPazxuYt07gn6SNKfJSooJzjBwYd1cryCCHMWbnPtHjN5wNmqvywDjP7l/9hP
 KD+gN+NV11mpHmUUDleHpwC/fhwXSIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-uOTAmpURO7GzMezhdAGtEw-1; Tue, 15 Sep 2020 11:10:30 -0400
X-MC-Unique: uOTAmpURO7GzMezhdAGtEw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 695E181C478;
 Tue, 15 Sep 2020 15:10:29 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D70C6E71A;
 Tue, 15 Sep 2020 15:10:09 +0000 (UTC)
Date: Tue, 15 Sep 2020 16:10:08 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH] docs/system: clarify deprecation scheduled
Message-ID: <20200915151008.GH629589@stefanha-x1.localdomain>
References: <20200811104736.17140-1-stefanha@redhat.com>
 <20200914142146.GN1252186@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200914142146.GN1252186@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 03:21:46PM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Aug 11, 2020 at 11:47:36AM +0100, Stefan Hajnoczi wrote:
> > The sentence explaining the deprecation schedule is ambiguous. Make it
> > clear that a feature deprecated in the Nth release is guaranteed to
> > remain available in the N+1th release. Removal can occur in the N+2nd
> > release or later.
> >=20
> > As an example of this in action, see commit
> > 25956af3fe5dd0385ad8017bc768a6afe41e2a74 ("block: Finish deprecation of
> > 'qemu-img convert -n -o'"). The feature was deprecated in QEMU 4.2.0. I=
t
> > was present in the 5.0.0 release and removed in the 5.1.0 release.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  docs/system/deprecated.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> > index 851dbdeb8a..fecfb2f1c1 100644
> > --- a/docs/system/deprecated.rst
> > +++ b/docs/system/deprecated.rst
> > @@ -4,9 +4,9 @@ Deprecated features
> >  In general features are intended to be supported indefinitely once
> >  introduced into QEMU. In the event that a feature needs to be removed,
> >  it will be listed in this section. The feature will remain functional
> > -for 2 releases prior to actual removal. Deprecated features may also
> > -generate warnings on the console when QEMU starts up, or if activated
> > -via a monitor command, however, this is not a mandatory requirement.
> > +for 1 more release after deprecation. Deprecated features may also gen=
erate
> > +warnings on the console when QEMU starts up, or if activated via a mon=
itor
> > +command, however, this is not a mandatory requirement.
>=20
> So we're changing
>=20
>   The feature will remain functional for 2 releases prior to actual remov=
al.
>=20
> to
>=20
>   The feature will remain functional for 1 more release after deprecation=
.
>=20
> How about
>=20
>   The feature will remain functional for the release in which it was
>   deprecated and one further release. After these two releases, the
>   feature is liable to be removed.

Nice, that is clearer. I have send a v2.

Stefan

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9g2VAACgkQnKSrs4Gr
c8g96ggAuT2zXg0/l+4RRRtaCtps9w3yAD/sSp57n8CwYDKlmNC9nmuqtocYCUzm
4QARpTPd0mS+h3r7Q8vPy3fjjWwCy88E+3p0GdpBa6K5QrzZ7hVHK0FUIJJuqYI3
+ip0eRD5FYt7DIUA7laRI/ezOkCedLddY5kZacYWXvjm77ozrGg54xpsCRGE0D+9
plZIdln9tFgSMFRV4L1LSfbRroXtCfGvmx67DeSAERXpojRKPiUro/X5IAZAa5uq
1GuNlRFXcr46RSkqArc5fp5Gn7xMEBqQ3WXXze4GFpj2oLQ/m0TshAxvqSrTGz1U
rYP/joTsdQfHrzJuRA8ZNj8MwIYV/g==
=E2Ix
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--


