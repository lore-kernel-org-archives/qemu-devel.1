Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61A9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 206E2206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfeJs0c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206E2206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3j1-0003Jr-2R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc3h8-0001yN-TM
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc3h6-0001mw-74
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604914953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4KgfpFZGdPwPYBBeSbK4lGjx9H69kcqipCUwb8XDt0M=;
 b=VfeJs0c8eO0hQ3JcAJ2H9kFcgtuif7CqXp4yNuezwewnROrUkathPtGE9u/mYrn84X0nV8
 pdYY8NZ4FLWz1tXbNvB0lt2IdNYi5BSl7NmApMqeNjxJcxzbQKjfYqdf6BHAvBjUFa1eQ5
 OrboRLyzB5PsEiPY4YGc0kVGEuZYw4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KWV1oPctPLG6ix8o6vNXFg-1; Mon, 09 Nov 2020 04:42:31 -0500
X-MC-Unique: KWV1oPctPLG6ix8o6vNXFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75E4A186840C;
 Mon,  9 Nov 2020 09:42:29 +0000 (UTC)
Received: from localhost (ovpn-114-110.ams2.redhat.com [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8BBE960BF1;
 Mon,  9 Nov 2020 09:42:22 +0000 (UTC)
Date: Mon, 9 Nov 2020 09:42:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-6.0 v4 12/17] gitlab-ci: Move coroutine tests across
 to gitlab
Message-ID: <20201109094221.GA783516@stefanha-x1.localdomain>
References: <20201108204535.2319870-1-philmd@redhat.com>
 <20201108204535.2319870-13-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201108204535.2319870-13-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2020 at 09:45:30PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Similarly to commit 8cdb2cef3f1, move the coroutine tests to GitLab.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> ---
>  .gitlab-ci.yml | 16 ++++++++++++++++
>  .travis.yml    | 14 --------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a799803afb9..6552a832939 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -475,6 +475,22 @@ build-tci:
>      - QTEST_QEMU_BINARY=3D"./qemu-system-x86_64" ./tests/qtest/pxe-test
>      - QTEST_QEMU_BINARY=3D"./qemu-system-s390x" ./tests/qtest/pxe-test -=
m slow
> =20
> +# Alternate coroutines implementations are only really of interest to KV=
M users
> +# However we can't test against KVM on Travis so we can only run unit te=
sts

s/Travis/GitLab CI/

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+pDv0ACgkQnKSrs4Gr
c8hfpgf+N9BeD7jGt4fbcQ9beOoYarp3oI7koWu8pQmUBavoTHXV6zasItAMpjaf
7FFkvcUi+tatWsOXluQzyz/346/IQRtpdBSJ6Nu2P09Mq/HhnV9ITv3gDpZYB29W
5TG+VmqFE1ZmcFgzAiaUsXaL+n1seVjXLaolMrIUPRe2ZgLPieCfg3iGO//2xOEI
41lUYbQ4B2vQHKvm2KVnn6xnKSfu50qnI2JuxxqZIyxErQPy8UayUCmJ6CN3UhiE
yYWAgvDANs40Wbr/YqL6d8DbAcTt/KfUneJgjhEEuFc/kaJ92WpVOoKAzajX2t3c
dMHesnmLEe7+eQU7wLrpgaSu28xomA==
=2rgo
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


