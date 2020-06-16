Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF39C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AEE0207DD
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J/OKJ+x8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEE0207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7JC-0003AW-Ck
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jl7HJ-0001eo-98
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:49:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28650
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jl7HH-0000iS-3O
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297345;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=aHw0WHUDjplHhyM2x7z49ozQEApYFi2qNDHdSE7wkJ4=;
 b=J/OKJ+x8WoN1fO7CP/VINKY4JjpkFHuvXvGJ4GsZ8TM1K6Sdou54cBSUZWmS7wVXUOyEIQ
 X/jtX8kWVIqO14lVAbKlAyiAbpTgxAoyGN+5IOQ3JCqz+VhiAS77UwRbEy/SsnL4Tpn2RW
 B7S5JdcGglzW5DnjTA3yAVTrmIBXCRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-leYQD5xCOlaWyqXbE43OiA-1; Tue, 16 Jun 2020 04:49:03 -0400
X-MC-Unique: leYQD5xCOlaWyqXbE43OiA-1
Received: by mail-wm1-f69.google.com with SMTP id 11so669823wmj.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 01:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version;
 bh=aHw0WHUDjplHhyM2x7z49ozQEApYFi2qNDHdSE7wkJ4=;
 b=aJsHit4VDQDGA/O4BwsMYNuhr0b4k/iaWDioCdBEjbNcA8MQb65BCv8m2f9y9r4KtV
 aEcBWTBpG92oacC/KFLVaP8Uk/e3BEyCCNhTGb75Sbidpr8671KSo4mmfcbdTgTFvf1o
 KM04abd3EOee+UksvST1FPQ1ZfhE16jqurwpiLFu85rqJz55F0UZDKxNGdEo3QbnCT9V
 fI9/3TNjv9dmDtQ5d48rA8OHAuRWz1mAwe278wdun8QoOCe760SZu7vkzy6Ut30ZVYvE
 p7vtXaOAfwkjxvqcNrydqZWOzUoI0Gcskb2qGw9DSH02AB5BzFAwMZqQo/GHkFE6ta8K
 /jOQ==
X-Gm-Message-State: AOAM530vhusvMLRE7L3uMIOwtMFTmvvrz1mHafEgd2xVtknvk0XtIM2M
 kQP+Q8mxeCsGqqqBETeyolZPfZYgPorz8rEZaPeTWck4VYx0HN9Z+ReX67PjIQBq3u/1Fl/K+KA
 Fiq35wrCCS91PhqI=
X-Received: by 2002:adf:e285:: with SMTP id v5mr1840473wri.129.1592297342347; 
 Tue, 16 Jun 2020 01:49:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEn7kENsYjcXnQwyyS7aWlQp3jLb1PHk7TkKGkmsPonFYcw7ViNxKhXJFLqEgygiHSMwM0ug==
X-Received: by 2002:adf:e285:: with SMTP id v5mr1840455wri.129.1592297342108; 
 Tue, 16 Jun 2020 01:49:02 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id c68sm2976259wmd.12.2020.06.16.01.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 01:49:01 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: KVM call for 2020-06-30
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 16 Jun 2020 10:49:00 +0200
Message-ID: <87d05zxuo3.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Hi

Please, send any topic that you are interested in covering.

At the end of Monday I will send an email with the agenda or the
cancellation of the call, so hurry up.

After discussions on the QEMU Summit, we are going to have always open a
KVM call where you can add topics.

 Call details:

By popular demand, a google calendar public entry with it

  https://www.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

(Let me know if you have any problems with the calendar entry.  I just
gave up about getting right at the same time CEST, CET, EDT and DST).

If you need phone number details,  contact me privately

Thanks, Juan.


