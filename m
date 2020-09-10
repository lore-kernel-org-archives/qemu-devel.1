Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C15C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382F221D6C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 13:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2oZnoRe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382F221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGMsQ-0005Cs-7t
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 09:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kGHFG-0003Zq-Vd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:43:51 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42231)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kele.hwang@gmail.com>)
 id 1kGHFF-0006wA-AG
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:43:50 -0400
Received: by mail-pg1-x543.google.com with SMTP id m5so3784291pgj.9
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zioyCSX2ghVg4EyqyVRB3f4wkIT7KsOFtx56jQRuvaI=;
 b=a2oZnoReD4+4VbmqlPgXxBQFIkJaavgJ80bq/RDJ/45z8taOGH70vIFrPXL8dMjle4
 Xtovk1qk6JW1IyS3xwMhZJ3w0w1WAcWxQmwg9+PXN52cK/VYxIsiyqmIWpod8NMalZEn
 isumS3CkVKa9tsjrbPo6OGkcBXB6SQSnTY7rj34zRiFyWmos5wh8rIDYFiIQt5piuR9j
 Sp5CoJDQLdWrb25MJLSoFkc5K2T1KWVPpCPp0uLwl9OANaYN5rgUVv8LU4F84mcvOzqi
 6RyzMdHgflnh9U88a8qGHk8wTPO+yPej1/Pmm8XimX+cGMfc6E+7W6rtWyLV4aj5Vab/
 U+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zioyCSX2ghVg4EyqyVRB3f4wkIT7KsOFtx56jQRuvaI=;
 b=UH4F51rD/NsYFikdhD04gqkv0GIcN+mwVnB9RvjLi+OHcpQndszp8tPqXeO2LizjFN
 R1GifMbDTAuimannPdK7FW+dLSF8Rq+Ij4RI3MiCeltIY4y7nNDNYIWhr9Xxdmtvrawt
 BLGY/0WS5JYi00N+4+wrd1NPAIfc8yMYstvI5MO7nX/oqWBBtpa3r2PH8n2mggvNFzdQ
 8F2s+OhNR12ThO9VqTUztdGLl+1Wvb+2XHUt/DOmmCF3+eEaCkQzohSBbbUuUKu1MYTj
 a8Yn4OM7eUM1RI6Wla2IMDGUVvEfKSHcRBHGhe8ldEbuV5qLfwrSCtPnF5vP7DzhuKFs
 y8sQ==
X-Gm-Message-State: AOAM532XvBd/mspFoPdLOA8htRqAnzAKLTBmqN0/szxQM+6hwrZSKL5q
 09gLHTRH5rvT5ddGIhN3ekYrSS1GClDMgbk9hdWW9Q==
X-Google-Smtp-Source: ABdhPJx5liAW8JgpQ9ZGV1TuwUcfFqMda+CqbdUoHzLl92dYYQ5MP8I7qYXhzDCiQmdh9et+yQJL2A==
X-Received: by 2002:a65:68d6:: with SMTP id k22mr3397879pgt.136.1599723827099; 
 Thu, 10 Sep 2020 00:43:47 -0700 (PDT)
Received: from carbon.loongson.cn ([52.229.162.29])
 by smtp.gmail.com with ESMTPSA id n67sm3995337pgn.14.2020.09.10.00.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:43:46 -0700 (PDT)
From: Kele Huang <kele.hwang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/1] accel/tcg: Fix computing is_write for mips
Date: Thu, 10 Sep 2020 15:43:41 +0800
Message-Id: <20200910074342.20421-1-kele.hwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <503406>
References: <503406>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=kele.hwang@gmail.com; helo=mail-pg1-x543.google.com
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
X-Mailman-Approved-At: Thu, 10 Sep 2020 09:42:38 -0400
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
Cc: Kele Huang <kele.hwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Detect mips store instructions SWXC1 and SDXC1 for MIPS64 since
MIPS64r1, and MIPS32 since MIPS32r2.

Can work better with self-modifying codes (SMC) now.

Kele Huang (1):
  accel/tcg: Fix computing is_write for mips

 accel/tcg/user-exec.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.17.1


