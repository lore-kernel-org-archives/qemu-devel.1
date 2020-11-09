Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46563C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:01:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98207206E5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWL5nFNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98207206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3zT-0002EY-7N
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc3xg-0000oe-SF
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kc3xe-0007sC-V5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604915980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UmPRvxsYWLrXdWILn21Qd7AHp2TCxZY0KecQeBszEw=;
 b=AWL5nFNfO3ioHUEeqMNmcADa0XYsdS+LG1UgRVko+NFsxXoqj91nEqDnI3IrnFT1R7Kkuh
 8+8kQWHnE0NaVUUp3n5M3ua+T0HE07NytxBPOm/EgJ7YhrFWRivZWnecxB1XdIQCpZJ2bq
 lDOgBEHvpCXPWRrQPBQHqz83QLn1AlE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-BHXVwEznPhGH-14rNw1UjA-1; Mon, 09 Nov 2020 04:59:39 -0500
X-MC-Unique: BHXVwEznPhGH-14rNw1UjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37FD480F058;
 Mon,  9 Nov 2020 09:59:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-53.ams2.redhat.com [10.36.112.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A764E5D98A;
 Mon,  9 Nov 2020 09:59:33 +0000 (UTC)
Subject: Re: [PATCH v3 11/11] gitlab-ci: Move artifacts expiry rule to common
 'native_build_job'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201108221925.2344515-1-philmd@redhat.com>
 <20201108221925.2344515-12-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <51367eb8-ce2f-aca5-0648-8c526245d355@redhat.com>
Date: Mon, 9 Nov 2020 10:59:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201108221925.2344515-12-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2020 23.19, Philippe Mathieu-Daudé wrote:
> Build jobs include the 'native_build_job' template. Move
> the 'artifacts expiry' rule there. Now all build jobs benefit
> from it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .gitlab-ci.yml | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index dd5f9a4c505..27a4cbc5171 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -79,6 +79,10 @@ include:
>        then
>          make -j"$JOBS" $MAKE_CHECK_ARGS ;
>        fi
> +  artifacts:
> +    expire_in: 2 days
> +    paths:
> +      - build

Should we also keep artifacts for pipelines that do not need it to pass them
from one job to the next? ... not sure ... considering that gitlab is
thinking about cutting down CI minutes etc., we should maybe be more
conservative and only keep artifacts where they are really needed?

 Thomas


