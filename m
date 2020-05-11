Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7891C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801A120735
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD0sWOAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801A120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY3JN-0003TJ-K0
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jY3Id-00031s-Pu
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:56:31 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:38161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jY3Ib-0004ue-OC
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:56:31 -0400
Received: by mail-ot1-x32d.google.com with SMTP id m33so6819432otc.5
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EmTbs9E3EmJg6oCT0ziN++yvqFjJPC/xzhcAg60Mycw=;
 b=YD0sWOAZRVRK6yirPmfVB67SprTI4A0MYd7WFu+/cn+Ln5E+a0L8iyXJGHDiuyxlPJ
 POGK4WeyD9sLx2Yxzc2z8gErKYbsq+GQsDBFAbHodVsJeNTKYgUEwDqsZTq0RNolOInF
 6lsUu1GREVCvm1ZzHsS2/nD+j7zeHFViOsTSggXIVIS+s3vG3Lghl24TunFCU7H+DKzP
 Q+llEgb3WQj3EMnef3t3iP8v2x01CKp4na0YRNXgt6asCab6MTgt1ecAZD6vb2xpGyQ5
 kUUfi4jkcV59Dm0u62D6td3hf6+zLXzoEOdO+bCBSZYTMs7Ssq4SkXQFCqEGLdmHU5fW
 YPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EmTbs9E3EmJg6oCT0ziN++yvqFjJPC/xzhcAg60Mycw=;
 b=rNqlXDKl/vRTrSVACPr+VveV/hEbYmqtqXSF2sJO6D6C+6buRWhL3bujVhKHPLuw4g
 XYuThPYN9OR7/3+Y3KMAusgtx7T/DBD94DkZ0L5xPV5KYFTFi5fPHMiPZyFHZMyqlJem
 xGdUXcAUXCXDFn1ZN/ghTglXCJLqs4XEC+P9ZF0i7cEgHVfae6fOd5z9LKOTHNiRmPDT
 w9Jor1JwogQwB7wGD9d9QaF0n17WIMKNI8RKFC9gNLiMeQYoyBPwKbRNYX7KtJeOZp4A
 L1JATD/P+ulkzGa0ElP6fRIlR6WL7TOu1ExNt1d6IkwsNibyjEzjn+elwOfWLwIGYYy4
 QdpQ==
X-Gm-Message-State: AGi0PuZXrlXYQUyrTLSgltThYaSInO3qzwsGQgmJ+NVWHDhObI8I+lI8
 4JUU5vXW+8K4vq9cCKBrrBtC0SKu515lqgaNTBY=
X-Google-Smtp-Source: APiQypLeMD5XnhPgckHgRvAOF7DfHBw1+IQJDGYQBETYPDThGxjcvM2a+zgcI/TKrJIg41QPM5HXTxkzG3Bz5gLxLIQ=
X-Received: by 2002:a9d:6a81:: with SMTP id l1mr11832736otq.75.1589183788187; 
 Mon, 11 May 2020 00:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
In-Reply-To: <2393388c-86c3-4d7e-178e-2c7e6d14a8de@t-online.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 11 May 2020 09:56:16 +0200
Message-ID: <CABLmASGbq1KoLxFDpR3souP=PTaA27OEstrn8GsFnOPR8b2OxA@mail.gmail.com>
Subject: Re: Patches for ui/gtk and ui/sdl
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: multipart/alternative; boundary="0000000000002d839d05a55aafa0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=hsp.cat7@gmail.com; helo=mail-ot1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002d839d05a55aafa0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2020 at 8:42 PM Volker R=C3=BCmelin <vr_qemu@t-online.de> w=
rote:

> It's rather difficult to test qemu patches in guests on Windows with
> important keys missing. These patches mainly fix the guest keyboard on
> Windows.
>
> With best regards,
> Volker
>

Hi Volker,

Excellent patch! I tested this on Windows with qemu-system-ppc running Mac
OS 9.2 with both SDL and GTK GUIs. Finally no more popping up of that
windows menu. Key combos are sent correctly into the guest. Also right alt
does no longer send left ctrl+alt into the guest.

A mere cosmetic difference between using a real mac keyboard and a pc
keyboard is that alt and windows key seem to have traded places. However,
the mac keyboard does have the alt where the windows key is on the pc
keyboard. The keys are, however, functionally correct.

The GTK GUI itself was and is unusable for Mac OS 9 guests in WIndows. That
OS has no tablet driver available.

Thanks,
Howard

--0000000000002d839d05a55aafa0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, May 10, 2020 at 8:42 PM Volke=
r R=C3=BCmelin &lt;<a href=3D"mailto:vr_qemu@t-online.de">vr_qemu@t-online.=
de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">It&#39;s rather difficult to test qemu patches in guests on Windows with =
important keys missing. These patches mainly fix the guest keyboard on Wind=
ows.<br>
<br>
With best regards,<br>
Volker<br></blockquote><div><br></div><div>Hi Volker,</div><div><br></div><=
div>Excellent patch! I tested this on Windows with qemu-system-ppc running =
Mac OS 9.2 with both SDL and GTK GUIs. Finally no more popping up of that w=
indows menu. Key combos are sent correctly into the guest. Also right alt d=
oes no longer send left ctrl+alt into the guest.<br></div><div><br></div><d=
iv>A mere cosmetic difference between using a real mac keyboard and a pc ke=
yboard is that alt and windows key seem to have traded places. However, the=
 mac keyboard does have the alt where the windows key is on the pc keyboard=
. The keys are, however, functionally correct.</div><div><br></div><div>The=
 GTK GUI itself was and is unusable for Mac OS 9 guests in WIndows. That OS=
 has no tablet driver available.<br></div><div><br></div><div>Thanks,</div>=
<div>Howard<br></div></div></div>

--0000000000002d839d05a55aafa0--

