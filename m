Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1E0ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02D720872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 17:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=astrobotic-com.20150623.gappssmtp.com header.i=@astrobotic-com.20150623.gappssmtp.com header.b="JrCkP9M/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=astrobotic.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQH6-0007LC-1U
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 13:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKQ5e-00089U-Ui
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:54:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joshua.shaffer@astrobotic.com>) id 1iKQ5d-0003I6-PE
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:54:30 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134]:40079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joshua.shaffer@astrobotic.com>)
 id 1iKQ5d-0003HV-IS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:54:29 -0400
Received: by mail-lf1-x134.google.com with SMTP id d17so15059275lfa.7
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=astrobotic-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=44V4fTBtc0WHXNOJMfTffFiCa4MbGhN++/zxpOzYOdc=;
 b=JrCkP9M/E/S3NGb1GZG/+kvajU2joofj7xo8zvRaWDVb9zAQuOooc2vIduhwHTBsWF
 93KlI8U4qNdz/JlPno+xoCBvCTXWUPRfuY0QDjhOxSGefNfpz8gtZgXW2QgagKvj36nw
 YAbkzYy4XggKrwCuCKdp40dZnMrhY5icZhbQrJbCYBII/OPyK39mFjvuZmkTX4DvJgnk
 /1oNbHNp7Dwg2NjzIxRjHImiyx6xdvvM00QNARybUU+uDT9USyNEOv9lVArCgxGW/ara
 f4BRN26RnJLU+xofVQzRx9Y+y7yxSCkVa0+JxcBiHk6GCVFSkztt6ueN5KT/zSJYwq1a
 BNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=44V4fTBtc0WHXNOJMfTffFiCa4MbGhN++/zxpOzYOdc=;
 b=CP3Y3PfLrtHcmWX+Z8HtQY2D/1yFa7jeHPGFs7UGp9XkW5ocD+Gtm0gJfO0FepAV2f
 A2XyGp7j4xMMEn9T90+KfYUpo6TzD31+ek0PnOo0nU8J8fzocM2U5fDu+8a9FOoZWKyA
 PUdrlzvF/6hmoSNyKWCT/qwBbV3tkBmz6A346TzUHu+YKGWFpr4NBGZm02OYdTq7eUPJ
 KieDB/85msCEpKOyCBvWxNTEIwVCn7ssaRdREWnkEfloDQAZWF+3EojFy5yqZPTjAoA7
 l689mGjgAWYvkw616nolRxlXgA8vf5DVove4x5EDGaIuBXxj1sV2VK/G+cu9045q9BA9
 Ng2Q==
X-Gm-Message-State: APjAAAW6JB9ZkQDSyDO1Bjvh0JtpKvMPEPQpc7H5fuKFy5xhW3UliYjr
 +bQSv30BcscTFdaMduGYB6ngILW8vqtEWdulJM0Wng+oEFUDySfkqaayTl3T82kSmerYjSME5X0
 +ijgVBvS9vhqHv2pbr8cEfnxPDwk=
X-Google-Smtp-Source: APXvYqykU3EtXXYgBzWzakZ6XbDyskelDeIy3shnf2rgTcNf4/OCkKJXb7xNMsn1vu74Xl/jyEMyi1RlTQDKQN2Ol/8=
X-Received: by 2002:ac2:410e:: with SMTP id b14mr21023166lfi.110.1571158468204; 
 Tue, 15 Oct 2019 09:54:28 -0700 (PDT)
MIME-Version: 1.0
From: Joshua Shaffer <joshua.shaffer@astrobotic.com>
Date: Tue, 15 Oct 2019 12:54:17 -0400
Message-ID: <CAPJW7GLchXnRs8+n0o5A3yOk4crjvYU0Fruq1enPgRqFATwnig@mail.gmail.com>
Subject: LEON3 networking
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::134
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I've been using the LEON3 port of qemu, and am wondering if anyone has
touched the networking setup for such since the thread here:
https://lists.rtems.org/pipermail/users/2014-September/028224.html

-- 
Notice: This message is intended solely for use of the individual or entity 
to which it is addressed and may contain information that is proprietary, 
privileged, company confidential and/or exempt from disclosure under 
applicable law. If the reader is not the intended recipient or agent 
responsible for delivering the message to the intended recipient, you are 
hereby notified that any dissemination, distribution or copying of this 
communication is strictly prohibited. This communication may also contain 
data subject to the International Traffic in Arms Regulations or U.S. 
Export Administration Regulations and cannot be disseminated, distributed 
or copied to foreign nationals, residing in the U.S. or abroad, without the 
prior approval of the U.S. Department of State or appropriate export 
licensing authority. If you have received this communication in error, 
please notify the sender by reply e-mail or collect telephone call and 
delete or destroy all copies of this email message, any physical copies 
made of this e-mail message and/or any file attachment(s).

