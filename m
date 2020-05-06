Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A527C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6001D2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNhLApxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6001D2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWJbe-0001dv-G6
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWJb6-0001Dt-9w
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:56:24 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:46743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <priyamvad.agnisys@gmail.com>)
 id 1jWJb5-00019d-LR
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:56:24 -0400
Received: by mail-lj1-x241.google.com with SMTP id f18so2196282lja.13
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=X5jMTmvORI1mzcC0YGhr+6ixyJJe6wwu6bstylJsaO0=;
 b=KNhLApxOR3wCEsM7ZXzZzU4YlPrpy8bfwPnE4oTvnBwnH+tW4dTa1FEkelLpLP3NTw
 idN/5Pv3HGSRRaQrTk890WoC9LDNU4wRmBExUG3vIowHa/ScKfbMfFgGUFis7sz4Qfy2
 TSGSPSDjVudZENwKOLuxTqMYdtAM+55pmJICBErSObq7T62lca+1z9Kt3vYimkofQNxo
 +r6nF7Ijsws8lnwjM2StlabEdmEhjJZgTI+y06QWPS5D1MAnj1mGJVQ/Am+M21htd9I2
 wQH1YTlX+h0yu3f70xMLZHmBcswZjjjnLRRfPRNrPskEY0USD7PQb3010E8GzQg9LT53
 IHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=X5jMTmvORI1mzcC0YGhr+6ixyJJe6wwu6bstylJsaO0=;
 b=ZE9zBdXg9gs/iJMYattOwonx8dsjNQf90FYk7B8ISI6Yj4OApp4owDwWwMTX/wwEMo
 0Rp5OO7qY+bCpDi3fPCaS/DhFa8fa3FhasVzu08OvBpSglDhiaJZKAAjmyO0NDKmrUfK
 mW3sPoa29a8sY4gZvYgWPfo7vqSHp+ZJAU6DxEJ66gyQbw0kaSMlwmLSg3boxRr+yLtt
 lcn2wE7Hl/EmJ+RS7yqhYWX83OjW9t7jtFBpMPzTuCANPl0Y+9D9WTlYo1bKuTsjymS0
 BWOd56sEA0R0ppvSSmCIUb0vkcGnQDrTa0bSsQ9pxV5z7jD1/qSpOL5bMnFKtMraCh9Z
 9rDg==
X-Gm-Message-State: AGi0PuaNBvU7NZPOdXVX5ciDUtJayPMrg7Foh4GurryooLk8i9PtYZjS
 P8clLLhPv6qfuxiteApme1b7BgYg07T9i4lGXTZWq0HuPOY=
X-Google-Smtp-Source: APiQypLa04U99kbpXY8pJ6/I5xHcIFR9wS8CfLwPrFZIwikiW7THTBj+wypFAfXZL39nO0viAQEqhqY19ASmAb6POxw=
X-Received: by 2002:a2e:97d4:: with SMTP id m20mr4708436ljj.159.1588769780790; 
 Wed, 06 May 2020 05:56:20 -0700 (PDT)
MIME-Version: 1.0
From: Priyamvad Acharya <priyamvad.agnisys@gmail.com>
Date: Wed, 6 May 2020 18:26:08 +0530
Message-ID: <CAPV47zdeH0+G85De2nOeD-dw91PKqPZh0U4SZuwuFmdqRyhXjQ@mail.gmail.com>
Subject: Parameter 'driver' expects pluggable device type
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000069fd0305a4fa4af7"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=priyamvad.agnisys@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000069fd0305a4fa4af7
Content-Type: text/plain; charset="UTF-8"

Hello developer community,
I want to allow a *sysbus *type device to boot with kernel image(arm
architecture) via Qemu command line .

When I run qemu arm system executable with *-device *option via qemu
command line,I get following error message

> qemu-system-arm: -device pl061: Parameter 'driver' expects pluggable
device type

So, how to allow a sysbus device via command line?
Is there any working patch?

--00000000000069fd0305a4fa4af7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div>Hello developer community,</div><div>I want to al=
low a <b>sysbus </b>type device to boot with kernel image(arm architecture)=
 via Qemu command line .</div><div><br></div><div>When I run qemu arm syste=
m executable with <b>-device </b>option via qemu command line,I get followi=
ng error message</div><div><br></div><div style=3D"margin-left:40px">&gt; q=
emu-system-arm: -device pl061: Parameter &#39;driver&#39; expects pluggable=
 device type</div><div style=3D"margin-left:40px"><br></div><div>So, how to=
 allow a sysbus device via command line?</div><div>Is there any working pat=
ch?<br></div></div>

--00000000000069fd0305a4fa4af7--

