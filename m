Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE28C35240
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D8220661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM2vnS3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D8220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixF82-0003lH-NG
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 14:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixF7H-0003IN-3z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixF7E-0002GS-Vg
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:04:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46242
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixF7E-0002D2-RG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 14:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580411075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=uiO9lGlFY5SFN0csbI8CwJl2qIoAkKArb0vGsMS8Lm4=;
 b=cM2vnS3U0UKniMkq5H3LL9ey1H3wNvkcrZPdUNnZ2xov+cqA4PFR0q2nw8DAVGPvkcqDlW
 7Ywgm6kqS/CACVv71TOIuTOrrEL5oV2VlB1eK0P+pMF//vyg3wyynHzgoKI9cyNxMUmKuz
 rsTcPO5tazzFqm3hOMGKlrijUR3XEpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-ivHNOiT1MyW7L9hmugfpfQ-1; Thu, 30 Jan 2020 14:04:19 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45B1100551A;
 Thu, 30 Jan 2020 19:04:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-117.ams2.redhat.com [10.36.117.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE7A77928;
 Thu, 30 Jan 2020 19:04:04 +0000 (UTC)
Subject: Re: [PATCH v2 04/12] travis.yml: Install genisoimage package
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200130113223.31046-1-alex.bennee@linaro.org>
 <20200130113223.31046-5-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <619c3159-7e85-009c-739e-a537752a1c49@redhat.com>
Date: Thu, 30 Jan 2020 20:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200130113223.31046-5-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: ivHNOiT1MyW7L9hmugfpfQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/01/2020 12.32, Alex Benn=C3=A9e wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
> The genisoimage program is required for tests/cdrom-test
> tests, otherwise they are skipped. The current Travis
> environments do not provide it by default, so let's
> explicitly require the genisoimage package.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Message-Id: <20200110191254.11303-2-wainersm@redhat.com>
> ---
>  .travis.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 1ae645e9fc..e75c979b6c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -51,6 +51,8 @@ addons:
>        - sparse
>        - uuid-dev
>        - gcovr
> +      # Tests dependencies
> +      - genisoimage
> =20
> =20
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> @@ -383,6 +385,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD=3D"make check check-tcg V=3D1"
>          - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS}"
> @@ -412,6 +416,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD=3D"make check check-tcg V=3D1"
>          - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},ppc64le-linux-user"
> @@ -441,6 +447,8 @@ matrix:
>            - libusb-1.0-0-dev
>            - libvdeplug-dev
>            - libvte-2.91-dev
> +          # Tests dependencies
> +          - genisoimage
>        env:
>          - TEST_CMD=3D"make check check-tcg V=3D1"
>          - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFTMMU_=
TARGETS},s390x-linux-user"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


