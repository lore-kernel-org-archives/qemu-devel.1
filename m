Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8DC43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 14:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C7A20870
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 14:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jozi8dFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C7A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK0jm-0004KI-M6
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 10:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kK0j2-0003sW-Al
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 10:54:00 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236]:41464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kK0j0-0004Rt-J8
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 10:54:00 -0400
Received: by mail-lj1-x236.google.com with SMTP id y4so8970552ljk.8
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=X9Kok6Vip6w30nUoihQG6WEP5ipd6tFozJxZRsvdwu0=;
 b=jozi8dFyuI4RwkPmPscY6H3ouX4sFfyvTxcu34zg8hRpoQ1NRkHDf4x6awRy53itR9
 lLrnxlVpAn6waqA5O5O7YUmIhsty7nrMX8png6+nq+aixClB7VP1EQ5L04gXXljzqO0d
 oCBOOZn3MMNXTlCBIw67q8Mmkn+2XZiXpQkXq+F4rOxQ9dBZOpM8dK5n/fOHhHW506re
 NWHvWyV92tZtId+LkGOqUVxenZbb7yKz6L7nLOAJRJNf/IW1hVCHRca0ATCH5hd3kJVa
 QhrQiaKytARQijh71+XhX5e/qH0z615/QE0MTQHoOeGAWQPN8lfW26IU6W/f1RtTixsW
 9moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=X9Kok6Vip6w30nUoihQG6WEP5ipd6tFozJxZRsvdwu0=;
 b=ZLK68HbRLh35+QfqqndgEQYu6aLQvQ4B/tKvvm2zxoa584PccoUwtHjCwRvLdAfUOd
 eKwhPTr2mZt44FDc1VdMeZd3IoM0RsiQPoCLO9efKI9cz83yZS3r05wdjgjjo6BWXT7x
 xu1J0pS3WZAgMeTLvgVlZP/4kLIwLjXJ8arBYOeXphfwadD3cHhKVuYJOek9+7zUB53c
 2YFY8Z5dKcu9pQ6/zCIoEvjXaYzblIxOF60Y/YKt4iL1R1wJuG6UEr2fsy2X2WzsZqAa
 t6sWLnHLqA5BfunYBUZ4iBKIMaQkLrlPl3YqFCtlQKvEAEuepXJmgjgS6w8UGfu9E9R7
 752g==
X-Gm-Message-State: AOAM532e0eCcmudXJl/EB3BP3xQmPEYqU9QoWW50iQqNWTjG/+d6AJ/z
 jrvR3eVdeqxNWvzZAC2vpIp7nWbagBGkDDF2Yl4=
X-Google-Smtp-Source: ABdhPJygy/U/Ht0U6fPomPsEihdeOkXtJABl2rhv3UDTTm7Ls0/rylTdKPjPXG+LmWrNfOAfeOZbUrQRCXdSRdv9In0=
X-Received: by 2002:a2e:8983:: with SMTP id c3mr15202009lji.171.1600613636825; 
 Sun, 20 Sep 2020 07:53:56 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 20 Sep 2020 22:53:45 +0800
Message-ID: <CAE2XoE83rMdELyu5SSb=ysOzgbkSGHsmUVuonGRegkYGCdU9eQ@mail.gmail.com>
Subject: Hi Bonzini,
 I've seen your 3.1 branch have conflict with qemu.org/master
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000003ee5dd05afbfe7d0"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x236.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003ee5dd05afbfe7d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I rebased 3.1 branch on  qemu.org/master and placed at
https://github.com/lygstate/qemu/tree/for-3.1

And removed two conflcit revision

* iotests: Work around failing readlink -f
* Simplify the .gitignore file

And test result at here:
https://cirrus-ci.com/build/4717093432066048

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000003ee5dd05afbfe7d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I rebased 3.1 branch on=C2=A0=C2=A0<a href=3D"http://=
qemu.org/master">qemu.org/master</a> and placed at</div><a href=3D"https://=
github.com/lygstate/qemu/tree/for-3.1">https://github.com/lygstate/qemu/tre=
e/for-3.1</a><div><br></div><div>And removed two conflcit=C2=A0revision</di=
v><div><br></div><div>* iotests: Work around failing readlink -f<br></div><=
div>

* Simplify the .gitignore file<br></div><div><br></div><div>And test result=
 at here:</div><div><a href=3D"https://cirrus-ci.com/build/4717093432066048=
">https://cirrus-ci.com/build/4717093432066048</a><br></div><div><div><br><=
/div>-- <br><div dir=3D"ltr" data-smartmail=3D"gmail_signature">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div>=
</div></div>

--0000000000003ee5dd05afbfe7d0--

