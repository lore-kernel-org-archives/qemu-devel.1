Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:01:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F502085B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y386RBUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F502085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqtDd-0002Lt-S6
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jqtCb-0001nu-8C; Thu, 02 Jul 2020 03:00:09 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hsp.cat7@gmail.com>)
 id 1jqtCZ-0007Vo-De; Thu, 02 Jul 2020 03:00:08 -0400
Received: by mail-oi1-x243.google.com with SMTP id t198so10285026oie.7;
 Thu, 02 Jul 2020 00:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6Nam8M205vGCTrGD6I1P4GjjUjCFVP/knAYaNpne5Ko=;
 b=Y386RBUbE/mcQ1XLmOBWPpfkfZLOZMWbtPifUIpruTJR5rySQ5yiesbMi6fxoFil23
 aDwV7/0+P1DNUNURVkWtX/+REA2RiiKC/WGOOmRbsfZyCX96nnnOgpdVqS7lP2iMMaKf
 jXE7OS5hbv66pi+ZoQwXU5dNbmcm+Q4wCkeEAssi169SdjNpXaeb3ULn8frcEg5m4Iy3
 pEucTM7/7l9aaow6Qvysh2ghSu00W5tWy7w9xfisPpC/gypetPG9w9IIRQubnbFfOxoq
 +FQRMIjF2NVqFFfjMsQeZ0J2ggSE31rvDwJiOQZ5Hkbv+YH3FK3rxn2Y8pCDaZ2XB8wM
 7Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6Nam8M205vGCTrGD6I1P4GjjUjCFVP/knAYaNpne5Ko=;
 b=V9AUVeM8GbtIsV/S3AdPEdGW27VhDjKULo8uB4A0hKA5ahs6fAey+fG8rTI2peH9Ju
 kBkbGS7jbCR1vqx2//j8InpbE2OPAduqfA6NopbfCLNwWE7/AZjcXnfsr2AtbvVldwlp
 6N6DYeywV9lyZXAx/lwJ7/W93hwJWBc6rjjcTybTkcQaoT6Y98Xfs4jMJtorraPCYm0H
 ip2+l6crObqMXWVr21tNmP9w8SaAx6wplUCy9XZjRLlugCTpPOumEgWgP3rEHUzcAFLl
 +PV85F2P7ROKShDmWbJSLArKPkoqIfWId4Jh1mm8gQxHZ76tKAb7TUJ1/rypC2oZa1lD
 cmqA==
X-Gm-Message-State: AOAM530DRjN8aFZRDIuB2pLoh/2zZAiZzqB56gkSTDZginraKN7oZ/vs
 jYJwe+5K1s3qZRI6DzHB3Kd/yHxebIgpdVN1hjY=
X-Google-Smtp-Source: ABdhPJwq5tAewaZAMa5pexNz64FjE7TBxhWJhqYXQnCq+s6yFNDcsumbffHtzRdRIyUk7r3272VVPfQdQvLKXdMYt7Y=
X-Received: by 2002:aca:4dcb:: with SMTP id a194mr23358409oib.59.1593673205389; 
 Thu, 02 Jul 2020 00:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593456926.git.balaton@eik.bme.hu>
 <5057ce7a-8e34-5b07-e93b-9cf8976fa3b2@ilande.co.uk>
In-Reply-To: <5057ce7a-8e34-5b07-e93b-9cf8976fa3b2@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 2 Jul 2020 08:59:54 +0200
Message-ID: <CABLmASGbMZGRTb30sVcsufyTKTbFX19=xFoXSJ+1jzt5h03dUA@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Mac Old World ROM experiment
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="0000000000004b9cb205a96ff50d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=hsp.cat7@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004b9cb205a96ff50d
Content-Type: text/plain; charset="UTF-8"

If you can sort out the issue with masking in patches 1 and 2 then I'd be
> happy to
> take patches 1-5. Obviously there is still some discussion around the i2c
> part, so I
> can wait a few more days to see what the outcome is there: the patches
> generally seem
> okay, the one change I would like to see is to add a comment around the
> SPD parts
> mentioning that these are only used by the real G3 ROM and not OpenBIOS.
>
> My only concern is whether an incomplete i2c implementation could cause
> OSs that
> currently boot to hang, so it is important that you can test a variety of
> OS images
> from MacOS to Linux and BSD to ensure that it doesn't cause any regression.
>
>
Hi, I tested this patch set both on top of current master and on top of
Mark' screamer branch.

On top of master with mac99 machine
MacOS:
HD boot: all 9.x and all 10.X boot to desktop
CD boot: all 9.x and all 10.X boot to installer
Linux:
HD boot: Fedora 12, Debian 4, Debian Squeeze
CD boot: Debian 10, Lubuntu-16.04 Live boots to desktop
Freebsd tested (Live CD only)
CD boot only: 12.1 boots to black screen (terminal shows: call-method
set-depth failed with error ffffffdf) 11.4 boots to root login.

On top of master with g3beige machine
MacOS:
HD boot: 10.0,10.1 boot to desktop
Linux:
HD boot: Fedora 12 boots to graphical login screen then hangs

On top of screamer branch with mac99 machine
MacOS:
HD boot: 9.0 and 9.1 often hang with audio extension error. 9.2 and all
10.X boot to desktop. Nothing new here.
CD boot: all 9.x and all 10.X boot to installer
Linux:
HD boot: Debian 4 boots to failing X server
CD boot: Lubuntu-16.04 boot to desktop

On top of screamer branch with g3beige machine:
MacOS:
HD boot: 10.0, 10.1 boot to desktop.
CD boot: 10.0 to 10.4 boot to installer
Linux:
HD boot: Fedora 12 boots to graphical login screen then hangs

All in all, I see no regressions.
The boing is beautiful when g3beige/screamer with increased buffer size
boots the G3 rom ;-)

Best,
Howard

--0000000000004b9cb205a96ff50d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
If you can sort out the issue with masking in patches 1 and 2 then I&#39;d =
be happy to<br>
take patches 1-5. Obviously there is still some discussion around the i2c p=
art, so I<br>
can wait a few more days to see what the outcome is there: the patches gene=
rally seem<br>
okay, the one change I would like to see is to add a comment around the SPD=
 parts<br>
mentioning that these are only used by the real G3 ROM and not OpenBIOS.<br=
>
<br>
My only concern is whether an incomplete i2c implementation could cause OSs=
 that<br>
currently boot to hang, so it is important that you can test a variety of O=
S images<br>
from MacOS to Linux and BSD to ensure that it doesn&#39;t cause any regress=
ion.<br>
<br></blockquote><div>=C2=A0</div><div>Hi, I tested this patch set both on =
top of current master and on top of Mark&#39; screamer branch.</div><div><b=
r></div><div>On top of master with mac99 machine<br></div><div>MacOS:<br></=
div><div>HD boot: all 9.x and all 10.X boot to desktop<br></div><div>CD boo=
t: all 9.x and all 10.X boot to installer<br></div><div>Linux:<br></div><di=
v>HD boot: Fedora 12, Debian 4, Debian Squeeze</div><div>CD boot: Debian 10=
, Lubuntu-16.04 Live boots to desktop<br></div><div>Freebsd tested (Live CD=
 only)<br></div><div>CD boot only: 12.1 boots to black screen (terminal sho=
ws: call-method set-depth failed with error ffffffdf) 11.4 boots to root lo=
gin.<br></div></div><div class=3D"gmail_quote"><br><div>On top of master wi=
th g3beige machine</div><div>MacOS:</div><div>HD boot: 10.0,10.1 boot to de=
sktop<br></div><div>Linux:</div><div>HD boot: Fedora 12 boots to graphical =
login screen then hangs</div><div><br></div><div>On top of screamer branch =
with mac99 machine<br></div><div>MacOS:<br></div><div>HD boot: 9.0 and 9.1 =
often hang with audio extension error. 9.2 and all 10.X boot to desktop. No=
thing new here.<br></div><div>CD boot: all 9.x and all 10.X boot to install=
er</div><div>Linux:<br></div><div>HD boot: Debian 4 boots to failing X serv=
er<br></div><div>CD boot: Lubuntu-16.04 boot to desktop<br></div><div><br><=
/div><div>On top of screamer branch with g3beige machine:</div><div>MacOS:<=
br></div><div>HD boot: 10.0, 10.1 boot to desktop.</div><div>CD boot: 10.0 =
to 10.4 boot to installer</div><div>Linux: <br></div><div>HD boot: Fedora 1=
2 boots to graphical login screen then hangs<br></div><div><br></div><div>A=
ll in all, I see no regressions.</div><div>The boing is beautiful when g3be=
ige/screamer with increased buffer size boots the G3 rom ;-) <br></div><div=
><br></div><div>Best,</div><div>Howard<br></div><div><br></div><div><br></d=
iv><div> <br></div></div></div>

--0000000000004b9cb205a96ff50d--

