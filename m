Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741CCC433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41569205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/+ZYx8m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41569205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00xX-0005ke-DO
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <willreli@gmail.com>)
 id 1k00x1-0005KM-Hc
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:05:47 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:45225)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <willreli@gmail.com>)
 id 1k00wz-00051d-QO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:05:47 -0400
Received: by mail-ej1-x62c.google.com with SMTP id g7so8341881ejw.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 04:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=UZJjTg4osQS6Rvb2UzqflUqekKgYRlGzgmRinEALU1I=;
 b=j/+ZYx8m0LGAXFJPNzb2yhCp2k7z3tPKeImCXmk0iDNkYKT6Nmpg1LrvjqqGSmxkMh
 LG5w+BvhiKZIUZQC9FTUiGzFeORFblAFJi4owMxlEwmXXDQsU4s6aAezXsRyyYRbGWxU
 ToJYNcHOrLfPAFoLspPmWbT3EMX0ivAToVzpEJGRnyQy+ulb1ODRVJg4rQKHi5/r8G8z
 Ei9CVIRqZ9aMvRXIXJQ3VV/tWTPNWlSwQ+O1YwV0a4hmyCpuKLBh9fs9/zTd01AKYJDZ
 4xWqM2k7yqmResBSYKzSkM+MJilq6K2F8GXbvJP12xLEEJwrQyRsU8YtKBU06YLuPPgX
 EWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=UZJjTg4osQS6Rvb2UzqflUqekKgYRlGzgmRinEALU1I=;
 b=Ux4grdqfqqvLGnXNxyG0nBxmDYR+0YtW5PhEtD37PgAaxVLaYw5Ji3m2/1G2DADbnN
 2KmuWCn4kwkUHGGavjDRJBIePMljkgGs+voYr9WAnEGMZVOLv4MwfNKkh163FYT2Nhz7
 LQdMDqqtYc7lO919vjR5HnPKsxO4mU0K4dGdSgMxPEF3XHYVMp58+tL9T69IVSsPKcOa
 66un5wO+2oIPwMDZkvgP8EO+9WCz0YV65VkiuzkQg/D2KoDbdCHBVIoeY3mzO4OBDM6o
 R5QtdJ/f/VEWL+HnuhSdtqRQGaTV1CFty5DvIkTxzgPRRPrZZn7fOIxI2ZKjN9nTxKru
 ZlDw==
X-Gm-Message-State: AOAM533m4VQEKkhCkUQpqm52/Ts95c3Qf9GifpDkzS/E5WywBKONKEc9
 s/CzGabJJ7QIWoiE1Sl8BeJS6lOC21J+hyCnevULQfU1
X-Google-Smtp-Source: ABdhPJyFnig8tc5H3Ll8BniolXtG8pn0AeL+x3bsng5+z5UZYWp91HOcqml10qFfAbv95lIQzsM/9dYRBwBednVlid4=
X-Received: by 2002:a17:906:1b0a:: with SMTP id
 o10mr11955688ejg.463.1595847943553; 
 Mon, 27 Jul 2020 04:05:43 -0700 (PDT)
MIME-Version: 1.0
From: William Lima Reiznautt <willreli@gmail.com>
Date: Mon, 27 Jul 2020 08:05:32 -0300
Message-ID: <CAO4s5Y90ZTYLbt1M_JDOJx1wmOY43PEu+cFSw0SHY5BOEqk3pA@mail.gmail.com>
Subject: Live Migration (L2 network)
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ca888405ab6a4d9b"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=willreli@gmail.com; helo=mail-ej1-x62c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_40=-0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--000000000000ca888405ab6a4d9b
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I hope everything is well.

Sorry about that doubt in this channel.

I have a doubt about live migration interacting with layer 2 network, when
the live migration is running. How does the qemu signal the switch network
that the qemu instance changes port ? Because when the qemu migration to
another port switch, the switch has a time to understand that flow is
changed.

I saw the dump traffic in live migration and I noticed that one packet
(RARP). "This packet is created by qemu."

Does anyone know if there is documentation on this?

Thanks

- - -
William Lima Reiznautt
willreli@gmail.com
www.ic.unicamp.br/~william

--000000000000ca888405ab6a4d9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi folks,<div><br></div><div>I hope everything is well.</d=
iv><div><br></div><div>Sorry about that doubt in this channel.<br clear=3D"=
all"><div></div></div><div><br></div><div>I have a doubt about live migrati=
on interacting with layer 2 network, when the live migration is running. Ho=
w does the qemu signal the switch network that the qemu instance changes po=
rt ? Because when the qemu migration to another port switch, the switch has=
 a time to understand that flow is changed.=C2=A0<br><div><br></div><div>I =
saw the dump traffic in live migration and I noticed that one packet (RARP)=
. &quot;This packet is created by qemu.&quot;</div><div><br></div><div>Does=
 anyone know if there is documentation on this?</div></div><div><br></div><=
div>Thanks</div><div><br></div><div dir=3D"ltr" class=3D"gmail_signature" d=
ata-smartmail=3D"gmail_signature">- - - <br>William Lima Reiznautt<br><a hr=
ef=3D"mailto:willreli@gmail.com" target=3D"_blank">willreli@gmail.com</a><b=
r><a href=3D"https://www.ic.unicamp.br/~william" target=3D"_blank">www.ic.u=
nicamp.br/~william</a><br><br></div></div>

--000000000000ca888405ab6a4d9b--

