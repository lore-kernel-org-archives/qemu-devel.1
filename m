Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DE5CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B9E2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqwoD2Kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B9E2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQEA8-0001IQ-MQ
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 13:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iQE9L-0000kQ-1L
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iQE9J-0002fN-NO
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:22:18 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731]:40784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iQE9J-0002eO-J9
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 13:22:17 -0400
Received: by mail-qk1-x731.google.com with SMTP id y81so7800129qkb.7
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=DmZMafdUYDDKbYHY707LzRAyyw3AgWEynvM0mDyNavk=;
 b=fqwoD2Kr3WYsiq0KKEwoIZDkmuopZ6Q7Tyj2MXqXZ+dPFVloxKkqDwen9mjO0/7Z2u
 Hn9q4chBRMJjuBgKz0VYWHPmTSACFHnbjkBSxZwUT5s82B/P7/Xo5IlS7bI1g+Im+ITq
 bF7W/nKXjiykoVozOFWAfvktOrcaQH3WJAs13KyJJGQuzd+u62mHp++yXLAsCBTWo/+j
 i0PrL3gLc6gtl0wS4YqTOh2Htt2tWmyZ407ik/sd/PFwbLr40NoehTauxQ65YTkLjiAs
 BasAY3YV+ltWET+QD2h6vhPeTgsrlUQ8vk2ue9CBt2hAyYMTH4TJyQiKnb2NpXWhgkN3
 TMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=DmZMafdUYDDKbYHY707LzRAyyw3AgWEynvM0mDyNavk=;
 b=NXCZvklumwnzV1HKW+AZtdV8zGFTO26y5OhokfmmaC4Z0v775k2QhUCuYUQnQRkzHF
 pyjX6yKX3ErWYSirrsl7bVtgn0cCUWitX27yA3e94xMSFAQp8/Pa9hrsaLA7Wtxyj0XO
 M/fc6HS86tph3fNOOF8GgVIDBn+5bbXTqFQeSkKCtYsbWTQbtQcxNNH+L2vLVpYEEIcx
 Z5hn/uJawKaASvhMPzo6/b6BWckKBceqWDWcWUQEr/4Cz+uwpMGsr5DPvRBVIaxhj118
 oYk+tVF/Mh+FQTyPelod2txH1U+nI1W8/426vnibtvR3ZUK9GjYl4pkVLN56Oz3sgKVY
 N72A==
X-Gm-Message-State: APjAAAVfzRtL6g2OMgu3904YNEF0j2stj0fvpzAINU+vmbuML6Bpa9V4
 RVkdGiGzty8OWUd6ErSEVpZlKSFY1WCA6nfKaZMf1yCwmUA=
X-Google-Smtp-Source: APXvYqxS/lWIyDt5iUvt/RgNwlUA34KDXCVmT3wA9OoX570AzfQFljusYj74sShZgj1gMoFIEeB6arFWNh5hX9CPYvs=
X-Received: by 2002:a37:bc3:: with SMTP id 186mr1794452qkl.196.1572542536433; 
 Thu, 31 Oct 2019 10:22:16 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 31 Oct 2019 18:22:05 +0100
Message-ID: <CAJSP0QXZNK_uZzC69oGSMiYeFwpv2Pj9O3VjajgJRVhYgOXUQg@mail.gmail.com>
Subject: [KVM Forum] Upstreaming device fuzzing discussion Fri 1 Nov 2019
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::731
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
Cc: "Oleinik, Alexander" <alxndr@bu.edu>, dstepanov.src@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
Following Dima's presentation on virtio device fuzzing[1] and
Alexander's "[PATCH v4 00/20] Add virtual device fuzzing support"[2]
series on the mailing list, it's time discuss the roadmap for QEMU
device fuzzing in qemu.git.

We will meet at 13:45 CET on Fri 1st of November in the Forum 1/2/3
Foyer with a video conference connection for anyone not attending KVM
Forum (https://bluejeans.com/6063766077).

Anyone who currently has a private device fuzzing setup and is
interested in seeing fuzzing infrastructure upstream in QEMU is
welcome to participate.  This session is not (primarily) about how to
fuzz specific devices, so it won't be relevant if you want to start
device fuzzing and do not have prior experience.

Stefan

[1] https://static.sched.com/hosted_files/kvmforum2019/76/kvmforum2019_virtio_device_fuzzing.pdf).
[2] https://patchew.org/QEMU/20191030144926.11873-1-alxndr@bu.edu/

