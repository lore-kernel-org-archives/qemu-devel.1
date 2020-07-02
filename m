Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF44C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8AF20936
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez5mBgFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8AF20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqtsh-0002qg-6v
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jqts8-0002QF-AS
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:43:04 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24346
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jqts6-00033z-2B
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593675779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rUFjCc909kYF730XZDNNC8RP/af6nmrEh1PPkjsPbU=;
 b=ez5mBgFHqvoSJ0sVzncRA0KO0gdEMGwrHrLJFw3yDXF7zOjSO3u0YSfyYakS/9TViedcXF
 Y2UT8/EEEN495TIqjBbY2fYQqswbmQquW1wruiiu2eWCeKzJRZ6n+hd6+lT9IX3AAX8/OI
 9LnQNcieWhtE6XVtttNCamqGsZs8Qr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-xMYo57uNPbSDe99_8PSMDw-1; Thu, 02 Jul 2020 03:42:57 -0400
X-MC-Unique: xMYo57uNPbSDe99_8PSMDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3F5D80058A;
 Thu,  2 Jul 2020 07:42:55 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-177.ams2.redhat.com
 [10.36.113.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3417E4FA3F;
 Thu,  2 Jul 2020 07:42:53 +0000 (UTC)
Subject: Re: [PATCH v3 17/30] gitlab-ci: Fix the change rules after moving the
 YML files
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-18-alex.bennee@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ff4ee4c6-d03f-a856-fcaf-96858a8f35be@redhat.com>
Date: Thu, 2 Jul 2020 09:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-18-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/26/20 20:13, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The edk2.yml and opensbi.yml files have recently been moved/renamed,
> but the change has not been reflected in the rules in the YML files
> yet.
> 
> Fixes: 922febe2af ("Move edk2 and opensbi YAML files to .gitlab-ci.d folder")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Message-Id: <20200625151627.24986-1-thuth@redhat.com>
> ---
>  .gitlab-ci.d/edk2.yml    | 2 +-
>  .gitlab-ci.d/opensbi.yml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.gitlab-ci.d/edk2.yml b/.gitlab-ci.d/edk2.yml
> index 088ba4b43a3..a9990b71475 100644
> --- a/.gitlab-ci.d/edk2.yml
> +++ b/.gitlab-ci.d/edk2.yml
> @@ -2,7 +2,7 @@ docker-edk2:
>   stage: build
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
> -   - .gitlab-ci-edk2.yml
> +   - .gitlab-ci.d/edk2.yml
>     - .gitlab-ci.d/edk2/Dockerfile
>     when: always
>   image: docker:19.03.1
> diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
> index dd051c01245..6a1750784ac 100644
> --- a/.gitlab-ci.d/opensbi.yml
> +++ b/.gitlab-ci.d/opensbi.yml
> @@ -2,7 +2,7 @@ docker-opensbi:
>   stage: build
>   rules: # Only run this job when the Dockerfile is modified
>   - changes:
> -   - .gitlab-ci-opensbi.yml
> +   - .gitlab-ci.d/opensbi.yml
>     - .gitlab-ci.d/opensbi/Dockerfile
>     when: always
>   image: docker:19.03.1
> 

Reviewed-by: Laszlo Ersek <lersek@redhat.com>


