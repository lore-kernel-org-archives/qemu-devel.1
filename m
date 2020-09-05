Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAFDC43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F43206B8
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 14:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gq/YqWOL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F43206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEZNc-00019c-VP
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 10:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEZMu-0000c5-Vp
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:40:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133]:44642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kEZMt-0005lh-5y
 for qemu-devel@nongnu.org; Sat, 05 Sep 2020 10:40:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id d15so4454190lfq.11
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to:cc;
 bh=7hYqtK4NuZZiooqXGycoQbpdufnHTfi5alQptIv+Uj0=;
 b=Gq/YqWOLTNrHwDTRFS9hStFUZ7SfKIWCogZjxqh7LZx7NOmYCyK0VHG8qkPGM1DTUH
 jSP+or5YP6/dQAUknlC9uz7DNxIlWim4y27AlIEh17olJVO1keRtLNOZyR6O+5/Y2/fE
 CyzwEYGZIaqTm4XLnKnkPWpnwKbdJaweeEGSWCYGaptNenMy+VQ2e17spHMu5PoXD672
 R28UoMjUUKpYqXfVt/DGAaRZX2BjCHFc7er/yQnvz8JNzURbDTf3vlnAMfnj0Q1RVVR1
 LOV9vkB3+GKancl4A+rDaOPdBKuQMnVL9OwZQB13dQdxmsSFXlzswkDVPzX6W8HnJdIL
 iX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to:cc;
 bh=7hYqtK4NuZZiooqXGycoQbpdufnHTfi5alQptIv+Uj0=;
 b=cFpyzRYKmwXvz8KDWeW6QLDWj4EXee9GoH3p+lHJni2QQ8JDk4wcaC5z/0I8BI21J3
 F5cmZZRYlYaoD0SYy0pm1Vpllfl7M5MMUbjsvu2cgfZIGKjgIiE09IDofPq2P85gJfoo
 U1onwCqM0iceNjQ4zZkupm0ew0+LMQWrYTxDROL8msUOWkahuf2lW40Ba8HrmYr3CCrJ
 VzpXIMvTZh6MvmR4cEtKb6/TIC3U3Yl/0bHqajHW1065E33FBo3cwvk/sv9N7KcoCngU
 m2KWIae14QLvskSKlcWLQxOFkyDwDfZGJ5zPPFVPzUiWiB0NwYaVxVQPsIZJCPh5FWGb
 eKOw==
X-Gm-Message-State: AOAM530feAiS4rQNwVwNUaRGLuIMVFIGL7CmkuYvaszm381+fVoSPwSQ
 TmeB3VsAcIbSx3cS4rykH7o7xY8Zavp2/fMdCgAG7aXTFR27MiOv
X-Google-Smtp-Source: ABdhPJzYPza2kuf/xytE8Qh21WApEik7vlvMdnQIYRY+OChw/86L/yfKfKE/Xn8pefCNTuuzgZCIQJt+SYzErDTS/Ms=
X-Received: by 2002:a19:102:: with SMTP id 2mr6280027lfb.54.1599316836370;
 Sat, 05 Sep 2020 07:40:36 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 5 Sep 2020 22:40:24 +0800
Message-ID: <CAE2XoE-KYjVsZ=jpARiW9dWz1yyonAdy25ahWrD-BQV8UidYkw@mail.gmail.com>
Subject: tests/test-char.exe are blocked by char_stdio_test_subprocess are
 blocked
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ea4b9c05ae91f77c"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x133.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ea4b9c05ae91f77c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

and the process won't finishe
--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ea4b9c05ae91f77c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div><div>and the process won&#39;t finishe=
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=
=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<=
br>Yonggang Luo<br></div></div></div>

--000000000000ea4b9c05ae91f77c--

