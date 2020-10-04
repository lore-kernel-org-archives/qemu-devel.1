Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7CDC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945DB2065E
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LllpIgSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945DB2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8P0-0003dZ-Am
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NN-0001zt-Oy
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:49 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:39736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NM-0008Hr-09
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:49 -0400
Received: by mail-wr1-x432.google.com with SMTP id k10so7089143wru.6
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZsDgnrJqfOPBDNqcP+eHbnrmNO8wUSqpbmQU08QeIAU=;
 b=LllpIgSV2og/UNeu5hhvZX0cq6bmrnQ15a+vkflcdGbStE9Ay4qTriUj0/XKqcIg28
 Q3XMD3p0yvnptw/VEIijkRpsyGFMQf9qiCqBF0K1XrkM8F7etPWifKw7w0VwW5iYPLpY
 7M8Pb3kjBTe4l1Z1B0r6UOoy6GCUa6y/oF6MopneiiJLxbB0/OoXTCfQDFTC/y9tncmN
 IscAK28Q+ZaUXnUsawFRH5xdJOGb4CorXaUqL03aAetQ86SfIaPBJ4hXJsyjNbKZLxhL
 Z2vL5bGwi5iQhld9Q0S5YX1oPrcS2iNllvQIh1h1m2SuOWbOY8ILukVC62p9vuT/ql4w
 09hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=ZsDgnrJqfOPBDNqcP+eHbnrmNO8wUSqpbmQU08QeIAU=;
 b=lMfOAlg6JJlF8VRYQz0/9y8yKNSDwVAXDq9vQN5YOsde1RDAF//akf2Q6+aKh8JGUI
 5aT6K9YVCzvEi9ibwHlcGLbovE9z3roBmWs3G3fzRDlpFlI12+wTv17p8MQ4jMUcg35y
 +alKAuYGgLcX88oWIgYW/T3KK2kX1Cnd6ucmhUERdWc84DQEcP+0Mf8Qsumkl5SDmrBR
 ULq/fCnYJifhLjA9t37lp+l3ofCBb5j487W38ruRlQAr2nN3gGBFOOa6IHoQ6l4Qogbs
 WCFQ6p7BbHbnXIG17F6+uB1CZZG9d6GATRUzlMGHndtZ+quUVgs5LmMACPY6gz8Qrrt4
 eIQA==
X-Gm-Message-State: AOAM5323KQklnRKsoanQJgMMa7IY8sWnTvVcQ5INZTw9n08+S+FQJK82
 r5mdgE5IC3Gpg3hog89LDj+BMq3kOrc=
X-Google-Smtp-Source: ABdhPJwYXr8tfwrgGAQ7CUyfNFIP7Tz8m6n5wUr1L8j3bgqtmQ2X9LyUUhVsPuSIHkzmAcQihyeswA==
X-Received: by 2002:a5d:5146:: with SMTP id u6mr14141176wrt.255.1601834686239; 
 Sun, 04 Oct 2020 11:04:46 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/21] contrib/gitdm: Add more companies entries
Date: Sun,  4 Oct 2020 20:04:22 +0200
Message-Id: <20201004180443.2035359-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

List companies when there is either
- a lot of contributors
- a lot of contributions

Each patch has review instructions embedded.

Philippe Mathieu-Daudé (21):
  contrib/gitdm: Add Alibaba to the domain map
  contrib/gitdm: Add Amazon to the domain map
  contrib/gitdm: Add Baidu to the domain map
  contrib/gitdm: Add ByteDance to the domain map
  contrib/gitdm: Add Daynix to the domain map
  contrib/gitdm: Add Google to the domain map
  contrib/gitdm: Add more contributors to IBM group
  contrib/gitdm: Add Mentor Graphics to the domain map
  contrib/gitdm: Add Nutanix to the domain map
  contrib/gitdm: Add Nuvia to the domain map
  contrib/gitdm: Add Yuval Shaia to Oracle group
  contrib/gitdm: Add Qualcomm to the domain map
  contrib/gitdm: Add more entries to the Red Hat domain
  contrib/gitdm: Add Samsung to the domain map
  contrib/gitdm: Add Renesas to the domain map
  contrib/gitdm: Add SUSE to the domain map
  contrib/gitdm: Simplify the Wavecomp domain group
  contrib/gitdm: Add Wind River to the domain map
  contrib/gitdm: Add Yadro to the domain map
  contrib/gitdm: Add Yandex to the domain map
  contrib/gitdm: Add ZTE to the domain map

 contrib/gitdm/domain-map          | 20 +++++++++++++++++++-
 contrib/gitdm/group-map-ibm       |  4 ++++
 contrib/gitdm/group-map-nutanix   |  2 ++
 contrib/gitdm/group-map-oracle    |  1 +
 contrib/gitdm/group-map-redhat    |  2 ++
 contrib/gitdm/group-map-renesas   |  3 +++
 contrib/gitdm/group-map-wavecomp  |  6 ------
 contrib/gitdm/group-map-windriver |  1 +
 gitdm.config                      |  4 ++++
 9 files changed, 36 insertions(+), 7 deletions(-)
 create mode 100644 contrib/gitdm/group-map-nutanix
 create mode 100644 contrib/gitdm/group-map-oracle
 create mode 100644 contrib/gitdm/group-map-renesas
 create mode 100644 contrib/gitdm/group-map-windriver

-- 
2.26.2


