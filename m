Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C4CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E83205C9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 23:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E83205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNQPn-0001Iv-5A
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 19:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iNQOr-0000hT-MU
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iNQOp-0002O5-3t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:50:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iNQOo-0002NR-Ud
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 19:50:43 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFC5A356CE
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 23:50:40 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id s1so16342108pgm.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 16:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zg3YBGx0r6mLSGynkhGw7i73NG27NIYxR8OjsSsMOB4=;
 b=d0yw2K6eIuSgZYJEFp9LUZdTPb8EyN938irghyQAaHA2KN/gbXktoBSkWUkBGK/I8F
 tPv/JPKzKnG0zwuGyoMbjLivEfQ8UucdkqMKRykD5iZvbgJpzt29jVKhMcHxECEPBhNS
 Tao2xlA3UQ70hB+UqrzEx1fb6oIxW8IZkCa6sFW2bgqJNzL0T+LWcSpqVhPkjsFSMjIG
 F4tgsltZG/LsKGscA57MBg2kbJZZtclC1ILFP1ZLAG9/UAR7CLBj1dyAtwv+HDWUZOli
 oIm7ZZRU9Y7CwneDunokXMUChzXeXDCIEMTBPC53grT/JnDAI6ar7a0E8O1i7TXhZulG
 MUEQ==
X-Gm-Message-State: APjAAAULEXqR/ajj69giwiqeYU+Sy7wyIJY8FMLdAvdpxFC+/ibOdDKH
 aN9Sz+nuYCwyGDRPl0jTJHtZ6EpmJQ+CrUnAVusgDZiCJvpEL+PK/XT/1LpmF5a8ZZMJTbYvbcq
 VtudQwVcRugZhJtQ=
X-Received: by 2002:a63:d50c:: with SMTP id c12mr12081698pgg.199.1571874640321; 
 Wed, 23 Oct 2019 16:50:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyEtcptlNw6cZvaxb5i6fqwStNogKW7SVICGjkLBil0FqT+CT3RnSCSXthQpBnWet8Wj5o6Lg==
X-Received: by 2002:a63:d50c:: with SMTP id c12mr12081680pgg.199.1571874640011; 
 Wed, 23 Oct 2019 16:50:40 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id e17sm28440863pfl.40.2019.10.23.16.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 16:50:39 -0700 (PDT)
Date: Thu, 24 Oct 2019 07:50:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v5] migration: Support QLIST migration
Message-ID: <20191023235028.GA18357@xz-x1>
References: <20191023150237.17324-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191023150237.17324-1-eric.auger@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 23, 2019 at 05:02:37PM +0200, Eric Auger wrote:
> Support QLIST migration using the same principle as QTAILQ:
> 94869d5c52 ("migration: migrate QTAILQ").
> 
> The VMSTATE_QLIST_V macro has the same proto as VMSTATE_QTAILQ_V.
> The change mainly resides in QLIST RAW macros: QLIST_RAW_INSERT_HEAD
> and QLIST_RAW_REVERSE.
> 
> Tests also are provided.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

