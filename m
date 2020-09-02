Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FC6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91562204FD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 09:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pi6oRoDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91562204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDPNe-0007sT-OP
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 05:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPN7-0007S8-Fe
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49268)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDPN5-0006qW-7i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 05:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599040082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhnN6HJUZiGCk7GagCL5uRu0jnzCm9TskM1VZ7DpPcI=;
 b=Pi6oRoDE1VpXqsR8w9eE8KngmRtfkXd5dGoiWqR4q6vS1HpFuSmne/1K+CMAHwYNIb7Zo1
 Is4g/vtGPIQ9CWY5vKvCE8NdiIZUjhoZZRwlHpXZ/Yd5nGUFj1kYUljvYaVXr3p+chAy1y
 Hb6bzD94DCIiHs2ubUC5B2mCyCpbKA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-m7-z9_4VOn6d4-V3d_DN_Q-1; Wed, 02 Sep 2020 05:48:00 -0400
X-MC-Unique: m7-z9_4VOn6d4-V3d_DN_Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 612D6801AE0;
 Wed,  2 Sep 2020 09:47:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-129.ams2.redhat.com [10.36.112.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E61B91972B;
 Wed,  2 Sep 2020 09:47:57 +0000 (UTC)
Subject: Re: [PATCH] tests/qtest/tpm: Declare input buffers const and static
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200902080909.161034-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ea048124-3902-8a36-c9a7-6e7dfbba3d5c@redhat.com>
Date: Wed, 2 Sep 2020 11:47:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200902080909.161034-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.13, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/09/2020 10.09, Philippe Mathieu-Daudé wrote:
> The functions using these arrays expect a "const unsigned char *"
> argument, it is safe to declare these as 'static const'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/qtest/tpm-tests.c |  4 ++--
>  tests/qtest/tpm-util.c  | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index a2f2838e15b..70c80f8379a 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -59,7 +59,7 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
>      tpm_util_startup(s, tx);
>      tpm_util_pcrextend(s, tx);
>  
> -    unsigned char tpm_pcrread_resp[] =
> +    static const unsigned char tpm_pcrread_resp[] =
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
> @@ -107,7 +107,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
>      tpm_util_startup(src_qemu, tx);
>      tpm_util_pcrextend(src_qemu, tx);
>  
> -    unsigned char tpm_pcrread_resp[] =
> +    static const unsigned char tpm_pcrread_resp[] =
>          "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
>          "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
>          "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index e2b29ef0f8c..3ed6c8548a6 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -98,9 +98,9 @@ void tpm_util_tis_transfer(QTestState *s,
>  void tpm_util_startup(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_startup[] =
> +    static const unsigned char tpm_startup[] =
>          "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
> -    unsigned char tpm_startup_resp[] =
> +    static const unsigned char tpm_startup_resp[] =
>          "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
>  
>      tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
> @@ -112,14 +112,14 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
>  void tpm_util_pcrextend(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_pcrextend[] =
> +    static const unsigned char tpm_pcrextend[] =
>          "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
>          "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
>          "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x00";
>  
> -    unsigned char tpm_pcrextend_resp[] =
> +    static const unsigned char tpm_pcrextend_resp[] =
>          "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
>          "\x01\x00\x00";
>  
> @@ -133,7 +133,7 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>                        const unsigned char *exp_resp, size_t exp_resp_size)
>  {
>      unsigned char buffer[1024];
> -    unsigned char tpm_pcrread[] =
> +    static const unsigned char tpm_pcrread[] =
>          "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
>          "\x03\x00\x04\x00";
>  
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

and queued (together with your ahci patch) to my qtest-next branch.


