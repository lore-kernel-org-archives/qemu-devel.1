Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11A2C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A59A20730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnW5YJ4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A59A20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1Rj-0006f6-NP
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:53:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz1R3-0005kg-R8
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iz1R2-0006ed-L1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:52:25 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:41117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iz1R2-0006av-FS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:52:24 -0500
Received: by mail-ot1-x32e.google.com with SMTP id r27so17720625otc.8
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j34pWu9H4cE+y3eCmsaq1xh20zcmZ0oPLVxR5fjmYGo=;
 b=ZnW5YJ4/Hhv/A/VwmsKnoyluBMhrbHNNi/7CBRCzF1BbT9Afz0oFw2L1aeRB5e8bTJ
 DNU5DC6X6f/nPHRi3o3hVk3F8fwdzV4Hl9wo7c+MrKf2WvqYVNdmbTcK3Ho9DIJWXOiG
 P3385gDeqjJPJTW1TvnOW6+M9gj0Ma0XgESqG1CIlWt0tTOBn8ZFVdoAA8lEQZqQsxD5
 4+mOj9GY7zQe/FEsmtACipsGhN3bfTcYPECs9MWmkskMssMwXUgJspcO1cTJzl06SVVu
 jNby9YLYHMY+Klx8Ac4+lNo9JIvCxYz1N7Lnw3GVQKEcenuROpfJCHyJCpDrtBF/zQAO
 efpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j34pWu9H4cE+y3eCmsaq1xh20zcmZ0oPLVxR5fjmYGo=;
 b=jK+rAHUJ2NWWxLMWnY2dqUlrTAlFsHj3+p3OBMRnh58LJrwwd/qPW++mzCN4SRFkMh
 Fm3zTG1OJ6QGoX9mjOuMvhegDxuN2jjSoOy9C+okOo56c0YlFmuETmZag6xuxZGLZjiP
 RQcjF5pGaTjeLAtX+Zjrfw78cywN5mnupoCATWuVyS/WAPyhUfDipNUYnO6L5av16g1P
 77zdt3AxKjEhu0VCwfDD9CERKj3SYa/5HFubxftR3+b316bp1Kqs0BVLarBztZIb2aRD
 qi5/xjCKle1uzlVK57DbdEnTutmesWIdeud/6KIaHX9A18x3axMHYawT17KdXr0DUUI/
 kjqw==
X-Gm-Message-State: APjAAAXn/MM8njzCf6eKX4FIbPVlq+hzlDG8wkN+l6Xkvxf2RBoGvf5h
 sO31NL+bEdc720y+xqNeCVfrsTaveM5a6W6O4w8=
X-Google-Smtp-Source: APXvYqwO69WRhYN1wmSyYevCQQXZZtZdYRqxAM4QHxGMcFPFMoeOpY+a7oSFf3RIIk4Rto973FIruz9uXHpJUGZfZb0=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr21668540otk.64.1580835143608; 
 Tue, 04 Feb 2020 08:52:23 -0800 (PST)
MIME-Version: 1.0
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
 <20200122112818.GA663955@stefanha-x1.localdomain>
 <CAL1e-=hJ=vD6Ngy0_w-kGA2X4EP-yni+S0ZTkPKW36moqaBozg@mail.gmail.com>
 <20200129153937.GA157595@stefanha-x1.localdomain>
In-Reply-To: <20200129153937.GA157595@stefanha-x1.localdomain>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 4 Feb 2020 17:52:09 +0100
Message-ID: <CAL1e-=h+G+8ZWxHpS0WenxLLrfwBOVxv+xaL9KkGO1JqM=ksTA@mail.gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000002eec7f059dc2dd95"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002eec7f059dc2dd95
Content-Type: text/plain; charset="UTF-8"

>
> Please go ahead and add this project idea to the wiki:
> https://wiki.qemu.org/Google_Summer_of_Code_2020#How_to_add_a_project_idea
>

Hi, Stefan,

I set up the proposal wiki page:

https://wiki.qemu.org/Google_Summer_of_Code_2020#Performance_Measurement.2C_Analysis.2C_and_Presentation

Anything else I need to do?

I see Feb 5, 20h European is the "organization deadline":
https://summerofcode.withgoogle.com/

Yours,
Aleksandar

> Stefan

--0000000000002eec7f059dc2dd95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>&gt;<br>&gt; Please go ahead and add this project =
idea to the wiki:<br>&gt; <a href=3D"https://wiki.qemu.org/Google_Summer_of=
_Code_2020#How_to_add_a_project_idea">https://wiki.qemu.org/Google_Summer_o=
f_Code_2020#How_to_add_a_project_idea</a><br>&gt;<br><br>Hi, Stefan,<br><br=
>I set up the proposal wiki page:<br><br><div><a href=3D"https://wiki.qemu.=
org/Google_Summer_of_Code_2020#Performance_Measurement.2C_Analysis.2C_and_P=
resentation">https://wiki.qemu.org/Google_Summer_of_Code_2020#Performance_M=
easurement.2C_Analysis.2C_and_Presentation</a></div><div><br></div>Anything=
 else I need to do?<br><br>I see Feb 5, 20h European is the &quot;organizat=
ion deadline&quot;: <a href=3D"https://summerofcode.withgoogle.com/">https:=
//summerofcode.withgoogle.com/</a><br><div><br></div><div>Yours,</div><div>=
Aleksandar<br></div><div><br></div>&gt; Stefan</div>

--0000000000002eec7f059dc2dd95--

