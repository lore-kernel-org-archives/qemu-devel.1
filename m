Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E23C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:17:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868F6206C9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2HiPRYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 868F6206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO38S-000102-Ll
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO2p4-0008Ba-JW
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kO2p2-0008Gb-US
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601575010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIvUOwW3qme1A3loFSMi1+8exHY8qAY72cgyMrRkcO8=;
 b=P2HiPRYJmwrv9E9VoX2pUOAoB5FTH0KxppVoh+B0RcWiZK4awCu8ieD/GTJB6FdbqetyMA
 we0ektznDV4X4ks4awYm78r4999ijCyEGqsNnshrFik6KRngkI78YiO4IcTwGC/iwB/1my
 O9M7je6OnoXv/Yiwe3m1TjIxOEbHZKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-Aw7a2JZWPxyuG8SsH8cRWQ-1; Thu, 01 Oct 2020 13:56:45 -0400
X-MC-Unique: Aw7a2JZWPxyuG8SsH8cRWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8312E801AB1;
 Thu,  1 Oct 2020 17:56:44 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4041655770;
 Thu,  1 Oct 2020 17:56:44 +0000 (UTC)
Date: Thu, 1 Oct 2020 13:56:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] hw/core/cpu: Add missing 'exec/cpu-common.h' include
Message-ID: <20201001175642.GH3717385@habkost.net>
References: <20200908123433.105706-1-philmd@redhat.com>
 <ff99f676-2e6d-2f23-5a09-96cc77fb8469@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ff99f676-2e6d-2f23-5a09-96cc77fb8469@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 01, 2020 at 07:44:57PM +0200, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 9/8/20 2:34 PM, Philippe Mathieu-Daudé wrote:
> > cpu_common_reset() uses tcg_flush_softmmu_tlb() which is
> > declared in "exec/cpu-common.h". Add the missing header
> > to avoid when refactoring other headers:
> > 
> >   hw/core/cpu.c: In function ‘cpu_common_reset’:
> >   hw/core/cpu.c:273:9: error: implicit declaration of function ‘tcg_flush_softmmu_tlb’ [-Werror=implicit-function-declaration]
> >     273 |         tcg_flush_softmmu_tlb(cpu);
> >         |         ^~~~~~~~~~~~~~~~~~~~~
> > 
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Qeueued, thanks!

-- 
Eduardo


