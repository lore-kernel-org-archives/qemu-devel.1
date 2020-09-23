Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4E7C4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39ED6206FB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 14:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L1zbSlal"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39ED6206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL5ue-0007Uh-53
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL5tt-000726-6C
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL5tq-0005vO-RO
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 10:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600871857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7EXB3bEDQSI5wqr3/InNcZXD9blH0C8AHKZAVABdmOM=;
 b=L1zbSlaldVfRTW3IkK6y73s6LS+EoGW8jLZ3YhO8WmP+n9OllWpj0+ll6eznmkSu2Ie5Im
 lQ/UIxSrNKGTlZjsWRMxlPLIOJc0/lIZZs1k+8Ihmkv4WZBvJ9fBvgLV6eqb9MgRjM6OtU
 PlkxbajobK3DdexIE5cwHw/VwxHWR2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-pRjS4K5bNUGJ-1K_kJYFNA-1; Wed, 23 Sep 2020 10:37:35 -0400
X-MC-Unique: pRjS4K5bNUGJ-1K_kJYFNA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0424610A7AEF;
 Wed, 23 Sep 2020 14:37:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0625D990;
 Wed, 23 Sep 2020 14:37:33 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:37:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 08/38] qapi/common.py: Remove python compatibility
 workaround
Message-ID: <20200923143731.GH191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-9-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-9-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 05:00:31PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rXagACgkQZX6NM6Xy
CfP2MA//fN1oyHKX5X1skFwH0sV7VRIPER3c3oEmgMzl/CtQ5JKI0mqjJ1CgHJ/w
DS5sd7qP3uOFDqxMQuF/1JzQMhNo9mEMbdmvH6XGuwq8hrngXpFUX6d/rNzVKoMK
+XdXLTTtaVw5UYhTBC5GlgHu/ASqTV63VWCcoosQPB3/9QAZztKXjiztq/bFUZBn
k8dqQfLX6WgHMwilPBwmQ6fqGIpEmIfc4b+D6Q6qLTdCic48yDCdmXCrJuMKiI+/
ArtoXcJOezc4oQEak7stk1K+RRWmL7KdgX/JyHQ1ZEYLsMK/TlieowIVdfjah3+k
TS4kE0zOdb47l3tFVtrPkYaB3Xg38P75UDA1UDe8VqOu+v7ACS1KtBlm06P8jZdv
/Cx3TSjzbnM8Pgy7sYa/+Vi8dE/dEh6HU3uv71MMPGIgJ0CQvTh0+wmQ1xBPTahG
VHTSmSwVKAiJDtfsCoWdJA4W9ufjQ23w4qO6RtDL8/yMoHN0Etct1c7LH88cLAOW
oCYZ1dLDEyAqku2qiN5Q52ps8juduElX06vHimy+Fu0GNKj5x9jJxCmdZjMAOXYA
pqYC0IZvot7QglgsTH7ZJz9E4Wle2WefmqTas6KLqJ7uItsngW7/4G47Jg2hn5oq
kYdqZf8uEBsK0xQSoSAAf+xNYb3GPYmlFMWh6AYYJUWaO1pG+qs=
=kMIA
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--


