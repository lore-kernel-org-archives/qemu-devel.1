Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F93C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F107922304
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV7Aoo9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F107922304
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3o2-0006un-TY
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:44:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iX3hl-00015T-49
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iX3hj-0006nE-RR
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:38:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33115
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iX3hj-0006mw-NL
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574170682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JG/ysw3bE6Epdk0PvBZpr8YCrHDNhJi2HiwOWJe+t8=;
 b=gV7Aoo9soLTnL1nj+CpiMD4CF7Gh3tj5HMz11UjoC1ijnkczm28xri4FBPcowkp3WHfX6m
 Nw1xNZ1un1P2zcSyh4S2jPhTe7EWyjdlMfamGFQ7TOOmzApdKkLtsnE3IGojTFz42uuYwu
 Iyd5ZTY94v71ZpB9gR89JBvmRsUmDuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-XuvIwB0QNPGzBlFIOH3row-1; Tue, 19 Nov 2019 08:37:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8192B80269B;
 Tue, 19 Nov 2019 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-83.gru2.redhat.com
 [10.97.116.83])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC4465F92C;
 Tue, 19 Nov 2019 13:37:51 +0000 (UTC)
Subject: Re: [PATCH] travis.yml: Remove the redundant
 clang-with-MAIN_SOFTMMU_TARGETS entry
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191119092147.4260-1-thuth@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <53459e38-4866-254a-17ed-08931edd14f1@redhat.com>
Date: Tue, 19 Nov 2019 11:37:50 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191119092147.4260-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: XuvIwB0QNPGzBlFIOH3row-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/19/19 7:21 AM, Thomas Huth wrote:
> We test clang with the MAIN_SOFTMMU_TARGETS twice, once without
> sanitizers and once with sanitizers enabled. That's somewhat redundant
> since if compilation and tests succeeded with sanitizers enabled, it
> should also work fine without sanitizers. Thus remove the clang entry
> without sanitizers to speed up the CI testing a little bit.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .travis.yml | 6 ------
>   1 file changed, 6 deletions(-)


Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/.travis.yml b/.travis.yml
> index b9a026c8ee..47875bdafe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -181,12 +181,6 @@ matrix:
>         compiler: clang
>  =20
>  =20
> -    - env:
> -        - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARGET=
S}"
> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-default"
> -      compiler: clang
> -
> -
>       - env:
>           - CONFIG=3D"--target-list=3D${MAIN_SOFTMMU_TARGETS} "
>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-clang-sanitize"


