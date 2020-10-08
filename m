Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15AC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D872083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g4+hW0I3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D872083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVCX-0005vp-2J
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQVAS-0004G7-Rb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQVAQ-0007Fx-73
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602160625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRcG75tZk0vu22SxcgYOvD1PB127bK/OTP8m7a4jaF0=;
 b=g4+hW0I32E+BcvgXRglp0DrMUQNP8+ConFkbDdmUi0nINS8BT/ApHVUWJ52jtGOsr+igzw
 ztCcQi50eMjb3bero4LWUoW1tbqZ3ImcS0Mz7DmXM7bsYdfWPEpzwGBJpm8rcz+KV1QIcH
 T6l4PG5zilpIh3jWqsrhgOG+0rX1m2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-U-yhPUAHPOGpV64ot8AlmA-1; Thu, 08 Oct 2020 08:37:03 -0400
X-MC-Unique: U-yhPUAHPOGpV64ot8AlmA-1
Received: by mail-wm1-f72.google.com with SMTP id w23so3075737wmi.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IRcG75tZk0vu22SxcgYOvD1PB127bK/OTP8m7a4jaF0=;
 b=rhULADqfnxdTb3vGkh04XorjOcyVJTIZLo7nNw3RkLLh/CBO78D7zI3+/sWE/QPBpm
 3quG8r7xNG+NU8uF/GnIbV+dp2DhKY1DquuOkjsZBpt8wv9fZKxB7zw+uLKaS8bbYMpq
 R4CFAnwdWen5smHyj8ezMVgyildTwLT3ahQctzuE14JZxuOo+32O+wCy0lL9CRg0IMen
 BWGXfDuHkCMLW3T7uHICTF3RDJ/q3/FHo7IMdQraXWnA1YMHK3hvqLiLgt5PA6FyFGJE
 DFHxoZUSlQUIXJhuhV92t41Bqkozg+duFeQxvMfT2FiemZiVxnPwfQJOaVNZIRUeM48a
 rcEA==
X-Gm-Message-State: AOAM531PJgiTcLVYaAjg/3bppWO83jAijkxRtvws5F4P8DoRoDw7xMv0
 opoJikUzQaOIWJF6vPKEmakqx1S+sCP8sUHPUeqKWxWRbyWlsXMqdbjIu9J80pfb/EJZzOmFGRB
 KXJZdVfR6PcAsAyM=
X-Received: by 2002:adf:d850:: with SMTP id k16mr9006559wrl.259.1602160622695; 
 Thu, 08 Oct 2020 05:37:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlcgjyvVZbBRcQBEgJ9tak8/xFt7Ug8nilsiilb+G9K0fMyg8lukjC6iqyBc2yhzPBXvwEwg==
X-Received: by 2002:adf:d850:: with SMTP id k16mr9006546wrl.259.1602160622490; 
 Thu, 08 Oct 2020 05:37:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id x15sm8051847wrr.36.2020.10.08.05.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 05:37:01 -0700 (PDT)
Subject: Re: [PATCH v3 05/11] tests/qtest/qos-test: dump environment variables
 if verbose
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1601655308.git.qemu_oss@crudebyte.com>
 <8d8b242f38caccd81c27125167862f4457e8a22f.1601655308.git.qemu_oss@crudebyte.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff76657f-4da1-5131-f981-02ea975cf1a3@redhat.com>
Date: Thu, 8 Oct 2020 14:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8d8b242f38caccd81c27125167862f4457e8a22f.1601655308.git.qemu_oss@crudebyte.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/10/20 18:15, Christian Schoenebeck wrote:
> -int main(int argc, char **argv)
> +int main(int argc, char **argv, char** envp)
>  {
>      g_test_init(&argc, &argv, NULL);
> +    if (g_test_verbose()) {
> +        printf("ENVIRONMENT VARIABLES: {\n");
> +        for (char **env = envp; *env != 0; env++) {
> +            printf("\t%s\n", *env);
> +        }
> +        printf("}\n");
> +    }

But doesn't this (and patch 6 as well) break TAP output?  Using
g_test_message + g_test_verbose would be the best of both worlds.

In fact using printf in tests should be forbidden, since glib 2.62 and
newer _always_ emit TAP.

Paolo


