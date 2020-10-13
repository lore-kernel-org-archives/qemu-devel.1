Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB939C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1903620789
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 08:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMYqVgq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1903620789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSFO6-0001kX-5f
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 04:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSFMr-0000mI-Ms
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSFMp-0001Lr-Ve
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 04:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602576546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rp3PbhqZRm2cB8Qz+fnsXjWgofcgJfQO1WKC1y7MHXA=;
 b=OMYqVgq9Rjq5176kchSU0+vPM8PhBfuCZhvcF8p/HgEoaRVK5QF7CPmDkV/+MktxYRVTkw
 QkGQYBA9t9gu6+TOKPfO0MvPBQUHAKhBRVWCRhgJOPZFtd7nN8RvKGur3WpRacIv1AGiov
 CbU0r6HAYk91MyxWdg0Hdh22C36RKek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-pssVjhyQOwyGvgFlmq4XTQ-1; Tue, 13 Oct 2020 04:09:03 -0400
X-MC-Unique: pssVjhyQOwyGvgFlmq4XTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC14E1091063;
 Tue, 13 Oct 2020 08:09:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 12FA75C22D;
 Tue, 13 Oct 2020 08:08:58 +0000 (UTC)
Subject: Re: [PATCH 1/3] gitlab: add a CI job for running checkpatch.pl
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200918132903.1848939-1-berrange@redhat.com>
 <20200918132903.1848939-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34ecfca3-e8f1-4faa-d55d-df40310f08a0@redhat.com>
Date: Tue, 13 Oct 2020 10:08:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200918132903.1848939-2-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/2020 15.29, Daniel P. Berrangé wrote:
> This job is advisory since it is expected that certain patches will fail
> the style checks and checkpatch.pl provides no way to mark exceptions to
> the rules.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .gitlab-ci.d/check-patch.py | 48 +++++++++++++++++++++++++++++++++++++
>  .gitlab-ci.yml              | 12 ++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100755 .gitlab-ci.d/check-patch.py
[...]
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a18e18b57e..3ed724c720 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -369,3 +369,15 @@ check-crypto-only-gnutls:
>    variables:
>      IMAGE: centos7
>      MAKE_CHECK_ARGS: check
> +
> +
> +check-patch:
> +  stage: test

Would it be ok to move this to the "build" stage, so that the job does not
have to wait for all the slow build jobs to finish?
(same question applies for the next patch, too)

If you agree, I can do the change when picking up the patches, no need to
resend just because of this.

 Thomas


