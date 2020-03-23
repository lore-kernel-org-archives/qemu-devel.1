Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184A8C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF82920753
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 22:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPyEYCng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF82920753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGVBN-00088f-SO
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 18:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41150)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mansourweb@gmail.com>) id 1jGVAd-0007iu-T5
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mansourweb@gmail.com>) id 1jGVAc-000050-RO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:03:43 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:37931)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mansourweb@gmail.com>)
 id 1jGVAc-0008WB-HX
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 18:03:42 -0400
Received: by mail-lf1-x12b.google.com with SMTP id c5so6088003lfp.5
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=iTYrqTTpZwGkynOZXc/7kcL4LXpv4DFfmgYXXebSOo4=;
 b=iPyEYCngETY60SBOpfT8M5kFYQS5vhOoMcMnh0UzPWHx3UKpeGj+v3rhqhIOhazy7K
 OHJXqf3ZAwROzHTuEFN2YoqdYpoTtG3Il7SjYEecfU+NxiBib2R50VT/btfvuJXUgLID
 RulaF1jOn8v3YP0oN5xrMrfsuB3QGEcP/ymIQ0MCP+lEB677EudpSjw/uh4yYeiNNFBS
 F8LO62ogX20frx3YffDQHFef7ixkZ+sju2N6/BUg6BQzvQwbMZ0SUT+Kz8U8g6GAd/pT
 cbRcD31SkDA4A3Ah4lzFaI35BX3Q6pV+rSDDmE6rvauWX1qrWKx0Q4xZnFlRcvxKrQTq
 d8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iTYrqTTpZwGkynOZXc/7kcL4LXpv4DFfmgYXXebSOo4=;
 b=TBp+2+Efg99m9urHazUjxAaPfJpT/SuGtb/xv6gpReVfv2gLcNOUW9s5+i8s3MHQo2
 vQL98XVqSVp+RDn1LG3/Sy2lGqwkWKU7md0kegcdCOG103vn0+GQSVd+Dy1qdRn6n+nz
 yzCLxTo/NLuY2RTFhaAxvEHbIRzuF2cpRiM3E9qunyprMZJG5ZBFlZO22Rbn9mn5E2ON
 p0Dv9piXZs8ywYGr7USoIylSbaFos9s2SiGXqkCDJ3TKFv+jSU8RWLXbLlu1S3UrjAiJ
 FqQytRVFfYE2RKq6QMiKgtSmNW+ca26/de5hvQ3OTkzBw73ia8hK3a7ReibcygfUD4Kq
 SKaQ==
X-Gm-Message-State: ANhLgQ2136y9EiXvaE0rh9GPdrPkT9YnmdndCPlYwo1bP1taZJNmb1d0
 iCS4LEx5e4IKahqU6c/7/Xa3KIc28lSFt7wJku7idJAHYQM=
X-Google-Smtp-Source: ADFU+vu80OJeZqX+72p085Y6svZw5QPki2GCq0Puub/LiRN/gWcqSJNLtRFYy63Eah4XowIIx3BDwpBN7jgevPk5ROs=
X-Received: by 2002:a19:6445:: with SMTP id b5mr13946456lfj.187.1585001020046; 
 Mon, 23 Mar 2020 15:03:40 -0700 (PDT)
MIME-Version: 1.0
From: Mansour Ahmadi <ManSoSec@gmail.com>
Date: Mon, 23 Mar 2020 18:03:29 -0400
Message-ID: <CAGT9xrDKJQW6HV6OWDDck=H0bGzk=7ZTVn6tTfNnv=tH0sr1nA@mail.gmail.com>
Subject: Potential missing checks
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c4c3b705a18cce42"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12b
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

--000000000000c4c3b705a18cce42
Content-Type: text/plain; charset="UTF-8"

Hi QEMU developers,

I noticed the following two potential missing checks by static analysis and
detecting inconsistencies on the source code of QEMU. here is the result:

1)
Missing check on offset:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2728-L2733

While it is checked here:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L1748-L1752

2)
Missing check on bmds->dirty_bitmap:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L377-L378

While it is checked here:
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L363-L365

Thanks,
Mansour

--000000000000c4c3b705a18cce42
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:garamond=
,serif;font-size:large">Hi QEMU developers,</div><div class=3D"gmail_defaul=
t" style=3D"font-family:garamond,serif;font-size:large"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:large">I =
noticed the following two potential missing checks by static analysis and d=
etecting inconsistencies on the source code of QEMU. here is the result:</d=
iv><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-si=
ze:large"><br></div><div class=3D"gmail_default" style=3D"font-family:garam=
ond,serif;font-size:large">1)</div><div class=3D"gmail_default" style=3D"fo=
nt-family:garamond,serif;font-size:large">Missing check on offset:</div><di=
v class=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:lar=
ge"><a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f=
75f1b95bd4df76/disas/arm.c#L2728-L2733">https://github.com/qemu/qemu/blob/c=
532b954d96f96d361ca31308f75f1b95bd4df76/disas/arm.c#L2728-L2733</a><br></di=
v><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-siz=
e:large"><br></div><div class=3D"gmail_default" style=3D"font-family:garamo=
nd,serif;font-size:large">While it is checked here:</div><div class=3D"gmai=
l_default" style=3D"font-family:garamond,serif;font-size:large"><a href=3D"=
https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95bd4df76/=
disas/arm.c#L1748-L1752">https://github.com/qemu/qemu/blob/c532b954d96f96d3=
61ca31308f75f1b95bd4df76/disas/arm.c#L1748-L1752</a><br></div><div class=3D=
"gmail_default" style=3D"font-family:garamond,serif;font-size:large"><br></=
div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-s=
ize:large">2)</div><div class=3D"gmail_default" style=3D"font-family:garamo=
nd,serif;font-size:large">Missing check on bmds-&gt;dirty_bitmap:</div><div=
 class=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:larg=
e"><a href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f7=
5f1b95bd4df76/migration/block.c#L377-L378">https://github.com/qemu/qemu/blo=
b/c532b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L377-L378</a><=
br></div><div class=3D"gmail_default" style=3D"font-family:garamond,serif;f=
ont-size:large"><br></div><div class=3D"gmail_default" style=3D"font-family=
:garamond,serif;font-size:large">While it is checked here:</div><div class=
=3D"gmail_default" style=3D"font-family:garamond,serif;font-size:large"><a =
href=3D"https://github.com/qemu/qemu/blob/c532b954d96f96d361ca31308f75f1b95=
bd4df76/migration/block.c#L363-L365">https://github.com/qemu/qemu/blob/c532=
b954d96f96d361ca31308f75f1b95bd4df76/migration/block.c#L363-L365</a><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:garamond,serif;font-si=
ze:large"><br></div><div class=3D"gmail_default" style=3D"font-family:garam=
ond,serif;font-size:large">Thanks,</div><div class=3D"gmail_default" style=
=3D"font-family:garamond,serif;font-size:large">Mansour</div><div class=3D"=
gmail_default" style=3D"font-family:garamond,serif;font-size:large"><br></d=
iv></div>

--000000000000c4c3b705a18cce42--

