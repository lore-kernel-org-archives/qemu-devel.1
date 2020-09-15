Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC39C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08A42193E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq1mkQJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08A42193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEdg-0006ex-0J
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWv-0008Og-Df; Tue, 15 Sep 2020 13:14:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:36413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kIEWR-0002gn-Tf; Tue, 15 Sep 2020 13:13:41 -0400
Received: by mail-pf1-x434.google.com with SMTP id d9so2334469pfd.3;
 Tue, 15 Sep 2020 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/tGNcDT+soty377wKryHTaQKgDiEnZiZY12oC2sg7jk=;
 b=Jq1mkQJ2oLMhp2/agRHxyXoYfMSJ+5X9wsHvMkKqB/FPDniLQbEwzb1MaqAPCXBGto
 oxqp9q9DdTfHYlmwse2STsfHylDjq0DNljfkRygpfdga7ffdbNUcoGm/uJhY7IhPoyxO
 H7CS8EGD9lPnhoaIkXCz2EWQ6zL0B+uTacBg8TFkHgJ8CTfy40Ng1Ae07D4Vs9UaAAaX
 SiJ63QQMQj7Yaecyc5UbVaQLhSB2OXvHcbjiaoZvd/8Ac+6bhVk9vBlyNMBfXlLbqQmp
 aQT2okwatv4D94OUgcJK8fmGHGHvlcYYwvTQQysjSYOqrdA1Sn1xd4kLE4RmFdqtkUUj
 Qyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/tGNcDT+soty377wKryHTaQKgDiEnZiZY12oC2sg7jk=;
 b=BWm7Oz0TGO12UH+SE4LbY5x9RQiY3VIqgLRK3gYL9LGuhb2XG2BhvM2ScjwDd2M4b2
 8XI4OzBvZVE2QGW4h4qc41zYYTjnfKSSEIV4u2Nh9TCTqQn+Yc7KoPWazLBiGsisNuxZ
 0w3AUXY/taf8ScMocH2N54cK0OtdtnH2nySSUr9q0lCmc7nL2efNdtj+/18AlrrnoqsV
 MvUwAP5p1JPcGSu7i7TTxf+S+TUbd7zPDwtuZ/aT6uFM9SPy+erxRq9SAcW9amrRKPBD
 /VL09twyY+3cezxRkFmDMMs3LOYvCKUe9EFIP5U/fhC64e42l9aq8q3i5yrrHF7KnIEZ
 LKUg==
X-Gm-Message-State: AOAM531swuFRDme8gvIc6ipmrgiIsHJfwLt1GPBkwj/543Lhuy8UCof+
 olTDgNJTAzvwdPNnNAHIRHd9FovqF43EgXxOcbQ=
X-Google-Smtp-Source: ABdhPJxVyVNPbviiIqqua7FhfGfCrzXlgGJVxXpcVhJSn6ZzxahgLTvN/kOC9huSBuvHZrx/eHuotQ==
X-Received: by 2002:aa7:82ce:0:b029:142:2501:35cb with SMTP id
 f14-20020aa782ce0000b0290142250135cbmr2821403pfn.43.1600190017789; 
 Tue, 15 Sep 2020 10:13:37 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id j14sm124046pjz.21.2020.09.15.10.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 10:13:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 10/26] meson: Use -b to ignore CR vs. CR-LF issues on
 Windows
Date: Wed, 16 Sep 2020 01:12:18 +0800
Message-Id: <20200915171234.236-11-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200915171234.236-1-luoyonggang@gmail.com>
References: <20200915171234.236-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x434.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ideally we would use the '--strip-trailing-cr' option, but not
being POSIX is a portability problem (i.e. BSDs and Solaris
based OSes). Instead use the '-b' option which, although doing
slightly more, produce the expected result on Windows."

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qapi-schema/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c87d141417..f1449298b0 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -220,6 +220,6 @@ qapi_doc = custom_target('QAPI doc',
 
 # "full_path()" needed here to work around
 # https://github.com/mesonbuild/meson/issues/7585
-test('QAPI doc', diff, args: ['-u', files('doc-good.texi'), qapi_doc[0].full_path()],
+test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'), qapi_doc[0].full_path()],
      depends: qapi_doc,
      suite: ['qapi-schema', 'qapi-doc'])
-- 
2.28.0.windows.1


