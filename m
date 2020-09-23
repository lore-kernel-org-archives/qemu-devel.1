Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F06C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:46:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB48220C09
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 12:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mfs2f3Sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB48220C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4Ae-0002l8-LM
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 08:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL46K-0006Wv-Dr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kL46H-0006x9-Nt
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600864940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ovf6oaoZx8h/g2W8pXKd9ehXlluGAFW20otusFkMTio=;
 b=Mfs2f3Sljao91SnK9A1EjAuxyfJlXMbXROJP550KhTJmD6hJVvEjJtODF7criMKJQqXsj4
 erSDZ3brI9SHnJal0NJFPsNO3aDqqFVt667t+BO03jFP+obzOA0Iu0RQLt0lWEx+Thn54N
 XtsAT1NQ8iajto0mSVyRkYm37ioCfHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-s4YHzvDGPGOnHTPgSC6Cpw-1; Wed, 23 Sep 2020 08:42:16 -0400
X-MC-Unique: s4YHzvDGPGOnHTPgSC6Cpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EEB801AB5;
 Wed, 23 Sep 2020 12:42:15 +0000 (UTC)
Received: from localhost (ovpn-113-77.ams2.redhat.com [10.36.113.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBFB055768;
 Wed, 23 Sep 2020 12:42:11 +0000 (UTC)
Date: Wed, 23 Sep 2020 13:42:10 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] docs/system: clarify deprecation schedule
Message-ID: <20200923124210.GG51019@stefanha-x1.localdomain>
References: <20200915150734.711426-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200915150734.711426-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pE2VAHO2njSJCslu"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 philmd@redhat.com, Daniel Berrange <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pE2VAHO2njSJCslu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2020 at 04:07:34PM +0100, Stefan Hajnoczi wrote:
> The sentence explaining the deprecation schedule is ambiguous. Make it
> clear that a feature deprecated in the Nth release is guaranteed to
> remain available in the N+1th release. Removal can occur in the N+2nd
> release or later.
>=20
> As an example of this in action, see commit
> 25956af3fe5dd0385ad8017bc768a6afe41e2a74 ("block: Finish deprecation of
> 'qemu-img convert -n -o'"). The feature was deprecated in QEMU 4.2.0. It
> was present in the 5.0.0 release and removed in the 5.1.0 release.
>=20
> Suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Use Dan's suggested wording [Daniel Berrange]
> ---
>  docs/system/deprecated.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--pE2VAHO2njSJCslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9rQqIACgkQnKSrs4Gr
c8g1LQgAnQ0gg/CEgT+/NfypKUwfkDm3RPZLMBVwYWn692zMG7r1kA9CCalA6/ji
LKDf1Y7wwpJ/w1MSbAmmbEuMc5HoAdV9R+L7CSDuw/FPDdBEazewJ6IWW6sLHrWz
4atfCv3U6lTfrZTUj4ZSjK+ztbSsy5atgqAu3LAZekyfb6EiOVBKdfJc1Vr7Sf4b
uDJkJm6/oDN2V3l2Eh0GzXWzFkOtViCwWMEUwxdzfw/VJX6orhVJl7/LNgB+IYyj
obb5FQSzWUeuvXU8HWNk637/HQCREBqe3Fy4SYjw4UrHKqfSnnjkoVE6YUQphHJo
OQUQ1ovtVXZbs2EpBgKB23uve/IEwA==
=N4qy
-----END PGP SIGNATURE-----

--pE2VAHO2njSJCslu--


