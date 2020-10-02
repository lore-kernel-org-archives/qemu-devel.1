Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05E5C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E06206C1
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 05:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqQpCfGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E06206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kODNq-00031X-Ol
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 01:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kODNI-0002cq-Vm
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kODNG-00052Y-TA
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 01:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601615573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUhK790eIh7mfRnrtI+yFdyHNJ22lYfoLa5dRsLcQOk=;
 b=AqQpCfGDH6ij0QQaMNE8VkebA9q9R5USRA9sZvifau2ZFcA3g40/LicdTdaCaN5FnzrIBC
 ApnjM+lyNYpact+TdNHlclKXWupsNiopFseXSChWK4LIySGIFOom3v+KdMBwpAneFpjzqH
 sEKefRpqEOSKmuoZqr2N+tdTvLjxYLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-DaRghXWPMS-bhQ__m0Dyyw-1; Fri, 02 Oct 2020 01:12:50 -0400
X-MC-Unique: DaRghXWPMS-bhQ__m0Dyyw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1761084C85;
 Fri,  2 Oct 2020 05:12:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-90.ams2.redhat.com [10.36.112.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87CA455770;
 Fri,  2 Oct 2020 05:12:42 +0000 (UTC)
Subject: Re: [PATCH] gitlab: move linux-user plugins test across to gitlab
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201001215114.28154-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dba14443-b881-e11c-bf8a-c5b1902c1b01@redhat.com>
Date: Fri, 2 Oct 2020 07:12:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201001215114.28154-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.26, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/10/2020 23.51, Alex Bennée wrote:
> Even with the recent split moving beefier plugins into contrib and
> dropping them from the check-tcg tests we are still hitting time
> limits. This possibly points to a slow down of --debug-tcg but seeing
> as we are migrating stuff to gitlab we might as well take advantage of
> the ability to properly split our builds.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .gitlab-ci.yml | 23 +++++++++++++++++++++++
>  .travis.yml    | 11 -----------
>  2 files changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index c265e7f8ab..cc16385d65 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -244,6 +244,29 @@ build-user:
>      CONFIGURE_ARGS: --disable-tools --disable-system
>      MAKE_CHECK_ARGS: check-tcg
>  
> +# Run check-tcg against linux-user (with plugins)
> +# we skip sparc64-linux-user until it has been fixed somewhat
> +# we skip cris-linux-user as it doesn't use the common run loop
> +build-user-plugins:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: debian-all-test-cross
> +    CONFIGURE_ARGS: --disable-tools --disable-system --enable-plugins --enable-debug-tcg --target-list-exclude=sparc64-linux-user,cris-linux-user
> +    MAKE_CHECK_ARGS: build-tcg
> +  artifacts:
> +    expire_in: 2 days
> +    paths:
> +      - build
> +
> +check-user-plugins:
> +  <<: *native_test_job_definition
> +  needs:
> +    - job: build-user-plugins
> +      artifacts: true
> +  variables:
> +    IMAGE: debian-all-test-cross
> +    MAKE_CHECK_ARGS: check-tcg

I think it would be easier to use one job and increase the timeout
there, see:

https://docs.gitlab.com/ee/ci/yaml/#timeout

 Thomas


