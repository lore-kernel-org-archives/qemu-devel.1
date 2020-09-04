Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8772C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960CB20709
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjtMpxAC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960CB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECE5-0005FY-PP
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCt-0003wo-Ha; Fri, 04 Sep 2020 09:56:47 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:37278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kECCr-000864-Dz; Fri, 04 Sep 2020 09:56:47 -0400
Received: by mail-qk1-x743.google.com with SMTP id b14so6342341qkn.4;
 Fri, 04 Sep 2020 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yi+LLTvZLTYhkLXYoac4zs7LGeqF4jWw0nh9W7z/ees=;
 b=NjtMpxACJwmjL57goL05h9YEv0B8F7NuKSrmSRKgxZvCcvyTDKw2V1+OUpyggFcJ22
 oTYBNc+K8wVQHSYXwPhRIhPmq38aCXBbjGbjbWOVAPXREb3aqqAu6Z9BZvqNORPvsYn8
 D95NF1CUqbSDwlnlhN7cbrn+vCkW0S3czRQlN6hQipbc8AkatXSekUYrpF1NzEX4SV/p
 2P3q8JZLKeNDRWwgnMby6+mkSrxU1YWSDaMmkAUZrws4qOE2JvVYEFev7kb3yTF/SsQb
 GBcI0/+K//0XMe4noqsMwPSKMiKHpQmlPnzeLD1tRgS8IfYY0+rsFrcQauw5HTmeQVWS
 sqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yi+LLTvZLTYhkLXYoac4zs7LGeqF4jWw0nh9W7z/ees=;
 b=YFojjulItpVCOppVLc2WfNijQzYyemyExupCT/COY37N4aBoHV7jzvgXOTt+QPK8KJ
 vxTbAZYd4eyd7VJhTxq0icrkBVrSMIKjACoM0X0TPtZ81NDL+YeTejXwpy+GI+nhXqCX
 mcOnNHBTGvMtzb6QlBsqxbh3ebncyGdXHuRG073UEzHiqcvYOSeb0HOJjuSadmTfX5lA
 BHzn7GDufT6zJ/H+UpxE1vBnmx0JFOR39OdMILwgjAhE2WCAF2OTCoc7An3MT3Y3UfBK
 VXJkQ2wI73pb/l8Jk7ogMFA2raX9SWVKy2Vjemvg4swRyU54tWuY8ASlPvsNzrz0/2it
 fZHA==
X-Gm-Message-State: AOAM53051XLOCqSMau2Oq5Bso1mmYBTaGSaFAFOMyfQIY+MKGrIG2MGI
 9R9mkmRITr5TRVO2Kf0SwphFZ0rGnJA=
X-Google-Smtp-Source: ABdhPJyDDgOSFpR8FXMObDCZRPCc6pCpO5DxiXrDWcsJk1b2SZwtzukNi8L3aVsrFsyZ9FObY967/A==
X-Received: by 2002:a05:620a:159b:: with SMTP id
 d27mr8146745qkk.28.1599227803450; 
 Fri, 04 Sep 2020 06:56:43 -0700 (PDT)
Received: from rekt.ibmuc.com ([2804:431:c7c6:1dc:ffbd:d3fb:97ff:aaca])
 by smtp.gmail.com with ESMTPSA id y30sm4682993qth.7.2020.09.04.06.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 06:56:42 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/3] pseries NUMA distance rework
Date: Fri,  4 Sep 2020 10:56:28 -0300
Message-Id: <20200904135631.605094-1-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::743;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x743.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 groug@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

changes from v4:
- patch 01 - no changes from v4
- patch 02:
    * fixed the size in memcpy
    * created a new macro to store the size of the vcpu
associativity array, VCPU_ASSOC_SIZE
    * simplified the logic using the new macro, dropping
the size argument from the helper
- patch 03:
    * added a comment in the loop where R4-R9 is set

The code turned out way cleaner after adding the the macro
Greg suggested. Patches were rebased on top of David's
ppc-for-5.2. 

Also, something that I forgot to mention: this series has
been tested with a guest with 4 NVlink GPUs and hotplug
memory enabled, and I'm comparing the FDTs created with
and without the series using dumpdtb and doing lsprop
manually. The idea is that, after all this code, we're still
in the same place as far as the guest can see. Guest
visible changes will be coming up after this.

Daniel Henrique Barboza (3):
  spapr: move h_home_node_associativity to spapr_numa.c
  spapr_numa: create a vcpu associativity helper
  spapr_numa: use spapr_numa_get_vcpu_assoc() in home_node hcall

 hw/ppc/spapr_hcall.c   |  40 ----------------
 hw/ppc/spapr_numa.c    | 103 +++++++++++++++++++++++++++++++++++------
 include/hw/ppc/spapr.h |   7 ++-
 3 files changed, 96 insertions(+), 54 deletions(-)

-- 
2.26.2


