Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2E8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8803120771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 06:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSiqkEVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8803120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jy82z-0005mQ-Pu
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 02:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <backtogeek@gmail.com>)
 id 1jy826-0005Jk-S3
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:15:14 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31]:37505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <backtogeek@gmail.com>)
 id 1jy825-0005Fk-Ak
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 02:15:14 -0400
Received: by mail-qv1-xf31.google.com with SMTP id p7so561587qvl.4
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=WVBmiYHGCp5F9mjjUMWxCWu5O4UUX6Y875vBEkKBca0=;
 b=eSiqkEVL1QwB45c6psHsMSXCzsmNyTic7uG8Uyd8i29W5gNrjtZnUUdxGzB9bl3Aay
 jIi+N+m5rpRrCt8TbwjasvQmyO9N9Jw83JVN4NEKjME0GKd9HyoGVlFDSSFDF+aOMDZ8
 5wbSA+Tu2Ij0qPKOPcdZSdX4C7+dhQIvcyxCvHp3LOaTwgsiq6l0AhUFmK6l2wA+BjdO
 Fat3N4J/3XRHNDuz07XZnM8vfX8v1fakpclv7+EREjF+irUfQYPi22vXhYdw7H3xKbcH
 d1tFEArXG53c/+Hdk3TZNEVG+Dd3dbxD8Yo/glqdKsy+NHygYO58P+OBKKCyJaAqvhqP
 YeUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=WVBmiYHGCp5F9mjjUMWxCWu5O4UUX6Y875vBEkKBca0=;
 b=Kff9YZb0vfCqegHvcymp4UKSTVVMxl7dzis5yl1i/pQhGAPyknJUVBdYxJBXujr7VZ
 qPmldjwlQFwzUbNyBqwWl2FaWLz6JV/G+ChH7cGz0NjWiWNczyg8YrIgAXghIx3SHwaC
 X3PX80E6DpbOgIr272NheYMYW2O0Ht5EMJG2K1DDF/uURldYCXlf7QaUWmxSRUIXwZgQ
 JLodn0lQGJKTtfoBaKBThoetugg5mLUIWGZur8hadTNHu/ulz7a70U4JGFa0vfYUaR2d
 IOiURI/r21vS54CoR52hHWA36J9Jre2r/zk6y436EXMd6Qjcq7f7ayjqEp+1Q+AY8mxR
 6Q7A==
X-Gm-Message-State: AOAM531AXUX/QIZbo93mKd/yu6ab4JXNYogPo7Sb6LLL3iD2Eyln0/qt
 e/NYmf2HX/r2fHqwRpUZXNZQMSwC1J83SMD99Kb+pAcHsdk=
X-Google-Smtp-Source: ABdhPJyDv05uu5zcD6r1XwWLnOVGYkw9WHEp4XTES+Vb9xS6MJsoxRWFVbCvxA+HnCj6Lkp/8ZtRXI0oKZ574RI85p0=
X-Received: by 2002:a0c:cc93:: with SMTP id f19mr30568845qvl.185.1595398511725; 
 Tue, 21 Jul 2020 23:15:11 -0700 (PDT)
MIME-Version: 1.0
From: anthony smith <backtogeek@gmail.com>
Date: Wed, 22 Jul 2020 07:14:59 +0100
Message-ID: <CAPf-64Wni=_9byuHt9HyFnZ6PwTF3wp17oEMF2ok-Tvk6UG0RQ@mail.gmail.com>
Subject: Disk cache defaults
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000091108005ab01a91a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=backtogeek@gmail.com; helo=mail-qv1-xf31.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000091108005ab01a91a
Content-Type: text/plain; charset="UTF-8"

Having spent a while searching for answers on this I am making a last-ditch
effort by contacting the devel group.

Could someone let me know if it is possible to change the default disk
cache setting in qemu globally?

Currently it is set to writeback, in many if not most use cases "none" is
optimal.

I am aware I can change it per instance however I really need to find a
global method so that unless specified otherwise the default becomes
cache=none

It does seem a little strange that options appear to exist:

qemu-img -h | grep writeback
    options are: 'none', 'writeback' (default, except for convert),
'writethrough',

However I can't find any documentation that hints at a method of changing
the default, rather all documentation provides is a method per use/instance.

Appreciate any assistance even if the answer is just "Not possible" so I
can at least drop this search for answers.

--00000000000091108005ab01a91a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Having spent a while searching for answers on this I am ma=
king a last-ditch effort by contacting the devel=C2=A0group.<div><br></div>=
<div>Could someone let me know if it is possible to change the default disk=
 cache setting in qemu globally?</div><div><br></div><div>Currently it is s=
et to writeback, in many if not most use cases &quot;none&quot; is optimal.=
</div><div><br></div><div>I am aware I can change it per instance however I=
 really need to find a global=C2=A0method so that unless specified otherwis=
e the default becomes cache=3Dnone<br><br>It does seem a little strange tha=
t options appear=C2=A0to exist:<br><br>qemu-img -h | grep writeback<br>=C2=
=A0 =C2=A0 options are: &#39;none&#39;, &#39;writeback&#39; (default, excep=
t for convert), &#39;writethrough&#39;,<br><br>However I can&#39;t=C2=A0fin=
d any documentation that hints at a method of changing the default, rather =
all documentation provides is a method per use/instance.<br><br>Appreciate =
any assistance even if the answer is just &quot;Not possible&quot; so I can=
 at least drop this search for answers.<br><br><br></div></div>

--00000000000091108005ab01a91a--

