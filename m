Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061F1C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D66520BED
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdvdPYem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D66520BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN77r-0008UX-Ad
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN76Y-0007tH-Lm
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN76X-000883-1S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:19:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601353143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OfRkKVE9Ue3v+hOlwfeWfedYY1tw0AuecAQ/w6p1Hx0=;
 b=UdvdPYemPQW1++6zTg7ImGx+dQeub4cJ8aJmaCDKg7c+OHBHZE003wXlFZSpwZDe/yVm6Y
 +rfWlOwYwly37YWLMSWPjVW8VpN9JMvQuE3Lt4KnVps1DXZfgpDbHHjXLixMxfyyFGwl6g
 dYYYYwWSIvvV6j70wlJx7mn53a5zSkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-DacC2wRzPa-uyMDT7ggfPA-1; Tue, 29 Sep 2020 00:19:00 -0400
X-MC-Unique: DacC2wRzPa-uyMDT7ggfPA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC75C801ADF
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 04:18:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 346957881E;
 Tue, 29 Sep 2020 04:18:59 +0000 (UTC)
Date: Tue, 29 Sep 2020 00:18:57 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 29/47] qapi/source.py: add type hint annotations
Message-ID: <20200929041857.GL700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-30-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-30-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:42PM -0400, John Snow wrote:
> Annotations do not change runtime behavior.
> This commit *only* adds annotations.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9ytbEACgkQZX6NM6Xy
CfMuSRAAwz4cm1gd8gsvs0sj/7yCfg4I/0LyOE4XWmu8yP+SPOHIisU0Vjzthiig
JJveFko575siZahJuzJc5LlbjAyVGPE4DBcJVb8ncZ0hjwNkox4qLQIAejhB79Kl
fEe97wJyV4lDo7OfSL6GlLgGoiuUEl63rGftoeYiIk2tn9vuGs/BDVEKJDYq+hN8
74zujCiozS2nKstA62daio1pQAY4HKsjhTY5yg6Gx/BmG+PKUqDrlz9M0EmEd4LO
K1zKh10TZpyHhF4IVbxwgrCvizkLEJetkttZjk1ojqlqBcTOep3nbxjuju4LKiZq
PPSV/NReDV/UtMzxW5XW1HfEH9uMiagq5xtPf6Ph5JDbOz4xk+JyctmxThoN3e0D
pX4SQ/Ct9ws1+ZgoHo5ejB3i6nDuXvZswZMW4v08Kdq2k34i8nVBnSqphkaGoNgz
BFWsYzfFqPNh2sp75PIwChUOjNm0j1bJuerMqsH32XT0X2EtWBuH0/9neaabiDdo
7v4RwBODaLRAywapL7aoxFVJm0eqXVBUFb2hN1ZJVB9On2QXb2SUD4rc6wShmcTs
5106uIVNZ1yBc6KF+unfd6qP97UcC5W8HkMTb4PC03zi8kbYJdRKUMNwS03drl9l
RO2X0KjofKuBPoq3v0J2fNYV//ySeWsa/hh76ftGtL+5p2F33fw=
=Nw0W
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--


