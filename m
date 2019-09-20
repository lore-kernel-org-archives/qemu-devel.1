Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A192C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BCF2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdGy653M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BCF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBG3n-0007bq-6H
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2Y-0006TR-Rq
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iBG2X-0004p1-PZ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:26 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38442)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iBG2X-0004oj-Ka
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:21:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so6179652wrx.5
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=2kt1zxq82W6y6A9RMuXxe96/M7CQYy0TYMscclSRYNE=;
 b=hdGy653MfgdE0EA6J1+ItuG6Qtd0fSjxqy/uoDMhkA8nVWzT3KyyKGCz8nBZuRHSZd
 ur0nOOBmzW3AxoKl6qF1R6GRkYNxQKt8u3ium+TaDhDHtcjjfURGaq+qMdG3mPvm1xVy
 qzeFhSB6pf5OBR+s3IO/bUJGI5fURuS+boWEd3tVMu3KbgOLzvYQ/TqL5EOlrPEnWDwN
 kbknMxA2B9qX61clIUn0hsu2zo9kZPjWSzh8m1zAiZtkTDSlaXJtot90OFs5xvVY9Wa4
 vGR3IhNE3oZFVtCSkRTazda3FQfY+XCSLPHirOZpfgBdg5iYkYer2fGk3cxyAjruRhbe
 Reug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=2kt1zxq82W6y6A9RMuXxe96/M7CQYy0TYMscclSRYNE=;
 b=YhtCgaxbFTogHyXg7nGh+SvM17/MYCBxFPaOzkyUl+BdvGWkhaBb9XOlkYEFdm2FW0
 pP50d2tvkdDeK7MVuK1RNFBoobPkr72oL5nV1YkyCHEBpxVXYOz5znQbx9JM7squWO5q
 vWPO+YOzuqb2NHCeMlo3qeT9CBg/8FzpS8istUEUT0eb9pMxoOEm7tSQ5VO/fk8+Y5Kn
 yIp6g9KAQRlK2sy7hH3TlmEom1l4M3XMh1Rog2q2YKwVwAkjfTQhE22F+nOAYgUeJdkx
 DKTdS3AjdmEvAH04Ue60x6CepLxvUXS2f1eZJ7AwDObpYk/Yf6trRFtolCuTMxH4KXrK
 VZ3A==
X-Gm-Message-State: APjAAAW6Ch2M4SOcJlcgg7sNv1Y4SovBUctZZME5SvaFjUQ9UnM6iCH0
 Yf9vZdc0ubeq91/Zp3L8HqOH6pu8
X-Google-Smtp-Source: APXvYqwVy4jD78dcqjmf6gDDDTuJWTkE5kasDLc41mG+yPf2Aq/8mjcgTDVT6XYUmnEsdn0OTsRV1A==
X-Received: by 2002:adf:db06:: with SMTP id s6mr8664275wri.41.1568974884212;
 Fri, 20 Sep 2019 03:21:24 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id u10sm1331274wmm.0.2019.09.20.03.21.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 03:21:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] kvm: clear dirty bitmaps from all overlapping memslots
Date: Fri, 20 Sep 2019 12:21:20 +0200
Message-Id: <1568974882-7419-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: dgilbert@redhat.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A single ram_addr (representing a host-virtual address) could be aliased
to multiple guest physical addresses.  Since the KVM dirty page reporting
works on guest physical addresses, we need to clear all of the aliases
when a page is migrated, or there is a risk of losing writes to the
aliases that were not cleared.

Paolo

Paolo Bonzini (2):
  kvm: extract kvm_log_clear_one_slot
  kvm: clear dirty bitmaps from all overlapping memslots

 accel/kvm/kvm-all.c | 114 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 48 deletions(-)

-- 
1.8.3.1


