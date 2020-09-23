Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE34CC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:18:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FE42311A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 22:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzxNgFsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FE42311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLD6H-0007Ju-4F
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 18:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLD4a-0006lE-M3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLD4Y-0002cO-5T
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 18:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600899428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ML+YaewgwO8vqr3azHHfaNNZkR/dtNeEblHYLCAkJI=;
 b=RzxNgFsazWWwg0w6oG+7MEvM/nK7nj007UQivJokVJZ42xGa7oLO2a4SJUGWnK9nW2z6Wc
 Fqtk1wNsPyXDKJXPDmNYMgVKftJuUBPWLaWil/MT8d6azD6AufI/pHVguPHoM5pbi1uIDZ
 zEmN+2YcI5WLQ+hmzc7Hr3Uy7lwQzJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-ohHN_3qYMQi7qNM0uhL0hQ-1; Wed, 23 Sep 2020 18:17:06 -0400
X-MC-Unique: ohHN_3qYMQi7qNM0uhL0hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 188A9801F9A;
 Wed, 23 Sep 2020 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 478FF2C31E;
 Wed, 23 Sep 2020 22:17:04 +0000 (UTC)
Date: Wed, 23 Sep 2020 18:17:02 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 20/38] qapi/commands.py: add notational type hints
Message-ID: <20200923221702.GT191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-21-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-21-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+Yg8W10oK6rlW0RR"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+Yg8W10oK6rlW0RR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 05:00:43PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--+Yg8W10oK6rlW0RR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ryVsACgkQZX6NM6Xy
CfPYjg/+IJQozb+RU3SJ/m4otDkONh6VymeCU5/iPvd12CN5HGZC77ne8XP3quXM
0Yz3ktE24kpHQ7cx91wm7TUxZuiA9BOiMwyBVjtli0HRT+tLIHR0vUfYHnup1xZn
s0ICYtVigWE6/OAAcv2ZvSIoCRRnmC/v7O67SDYHEAG7T2qYmC5BpYkC7XlfyINC
4jLj2VVduOVgoMqNf0Ds7Ut503NXI0sfguRgYXUiAixLE810ys88h79PujvrV6ZG
dMB07H4CzS4WbpA5dZtq/uKd5rl9ZlL+/QccG+eItHBpFOSUkfl4LCl77SIaL20q
yQ19hRneTNMlacsrZfRa4gCaed0FkwzxE7hGfR6ToJoOpFVEQfAzyBtXWQuKzAYt
v3Vq7IKBYAjeHdO4d5NpDDD5SyPY89xyLO06huX3kJ75iUqJw0EYD225Pq6X1eff
zTpHfDT4s37LEnqNCqNzcyeTt7HE2e3ECWdHT9FP7swUA2U1b7mW71vmFaS/Bwvs
K1IftNw3uO5D98jsdV1DRY7bjQgm7r+ftjxxzBH1EnvOCAme0k6tYD1xKgYYA9HM
vjpKOmoPDDO0T/+US6j8oPLjZIEY5NaOjZjcgAlMZwrBnJ1gDzczL5hlGIyq2Oik
TZp9KmcIwNrdrL1Sr3Vi0F/E9mPHOfCYEMDWH7ch1GoURJcHhSQ=
=vB0o
-----END PGP SIGNATURE-----

--+Yg8W10oK6rlW0RR--


