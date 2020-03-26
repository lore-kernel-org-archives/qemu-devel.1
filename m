Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8994C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:35:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A1720774
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=thatjames.org header.i=@thatjames.org header.b="FvB8YQ6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A1720774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thatjames.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHaAA-0001eT-Ka
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 17:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benjamin@thatjames.org>) id 1jHa87-0007hj-PF
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benjamin@thatjames.org>) id 1jHa7z-00062H-T3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:33:29 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.65]:31629)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benjamin@thatjames.org>)
 id 1jHa7w-0005nQ-OK
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 17:33:26 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway22.websitewelcome.com (Postfix) with ESMTP id 33A2A4625
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:33:12 -0500 (CDT)
Received: from box5531.bluehost.com ([162.241.218.31]) by cmsmtp with SMTP
 id Ha7kjMoMBAGTXHa7kjlXJ7; Thu, 26 Mar 2020 16:33:12 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=thatjames.org; s=default; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=faifKFxsbBcPcDxEhLIehlbdYfFGAd3HhZxwuzZlWLs=; b=FvB8YQ6fKZpa0ytuXK6fWXLBhq
 cinv0++URFg5l8pk8yTSc/iUn84arUru5AGVW013N6y1bmJeSVNjuPEQzMmLJrteXPdpbpDnqbw4i
 2RN8z6uPm8jWwcgqICwEh4v56oeS9uqVbmsh3rIAsv20a5d82uBn1gu6fwqZ3PNncyd/28A2WdRk4
 jrSRcOQDyZ6fxsMtXpyeFsz1m2JVrGxT3++jDqyWzwr6ScI6DxGTLaObdPUwmQosSJ9TK6Ad2yFTV
 HY8REw8htvRvUGm5NuP8fvzrzkpI1a0qqD5vdJgoWwUsPcdcfMhOMKV02Q5P5VqNj/HNTi4fp1F7T
 cXVTdtFA==;
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39301)
 by box5531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <benjamin@thatjames.org>)
 id 1jHa7j-0017uk-RU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:33:12 -0600
Received: by mail-lj1-f174.google.com with SMTP id i20so8066136ljn.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 14:33:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuZllA/MnyXsEr/Nusle9bEVbpsOmhfUJJrQrl70D68HgQGvI2Bh
 La0VhJTkTn5aVVxx6Yv971WulOZGGzS1KeC3eGU=
X-Google-Smtp-Source: ADFU+vv8L7dxewbhozDs3ipynL0wSfecdfham233Ta/toEOXBgpOi1mO1PsikhFrpmltl3r92dTb2Xep4a++MZlWdPo=
X-Received: by 2002:a2e:894e:: with SMTP id b14mr6364047ljk.103.1585258390564; 
 Thu, 26 Mar 2020 14:33:10 -0700 (PDT)
MIME-Version: 1.0
From: Benjamin <benjamin@thatjames.org>
Date: Thu, 26 Mar 2020 15:32:59 -0600
X-Gmail-Original-Message-ID: <CAOragkxgc1cCz9S7oexiELhkvkWiRUW21p+L17Ra40PGCdN4hA@mail.gmail.com>
Message-ID: <CAOragkxgc1cCz9S7oexiELhkvkWiRUW21p+L17Ra40PGCdN4hA@mail.gmail.com>
Subject: Qemu TCG Plugins - how to access guest registers
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003f34b105a1c8bba3"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5531.bluehost.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thatjames.org
X-BWhitelist: no
X-Source-IP: 209.85.208.174
X-Source-L: No
X-Exim-ID: 1jHa7j-0017uk-RU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-lj1-f174.google.com [209.85.208.174]:39301
X-Source-Auth: benjamin@thatjames.org
X-Email-Count: 1
X-Source-Cap: dGhhdGphbWU7dGhhdGphbWU7Ym94NTUzMS5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 192.185.47.65
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

--0000000000003f34b105a1c8bba3
Content-Type: text/plain; charset="UTF-8"

Qemu version 4.2.0 includes new functionality for something called TCG
Plugins. There are a few examples in the tests/plugins directory, and the
API is more or less defined in qemu-plugin.h.

This file defines two enumerated types, "qemu_plugin_cb_flags" and
"qemu_plugin_mem_rw", which are passed into functions that register
callbacks. These enums seem to indicate whether the callbacks will read or
write CPU registers or memory. However, all of the example plugins use
"QEMU_PLUGIN_CB_NO_REGS", and only 2 of the plugins use the memory access
enum. hotpages.c and mem.c use "QEMU_PLUGIN_MEM_RW" as the default for
registering a memory callback (qemu_plugin_register_vcpu_mem_cb). mem.c has
an argument when the plugin is loaded to choose if it's read or write,
however, it doesn't seem to make any difference in the callback function.

My question is, how do I access the guest memory and registers from the
plugin callback function? The API seems to indicate that it is possible,
since the callback registering requires you to say if you will access them,
and if it's RW or just read.

Are there any examples of using this part of the API? I realize this is a
very new part of Qemu functionality.

Thanks

--0000000000003f34b105a1c8bba3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Qemu version 4.2.0 includes new functionality for somethin=
g called TCG Plugins. There are a few examples in the tests/plugins directo=
ry, and the API is more or less defined in qemu-plugin.h.<br><br>This file =
defines two enumerated types, <font face=3D"monospace">&quot;qemu_plugin_cb=
_flags&quot;</font> and <font face=3D"monospace">&quot;qemu_plugin_mem_rw&q=
uot;</font>, which are passed into functions that register callbacks. These=
 enums seem to indicate whether the callbacks will read or write CPU regist=
ers or memory. However, all of the example plugins use <font face=3D"monosp=
ace">&quot;QEMU_PLUGIN_CB_NO_REGS&quot;</font>, and only 2 of the plugins u=
se the memory access enum. hotpages.c and mem.c use <font face=3D"monospace=
">&quot;QEMU_PLUGIN_MEM_RW&quot;</font> as the default for registering a me=
mory callback (<font face=3D"monospace">qemu_plugin_register_vcpu_mem_cb</f=
ont>). mem.c has an argument when the plugin is loaded to choose if it&#39;=
s read or write, however, it doesn&#39;t seem to make any difference in the=
 callback function.<br><br>My question is, how do I access the guest memory=
 and registers from the plugin callback function? The API seems to indicate=
 that it is possible, since the callback registering requires you to say if=
 you will access them, and if it&#39;s RW or just read.<br><br>Are there an=
y examples of using this part of the API? I realize this is a very new part=
 of Qemu functionality.<div><br></div><div>Thanks<br></div></div>

--0000000000003f34b105a1c8bba3--

