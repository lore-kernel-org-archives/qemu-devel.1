Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C55C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76D62082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK6KxzCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76D62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60023 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhel-0001ip-3S
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:44:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVO-0001Ey-07
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVK-0001SO-HZ
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:20 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:41751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVI-0001QJ-LW
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:18 -0400
Received: by mail-pf1-x444.google.com with SMTP id l132so2178234pfc.8
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=eiE9fqe9KMXKwTkJClxb0B2B9ssy/VKRiWp6bsH/0U0=;
	b=sK6KxzCNzNFZFFS5hBP6i9IqgAut+jrnX9Azs97fkmeWcNbvdyHnS+KSS1jSUX4bij
	x9wop2iwo3pTvk9yCrAaL2NncN6cjXJtPhkKEaDwWJJT/I9AKcf7N3+LEasky95cyzPw
	fiddB8n9QZyfgkT8pXBk5ZRRKPR4IIGdYgSM64luPmO5jc9fiUK57eoUKqArtPslpPo3
	6UKxJ71IkqdFyuqic/UiUJYtRHGytAbJ/1qcEMnA8fZ+I6QxTd31GvdoeOipUHA9NlhU
	Nlmdn1BguZGgKaBS2WpBjT9sOurvC1A2SVs7tOeitcwZl6pUrwb/RnpGX7ggFu/LtXg4
	u66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=eiE9fqe9KMXKwTkJClxb0B2B9ssy/VKRiWp6bsH/0U0=;
	b=HZPFvVJuWcBTfiJWNm1Q3nOeI5QUIPXP6/F0Rts1Wul6vwJ0UuD/kEE2dFdL3oEA6b
	G+PYXYbDcMPV7h1GR/AgoTedwVpaF1Kl+8D0hfqfi3wZY+UslGOwqUTwnIAZdAPHDRK0
	lMEi6YiTdyAVEQTjmkH620ynvyvFQvonJCOfI/IEy3i+ImsVU66wGP1wITysM6aCYzkM
	5Q2EfJJL4u0diuNoxloHNRpWJwuFLKlC08kvFVjggsFl3sTJrSzS8HZx1siqvLOUgoB7
	0lr2735oDRYsZ1HhRIhmbhOwbkl0GR310cmvG6tVRWHNvrIRDtJRP2YuHlW3bnvcWWrQ
	FiUA==
X-Gm-Message-State: APjAAAUdXkBHhoR4oItMSzTeSzOGbyMSbsYU1w+jbZBu4IDyjHqFfddd
	vm9Nuq3wOiPJkgwHQfAmGX5f4a7DKQs=
X-Google-Smtp-Source: APXvYqyaCILbO54ajmpct6Vrf74iGV9DDBxkA/uasGdP3elG2AR6L6rw7n9Jnv2xpwhwHGzUXEx3bQ==
X-Received: by 2002:a62:5286:: with SMTP id
	g128mr34058692pfb.226.1557164055105; 
	Mon, 06 May 2019 10:34:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:45 -0700
Message-Id: <20190506173353.32206-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v4 16/24] linux-user: Remove srand call
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We no longer use rand() within linux-user.

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index e05aebe4e1..5d1c6a115b 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -623,8 +623,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_model = NULL;
 
-    srand(time(NULL));
-
     qemu_add_opts(&qemu_trace_opts);
 
     optind = parse_args(argc, argv);
-- 
2.17.1


