Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB83AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B9420771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4Pus7zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B9420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxsBk-0001hv-Lq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 09:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsB0-0000gJ-JQ
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45849
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jxsAx-0002YF-Ao
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 09:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595337557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HRNs1Eh71NYqle+QW+ORf61+4+aVAHB0LYnICG4zTOU=;
 b=c4Pus7zBeFv03v1bNR8o/YvlkWhYJTC+MYLDgzenm5r/1iURxe3jJmDdWy27oL8n5X3YtQ
 JWHTcfongLIAqy4cJ6VJQU79xTt0dStJLRfYDD1uL5x83ndlNBCO/j5YVctpFPdIn/HVMb
 I47fke2oh4FRhJwopflTXv+ouxHli3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-M6gx46ckNbKCFq4D7EGBDg-1; Tue, 21 Jul 2020 09:19:16 -0400
X-MC-Unique: M6gx46ckNbKCFq4D7EGBDg-1
Received: by mail-wm1-f72.google.com with SMTP id t63so1234109wmf.6
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 06:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HRNs1Eh71NYqle+QW+ORf61+4+aVAHB0LYnICG4zTOU=;
 b=Lv7eadOO6S6Aeg6UjbflvKunlkMdruP2YH76DLTs7N7Cs60INDePCyrlwrItRHDgCm
 BchLmvOFSevdYK2KBWSQVvqqPh/7mP3TUejGuhhsvBP2EC8Lgi+y9JDvBMcasdImQE0+
 EiKVwX5lbQYkjWQbXjUrAUp5dg7oMrWxgB/qA6idfP6QHyxkn0GbGP5M7fh4ZfjRv6vO
 5S2VMejEAN8onJJHjKGAeSLn7faqNgJANY3P2sLl498dYzfWFOG+76dKZv5pg+fyo+oU
 wkDM5QrhK9Yhk/VkEfMTy963MJrGhj59KHHhAmoDBCQaMvrtZysIyoQ3v+TbYq1SDG+0
 zXeg==
X-Gm-Message-State: AOAM530dew28XHfU7llMCrzRcyZmRU743EzVqkEMl+e11ULW3U7AE0ZH
 uI0VBdzrqNNxVVCdE7R8oVTSBVu8r4GW6KEZpw+pCDBGD5ZRaCMElk3LJyIoObX7j4TUQAcDetU
 qPkA4g5LAzwKlv24=
X-Received: by 2002:a5d:5651:: with SMTP id j17mr25359084wrw.145.1595337554545; 
 Tue, 21 Jul 2020 06:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH0wOYb3i2LiqGd5+6DjFnnsmzHN6hem8uhGt8HY3dVcI9eo3lY+fTNOKs1l+qHofkzhXFmQ==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr25359065wrw.145.1595337554348; 
 Tue, 21 Jul 2020 06:19:14 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id l132sm3447765wmf.6.2020.07.21.06.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2020 06:19:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] hw/nvram/fw_cfg: Let fw_cfg_add_from_generator()
 return boolean value
Date: Tue, 21 Jul 2020 15:19:09 +0200
Message-Id: <20200721131911.27380-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 03:39:19
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
Cc: Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since v1:
- Addressed Markus review comments
- Added patch to clarify fw_cfg_add_from_generator (Markus)

Philippe Mathieu-Daudé (2):
  hw/nvram/fw_cfg: Simplify fw_cfg_add_from_generator() error
    propagation
  hw/nvram/fw_cfg: Let fw_cfg_add_from_generator() return boolean value

 include/hw/nvram/fw_cfg.h |  8 ++++++--
 hw/nvram/fw_cfg.c         | 13 +++++++------
 softmmu/vl.c              |  6 +-----
 3 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.21.3


