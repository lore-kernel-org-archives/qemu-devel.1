Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9448C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:13:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764BA207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke9AxfCT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764BA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKm1-0003RE-IC
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 19:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlA-0002Q3-BX
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:12:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKl8-0006tg-RW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:12:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id l26so86529wme.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bSex25mrVuvuSRHch7MnZyzUA8bDq5hD+96o2w7A9Ew=;
 b=ke9AxfCTEhvMnPbpp+eUOFNvfV3C7VFD+exjDeoZZk1Tb7DUia0syQ89j31lfETPbd
 WT0+rESQbak02o15t1LbahtQfemuoeDILHciH3J50wBLjsFkKaC1Z8/YqS/LdaolHZpp
 0Xi2J1HxPVlYUAx3WeksDcFtrLWRbt9H7Q7c0Ya/KDJf27QrExrovBDLRKj0ZbF/NtaN
 G1e70eJ7gNYLg8knb9CyPx18RfhFTQ3DlBiC7+YgxHLPqNoplcSF5lYo6XxfUF+nSLfD
 asWT5BtQJvMzgPq5maMTwh9Sc6YWjGpbuk4h17Vg4m4IZ7G1OpqgCj50/ukcELYbcCjI
 B9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bSex25mrVuvuSRHch7MnZyzUA8bDq5hD+96o2w7A9Ew=;
 b=qo0aGVHlj4PjuKlx1HOTpDj8aWQKgXu4i4rBgvV1kgQQtmQCKEYYEcJxqvdQOdOa4S
 KnzQ1Ee3gKCUw9fDzei6aq25VN/3doPo3hhkkOTUvrXPWeeNxzXWhvoOhliXyXYioOkk
 Q4ZFLkzjX8uz7I2YDXxwMzVzVbX9Lpf7hcoKO7TCllA6U2YNJnew/0cSkcvru2MoYnBe
 97BBStNCj5ffR7L5CrxSKdt4c3dahkcbt9fPjfcX27IrNc8Qnz9hd4GQSbt2di+Nakee
 NvBDnMVhxnjGH0T/HSAeGWzQE/W2gR6DffLj31VGGRqlA8aScUWuTqXVLvvBDxVnT3a3
 BV4g==
X-Gm-Message-State: AOAM533JeEuPbA7J9+nBmNF1MpgYlYkFEskOL3188j4I7bGhzQqViP++
 850cmhkkZDOXaQVipKU4+JxC1GQ64jQ=
X-Google-Smtp-Source: ABdhPJzx0ZsX55dN4HvWc3/ZcA5ha4JnhK+lA/xS1l1D+ZbabhbOOcQ5nWD6TaNgHMTkJR0oXmeeSQ==
X-Received: by 2002:a1c:bb0b:: with SMTP id l11mr5735852wmf.31.1592349168189; 
 Tue, 16 Jun 2020 16:12:48 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.89.86])
 by smtp.gmail.com with ESMTPSA id o9sm2384226wrs.1.2020.06.16.16.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 16:12:47 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, rth@twiddle.net, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
Date: Wed, 17 Jun 2020 01:12:01 +0200
Message-Id: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Greetings,

As a part of the TCG Continous Benchmarking project for GSoC this
year, detailed reports discussing different performance measurement
methodologies and analysis results will be sent here on the mailing
list.

The project's first report is currently being revised and will be
posted on the mailing list in the next few days.
A section in this report will deal with measuring the top 25 executed
functions when running QEMU. It includes two Python scripts that
automatically perform this task.

This series adds these two scripts to a new performance directory
created under the scripts directory. It also adds a new
"Miscellaneous" section to the end of the MAINTAINERS file with a
"Performance Tools and Tests" subsection.

Best regards,
Ahmed Karaman

Ahmed Karaman (3):
  MAINTAINERS: Add 'Miscellaneous' section
  scripts/performance: Add callgrind_top_25.py script
  scripts/performance: Add perf_top_25.py script

 MAINTAINERS                             |  7 ++
 scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
 scripts/performance/perf_top_25.py      | 82 +++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 scripts/performance/callgrind_top_25.py
 create mode 100644 scripts/performance/perf_top_25.py

-- 
2.17.1


