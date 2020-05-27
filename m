Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE0F2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW3F3Ydy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE0F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je36t-0004uF-Bb
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hoychris01@gmail.com>)
 id 1je36G-0004UU-R6
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:56:32 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b]:40410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hoychris01@gmail.com>)
 id 1je36F-0001PZ-86
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:56:32 -0400
Received: by mail-lj1-x22b.google.com with SMTP id z13so21001520ljn.7
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=A3ZP7dktoAf/Ss3upPYdDDeiFBdzevienUzcEUz6OZU=;
 b=tW3F3YdyiVb2NQ7AiGOcCbAZ/VT5Ps4vHM55GG+VLz83X9gYX6RfDBjUxaTjtZI+EH
 1DPnML3ABJRFmoH0iC33fNI+wGofzqnYnSUD6/Nf5w+AePfsEzZVErK3FA0I5esHQck3
 nfcdHgwDHskblcInEyxfCcG2iypW22LnOfL51zEPs/j695Hk2MVeoUV2kQQRzlYg/GRY
 Kjny6OCRtyGj3meiwPKpOS+qQ5lyViUbbp0thY4eyP9pe2KIReD/1zjKg9HHWLDSsdSj
 sZE8rL44/oyYuNCz9jKmWdXZ/HGalyAETuot0xnP5Po3tVLi4U/cOgASu81ZM7f/V1of
 BdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=A3ZP7dktoAf/Ss3upPYdDDeiFBdzevienUzcEUz6OZU=;
 b=MOLUIPpiW+WRRZ6DZkK+AFZR7FrssS1tXmon/7ZRo5t5OPV0p/RfYF2XrOZvwt9DWF
 0Ox2rRSCNNkfn1mzocaP5UtcobfcGRIseu0WyIljXKu1ug5k8KZGeR74+l3xtqSXx/Ct
 Rooa1d77OD6YgjhYo+O5DQz2b/9lGsHttKbpreSx59mTVUNcbh8chw5vX0vL/U+O7wdK
 Id5OIH8X727L0CRiku7yNLzN6OkcnR5O8w8FtCFLt6M2+a4KzRRWrXe6rCqYF1VmfGZn
 a6w6HtSaIJUkukuSzZ6Tx4kuFi0Y8VP0498MhhaaJOHcFuo1KgiH79e4lgfRRbhsUvqB
 onZQ==
X-Gm-Message-State: AOAM530rf9qObOZDxo5lAypiX2zMG3tHi8HWrIXhOu2iuoCFWqV62tZb
 yJG7AsoaIFYG2NuBwdYsAUwTpWA4xmF7PpBRgeCsqfV2
X-Google-Smtp-Source: ABdhPJyZO6s7xiZfyKZ2k3Akz9v4uCnHOO0+cPw32gx/Dfp66sOmrxcIW4kKymK0qBK/rJNhmouBo+VbjUQ5Xw6VjoA=
X-Received: by 2002:a2e:870b:: with SMTP id m11mr3506132lji.315.1590612988616; 
 Wed, 27 May 2020 13:56:28 -0700 (PDT)
MIME-Version: 1.0
From: Chris Hoy <hoychris01@gmail.com>
Date: Wed, 27 May 2020 12:52:42 -0700
Message-ID: <CADAnahmxeveTRvoN9TN3qgi+_gy5PpSCULy+Cp3Rzj0gaE-p7A@mail.gmail.com>
Subject: Fully operable build post
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002968c705a6a77276"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=hoychris01@gmail.com; helo=mail-lj1-x22b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002968c705a6a77276
Content-Type: text/plain; charset="UTF-8"

Hello all,

I am proud to see that I have my barebones implementation of qemu finally
working. After starting earlier this year, I have slowly made progress to
fully integrate my kernel hardware into a gpu-passthrough vm. I went
through many settings and templates from various sources and finally have
something that works for me for a start and would be really interested in
lining out my experiences. It is my observation that the documentation may
be a bit unevenly distributed on the official page as far as templates go
and so if I could help I would like to send my template through the
official forum. Any help or advice with this would be greatly appreciated.

Best Regards

--0000000000002968c705a6a77276
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,<div><br></div><div>I am proud to see that I hav=
e my barebones implementation of qemu finally working. After starting earli=
er this year, I have slowly made progress to fully integrate my kernel hard=
ware into a gpu-passthrough vm. I went through many settings and templates =
from various sources and finally have something that works for me for a sta=
rt and would be really interested in lining out my experiences. It is my ob=
servation that the documentation may be a bit unevenly distributed on the o=
fficial page as far as templates go and so if I could help I would like to =
send my template through the official forum. Any help or advice with this w=
ould be greatly appreciated.</div><div><br></div><div>Best Regards</div></d=
iv>

--0000000000002968c705a6a77276--

