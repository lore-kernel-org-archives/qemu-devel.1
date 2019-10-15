Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC6C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4FC720854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4FC720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKK4S-0004te-QM
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKK3q-0004UW-VG
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKK3q-0000gx-1G
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:28:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKK3p-0000gk-S5
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:28:13 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 085EA44BCF
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:28:12 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id y2so11804780plk.19
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 03:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EyPHzd4U8raLFZIPAeZtCdUrehSbj3DARbdd9loQ1pQ=;
 b=L1FPFlVMlyUwRISuTAkrmc19aCjgaFYVnWwNneapmVmdffVQSbUM1699dkfiXUm0TQ
 Chf2edACLEH8ve1JfgeYNXXn3sPVftIqXFR7efR/StQuYSsFqlgAVFwmGobUJ1Es8zr5
 qYPI3gC2gCyiK2yOJUDjUQajuiywCPySz24dBfAAtduDjKpG6kKPZzsPLAY5Npze0tWd
 MROIbqm/PSukWiwJLI+SkmzYxXnZiOuawy2OFXznigcqUnP9PfpRI4ElUYVyXeeiN2a5
 6dELmfU8Bau8HqnWNOtQRBs2MrKe6noO5c8MfjCXs2XhJBpYqlrdz74vAmE89rwxi11l
 bJGw==
X-Gm-Message-State: APjAAAVLgbrY6D+KRc3St9sAzF7H8EOTapjzAMLluMKiQTDB4NGu5fju
 d26jz1bNpXwoFa7xKVylA7F682/stRyKDelmc4BIXN+BmJwRntOwXV7bUKnulBzhisEO1xgFJDt
 UeRbeKdb+0Vhj9yE=
X-Received: by 2002:a63:e802:: with SMTP id s2mr1020402pgh.188.1571135291375; 
 Tue, 15 Oct 2019 03:28:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyXekqTanccBKnOqHMEh/1Wvfh8WrDFYA3jls4cL80/FDgDYerKm2fxHTBsCoc/7AaOVibcNg==
X-Received: by 2002:a63:e802:: with SMTP id s2mr1020384pgh.188.1571135291172; 
 Tue, 15 Oct 2019 03:28:11 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b16sm28414078pfb.54.2019.10.15.03.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 03:28:10 -0700 (PDT)
Date: Tue, 15 Oct 2019 18:28:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/2] migration: Boost SaveStateEntry.instance_id to 64 bits
Message-ID: <20191015102801.GF8666@xz-x1>
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-2-peterx@redhat.com>
 <87tv8aqudq.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tv8aqudq.fsf@trasno.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 10:34:57AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It was "int" and used as 32bits fields (see save_section_header()).
> > It's unsafe already because sizeof(int) could be 2 on i386,
> 
> i386 is 32bits, so int is 32bits O:-)

Right it should be 16 bits systems.  And yes I don't think we need to
consider that! :)

-- 
Peter Xu

