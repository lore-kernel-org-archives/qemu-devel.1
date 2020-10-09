Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_08,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E22C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F432225B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 17:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RyZt4PZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F432225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQwFV-0000TM-Pr
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 13:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQwE5-0008C9-N9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:30:41 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34]:37912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shashi.mallela@linaro.org>)
 id 1kQwE2-0004Q1-9U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 13:30:40 -0400
Received: by mail-qv1-xf34.google.com with SMTP id de3so5132704qvb.5
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 10:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:message-id:subject:mime-version;
 bh=tgawoEedLRoE+ws7lMMliLdCAPjD+aQtngXCBKV9GDg=;
 b=RyZt4PZcVrjz4RjI5ZGtkS7vlZQ2M06xZHENFjf3qINu8qBujLze/XnceyP8RPPLNu
 bgo6oy7Ko5pWLXP2ZJDDLxlDalXLNem6y/L3g9ftTSYSkd1luvvQFnrGcuRxg1yjO8o+
 WXtwiSmGkgqYYv9LH9Qpxllrl/Lc4IYpbCu3ULbFSMaoITh+Wh/QXiYgR6snhuy+ZNKy
 55vLJzkYq5B8WQu3VQD7tgXLZQhYPsQqOiGKFcRfsBJSSUksqN0LbVqRGPcPwCftmKnd
 5wqQ5zBtsTWdV1m/oTIKgNbZdMjAJA2zXhyygzV9rD0IHv/MzhHlEofc3XM8iHNMXx7D
 uZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:message-id:subject:mime-version;
 bh=tgawoEedLRoE+ws7lMMliLdCAPjD+aQtngXCBKV9GDg=;
 b=ITKdzevtGev4BPfjj8QnYk7480tzzvTjBJCZlos7qCp+4vMNppZFaR4awyNyWJAPGB
 /1ctBmzda04nzi20X6kOi9+mgU+K56G+AqfaZGbuZrUygiMTFwIgbPzybSgp/Qkc//t3
 QhJC/niKnkB94fYs9n4tH7c/Li5qZGmVLxY6B9+KMkuIn3xid+HYu0YTlq+LKlhVxrgZ
 lTv5RrwaQEtMmxzYOEpHJwPnd+i5FWTMx4SZj4nrpu4ux8+dHFWR7etBgLHhpiO9DFgW
 LKg7BwOd7QIvaAH0kL0RKu3WuweX9EXqhD4tBhWzAZtcxqZWxNaE1XSNl6LbPGDzQNAl
 mQiw==
X-Gm-Message-State: AOAM532lTtx5MUyTVz4R0LOUGRoDxg7Hv53dKctlxfH2PyZ2FcopClgx
 SnYQjkJJtOY17lvAAMkNkF9bh+0QnWWcbhGT
X-Google-Smtp-Source: ABdhPJyVhsWxbFuUKre2epR276r1E88T8M+G98q+OREmp91FpQT5GVHkZQfvUSKkFeoAW/CBSH9dpg==
X-Received: by 2002:a05:6214:546:: with SMTP id
 ci6mr1565949qvb.0.1602264637152; 
 Fri, 09 Oct 2020 10:30:37 -0700 (PDT)
Received: from master ([2607:fea8:e2a0:e950::d884])
 by smtp.gmail.com with ESMTPSA id f189sm6459302qkd.20.2020.10.09.10.30.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 09 Oct 2020 10:30:37 -0700 (PDT)
Date: Fri, 9 Oct 2020 13:30:30 -0400
From: Shashi Mallela <shashi.mallela@linaro.org>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Message-ID: <74151CBD-4750-4E68-9127-21076C019036@getmailspring.com>
Subject: Re%3A [PATCH v4 1%2F2] hw%2Fwatchdog%3A Implement SBSA watchdog
 =?utf-8?Q?device&In-Reply-To=3D<CAD8XO3YmTC7fzxttg%3DQLMpJbg7uLogatxN7q7vf-iGZjyQLjjQ%40mail.gmail.com>?=
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="5f809e36_50dbf110_10e8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=shashi.mallela@linaro.org; helo=mail-qv1-xf34.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_IMAGE_ONLY_08=1.651, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=no autolearn_force=no
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
Cc: "=?utf-8?Q?peter.maydell=40linaro.org?=" <peter.maydell@linaro.org>,
 "=?utf-8?Q?qemu-arm=40nongnu.org?=" <qemu-arm@nongnu.org>,
 "=?utf-8?Q?qemu-devel=40nongnu.org?=" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--5f809e36_50dbf110_10e8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The value being returned here is 0 (initialized to 0 at the beginning of read function).
I have seen similar practices being followed in other qemu implementations like for example bcm2835_dma_read() in qemu/hw/dma/bcm2835_dma.c,a9_scu_read() in qemu/hw/misc/a9scu.c.

Please confirm if you would still like to add specific value like 0xdeadbeef for bad read offset.
Thanks
Shashi

--5f809e36_50dbf110_10e8
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>The value being returned here is 0 (initialized to 0 at the beginnin=
g of read function).</div><div>I have seen similar practices being follow=
ed in other qemu implementations like for example bcm2835=5Fdma=5Fread() =
in qemu/hw/dma/bcm2835=5Fdma.c,a9=5Fscu=5Fread() in qemu/hw/misc/a9scu.c.=
</div><br><div>Please confirm if you would still like to add specific val=
ue like 0xdeadbeef for bad read offset.</div><br><div>Thanks</div><div>Sh=
ashi</div><img class=3D=22mailspring-open=22 alt=3D=22Sent from Mailsprin=
g=22 width=3D=220=22 height=3D=220=22 style=3D=22border:0; width:0; heigh=
t:0;=22 src=3D=22https://link.getmailspring.com/open/74151CBD-4750-4E68-9=
127-21076C019036=40getmailspring.com=3Fme=3D2a4b90d6&amp;recipient=3DcWVt=
dS1kZXZlbEBub25nbnUub3Jn=22>
--5f809e36_50dbf110_10e8--


