Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB72C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:51:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8880A21556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QD30vj3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8880A21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3LC-0006O6-9E
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:51:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1if3K0-0005Tx-Sv
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1if3Jz-0001Ap-95
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:50:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57773
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1if3Jz-000178-4a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576075833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=DshJsrd+BxE5qVxiWfwu5dTou3/D3RdoUvRLYqaO4ek=;
 b=QD30vj3rn0ZjNzhvpNl7SYNgaiszRfbxLMfVQrbEIl6ZJyaWih7gVFpstX1cqIj7btSp//
 wzo75Y2HDzjFicohZRn7rEVFRe7/LEYgtpjs5bUu+vbeOa6SAOtB/XnGS3VfhPO5rzUfCd
 dTXqSjkGOYYulnlnbVoXNfd1J1LLguo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-_6tovIOkMECl7zUfQ0HMbA-1; Wed, 11 Dec 2019 09:50:30 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A64B1856A73;
 Wed, 11 Dec 2019 14:50:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-11.ams2.redhat.com [10.36.117.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 44C235D6AE;
 Wed, 11 Dec 2019 14:50:28 +0000 (UTC)
Subject: Re: [PATCH] ci: build out-of-tree
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576074600-54759-1-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <be96796e-958f-e51e-6832-b6376e2f9c72@redhat.com>
Date: Wed, 11 Dec 2019 15:50:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1576074600-54759-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: _6tovIOkMECl7zUfQ0HMbA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/12/2019 15.30, Paolo Bonzini wrote:
> Most developers are using out-of-tree builds and it was discussed in the =
past
> to only allow those.  To prepare for the transition, use out-of-tree buil=
ds
> in all continuous integration jobs.
>=20
> Based on a patch by Marc-Andr=C3=A9 Lureau.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
[...]
> diff --git a/.travis.yml b/.travis.yml
> index 445b064..d259b51 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -74,8 +74,8 @@ notifications:
> =20
>  env:
>    global:
> -    - SRC_DIR=3D"."
> -    - BUILD_DIR=3D"."
> +    - SRC_DIR=3D".."
> +    - BUILD_DIR=3D"build"
>      - BASE_CONFIG=3D"--disable-docs --disable-tools"
>      - TEST_CMD=3D"make check V=3D1"
>      # This is broadly a list of "mainline" softmmu targets which have su=
pport across the major distros
> @@ -192,7 +192,9 @@ matrix:
>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"
>        compiler: clang
>        before_script:
> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>          - ./configure ${CONFIG} --extra-cflags=3D"-fsanitize=3Dundefined=
 -Werror" || { cat config.log && exit 1; }

Don't you want to remove the old line?

> +        - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=3D"-fsanitize=3D=
undefined -Werror" --extra-ldflags=3D"-fsanitize=3Dundefined" || { cat conf=
ig.log && exit 1; }
> =20
> =20
>      - env:
> @@ -323,6 +325,7 @@ matrix:
>          - CONFIG=3D"--cc=3Dgcc-9 --cxx=3Dg++-9 --disable-pie --disable-l=
inux-user"
>          - TEST_CMD=3D""
>        before_script:
> +        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>          - ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -Wno-error=3Ds=
tringop-truncation -fsanitize=3Dthread -fuse-ld=3Dgold" || { cat config.log=
 && exit 1; }

That should also use "../configure" (or $SRC_DIR/configure), shouldn't it?

 Thomas


