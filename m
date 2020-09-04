Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BB0C28E83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E05206C9
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 08:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="04noX4vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E05206C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE72t-0003Ba-AS
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 04:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kE727-0002JL-Ad
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:19 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:45048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kE723-00040v-AZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 04:25:18 -0400
Received: by mail-pg1-x534.google.com with SMTP id 7so3945152pgm.11
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=QGwLk9vEmgl3YoDW8qnNwPyQqpLpwmDofsveguiqT2I=;
 b=04noX4vnVYLHAuT833Hc+OYnouj17sZwLF1sCJB7reSnAn3OIgcCd3L1GStuWgqF+0
 XF3+ASge6ivLRzI2oK+S3agfbToKFnMyeP9K4olMw6lnKiLsNUcN5cxFyfwn5wCX70xa
 9c4/IBxvTca6UFUAtJn/qLx5ZhNoeqi8ycCjVbKik/ZI7o0uSw9BFKzDqsQompcPftdN
 UdzijX4n3XShMR5NBwXRkBk4N86bot5mGpUOaLi6BtQGPJ3zb+/2Cu5BltWqyEXkD1wn
 QusStoclo29/Cl97vbrAK2VFuMRjNTLD0dM+RRl0gTT25/ZT6EBKZyFC7BMnR9fxGbDa
 1aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=QGwLk9vEmgl3YoDW8qnNwPyQqpLpwmDofsveguiqT2I=;
 b=Ctwh+CoF5Qark/15DO5KPn28TxZiTAIliFtKUgoh+eCroGEXHFImIrbBrXymaLqzhS
 ryDNIYX5yRkUYBBlcM6SOwY76EUNBYRkHmMdN6+AI1nECJe9wAv03JJDCc0cc7A29a1p
 qcs4MbYHj1pFJetipnc3tGv6XfdYw/vpnLp2C9P2W50VQ0iS2SCxNsx6R+cU9rgDH9Tm
 +NtBNl+0pmW9Q2ihgyn3YwxWNnGYCSVCY9GE6uBvTcXS0CcboYK+UWmTBZN/fSdTfkpn
 TpSVFEHN94O8Vb6ZDECdyQWQNFBMiFQGxipqyNAk54UVfpIQ1lkJTfd2dQIX1xYvM9w/
 Otxw==
X-Gm-Message-State: AOAM533914NfC+00jqOcqO0j9VPCqeEWUm3kGZ4wxb0a7U34aKzjhH+5
 EBKR3/unQMelJD9t+r9uF9d+Kp7yTNbcVA==
X-Google-Smtp-Source: ABdhPJyRnf7CZtCfixVwrkNotzkXTjcgEfyNbOuIdoZkKER3SMniiXnmExol049tFICjeII2nIwFPw==
X-Received: by 2002:a05:6a00:148b:: with SMTP id
 v11mr7602147pfu.88.1599207912497; 
 Fri, 04 Sep 2020 01:25:12 -0700 (PDT)
Received: from localhost.localdomain ([115.96.135.14])
 by smtp.googlemail.com with ESMTPSA id bj2sm4733098pjb.20.2020.09.04.01.25.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 01:25:11 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: i440fx/acpi: don't hot-unplug cold plugged bridges when their hotplug
 switch is off
Date: Fri,  4 Sep 2020 13:54:50 +0530
Message-Id: <20200904082451.1043-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x534.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have seen that when hotplug for pci bridge devices are turned off and devices are attached
behind the bridge, I still see Windows trying to hot remove the pci bridge and failing. Today
looking at the AML disassembly, I realized that we are addding slot enumeration and EJ0
methods even for the slot where the bridge is attached. 

Please see the video: https://youtu.be/pME2sjyQweo

This does not seem right. A cold-plugged bridge should not be hot removable under any
conditions. Hence, this patch tries to address this. After the change, as the demo video
shows, Windows no longer shows the bridge device as hot removable:  https://youtu.be/kbgej5B9Hgs
under the same test settings.

Requesting comments for this fix.

--Ani
 


