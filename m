Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62034C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:05:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6C72072F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 15:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeRjSsUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6C72072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHqXs-0000wE-CS
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jHqXC-0000Wr-Ug
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:04:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jHqXA-0006xh-Ok
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:04:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jHqXA-0006v2-Eb
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 11:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585321471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tqFnNqmh/cLwhrv6K9cYLlYhNKJkbHh29rYTgHO9MIY=;
 b=XeRjSsUtfV5AY+CdbrJrEEsGRfZNWL6vqoLdnL7WJprwMmqbYzPlKYu8884OgpFdpgibLF
 E0bQz91VMqJcHazrA/NC70chQuIk90JanruAk4NSocfriKTOAnplhE1IGu+alcjQWCNAd/
 E5LgDbnU6SnhYEXoUStaxXDweTejQ0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-wqHyMb7tOLWhQeZln2_JLg-1; Fri, 27 Mar 2020 11:04:29 -0400
X-MC-Unique: wqHyMb7tOLWhQeZln2_JLg-1
Received: by mail-wr1-f71.google.com with SMTP id l17so4693252wro.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 08:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=ybA34o+Jc6eyHXL88GPXd4Mm+9SU6BExVshPxk1hmUk=;
 b=l7eYfnt9hWV6FjRk8l+9ytUd7t7zwIUvPNbSCOWRZo/DOFYr9yIDpOqs1f9krgTcDf
 qG6lEGBsXXW0IZWz/Byd261nVoNyc2QQf7vy0lsWP8wGfIJzVTF1nsT6jbNl03twWOPo
 f3yDUBp84qhGmpvqBBq8x5tYOjSIOUnPQgA62cCW1u4YOOwDGBUUXQOuGJmEZ4MYNiy0
 PuX+AnOWaq7eG+Ws4Wnt1rXavAQ8JS+bQnJcDcLxBxH3LWo5S8Z5H92aq1/cbJyYuV8C
 2TvIwYVOGXmWtoW3+CjKnuYDbbs6pTCS/HQvyrARiiyrQk9UKrlsXx82qw6YZqzpEq6R
 mWDg==
X-Gm-Message-State: ANhLgQ07EGDM2QYhjlwwLaFhYETzjU8jpo1QJHyKTfb5tXB6yWc0lBl+
 HZjnkWoxYhpQYYH7fAI76tXWfIy2B5tzSGcjEJicWZqOQq25LSQI0M3yIpJEOW2LrCvx7MHmoTc
 sKs44XaXCf7z7Org=
X-Received: by 2002:a5d:4401:: with SMTP id z1mr15259717wrq.259.1585321468677; 
 Fri, 27 Mar 2020 08:04:28 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvzUbUF0c1L+BD5BmYp5YoPbCb/VB6Ns42a+ZcLybiygF7TVYKpLIps/r1AsHRTY46kOKag+Q==
X-Received: by 2002:a5d:4401:: with SMTP id z1mr15259691wrq.259.1585321468292; 
 Fri, 27 Mar 2020 08:04:28 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id z129sm8508214wmb.7.2020.03.27.08.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2020 08:04:27 -0700 (PDT)
Date: Fri, 27 Mar 2020 11:04:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>
Subject: Question on dirty sync before kvm memslot removal
Message-ID: <20200327150425.GJ422390@xz-x1>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Paolo & all,

I noticed something tricky in dirty logging when we want to remove a
kvm memslot: kvm_set_phys_mem() will sync dirty log before the slot is
removed to make sure dirty bits won't get lost.  IIUC that's majorly
for system resets, because that's where the path should trigger very
frequently.  The original commit does mention the system reset too.

That makes perfect sense to me, however... What if the vcpu generates
dirty bits _after_ we do KVM_GET_DIRTY_LOG but _before_ we send
KVM_SET_USER_MEMORY_REGION to remove the memslot?  If the vcpu is in
the userspace I think it's fine because BQL is needed so it won't be
able to, however the vcpus running inside KVM should not be restricted
to that.  I think those dirty bits will still get lost, but it should
be extremely hard to trigger.

I'm not sure whether I missed something above, but if I'm correct, I
think the solution should be a flag for KVM_SET_USER_MEMORY_REGION to
set the memslot as invalid (KVM_MEM_INVALID), then when removing the
memslot which has KVM_MEM_LOG_DIRTY_PAGES enabled, we should:

  - send KVM_SET_USER_MEMORY_REGION with KVM_MEM_INVALID to invalidate
    the memslot, but keep the slot and bitmap in KVM

  - send KVM_GET_DIRTY_LOG to fetch the bitmap for the slot

  - send KVM_SET_USER_MEMORY_REGION with size=3D=3D0 to remove the slot

However I don't know whether that'll worth it.

(Side question which is irrelevant to this: for kvm dirty ring we now
 need to do similar thing to flush dirty bits before removing a
 memslot, however that's even trickier because flushing dirty ring
 needs to kick all vcpu out, currently the RFC series is using
 run_on_cpu() which will release the BQL and wait for all vcpus to
 quit into userspace, however that cannot be done inside
 kvm_set_phys_mem because it needs the BQL.  I'm still thinking about
 a good way to fix this, but any idea is greatly welcomed :)

Thanks,

--=20
Peter Xu


