Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F3AC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 855D92067C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiOJjH3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855D92067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFill-0003i7-LH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihE-00031H-E2; Tue, 08 Sep 2020 14:50:28 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:43478)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFihC-0002ib-PD; Tue, 08 Sep 2020 14:50:24 -0400
Received: by mail-pg1-x533.google.com with SMTP id t14so177822pgl.10;
 Tue, 08 Sep 2020 11:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yqpsa73bQrzKkEPT9F/kH2K7vNqI8slBD9edFCTrOo0=;
 b=GiOJjH3ilEZikj3FTRNsztRMH1W97EMua3CMJHa8ywtwXLASqFqWU/2TR0ZAeWE3jY
 edfgF7PnTiORe1isWQxyJq3h58bg1joez1yYqx0v+jYgQzX/FPsCQdJ2NURi5wtmUESE
 Olcdl2g1KiMquWWYlvwAvxer4UAUkQkFt7ZORQ3FcYIg8WhrKFJcaq+De9lW+atuFSbq
 +pZpDWbxWjYwI26mGBS1ONmWGYl9kKHl5evY/QosgrlpM3TA0ch0575exw3lreYS576b
 gzSObE8Lkn/8l3SHGZnum7mCWhtlyq5c4RMVT6ddm7uZYGCevn2ufVxtlklaFtdoqD2K
 HyiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yqpsa73bQrzKkEPT9F/kH2K7vNqI8slBD9edFCTrOo0=;
 b=GbNeecMzMQsFIKlFiVV1Pj3ia2k2I3WUZciKQ3nNCjeY724++r0TLVIB8zqDtYQUmj
 A3tUXev2XLWrDibo5mQZsYvnYg+f01tOwLzODoo9MkXe4tLO0IwbfCP2b9zQL+9dmfzl
 e+aD2/C9JiI8PwIS9Yk0U9uu7My1ZRHCcz6F5m9J/6fd7QARwCSUvh3oX0c03PIylLrr
 Ne9cJYj2bEMrDxp+/2/gyBBH1eS9n6hzFgxZhaYI3fTGQrr5+xXq/itmMSZNcg1dbsQN
 eT7ujba83cB9VXnkY6UpFchJlLtOvR8ijX1jN+xvL4ctGS36wrofTcXJbXDBlk8HVdQk
 pOyg==
X-Gm-Message-State: AOAM53252bv+pLvvRrBaeOWvfEU6Tk0JY3jv2biv/Lv6AK+sTaBzhnrr
 6Vd8NxBfEpCg0teFpP/d8I0AnPZdTJcZ0YFY
X-Google-Smtp-Source: ABdhPJy+6wN4EfQnzL5iwjDk/XdHPi6JbeWCWa9ufz1jkUM5eqSss2Sa0C7WLpTGjl2mdtxq3Otn/g==
X-Received: by 2002:a63:5561:: with SMTP id f33mr109436pgm.13.1599591020731;
 Tue, 08 Sep 2020 11:50:20 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id 8sm43553pjx.14.2020.09.08.11.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:50:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] meson: disable crypto tests are empty under win32
Date: Wed,  9 Sep 2020 02:49:13 +0800
Message-Id: <20200908184918.1085-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200908184918.1085-1-luoyonggang@gmail.com>
References: <20200908184918.1085-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x533.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Disable following tests on msys2/mingw
      'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                   tasn1, crypto],
      'test-crypto-tlssession': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
                                 tasn1, crypto],
      'test-io-channel-tls': ['io-channel-helpers.c', 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                              tasn1, io, crypto]}

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 tests/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/meson.build b/tests/meson.build
index 998e4c48f9..b470a90e3a 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -145,7 +145,8 @@ if have_block
     'test-crypto-block': [io],
   }
   if 'CONFIG_GNUTLS' in config_host and \
-     'CONFIG_TASN1' in config_host
+     'CONFIG_TASN1' in config_host and \
+     'CONFIG_POSIX' in config_host
     tests += {
       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                    tasn1, crypto],
-- 
2.28.0.windows.1


