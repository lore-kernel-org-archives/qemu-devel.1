Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_04,HTML_IMAGE_RATIO_02,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC94C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 383FD20675
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 16:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxU82a8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383FD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icB2Z-0004BG-A4
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 11:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bilalwasim676@gmail.com>) id 1icAfb-0007aP-4f
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bilalwasim676@gmail.com>) id 1icAfY-0003bA-JS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 11:04:57 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:33282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bilalwasim676@gmail.com>)
 id 1icAfX-0003Vs-Gk; Tue, 03 Dec 2019 11:04:55 -0500
Received: by mail-qv1-xf42.google.com with SMTP id z3so1746657qvn.0;
 Tue, 03 Dec 2019 08:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kK01j+jtcyJhmrX4/7BKHM8cxyWwgPUG6WT1zXZuUmY=;
 b=kxU82a8ScrfqhiA70X7n4MfyE6AWrHQ/9lcfQ/19RC4Y0aNTqQCJNVFbqePLERicNN
 jhSFFHCBxNHDoLuvXdrSN640pKNY4sr3fXbKF/NBtIPQHcVUPWJrs/Ti+eiHBtx2zgwR
 QkWyu+qkUeaKD3NuDglJXBPXSBmEUxSQs44s8kETv7Mg3XROl7bk4OT2odDJfDoSiGLE
 PIzg4qkaiMS2fsBez4kWMLTB9AwRjx+tr+GVWNAAQwjNkSMeZFIXdTXwZJfXeHl3mFzk
 rjE0JKMWIb+iaFYOZZqW0LSlbsFPK4qMiE1+V1608Qs9jkL2XvUTZ9vcQe1n00EXQv9V
 m5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kK01j+jtcyJhmrX4/7BKHM8cxyWwgPUG6WT1zXZuUmY=;
 b=ZdRRaT2BZZg+sVxvt4sxb2tUyTxhizh1p4/4J4fduPpTAsMed3Wtr8Hq2FxVKJC09y
 Wk/an09wftZvQ3QlSfcPzi1rXyAHNpV3HqPAc0BfipchcIfGtV7YLpvHeIysE9JHp+Zx
 zIv1cqJvUyUN0faI8LPCKg0I6l9L/311Oe0RcsSGj2K7gCqoB9jGbrvt4in5NP//ED+3
 KeLafX7p80XTVTVGxCnzliqI5tWT1BSfQg/3BQtJuwDdp8y6Oeq8qweRTmH+cNRoXpNo
 kq4FQOgNEhZWGBY9///gYsZjT4uCliZSzeoK7GAo71041OVi8kzqaoQi6nM0SiwnRV+E
 e0Sg==
X-Gm-Message-State: APjAAAU6jNf5I7XGvS3s6zSaDuS0XzukctmWUhYlK8Oyykl3z+5y4MHb
 dneXteYPS4XW4yI3qgw7O4f2rUWo6EcFpyXcuBk=
X-Google-Smtp-Source: APXvYqxJpqM7Yry1X7/U3Zu9GwMWbQh4QA6QslrwpbGLhSb80Gm1vOet2Y4FU/Lx8slJOoligX6wTV6uzhzDpFzELVA=
X-Received: by 2002:a05:6214:4f0:: with SMTP id
 cl16mr5858994qvb.213.1575389089889; 
 Tue, 03 Dec 2019 08:04:49 -0800 (PST)
MIME-Version: 1.0
References: <20191129150508.24404-1-bilalwasim676@gmail.com>
 <afe9efde-7ac1-8607-446a-8fbf10accece@redhat.com>
 <8c956ae31e8f44a2b831a5030b2448b4@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAP+75-X_POJfTO=gOUu1zCPtcfnQ5yemQo0hqB_s3jy_C17o9g@mail.gmail.com>
In-Reply-To: <CAP+75-X_POJfTO=gOUu1zCPtcfnQ5yemQo0hqB_s3jy_C17o9g@mail.gmail.com>
From: Bilal Wasim <bilalwasim676@gmail.com>
Date: Tue, 3 Dec 2019 21:04:38 +0500
Message-ID: <CAHKB+OBU94Gh1qjnUZrEE0ARXezKbP37hcB02Gewjbb_bQM7oA@mail.gmail.com>
Subject: Re: [PATCH] net/imx_fec: Updating the IMX_FEC IP to support loopback
 mode.
To: jasowang@redhat.com
Content-Type: multipart/alternative; boundary="0000000000001602820598cedb09"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aa1ronham@gmail.com" <aa1ronham@gmail.com>,
 "jcd@tribudubois.net" <jcd@tribudubois.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Wasim,
 Bilal" <Bilal_Wasim@mentor.com>, philmd@redhat.com,
 "linux@roeck-us.net" <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001602820598cedb09
Content-Type: text/plain; charset="UTF-8"

ping...

--0000000000001602820598cedb09
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">ping...<br><img width="0" height="0" class="mailtrack-img" alt="" style="display:flex" src="https://mailtrack.io/trace/mail/ab61d4b3de3f44dd6a6ab1395b6369b442d6a47f.png?u=596396"></div>

--0000000000001602820598cedb09--

