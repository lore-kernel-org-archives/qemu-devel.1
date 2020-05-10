Return-Path: <SRS0=vfNf=6Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E8C38A2A
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB4020736
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2020 17:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWusThvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB4020736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXpV6-0007Ii-La
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 13:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU6-0005lV-1k; Sun, 10 May 2020 13:11:26 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:33949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jXpU5-0000BV-7r; Sun, 10 May 2020 13:11:25 -0400
Received: by mail-ed1-x544.google.com with SMTP id g16so5876576eds.1;
 Sun, 10 May 2020 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g3CQKoEsceWltY1vfC5X9PTIbG5UKc71WRd2sRWmnNo=;
 b=mWusThvKxZ0N9XxbLxhOJ5eUy2Hx5nGDF7aNELt9BwPw/JUUDp7tDFjCdp778SqzCS
 tlgQDpcmCLxTkMNUJhQzG8fz5QwzjNbAcN9ySp3j3ja2e0mgeatnBYv8w0HMjRjabWfi
 WPjoTlrCR8YX5HsiegJ/zZ3684yATucuENuIZLrGf+wcKaIDD5zK8z04w3NBsc0loclH
 GqAiv1KIVZCRCAbEGVV+V8qkYsQgMM+dtqVFAY1MJhTiGIhhPgSRu9CDMj9TjgoPIBug
 IAeua/vtKKhocxCpX2M0sQhJOwHTVYmDu2NWFNjAVKY+L1gwciVXFQX7fovPpGpxZvR6
 w/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=g3CQKoEsceWltY1vfC5X9PTIbG5UKc71WRd2sRWmnNo=;
 b=nl35KYjgXNvCRnHiE2dYx6jmR6TwXs2/vkyYmFav/T+u4NCBvZwNohLcQOdkrZaikW
 KSxTI8dGLvj7RLJ516lLDQhQJdDym7qlLQI8aPN1V/2iI8dc1zSILQx28/YguxRhvYit
 l67A/Hu75oJRtz/0rQpd9Od/P4NcrbNX7BAHtVrKzpUp628rTvEMQThAVe0CWM9T2hVH
 mdkVgewClTOSk8oJtDXxz8K2bRL9iEdDhbXR+if0dmKhp0Iu1Ab48UaFqhVt+ZzD9P9E
 4MX7xci4oIK4Pp+HvxwllXrO8jjgFjp51bX6mY3SOzrELo6hZ/I2UhOdb7PYtu6lZM2t
 mcoA==
X-Gm-Message-State: AGi0PubwKwWMZfLlA/j4LjIG/HALcUJFG65UBuj5k7+1jIe9K7ZTxB7K
 YWc7N9IS74Q38epCfyOOHc3foVwBcoc=
X-Google-Smtp-Source: APiQypKFjlZFGyKOuYxPH+HBVACdAG36MfrM67vMDO1QrAnzmtM5YBjgvFI/OCu1aPHkwUFU+Q/blQ==
X-Received: by 2002:a50:8b06:: with SMTP id l6mr10016514edl.190.1589130683278; 
 Sun, 10 May 2020 10:11:23 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id w7sm960776edr.20.2020.05.10.10.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2020 10:11:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] plugins: Move declarations around and rename 'hwaddr'
 argument
Date: Sun, 10 May 2020 19:11:16 +0200
Message-Id: <20200510171119.20827-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, "Emilio G . Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename qemu_plugin_hwaddr_is_io() 'hwaddr' argument to later
allow declaration of the 'hwaddr' type to be poisoned (see [*]).

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg02254.html
    "exec/cpu: Poison 'hwaddr' type in user-mode emulation"

Philippe Mathieu-Daudé (3):
  qemu/plugin: Trivial code movement
  qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
  qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument
    const

 include/qemu/plugin.h      | 65 ++++++++++++++++++--------------------
 include/qemu/qemu-plugin.h |  2 +-
 plugins/api.c              |  4 +--
 3 files changed, 34 insertions(+), 37 deletions(-)

-- 
2.21.3


