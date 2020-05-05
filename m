Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26694C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B28206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ac0d/FM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B28206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvRb-0004XN-0s
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jVvQy-0003tZ-V6
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:08:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jVvQy-000561-7f
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588676899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=dXQthJAAWmHN6ftbXU+DlVjTLlco4IbSJo9ORAF8vsM=;
 b=ac0d/FM68k1WloR7oLJrlCdlYBNcXHWHGxBeZS+2S05X3CrqWJIJUCfviY7bV4z29KIRr7
 qIfQMpbWgoC0tkFSObO6e1tzVjZiPen9DhwGcVub05okvR67NEW3GRriY2YqHbC8llefYL
 7P8TCFheqtW84SinAMimSJ+J6v89Hpw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-G8REHgtzNIaN5aNF5rUPcw-1; Tue, 05 May 2020 07:08:16 -0400
X-MC-Unique: G8REHgtzNIaN5aNF5rUPcw-1
Received: by mail-wr1-f72.google.com with SMTP id h12so1028187wrr.19
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 04:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version;
 bh=aHw0WHUDjplHhyM2x7z49ozQEApYFi2qNDHdSE7wkJ4=;
 b=fCX9cT0wqLuPkdsWByTwt5p/7ylS9/p9omT/d7s+Mfka0tsDpK5vwNiHh8vdgFSm+k
 GkDeqthBSqbJN+cEMGujDw+sXeCH0+fgYC+OSwEZLgdajbY12OpK6fsQZblDuDJ3s07t
 u0iUXjKdpsNB2ODx58c18G1g0MEzsqU45RQnnU9rxJjcwstYkq0h1yUdft+gNkEVmpXA
 lf3HsvRMh+Ju2q6n5b3ag+j4ZzSws7BoXhPMJmwaoo0gf0FUC1r55ct3UUNSB7UtlrPt
 CjZ5k21RWA5VPbU+32W5aBLKL3R9VcKtVkPtJdf3fkLmu2x6PrCdggPu/loyN7zwaQav
 Gf6A==
X-Gm-Message-State: AGi0PubbdsvjqXvmYuATkc/2H8+ScfQSBYKDt4PgxSVAgUNwTE+wecL0
 ojTPT1jOiX+cX5ZVsrgYgrYYnFuff9hg/adBtP5AvBG/4dciPCGi614eIViDySiAsX+/bn5BI9g
 GyjAbtu+CBW6owYk=
X-Received: by 2002:adf:fccd:: with SMTP id f13mr3271418wrs.386.1588676895862; 
 Tue, 05 May 2020 04:08:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypK5GxCqI4HICd7sSuy32iCCsa9f245KrM4v4vS5liHVKpaaBkd4+1n5GD7WxOvbEcbkkddRCg==
X-Received: by 2002:adf:fccd:: with SMTP id f13mr3271359wrs.386.1588676895342; 
 Tue, 05 May 2020 04:08:15 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id z22sm3204539wma.20.2020.05.05.04.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 04:08:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: KVM call for agenda for 2020-05-19
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 05 May 2020 13:08:13 +0200
Message-ID: <87o8r24p2a.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

  https://www.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a=
3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ

(Let me know if you have any problems with the calendar entry.  I just
gave up about getting right at the same time CEST, CET, EDT and DST).

If you need phone number details,  contact me privately

Thanks, Juan.


