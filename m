Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41EAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C49422470
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR5bwBWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C49422470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwU2-0007oO-3i
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIwMX-0006rx-77
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:02:21 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:44852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kIwMU-0004Dv-MK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:02:20 -0400
Received: by mail-pl1-x62d.google.com with SMTP id j7so1348080plk.11
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=nHVFqRghFBFymH0OR9d+PHUQPv0jCtcWv1PluEHLWxc=;
 b=NR5bwBWGPIojYmeRQgg4Yz1rmNOTWcsc/Mpfyj7DeARMkO4jn4LV9xEmjwkWrSMOGp
 s6mhGS7KgOU4Me5krI+H6hTH9zlUgvSVUeox5yhjK+4M15RyRcFIaRh7Z7H41SMX0QHb
 rZzFzacJQR37kCZobjG1xeNjiw9zylvK81e7hee5iRWcxEnpavHA9tMbxV2nelfr41PH
 uSndwkfh/W//q8Lx20OML61eNgZx0w0vt7P7wrlqY3awZ5O0xpk96tkJrn/CEGATVYQs
 URjzzWaYxMJQoBf1MWO+HnqBXqU9V/YtnBylBclm+EogTfOdVoaQJ47Jo6dbaZnXsgDg
 34Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=nHVFqRghFBFymH0OR9d+PHUQPv0jCtcWv1PluEHLWxc=;
 b=X0nTTZKEEHrflfG6zqEYtF+s7oIG1cY43MI+b8f80lE9CsRNncy+4NNqd1uP3phntk
 OocNGO9bd5BA4/spBG4AoD9cbJPCqFmd5oVg7GPIq0atTpJ6KT69Kdmb3tgbyKi1up+A
 Ry+wvMQVeyhaC6hjyDYMFBcPvWRBYyxrEO1IEo4yc0D5cKWXHKrb1JKdi8xF05xVM0iu
 XvFnQ75UDlJ+LSVRSS3qSu/1/+lMsxhjW34ChPrNQZ0w4rJjFCBV7EweUj/bh0SmUbmK
 1HizuaF7g+wEBjytQRbqKZbOUZv1NLvQBQQiYbFESh+8BhYwyqOF3HBT25ZInO74Xlky
 9IbQ==
X-Gm-Message-State: AOAM53260RQyDHYBStZ1npRXoE0/CrusyIQTf3wM1BuT4SbZ33H4yFSs
 3zS4XbUtAqDO+JQdQJ+uHn6rEAHSB/84GuW2Xn6slTnK7mjcSw==
X-Google-Smtp-Source: ABdhPJxcEphk5LdLqHsNd3UKt06bhzQujLcVLj7FNusrz5WqBOlg909vRYGpnkzsbOFilo9XiWA5ejDo5aDQmYwPOR4=
X-Received: by 2002:a17:902:be11:b029:d1:bb21:4c9c with SMTP id
 r17-20020a170902be11b02900d1bb214c9cmr25779289pls.8.1600358535629; Thu, 17
 Sep 2020 09:02:15 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 17 Sep 2020 17:02:04 +0100
Message-ID: <CAJSP0QUiNJZXtdiYZFVu_OLkPfWbX=F3JVkLSrqOHsJUL+MSTg@mail.gmail.com>
Subject: Reminder: Outreachy open source internships initial application
 deadline Sept 20
To: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-pl1-x62d.google.com
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
Cc: Julia Suvorova <jusual@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,
QEMU is participating in the Outreachy December-March open source
internship program. The internships are 12 weeks of full-time paid
remote work contributing to QEMU/KVM. For more information about
eligibility and what the internships are like, please see
https://outreachy.org/.

The initial application deadline is Sept 20 and it only takes 5-30
minutes to complete:
https://www.outreachy.org/apply/

If you or someone you know are considering doing an internship with
QEMU, Linux kernel, or another participating organization, please
remember to submit an initial application by September 20th!

Stefan

