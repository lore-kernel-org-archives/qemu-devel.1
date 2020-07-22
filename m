Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642B5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D99720771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3Vo3r+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D99720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCrJ-0001Ak-F1
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqb-00009D-KJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyCqa-0007xq-6a
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595417019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DBjlYjSFiEJM2oaRsAbeXI5IoQj4fIzTs///4XKTJOU=;
 b=f3Vo3r+nS/1tCbKECJQJyWtzvnhSuC4dCzYhsKd4zNR7jgDpr4xe51QW/BjUAIiQYu3z/R
 lLGSL7cJ/OA74QrPGd6xgbP4ReJYFr/ykDUBuzf+SF/ulp3Xr9IvFXOmi1fyB3H1/L4Vut
 28I1teQgaieeisi8YpmYPjBKixntNCg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-ZtLxmab6M0GEPZiRyAQrJQ-1; Wed, 22 Jul 2020 07:23:37 -0400
X-MC-Unique: ZtLxmab6M0GEPZiRyAQrJQ-1
Received: by mail-ed1-f71.google.com with SMTP id z12so655801edk.4
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DBjlYjSFiEJM2oaRsAbeXI5IoQj4fIzTs///4XKTJOU=;
 b=aVPtj3Pfm5Gb7eY4XHn2Y2Pz+olilBMZt5P3sSfsSpZpkiMwx2o78tB739IGVTsTZ5
 hLMZr2UgxXjuberTv/kkU5L5BfQNdsz6BFCFpvg1Advb+J665tLxcV9tQcAsw41QI0sT
 /jEHGykUDF/WkP5Ar5LgCpfxMdR/CR+5teawNzl1k4rvEI5ZP2OJaKwkXfy0jq00qtfz
 cQvy9Xku/JrxER6WDIP/AQd13yI54kPXv3NN7B/UYiuc/k07ZmhJQW+fXd4o0pBl340F
 aUbPkVj8yAU2SiUOpBwtvT5Rnhvrf8S6fh2pIrO+fWbyxfWvse5psj5s3l++ZaQWmtSo
 z/VQ==
X-Gm-Message-State: AOAM530n+Nqx8VW1GznvzL6eogVcIlnpy7B4jWfNX0NhHe7QSN6acf8K
 upbA63/NnqAoX3U5soFqSTQsAvg4f7jYAhFkf8AkAx37ViDDJEhxKbWSWmCtnFzfKi7TsyNtCwu
 hSVI99/g3D5QzWpQ=
X-Received: by 2002:a17:906:a289:: with SMTP id
 i9mr586323ejz.275.1595417015417; 
 Wed, 22 Jul 2020 04:23:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3654g0V6W6GRz87NcZLuAsp0nEgTd9+/+COkhLAUOPu33k1CA9oaXAe/KLiQGRRo3hbH7hw==
X-Received: by 2002:a17:906:a289:: with SMTP id
 i9mr586310ejz.275.1595417015194; 
 Wed, 22 Jul 2020 04:23:35 -0700 (PDT)
Received: from x1w.redhat.com (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 23sm19591366edw.63.2020.07.22.04.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:23:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 0/2] tpm: Improve error reporting
Date: Wed, 22 Jul 2020 13:23:31 +0200
Message-Id: <20200722112333.29966-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Improve error reporting by listing TPM backends.

Philippe Mathieu-Daudé (2):
  tpm: Display when no backend is available
  tpm: List the available TPM backends

 tpm.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

-- 
2.21.3


