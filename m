Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC75C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 03:17:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564E32070B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 03:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/UZXLyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564E32070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0cae-0005To-JE
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 23:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k0cZs-00053D-MC
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 23:16:24 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131]:44379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1k0cZq-0000MG-W1
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 23:16:24 -0400
Received: by mail-il1-x131.google.com with SMTP id j9so14759155ilc.11
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=QqniZKUuq04p1WPvSiHPZRNdg1Ocem8RYv/84DTWMVs=;
 b=a/UZXLySrvVPgYzWYI6roPIh0sRybSjj/yLNKbXS+GMcksnKnQI9ULgRQeGF6hAG35
 N0gpQ2bm6UYF+6V0M3FAyjfFWwEkWiWV4+f3fnKhuQUPlLiU0MrcsqZYoQpj/clvLsgv
 eg9ywv3q6ff0IXJ996CwJEqVNop2ox0rVGp7btqTBToEYMvdUrN3iVXHwoJR9BIgJAND
 1EQ4YwLUZ4ctCvwN1xFk4Aw/vHQdztZDtKvGvdqBHpJDMo5qnC4Dmw5MofcPGNO02emq
 iiQodZn3v45wr+QlbEWicZyGNrhxUf6ppmnfe4ChddpXF9V/Ktq6p9hlrrKVtvtb8mgM
 xwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=QqniZKUuq04p1WPvSiHPZRNdg1Ocem8RYv/84DTWMVs=;
 b=gvjM7HyYw+jGHAkF8CoWl/P2wd0LxvMRt5yf1uSrQzY/QVzRSgdgkN0AASJZLQN78U
 BeSGpc8E1tYrM5XFbfwdRlBItPTQx1VYtpGbSS3pCZct6PWKxcN6f9zg+GPHULWdordB
 gedyYlKk/yf1MMVCLrzRt03mwnLAa+bW986Hzs1psVLwI3LmhC0g/bs2Vk+88NUlcGsZ
 86s50omV+F8XrrAFKR0YTip6pjcM4dnujcaZ/88yT/biTBGDujh3P3umpoyXCLtdfzty
 PkqLZuJyEPGJGnxDIKOtoIVd5bryfa/tgt2na2qZib5V6pNwObj8P/8qTj6M5soC8aNl
 yb6w==
X-Gm-Message-State: AOAM533v6RdXbRKsjw0oJH3DFBcdCKM61b5e6vH6i0VqLRgvC3oa1wto
 RH2TPIFqQVuFGf23LmJA5ELjjh3ZKZWraqfLloA=
X-Google-Smtp-Source: ABdhPJz3KPfLa6El3Sn8M8XUARvLlX4yLPrItYw0Go19bmTbBFl/oCqhIHoURjS2ibSvYHDytdssg/83W0yJOkoT+Lg=
X-Received: by 2002:a92:4101:: with SMTP id o1mr32056184ila.53.1595992581576; 
 Tue, 28 Jul 2020 20:16:21 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Tue, 28 Jul 2020 21:16:10 -0600
Message-ID: <CAFubqFvm=k0FyELUd=rYK7CO=Dxns-jVxy4UGqfGfXPFNT1cFw@mail.gmail.com>
Subject: Adding VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS to 5.1 release notes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x131.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi mst,

Looking at the current changelog
https://wiki.qemu.org/ChangeLog/5.1#virtio, I don't see any mention of
the VHOST_USER_PROTOCOL_F_CONFIG_MEM_SLOTS protocol feature. It is a
user visible change so shouldn't we add a note?

Thanks,
Raphael

