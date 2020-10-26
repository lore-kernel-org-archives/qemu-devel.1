Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C845FC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29FEC2074B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET11fNCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29FEC2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX8yR-0007do-5T
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX8tO-0001Os-Kz
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:14:59 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:35352)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kX8tL-00072q-PK
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:14:58 -0400
Received: by mail-lj1-x22a.google.com with SMTP id x16so11760751ljh.2
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=G5X34XssD6eZocHMYjcZtyKh9SNU+IrvzYYI2iN1s2w=;
 b=ET11fNCdvg5j5cpTae7Y8qSpnFbmu1nQ9TIuewa6rHF8D7xB+3c+IIYtnDLOBz7wYz
 qv6x8Bv7nmEj5LOzaobB5735NlXGkips+pvJIwgFoj7sCgjKMHm8UdkLy1CZpvv2beA3
 SfAM6HcIUnFPAv+uUxHcYkzGagQ/3NCeAN4vy58mW/afnTgsL842wEJSwBBleV4vIpcN
 x8xZDBerPRtzdhwkptZD5PTsP7J5YnsSVCghwsSwbDkUAlHUKhaVsUE5yvors3yp2QA/
 38VAUElwHzgPVV1egvz3zccybys6MexlOV7683i8OGt/rYNi6XDB32BVQaLD3gR8OH/2
 bMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=G5X34XssD6eZocHMYjcZtyKh9SNU+IrvzYYI2iN1s2w=;
 b=SxUN4gDtCCJKwOpW+E7v4LphjDTOEzKLVkhn+CF3cVJ25FWecH9ooaGzLZknpekk9p
 2T46GkpUUHeczqKtJPtJGYIUuXwk1Qxv9wVcPOu2Kt8ggNyiD3OjOlMnZu11eEj/1xth
 bwTqxp/Um374uDsbhMOtJZsqlGJz10/n1BCdIUTYH+hkUJzc+Rs79KxT5wP/sBvrs+Ot
 FHjJaz7TGTTq2tGl9F0LsGLU4OE7gUiPVzLtLvXE3fHafR0jhgVJB21bclAxrW7DwJDE
 fA6Yq5mNPKVqO/k2mrY6Xlr1KFxaL1M7f3o72l3eEqV2lmFO5VtcvQNxzLXIDPokGPkQ
 K9vw==
X-Gm-Message-State: AOAM530jL3xc8U/WwoocUbPEU29+MEpqn461t8OxXbqJzhvQyttrvPTu
 S0qmjsscluRBxrRuyo/q39U0/Xz/tLv6cpuN+XQ4K3wTlzE=
X-Google-Smtp-Source: ABdhPJwDejLb+weNeXVWUt0uzsYujAJnhpF5Vb7oWffhaTqmspgHeHrg6/2YdVpYjo8WUzmo5MIncdhlDDolNcC54/M=
X-Received: by 2002:a2e:87c9:: with SMTP id v9mr7195367ljj.368.1603743293112; 
 Mon, 26 Oct 2020 13:14:53 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 27 Oct 2020 04:14:41 +0800
Message-ID: <CAE2XoE-nwJRgoraR9HFoDpW-tgGER6CAaY0s5gyR8BGDH3aHxA@mail.gmail.com>
Subject: How about using a bot to guard the pull request can be apply? like
 rust compiler does.
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004c08e805b29895d7"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22a.google.com
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

--0000000000004c08e805b29895d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter can @bots try to apply pull request, if pull request apply and all ci
tests passed, then the bot automatically merge the pull request and push to
the mirrors.
We even doesn't need gitlab or other things, only need the bot to monitor
the instruction from Peter.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000004c08e805b29895d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Peter can @bots try to apply pull request, if pull request=
 apply and all ci tests passed, then the bot automatically merge the pull r=
equest and push to the mirrors.<div>We even doesn&#39;t need gitlab or othe=
r things, only need the bot to monitor the instruction from Peter.</div><di=
v><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-sma=
rtmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div></div>

--0000000000004c08e805b29895d7--

