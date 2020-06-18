Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD04C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A53D20890
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdptTaN/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A53D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0EO-0008Ow-9S
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jm0Ca-00077l-8B
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:27:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:54242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jm0CY-0002OM-Le
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:27:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id l26so6286865wme.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=PeqDZE9gvcPT3T3aACyTek4vT6R2OJoE1sxnqWhxhe4=;
 b=RdptTaN/g7xvMYwoKl4DTQqmgZOHWU2ohGbrOJsfDwVV7Rj2OPaU+O5BqUqsdgMOtP
 nRtQIJCoz0e3R27UhrKVvwLLk5UkIUM4Xk9AWJToadJqOMsTRiR/Nk4inuFUpQM6v1EF
 zhAwosfJH9TpDapB4jotu2wY1r0ay1nak7LqlMFo/l6FVEU5BDg4OsYd1hstfzBhoQxX
 MSiESJgM7/1Ycan01ucp/lbfNA856ZKJkFhNxGgLv9wYXsV9ZlvIcboMGYp6LfDKHYRt
 1OP+JG/c/OgHZBjs0X0pL8v2LM5Kh6PYGq14vejg3bBSKifcRIudFozXmCueDSUJ+oFg
 N/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=PeqDZE9gvcPT3T3aACyTek4vT6R2OJoE1sxnqWhxhe4=;
 b=lg4iFYWM9FcwGgIwfCagC5lK3PPSqFhhakTqiZJPpslgedDR22w4NDnE3Nbf2k/+q7
 I2FW5HGrj3TkAk+el/kcqzC3W3Y28YNv+AYmiQorXciqD+i08gHyh5e9hY7S0T0F7D+I
 RySheuLHD4m82yePmchLiECedAhappSreQesnO4w6FW0bxKtZx+FLlCGRuDi1Chl1qzD
 NYJi2Bg7bVoxUh/9NXdDzdD8kL3D8/JFVT8IgfVLd6I4mlH6tUWn6auEDPQDC+SU9vIb
 SEFQoChc9TLCJpMOMTTLhOdwJnRM4QFfFihGno7E1MyBx21N2iviVR3MbTiEtScnlVN3
 AL9A==
X-Gm-Message-State: AOAM531OwZojoLDwoujMeAoUNZDxotYnbj7DgbmzVnpQ8wszzeqI/3Sa
 +rcx0kF2xKXoRi6gIzQkQL+9hQldoEmc0YRQXwAo58dR
X-Google-Smtp-Source: ABdhPJyZOGrVIiLnwjrydFtMUf7++u8tbjWvs1Hg4fLUWn6XsGnG3LzRvjDDd7foA8p4uOJ/QmdpQvFV+X+lZQ7We8M=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr6033742wmb.168.1592508472460; 
 Thu, 18 Jun 2020 12:27:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:451:0:0:0:0:0 with HTTP;
 Thu, 18 Jun 2020 12:27:52 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 18 Jun 2020 21:27:52 +0200
Message-ID: <CAHiYmc7iD4AoV3Lj5igTQMYESNHU6_-_7cwujhsgJYv5zKraDQ@mail.gmail.com>
Subject: [DISCUSSION] GCOV support
To: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cd89ed05a860c5c4"
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x331.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000cd89ed05a860c5c4
Content-Type: text/plain; charset="UTF-8"

Hi, Alex, Peter.

You may recall that I signalled on couple of occasions that there are some
problems related to gcov builds in out-of-tree builds.

It turned out that those problems manifest on some opder Linux
distribution, and are always related to the gcovr being older than 4.1. For
older gcovr, the tool simply doesn't connect properly executable and its
source files, and no coverage report is generated (or perhaps only some
small portions, but, on any case, gcov builds are virtually unusable).

I propose that we don't bother supporting systems with gcovr older than
4.1. We could check version of gcovr in confugure, and refuse gcov builds
if that version is older than 4.1.

This would remove one obstacle towards removing the support of in-tree
builds. (I am not sure about future Mason-based builds, I hope they will
support gcov builds, and work in almost identical way.).

If you agree with proposal on the level of design, Alex, can you perhaps
write the corresponding patch, I gather you are more familiar with
modifying configure than me? Or I should do it?

Warmly,
Aleksandar

--000000000000cd89ed05a860c5c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alex, Peter.<div><br></div><div>You may recall that I signalled on coup=
le of occasions that there are some problems related to gcov builds in out-=
of-tree builds.</div><div><br></div><div>It turned out that those problems =
manifest on some opder Linux distribution, and are always related to the gc=
ovr being older than 4.1. For older gcovr, the tool simply doesn&#39;t conn=
ect properly executable and its source files, and no coverage report is gen=
erated (or perhaps only some small portions, but, on any case, gcov builds =
are virtually unusable).</div><div><br></div><div>I propose that we don&#39=
;t bother supporting systems with gcovr older than 4.1. We could check vers=
ion of gcovr in confugure, and refuse gcov builds if that version is older =
than 4.1.</div><div><br></div><div>This would remove one obstacle towards r=
emoving the support of in-tree builds. (I am not sure about future Mason-ba=
sed builds, I hope they will support gcov builds, and work in almost identi=
cal way.).</div><div><br></div><div>If you agree with proposal on the level=
 of design, Alex, can you perhaps write the corresponding patch, I gather y=
ou are more familiar with modifying configure than me? Or I should do it?</=
div><div><br></div><div>Warmly,</div><div>Aleksandar</div>

--000000000000cd89ed05a860c5c4--

