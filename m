Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52085CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 11:00:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179CC20679
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 11:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas-edu.20150623.gappssmtp.com header.i=@utexas-edu.20150623.gappssmtp.com header.b="n0co72G1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179CC20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=utexas.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRDcX-0007Wy-5g
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 06:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinahbaum@utexas.edu>) id 1iRDbj-0006zA-N3
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinahbaum@utexas.edu>) id 1iRDbi-0001V1-Fc
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:59:43 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d]:40117)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dinahbaum@utexas.edu>)
 id 1iRDbi-0001UO-43
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:59:42 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id v10so9186182vsc.7
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas-edu.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=4ZVriADTH/tPl5QSQ0fNrhgVEITWAArOMlLU9/wknbg=;
 b=n0co72G1UAMEOFxjQhUzRWekydCSAeTbevblN7aOSga/8M9qsme3sIqAm8KX+fkGBg
 K98QoTEi+le4+31WtyEtNRsYqjisrNENazkPNP/YnhazwaiYSzJsQsfl1tnCOTyGA+br
 PHY1yF3MGxgrUkxD9CDWybdq31CIB2DeYlYeaaCvdq8c7CSqUfJzIK1clfJ/Rq0Surcq
 8iVRbNCkStkrlgytnw9Lyh3bKT8g03xasakqOHur7pRtGJRl+SUPM6JWGhUIV3DSNNBg
 8mxFpeAnVm0jLQHtDNtJIZzReNzKgcuKfYpKdFebzuhGEbg/xYx4nPJ0ReKQU/wn8Lpd
 Br3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=4ZVriADTH/tPl5QSQ0fNrhgVEITWAArOMlLU9/wknbg=;
 b=oPXu+QcqdzrowxjKjvA41lVQzYpvGi52ceZtOwOJ6MJX5z7hvvC88/PpJt5GDTxlr2
 S7Tueja1xjF1y35jcLErVCC/a4Uf08aBHI3g+LmvGfEuqEFH7PJms5K+fwcXwTNOoSvo
 vhC+Jic/IxKQayYOXScIdQrDlV+y8/LaKX14RPOEYh1/uUQ7nmO8YLVB06snIIoeSJ3x
 TiqDtLEuZCjB73/IKYmu6tD0WKf/LFv5c98/uwnnyGSHRTazRQR713g5nSpZmFKdUvJn
 HOOgyEcI0rFt+yML6hSEWATU/jN1pPxPwtgjcbRiP4wnn3TesarAWayrKHA4qTkMqOai
 q95Q==
X-Gm-Message-State: APjAAAXUPczAUnVJcRAhIaedG8SwJ2X5wXBaD1lVa5gLiB5pyqpzGoOB
 3gJEegG/UsPRGEukx6L9qzbljfvFL+gYyxGi3QtZFznq
X-Google-Smtp-Source: APXvYqywg1Ie9MVssXEjHSYhtngPN1UcWPEleuR6+7HV8eCJiboX8kV6r+iEkkyT8W11sUnd/kEsSUzEQSfsXDZudz8=
X-Received: by 2002:a05:6102:21a6:: with SMTP id
 i6mr7119704vsb.120.1572778779453; 
 Sun, 03 Nov 2019 02:59:39 -0800 (PST)
MIME-Version: 1.0
From: Dinah A Baum <dinahbaum@utexas.edu>
Date: Sun, 3 Nov 2019 04:59:31 -0600
Message-ID: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
Subject: Feature Recommendations?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000075c49205966f1899"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e2d
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

--00000000000075c49205966f1899
Content-Type: text/plain; charset="UTF-8"

Hello all,

I am a university student whose Virtualization course has tasked me with
contributing to an open source, virtualization related project. I have a
little more than a month to complete this. I was wondering if you could
recommend a feature you'd like added that could be done in this time frame.

-Thanks,
Dinah

--00000000000075c49205966f1899
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>I am a university student wh=
ose Virtualization course has tasked me with contributing to an open source=
, virtualization related project. I have a little more than a month to comp=
lete this. I was wondering if you could recommend a feature you&#39;d like =
added that could be done in this time frame.</div><div><div><br></div><div>=
-Thanks,</div><div>Dinah</div></div></div>

--00000000000075c49205966f1899--

