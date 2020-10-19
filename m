Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225A8C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D852224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ersHZS3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D852224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYv3-00071c-9R
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 13:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYtx-0005qs-Cq
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:24:53 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:40830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1kUYtv-0004QY-LE
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 13:24:52 -0400
Received: by mail-lj1-x236.google.com with SMTP id 23so921966ljv.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=6cXcyq49YeK0CIacutBMvNQbn/a7ge9uZijJ3uFfqH0=;
 b=ersHZS3aQSEPjBUkvwNZht1Cs7SbW0XuBqRNMCP2MD5SQNwhlLkkUVt0ZtQ+iduPJo
 D/2vvn+5TvGJkvM1ICAWtW/3SEXqfoVqkrJjxCC3KczY0busY6UNVLTSgwKerSJshjrS
 AFAqzoUed5U40SCnPquYdihj3K9aDGxG6y+G8uW9Vuq9y9O1qdkkNU1zyUeYjLLzn731
 N+ZT3s0jctoVgGWfDYtVwbaLoSY43IcTPgSaJRLYaswtqk3gUL6n02tHhXN7ScDHxhWq
 sVsO1tLiiu15Gi1w1BKmjlWk+CXm9kMuD6ubfHCSs/HqB2gwmBAgL1+r46DJez5diFbF
 qPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=6cXcyq49YeK0CIacutBMvNQbn/a7ge9uZijJ3uFfqH0=;
 b=qkSTe9xFE3UhyHn3MOoGcgpwjWZUWVvK6RaP9fqPPGVESS0DfoalqESI5Xue6EO+zG
 1o68lnqxlKZjTLLvb3pmwTxdHQt2McbuxTl6/oytX8o8yZdHXEOkJZiXk70uuwDK+4XU
 lAqkw4Q884u1WAIn3aieAlXQ+qHXsdtmF9W5VgZlP2Jr2WuKOzodOm4hWi7DLfp3OwYj
 RUANg1axrQsmJOdnW9T2e0DCfpv5ebmX6rTeW1MTulgbi/ia82nBXZmDDX6RsI4S+gjs
 B2TxEegLg/QNayXORv1Mqnp4bWC8DC8sLx5Cj7h+PRc3j20fatXkYAcyXrMd2IfCeRDd
 YeYg==
X-Gm-Message-State: AOAM532O5oewYJfnTctf48vHCBK+6KnKpQR68bvYLdWMlEoQ+1sHGP0a
 ABTtQ8I4uQS1WO/DKr4Cl6s=
X-Google-Smtp-Source: ABdhPJwVUyVWQJaWxaSVU02Ji2Mm0yFrYt1CU5SvPcJz+d5yAlO5lyGhK8CibvRwXvtPDls6AFGRwQ==
X-Received: by 2002:a2e:80d2:: with SMTP id r18mr478382ljg.286.1603128289613; 
 Mon, 19 Oct 2020 10:24:49 -0700 (PDT)
Received: from [192.168.2.1] (net.iroazh.eu. [109.190.73.171])
 by smtp.gmail.com with ESMTPSA id 130sm86438ljj.69.2020.10.19.10.24.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 10:24:49 -0700 (PDT)
From: "Emmanuel Blot" <eblot.ml@gmail.com>
To: "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: ld: file not found: _PreallocMode_lookup on macOS Catalina
Date: Mon, 19 Oct 2020 19:24:47 +0200
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <D99AD299-56A5-4252-9A39-FA0262B24B24@gmail.com>
In-Reply-To: <1cdb3e50-0dfb-3ddd-fed7-142e893fa364@redhat.com>
References: <24B952F3-465C-4AB2-AF28-6CA4722D94B7@gmail.com>
 <3869557c-10a0-8f07-a59a-69120a522568@redhat.com>
 <AA504B32-5134-4CDD-8CDA-6F200C7376CF@gmail.com>
 <1cdb3e50-0dfb-3ddd-fed7-142e893fa364@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=eblot.ml@gmail.com; helo=mail-lj1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19 Oct 2020, at 19:14, Paolo Bonzini wrote:

Sorry, I received your email just after I posted mine.

> I think this could be the fix.  The problem would be that
>
> 	awk '$2=="U"{print "-Wl,-u," $1}'

/

> Great, thanks.  Can you check if my patch would also work, as it would
> adhere more to the pre-conversion logic?

You fix does work, you can forget mine.

Thanks for the quick fix,
Emmanuel.

