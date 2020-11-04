Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABEC388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:19:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE6520714
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 09:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rf4xN3Iq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE6520714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaEwY-0001aa-JD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 04:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaEvp-00019n-0S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kaEvn-0001KS-EA
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 04:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604481494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAe1h6AW+xIkNnQQh2EWmXBOG4HVgFbKZRcGZfgHB9s=;
 b=Rf4xN3IqF9IR6Zh+f/6s1PJrfYIPeS+YnzDVtTRZ+CA4YscWp/y28Dga/+c9jtQcdSysRT
 xKCf3Aenf+R0AkO+OMvY0W1GzKP2yuyQzO0PLReZAjTevxnkjj2Qwq1Lkz3vFd2GUZ7x+P
 eabrNKtZJWr1Oh8e9vJc2PCSbCymRuk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-N1sgPp1RPuW1AQ61_F4aaw-1; Wed, 04 Nov 2020 04:18:10 -0500
X-MC-Unique: N1sgPp1RPuW1AQ61_F4aaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3C8D186DD21;
 Wed,  4 Nov 2020 09:18:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1C6B21E8F;
 Wed,  4 Nov 2020 09:17:55 +0000 (UTC)
Subject: Re: [PATCH-for-5.2 v2 3/4] gitlab-ci: Add a job to cover the
 --without-default-devices config
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201104084327.3010593-1-philmd@redhat.com>
 <20201104084327.3010593-4-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <dddf54a0-a940-c842-844f-7dbf71af3203@redhat.com>
Date: Wed, 4 Nov 2020 10:17:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201104084327.3010593-4-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2020 09.43, Philippe Mathieu-Daudé wrote:
> We test './configure --without-default-devices' since commit
> 20885b5b169 (".travis.yml: test that no-default-device builds
> do not regress") in Travis-CI.
> 
> Since having a single CI to look at is easier, and GitLab-CI
> is the preferred one, add the equivalent job there.
> 
> As smoke test, run the qtests on the AVR target. Since the
> boards are simple SoC, there is not issue with unavailable
> default devices there.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .gitlab-ci.yml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 3b15ae5c302..321cca2c216 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -262,6 +262,13 @@ build-user-plugins:
>      MAKE_CHECK_ARGS: check-tcg
>    timeout: 1h 30m
>  
> +build-system-ubuntu-without-default-devices:
> +  <<: *native_build_job_definition
> +  variables:
> +    IMAGE: ubuntu2004
> +    CONFIGURE_ARGS: --without-default-devices --disable-user --disable-tools --disable-docs
> +    MAKE_CHECK_ARGS: check-qtest-avr

As mentioned in my other mail, we can also use -m68k if you prefer that
instead of -avr.

>  build-clang:
>    <<: *native_build_job_definition
>    variables:
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


