Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7EC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:52:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2569D246CF
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IksqytLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2569D246CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjzm-0000nP-RY
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXjw2-0005y6-SD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXjw1-0002NX-0Q
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603885688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r/vkHU49zHJsz/CpjgiXCbHlRezQ4h9cKySvl7c56/w=;
 b=IksqytLXeClpIdzJhiAzZ6GlfbwpR9kUQCARRY7kAAmxXsEXxarYY38pJDkut6EBaXAuJX
 jZiICMNysbDMnYdj536+Uxfpgn/c6QyeNhL0E53VkY+p8yGMcSEVqK21fApAE4wAMLFYOr
 4VFv4YxwpO96IkSA5nFUpIN9UqQB0QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-8ADp144xOB2ufJRulSFyhw-1; Wed, 28 Oct 2020 07:48:03 -0400
X-MC-Unique: 8ADp144xOB2ufJRulSFyhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AC761009E2A;
 Wed, 28 Oct 2020 11:48:02 +0000 (UTC)
Received: from localhost (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDD8960FC2;
 Wed, 28 Oct 2020 11:48:01 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:47:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Subject: Re: [PATCH v3 4/7] coroutine: add libucontext as external library
Message-ID: <20201028114759.GH221115@stefanha-x1.localdomain>
References: <20201028030701.14086-1-j@getutm.app>
 <20201028030701.14086-5-j@getutm.app>
MIME-Version: 1.0
In-Reply-To: <20201028030701.14086-5-j@getutm.app>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 08:06:58PM -0700, Joelle van Dyne wrote:

I am not a lawyer and haven't consulted any lawyers, but libucontext
seems compatible with QEMU's license to me. I think QEMU can mirror the
libucontext repo and ship it like the other submodules. No changes to
QEMU's ./LICENSE are necessary since it is similar to the other
permissive licenses already in use.

FWIW I only took a look at
https://github.com/utmapp/libucontext/blob/master/LICENSE. I did not
review the actual libucontext source code.

> diff --git a/meson.build b/meson.build
> index 48c95150fe..0beb199303 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1243,9 +1243,35 @@ if not fdt.found() and fdt_required.length() > 0
>    error('fdt not available but required by targets ' + ', '.join(fdt_req=
uired))
>  endif
> =20
> +ucontext =3D not_found
> +slirp_opt =3D 'disabled'

Minor issue: the slirp_opt change should probably be part of another patch.

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZWm8ACgkQnKSrs4Gr
c8iA1QgAnGCCZ5qLc+dTKD4uY6CE8Wkxl/dxuNAo72Q22bMkuGyABnpmHh3CpNt5
v08pMxAux0mxcRQ8vKu1TfKDMKo0cVEpH53FV1qUCcu+lpEoEQ7OLuhuaNkjEzdf
/gdpvHMLqMPf8E0gZFJU8buNu7uf8KEsmCiFl6KYZ27CNH5subCqrQE8o37E6cde
RLSTOT5OnJR1oksfiZE0ksJsz+ESqR63WUalPjwBMt3NYBHRCrFR6Qkozg0LIMWf
NTKTf4vK78w5sVVBCjUnrOtfkiL1pM77ZBErwHyz0HJqhcsrVOkUp1WAJgSctPTJ
yMBHT7e+YzFpIReYDd5Q//vnFKYWsA==
=R97D
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--


