Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F8C47423
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDEF420672
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 09:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBjBDnyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDEF420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOH5H-0006y2-2Y
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 05:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kOH4c-0006Tp-Ad
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1kOH4a-00076S-8q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 05:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601629790;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=LLY7W9DKJou6LoXrOLGaFqgZXvA9GsySl0Xr1TMIq1k=;
 b=MBjBDnyb63oTDQDg9KOWy2PT7xpvBipqCqwRdRBw9Qejx6Mglh4SPK5yNwlbPL+fKf/tTv
 3rkQ/WO7VEMgd0vYiBQYpT8H7k9M7zqHklzXFqkUX8/27De+Gw4uo0U60QgPgnes2rxEAS
 WocY+zblpbWz0hJuXMquCKjqcUqMrSo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-c0LMktT8M363af7p7YqshQ-1; Fri, 02 Oct 2020 05:09:48 -0400
X-MC-Unique: c0LMktT8M363af7p7YqshQ-1
Received: by mail-wm1-f72.google.com with SMTP id y83so316887wmc.8
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 02:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version;
 bh=LLY7W9DKJou6LoXrOLGaFqgZXvA9GsySl0Xr1TMIq1k=;
 b=pP4IqCL3mpKPXQ3/QjNBBNriMz1ceCqsh/fBzonhrGHLJGBJOC51EGGq0b1hdmuskH
 F4CE15+sg0Z1OcLfFgdCTSRdpqYs01wwtHXqQTxc6sWCja/aMRkLG37GvaYxgxV8Eaoo
 IrlnMQaA9Ht/yfsuzAYblmmoDuTG7orYIm4d5sEHe4VRxy61Pi+huiwZMiQ7iHrFoXw9
 Y8GDbAVXeSAr8LrXHSfE8IG2jboaQp2BBT2oqO3tt7Famo62Bhrgi81zRS/+T1TwJw57
 sH+HenR4nDlxKWoR8UuIXtSAJlX+KiIItwtHtqj4Lg1tQ+TODEq5uOBdB6FBD8uUAPwB
 lbNw==
X-Gm-Message-State: AOAM532EBTUoxd31pbNPoSlWAfzgHIwbRkxx7NL4Ndzpu3AtCYdOo4cZ
 6sFnM7vvhVnxJglCTymptyw/sqS1nDK1T1I+oquexX1tHLRAlZiFVFOiNj2k9jjOarjwTHF+3Th
 LY3joz0KA09VjGn4=
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr1675182wmm.108.1601629786847; 
 Fri, 02 Oct 2020 02:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZK9qEvHj04yc/0eHdit3b1zXLDyx0gaAVoYt2N5f88LvHJNF+gKyApwXGkzohhGbsHgANGg==
X-Received: by 2002:a05:600c:20c8:: with SMTP id
 y8mr1675155wmm.108.1601629786550; 
 Fri, 02 Oct 2020 02:09:46 -0700 (PDT)
Received: from localhost (62.117.241.112.dyn.user.ono.com. [62.117.241.112])
 by smtp.gmail.com with ESMTPSA id v9sm180778wmh.23.2020.10.02.02.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 02:09:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org, John Snow
 <jsnow@redhat.com>
Subject: KVM call for agenda for 2020-10-06
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Fri, 02 Oct 2020 11:09:44 +0200
Message-ID: <874kndm1t3.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Hi

Please, send any topic that you are interested in covering.

At the end of Monday I will send an email with the agenda or the
cancellation of the call, so hurry up.


For this call, we have agenda!!

John Snow wants to talk about his new (and excting) developments with
x-configure.  Stay tuned.


After discussions on the QEMU Summit, we are going to have always open a
KVM call where you can add topics.

 Call details:

By popular demand, a google calendar public entry with it

  https://www.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

(Let me know if you have any problems with the calendar entry.  I just
gave up about getting right at the same time CEST, CET, EDT and DST).

If you need phone number details,  contact me privately

Thanks, Juan.


