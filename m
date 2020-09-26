Return-Path: <SRS0=cZnO=DD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0056C2D0A8
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:18:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D0320789
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Sep 2020 17:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcOVQ9wY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D0320789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMDqD-0006pO-J1
	for qemu-devel@archiver.kernel.org; Sat, 26 Sep 2020 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <awik32@gmail.com>) id 1kMDpf-0006P1-Q7
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:17:59 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:42370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <awik32@gmail.com>) id 1kMDpe-0005zu-7T
 for qemu-devel@nongnu.org; Sat, 26 Sep 2020 13:17:59 -0400
Received: by mail-lf1-x135.google.com with SMTP id b12so6339285lfp.9
 for <qemu-devel@nongnu.org>; Sat, 26 Sep 2020 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=kQ+uvVOfWp2Lbz0B8a3IW9GsgTdn/cr3rjowRpK8fKI=;
 b=WcOVQ9wYnyvWTLm4eEGB02OKBGAr4FQfaeCvnOGjQIi5owHdL9bs8GNa0GFHeCjTw4
 Je9gk7JOXL34gNIkGNSlXkzj5nQdDGvur2GVtOHxr+X4nPTcICdXBzR50jSd+WqHusM1
 6SPHo2IRIYdMlY3hBh3R0BLYR5kZ+vRls3MgBYbRBoi15obU4WrHowapffyaLynkjVOj
 T7CfH6jBbv/KVLVTurvien7E/XLmak8+VONlenZhIA49CC2eYy0D05iEf+2/I5nzngnx
 8QdI6eKiJZBaDQTryfOeTB6z1ceZIFVGbC0zKLbkxRCQjfSRMtKuqgHC4/Ce2AWPJwd+
 h4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=kQ+uvVOfWp2Lbz0B8a3IW9GsgTdn/cr3rjowRpK8fKI=;
 b=a53F9WaA4BHdz5xEkyoOouaCWN2eZ6wkUcK+vWY5W/OU5ubKD90hg2kxUltVViKq06
 4+riEN1m2PPldiRCgTcZYKRNBZgQFQd/hPsocbSz0fOxhNW0XT/mXxgdX8xraB1RsQl5
 xl/W2AF74k1rwSccVJ9wvB7CcncUXYIj6miUvLSLpZCXRmljhWV3eXp4Q0cjlXb7ZIvI
 txfc/bBWGnBhQGNOp3AcDdOsfHVsDocS1xb6xEBCru5F2iLRKAGcYDa7K69nAmhD6xKA
 oDJGgjo/HnMWFi99pf1RZdj3q3bfcWOMbXL1WgbOidFQfGvSLMdSoleHGjYJKOYCGiuA
 pHaw==
X-Gm-Message-State: AOAM530eKQj6BpTSoN3BuTKVLraGVvKZ/fSE0M9ec0+tHU5Mtb9qC+Xj
 Udv/RF8umoQtaZ/frRAer9A3T7PVzjUpD1rxa0Hacepp
X-Google-Smtp-Source: ABdhPJx/552wFulnD4R+W9FZnr3D1yi7TTJOD5FzY3jD1bEgkgNBC0PegOUUxQAbMOjZg3AlNMrtia/9Z1CgnCq+h3k=
X-Received: by 2002:a19:8706:: with SMTP id j6mr1219567lfd.234.1601140675743; 
 Sat, 26 Sep 2020 10:17:55 -0700 (PDT)
MIME-Version: 1.0
From: "A. Wik" <awik32@gmail.com>
Date: Sat, 26 Sep 2020 17:17:44 +0000
Message-ID: <CALPW7mROcSCEr3mc+Eh8zYEBpNNq1dNk3wNsDh_eFxHog-fkPA@mail.gmail.com>
Subject: Vim editor strange keyboard behaviour
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000036969c05b03a9d53"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=awik32@gmail.com; helo=mail-lf1-x135.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000036969c05b03a9d53
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm running MS-DOS 7.10 in a QEMU virtual machine, and there is a problem
with the keyboard in the Vim editor.  The arrow keys jump over a line, as
if you had typed the key twice.  PgUp and PgDn are likewise affected.
Other applications are not affected, unless you shell out from Vim.

The QEMU version is 5.0.0, and I'm using the "-k sv" option, but I've tried
without it and it doesn't make a difference.

I don't get this keyboard behaviour in the exact same VM under VMware
Player.

Regards,
Albert Wik

--00000000000036969c05b03a9d53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">Hi all,</div><div class=3D"gmail_default" style=3D"font-fami=
ly:courier new,monospace"><br></div><div class=3D"gmail_default" style=3D"f=
ont-family:courier new,monospace">I&#39;m running MS-DOS 7.10 in a QEMU vir=
tual machine, and there is a problem with the keyboard in the Vim editor.=
=C2=A0 The arrow keys jump over a line, as if you had typed the key twice.=
=C2=A0 PgUp and PgDn are likewise affected.=C2=A0 Other applications are no=
t affected, unless you shell out from Vim.</div><div class=3D"gmail_default=
" style=3D"font-family:courier new,monospace"><br></div><div class=3D"gmail=
_default" style=3D"font-family:courier new,monospace">The QEMU version is 5=
.0.0, and I&#39;m using the &quot;-k sv&quot; option, but I&#39;ve tried wi=
thout it and it doesn&#39;t make a difference.</div><div class=3D"gmail_def=
ault" style=3D"font-family:courier new,monospace"><br></div><div class=3D"g=
mail_default" style=3D"font-family:courier new,monospace">I don&#39;t get t=
his keyboard behaviour in the exact same VM under VMware Player.</div><div =
class=3D"gmail_default" style=3D"font-family:courier new,monospace"><br></d=
iv><div class=3D"gmail_default" style=3D"font-family:courier new,monospace"=
>Regards,</div><div class=3D"gmail_default" style=3D"font-family:courier ne=
w,monospace">Albert Wik</div><div class=3D"gmail_default" style=3D"font-fam=
ily:courier new,monospace"><br></div></div>

--00000000000036969c05b03a9d53--

