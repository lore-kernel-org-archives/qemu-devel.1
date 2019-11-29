Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE82C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:57:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD09217BC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 13:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Le2Ai/IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD09217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaglg-00073r-4s
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 08:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaghC-0004FW-3W
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:52:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iagh7-0000or-Ti
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:52:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59237
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iagh7-0000iw-PV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 08:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575035543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=WlPx4/sx/TZctH2jsqnOW/p7lypuvWawwIdh8jkMsrY=;
 b=Le2Ai/INqKzMxS2qqaFjllgNKRc2gMEW8sxUmPOfCf4o3s6KpkToR9XUSzzlPP5P7BbDNW
 2z573wUuXR86o1gORKz9HIeqrE732v3RBYZRpweyS9k+7/9xx1BpaBthKYTupbrPCumQ+P
 YlPfx6+kGS/4qfl3sMlSg5yARcTC7a0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-isy4_t0FOY61lH0GXG3K4Q-1; Fri, 29 Nov 2019 08:52:20 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8B7DB21;
 Fri, 29 Nov 2019 13:52:19 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-159.ams2.redhat.com [10.36.116.159])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2098A60903;
 Fri, 29 Nov 2019 13:52:15 +0000 (UTC)
Subject: Re: [PATCH for 4.2?] .travis.yml: drop xcode9.4 from build matrix
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191127132430.3681-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <38416b79-0068-6703-759b-2015b271801d@redhat.com>
Date: Fri, 29 Nov 2019 14:52:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127132430.3681-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: isy4_t0FOY61lH0GXG3K4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/11/2019 14.24, Alex Benn=C3=A9e wrote:
> It's broken so it's no longer helping. The latest Xcode is covered by
> Cirrus.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index c09b6a00143..445b0646c18 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -237,13 +237,7 @@ matrix:
>          - TEST_CMD=3D""
> =20
> =20
> -    # MacOSX builds
> -    - env:
> -        - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS}"
> -      os: osx
> -      osx_image: xcode9.4
> -      compiler: clang
> -
> +    # MacOSX builds - cirrus.yml also tests some MacOS builds including =
latest Xcode

Ack for removing xcode9.4, it's also constantly failing for me, which is
quite annoying.

Additionally, the xcode9.4 runs on macOS 10.13, which we do not
officially support anymore in QEMU (we only support the latest two
releases).

But maybe instead of removing the entry completely, you could replace it
with "xcode11.2" instead if that works? See:

 https://docs.travis-ci.com/user/reference/osx

  Thomas


