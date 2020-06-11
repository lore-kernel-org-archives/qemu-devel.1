Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13807C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E1A20760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3HwN5+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E1A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjM1U-0004yU-62
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjM0p-0004YQ-Ub
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:08:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53041)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jjM0o-0007vV-Jc
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:08:51 -0400
Received: by mail-wm1-x341.google.com with SMTP id r9so4752821wmh.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Wt5EjiyrU4aBN21K/jgvPRs5FXkJwvxPIiZylk4m1x4=;
 b=f3HwN5+f7eTNWCTzZjjjTb2Aj1lv5YH9sBp2Ctto85xOtkNTooViAFjsgGfa0emVbx
 +2WUcp9GeWFywcKpUAg1MAa053grPTCs4uIPIyLtlKeQiMFgP8JgiGoLlgMtGM0DOiiJ
 B42iIYd9M9/BvS9ygBXkEHJxYA9Ir8z69O261aCM+yvgIce+GttlOhE5uCXzbW/T4+oY
 cZq+7X3tQfx/cv5RSAkyA2J5fM2p3giK9tgCK5mFvTrnURHHQljYGXSKjVmAs4kyuekf
 TsetOaRJnlGXuztfBafEhKAKTTNG0U2SW9BiKYShDqvUR3kRek2W9l3XUUQvqcUbxZYh
 D4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Wt5EjiyrU4aBN21K/jgvPRs5FXkJwvxPIiZylk4m1x4=;
 b=AuUI2pFggrKpRZYaxEOQREHctT+kFAM28HXlXzFDEN+YqKUIwrnEFqNx0UP8CifbwV
 Qu049vpmtfDMcq1U/tIeVrKycRZhfAXJ8R/3XBVXmNji9hnz/CnyIE7ayxFjoo71ntdY
 6odXCC8tt5l37Stt4eRmKvh2L15fOFJa+M8cGu58BYAa90kXW8ESoJsPJ9lSyGsbBtdV
 xdH7MALIkRbHZCx6dOPVYCmflgXd103oIUHBjG1tvyItGnXEGlcHftmFhNVATEusqbwd
 /ZFl1JUE7qcvqjOgTUwMVWAXMkFSEPRWw/LWrXn2jOSVWvCl0046GEXxg6zkjKx8qMV+
 yNOA==
X-Gm-Message-State: AOAM53219IEl0YNq1DEeQIS39IJBtFNY2Ajj3CqJJHPqp36w4WyOqIiL
 NwxlJo8QBREHLe54BrVektrm9AocLHJC9NIo8Rz8VheW598=
X-Google-Smtp-Source: ABdhPJxuYHcaJo4gvaP/TGpSpVfhnTWSRNnQiU6dy7LvqmwrfJxe3VhA0G4qo8UNfWz0QwuCAdJ9hMt0coAizUV288E=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr8485336wmb.168.1591877323719; 
 Thu, 11 Jun 2020 05:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200611114523.15584-1-aleksandar.qemu.devel@gmail.com>
 <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <20200611114523.15584-2-aleksandar.qemu.devel@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 11 Jun 2020 14:08:29 +0200
Message-ID: <CAHiYmc60Z6Vp9hy1GqThrL+63TYFaMcgjHAccLO4iy7FyXq1rQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] translations: Add Swedish language
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Rasmussen <sebras@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=87=D0=B5=D1=82, 11. =D1=98=D1=83=D0=BD 2020. =D1=83 13:45 Aleksandar Ma=
rkovic
<aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Sebastian Rasmussen <sebras@gmail.com>
>
> This patch adds translation of QEMU to Swedish.
>
> Signed-off-by: Sebastian Rasmussen <sebras@gmail.com>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  po/sv.po | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 po/sv.po
>
> diff --git a/po/sv.po b/po/sv.po
> new file mode 100644
> index 0000000000..1e430edd65
> --- /dev/null
> +++ b/po/sv.po
> @@ -0,0 +1,75 @@
> +# Swedish translation of qemu po-file.
> +# This file is put in the public domain.
> +# Sebastian Rasmussen <sebras@gmail.com>, 2019.
> +#
> +msgid ""
> +msgstr ""
> +"Project-Id-Version: QEMU 2.12.91\n"
> +"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
> +"POT-Creation-Date: 2018-07-18 07:56+0200\n"
> +"PO-Revision-Date: 2019-08-16 21:19+0200\n"
> +"Last-Translator: Sebastian Rasmussen <sebras@gmail.com>\n"
> +"Language-Team: Swedish <tp-sv@listor.tp-sv.se>\n"
> +"Language: sv\n"
> +"MIME-Version: 1.0\n"
> +"Content-Type: text/plain; charset=3DUTF-8\n"
> +"Content-Transfer-Encoding: 8bit\n"
> +"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
> +"X-Generator: Poedit 2.2.3\n"
> +
> +msgid " - Press Ctrl+Alt+G to release grab"
> +msgstr " - Tryck Ctrl+Alt+G f=C3=B6r att sluta f=C3=A5nga"
> +
> +msgid " [Paused]"
> +msgstr " [Pausad]"
> +
> +msgid "_Pause"
> +msgstr "_Paus"
> +
> +msgid "_Reset"
> +msgstr "_Starta om"
> +
> +msgid "Power _Down"
> +msgstr "St=C3=A4ng _ner"
> +
> +msgid "_Quit"
> +msgstr "_Avsluta"
> +
> +msgid "_Fullscreen"
> +msgstr "_Helsk=C3=A4rm"
> +
> +msgid "_Copy"
> +msgstr "_Kopiera"
> +
> +msgid "Zoom _In"
> +msgstr "Zooma _in"
> +
> +msgid "Zoom _Out"
> +msgstr "Zooma _ut"
> +
> +msgid "Best _Fit"
> +msgstr "Anpassad _storlek"
> +
> +msgid "Zoom To _Fit"
> +msgstr "Zooma ti_ll anpassad storlek"
> +
> +msgid "Grab On _Hover"
> +msgstr "F=C3=A5nga vi_d hovring"
> +
> +msgid "_Grab Input"
> +msgstr "F=C3=A5n_ga inmatning"
> +
> +msgid "Show _Tabs"
> +msgstr "Visa _flika"
> +
> +msgid "Detach Tab"
> +msgstr "Frig=C3=B6r flik"
> +
> +msgid "Show Menubar"
> +msgstr "Visa menyrad"
> +
> +msgid "_Machine"
> +msgstr "_Maskin"
> +
> +msgid "_View"
> +msgstr "_Visa"
> --
> 2.20.1
>

