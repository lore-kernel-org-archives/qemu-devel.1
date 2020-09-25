Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F083AC4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB482086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 08:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHCMsdRI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLjJM-0003xB-7S
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 04:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjIV-0003Hj-NA
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kLjIT-00044U-NF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 04:41:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601023300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7zg2mEErwsg5P15hXlGazJt/aU7200y3snGaDHWz9EE=;
 b=IHCMsdRIgLcxztISaUmn7G1mC+KyoJifV3Fxaq1Yp8Y7lIgU7S0lC6doc7yaxKwtErO7Sa
 AlmI1FlDCUuOOSN2eUci1TVfZ/ZZTazr8SOUl1HxkLnChmBQeTF116E/K/JMgZHsGsfueo
 79p8c5CW97orXpCn3a1KGkVbmbCQ3e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-3cNTm3ZfPva8J79zrapKig-1; Fri, 25 Sep 2020 04:41:36 -0400
X-MC-Unique: 3cNTm3ZfPva8J79zrapKig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E016956BE2;
 Fri, 25 Sep 2020 08:41:34 +0000 (UTC)
Received: from localhost (ovpn-113-240.ams2.redhat.com [10.36.113.240])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AE2755767;
 Fri, 25 Sep 2020 08:41:29 +0000 (UTC)
Date: Fri, 25 Sep 2020 09:41:23 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PULL 00/13] Block patches
Message-ID: <20200925084123.GB33068@stefanha-x1.localdomain>
References: <20200923161031.69474-1-stefanha@redhat.com>
 <160089292579.27646.6143023099150501377@66eaa9a8a123>
MIME-Version: 1.0
In-Reply-To: <160089292579.27646.6143023099150501377@66eaa9a8a123>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: peter.maydell@linaro.org, dgilbert@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 23, 2020 at 01:28:47PM -0700, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200923161031.69474-1-stefanha@redhat.com/

checkpatch is warning about pre-existing issues.

Stefan

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9trTMACgkQnKSrs4Gr
c8i74Af/SORATyLFwJJoprHMizQ6dZHFMEMImvHJTVOeZB/XMcu18vcFta6cTovi
ciQNHaWCMM1ME8U87jHcBFPXwBbfZbRpSNtx8kYLtpZhEWrgOMJHe+m0O+MIYJb6
AO68s1MEOWG4PQx5Ur/u3gnucDlHfsX6dE6iU8jtGeH3HL2qGlok/irIKaAJtk97
SdcB6xaSL+1YIeyEfdSSUUVxamP9J0l2s/RnF67oHinOOz3AWuDORRoEA20Ym2lS
yPgWZ6C9BpEUNZS2gyv6SF56Isf3Iqo/TqgILnTH/x4Yzkh8tXz7XWcf9rDuA/Kx
yZp8SR6BshVUnG9bHjExOehNUdMg0g==
=dlGj
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--


