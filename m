Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC7C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:07:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E0D20659
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGBJ/DDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E0D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL7IO-0007Z3-KH
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 12:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7GW-00063Y-3v
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kL7GS-0004tu-MN
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 12:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600877104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m24uscasZisKZs4+kiPJE3wNuHfkvKChM84OZk/FbwA=;
 b=jGBJ/DDIEjv7KOmwaS+VGwSaJ17xI2GPyc+Co0bl03PAypMwWgaNJxguNAUA4c/5KG4SmX
 L68e2iteC4hfwuQxmsUL1hIPrIflu1HO0wnLouCdKaRcfuljtKevEtuy5D7485rNjx70QF
 YuDY1d1lHa06NOhVOMdVYlZK/p6AghQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-4qSj_YuGMxSI0lljEtzfpw-1; Wed, 23 Sep 2020 12:05:01 -0400
X-MC-Unique: 4qSj_YuGMxSI0lljEtzfpw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F1DE64088;
 Wed, 23 Sep 2020 16:05:00 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-49.ams2.redhat.com [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32B3F19C4F;
 Wed, 23 Sep 2020 16:04:59 +0000 (UTC)
Subject: Re: [PATCH] travis: remove TCI test
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200923151030.1613449-1-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9f33653a-30bc-ca38-cec6-c0fbe17cbea0@redhat.com>
Date: Wed, 23 Sep 2020 18:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200923151030.1613449-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/2020 17.10, Paolo Bonzini wrote:
> The TCI test is already performed on gitlab CI, and it fails because
> Travis tests (generally) disable tools and therefore do not have
> "make check-qtest".  Just remove it.

Huh? Where is it failing? It currently seems to work fine:

 https://travis-ci.org/github/qemu/qemu/jobs/729440748

Anyway, since we already have similar job in the Gitlab-CI, I think it's
ok to remove it from Travis, so with the commit message tweaked:

Acked-by: Thomas Huth <thuth@redhat.com>


> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  .travis.yml | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index c75221dca3..5811215957 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -239,14 +239,6 @@ jobs:
>          - TEST_CMD=""
>  
>  
> -    # Check the TCG interpreter (TCI)
> -    - name: "GCC TCI"
> -      env:
> -        - CONFIG="--enable-debug-tcg --enable-tcg-interpreter --disable-kvm --disable-containers
> -            --target-list=alpha-softmmu,arm-softmmu,hppa-softmmu,m68k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64-softmmu"
> -        - TEST_CMD="make check-qtest check-tcg V=1"
> -
> -
>      # We don't need to exercise every backend with every front-end
>      - name: "GCC trace log,simple,syslog (user)"
>        env:
> 


