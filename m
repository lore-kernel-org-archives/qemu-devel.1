Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13CBC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE501204FD
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 14:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ejPUyBMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE501204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5rWS-0002jH-U9
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1k5rVI-0001Md-I6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:13:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20320
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1k5rVF-0001IO-O2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 10:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597241595;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=aHw0WHUDjplHhyM2x7z49ozQEApYFi2qNDHdSE7wkJ4=;
 b=ejPUyBMvOUu6yQ6VpXxEzbEE4aCxr9FAJUwFr7TKkTBoFzOZa8MNq5oTEXlED3Oku/Xf/8
 ++tFKrBIAged0CELQomN4dLk5NTm+5KfcHoApscWyRExNcC2e3DVxtzPguIvBgi8qd3eZv
 EiBJ8bKGDw58LCsc/TE1JC8ZxRfqLag=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-jmNBhL7oOja8JABpjPq0eA-1; Wed, 12 Aug 2020 10:13:13 -0400
X-MC-Unique: jmNBhL7oOja8JABpjPq0eA-1
Received: by mail-wm1-f72.google.com with SMTP id d22so937106wmd.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 07:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version;
 bh=aHw0WHUDjplHhyM2x7z49ozQEApYFi2qNDHdSE7wkJ4=;
 b=WWEOhmeUrAXJcJkn8R9guRtA/wYv2FFQ2lFd3JeGk098Mx/vNkGPQPFJ2vMutlEhin
 fG+DRnBYRWgqtdgEJnhuEGFysL/7+UQerfI1pXaPpZYXTtaTo2/tHK4qJpBY3I9XFbhn
 83o0dQVGMHWGZ9LH5EzNdPl5BXhKlJ21Q6qr9st94orNrJ5DwieZ67x40GgtZCddYQ42
 F4hyEAs1pRTi5TBAXMGu/wb/88dMaD2RsPxoffl1uYfYA/NZs4EEcCZ57GcNQEWe01tG
 Z21hPhvhLkGXQI/Ts4ldWZFhHO05+Bt71mLLTfzDBlO3vPVecWWoLTvme8W4WOl9ua5I
 7lpQ==
X-Gm-Message-State: AOAM5323bgR/F88ckSh9Y8MCTM67I5SHjAxzaYSzr7hPdC6nTxoHMoch
 IduU7rBeo+ZASaNV9M6zAMdn27y+73hf4hBiPJA1CEbaDg1BjIa+nTsQIclWdqd2FmN1vJpmdXK
 IwRfUcsxaTVLIoj8=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr33595784wrw.322.1597241591400; 
 Wed, 12 Aug 2020 07:13:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwM3Nw8PFJ56wDkk5yBDHwzNrgBoZFZKvPFgaQnLLLxkgAZ87/sAULBDo/5hzhNGKdklJ2/7A==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr33595761wrw.322.1597241591130; 
 Wed, 12 Aug 2020 07:13:11 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id i4sm4387217wrw.26.2020.08.12.07.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 07:13:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: KVM call for agenda for 2020-08-25
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 12 Aug 2020 16:13:09 +0200
Message-ID: <87v9ho7y16.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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


