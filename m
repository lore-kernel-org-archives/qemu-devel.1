Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7DC4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE2A20786
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9YPq8BR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE2A20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaIfd-0001vG-Vb
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1kaIei-0001QC-EC
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:16:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60781)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wainersm@redhat.com>)
 id 1kaIeg-0008BC-P1
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604495809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oqlU3G+Rm2DQJnTPMoPXXklsZ3A19mrSGjbatqPJSVc=;
 b=Z9YPq8BRZ1DydBtaPJAyYXwIMDz1Ligo5+VdnW+zy5v6EVsT+NxRVWJhg24k9YznLSXRNw
 fjtIHHpwupaQ1CSF0fNGjtoB/tB+jHQGBwWaLYD2T7cQ4iWyXlnToo/QBKu2pLG+RVf0qB
 0WWB1b5HyxtTgUu9meVdz+muXjhOdjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-QSg5vacCOt2mK6sczRPpJQ-1; Wed, 04 Nov 2020 08:16:46 -0500
X-MC-Unique: QSg5vacCOt2mK6sczRPpJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39DE064158;
 Wed,  4 Nov 2020 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-201.rdu2.redhat.com
 [10.10.116.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1C675131;
 Wed,  4 Nov 2020 13:16:32 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 v3 4/4] travis-ci: Remove the
 --without-default-devices job
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104115706.3101190-1-philmd@redhat.com>
 <20201104115706.3101190-5-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <dd08cb7c-70ff-7b19-7d82-377f95b65c8d@redhat.com>
Date: Wed, 4 Nov 2020 10:16:17 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20201104115706.3101190-5-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=wainersm@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=wainersm@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/20 9:57 AM, Philippe Mathieu-Daudé wrote:
> We replicated the --without-default-devices job on GitLab-CI
> in the previous commit. We can now remove it from Travis-CI.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   .travis.yml | 8 --------
>   1 file changed, 8 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index a3d78171cab..15d92291358 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -224,14 +224,6 @@ jobs:
>           - ${SRC_DIR}/scripts/travis/coverage-summary.sh
>   
>   
> -    # We manually include builds which we disable "make check" for
> -    - name: "GCC without-default-devices (softmmu)"
> -      env:
> -        - CONFIG="--without-default-devices --disable-user"
> -        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
> -        - TEST_CMD=""
> -
> -

Goodbye.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>       # We don't need to exercise every backend with every front-end
>       - name: "GCC trace log,simple,syslog (user)"
>         env:


