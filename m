Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 541C6206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 11:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtflTrt0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541C6206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOK5T-00019B-Fn
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 07:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOK4d-0000Ed-Lj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOK4c-00030j-Jg
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:49:51 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:43857)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOK4c-0002zd-BN
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 07:49:50 -0400
Received: by mail-ot1-x329.google.com with SMTP id g14so4223994otg.10
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d3zVjl9tywF+ASgkOfEjaLlahSalUXP0Ec+nQFXkbJ8=;
 b=QtflTrt0/0xZLRr1Rh5ldQ6kvZ8BQRRoRWQKQmjZ5N/mTUA0RyzGAWx8wLkh9dcR2s
 901RnyLrpzEq2jKrBNaz/M77SjggY88TVjb/lzUFQIUDnoQl9GYBzT2L5WCmmSL6sp/U
 fz6ksIwNB12grw3c3t+IJxgHWAUwTg4Og/xyutwJ/tSTR2WHaqhIyP7qdb4I3iyfJHHe
 oelZCwsjqfNAE19t5jgR+YVL0UxAWOoxVZA2YSgs32zuTZDwldjg/FmqrhlnD3d2rCy9
 gk4iWI8LXgZ1rMMR5M8F5qyDi5YMuprLYicCo1NAw+UjDQrVsXrcy9+bHUVAE2XHv4ZW
 keHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d3zVjl9tywF+ASgkOfEjaLlahSalUXP0Ec+nQFXkbJ8=;
 b=AGfHJInwRairnTltJmFvQ99Fg8YaGVrcwbwQVXyTG+FWoYTJlcbW4sDTmVolT1ELCK
 5tG3sB3REnq2BQ7ImyvtMTKSjjO7rJnSMhBeONKB/oI0cceaRMvPJ5glZJX6Xm9TTErB
 BhuseY5yUKPdrxKWhAXdz4gaUqZ24TxNPbVoJN3jeJzSJp3RLOPbnWfeyPIM9M5w/R8X
 6mVXKJgEc3t4v6KBiHU0BjNl/GOOl7CA5geP7pGyfBHNuJjpL14R0w3PmVv+L+hZ08cW
 4Z63AbYuO6II6JeObHyp7dnJP2NoC145hg20LenvKMnrr1dSG9LqAb1rw2YmcT5sMCXG
 Cf2A==
X-Gm-Message-State: AGi0PuYZ3nmapM9g1MiZyrlNJR5UIUIsVWAHfcm818uP8EponMPdyGiW
 g5KRXKgnKUrO0NutNOVB5iKU0xdZyIyExrHW9F4hcA==
X-Google-Smtp-Source: APiQypKKqPaCN7tn9v84cU2s9U4g/rVcJfhSg148YBIgzaC4FMe7TyeJcn54YMnxoEFToHzoW340sQz9+R7LdiNfkeg=
X-Received: by 2002:a9d:7349:: with SMTP id l9mr17393031otk.221.1586864989455; 
 Tue, 14 Apr 2020 04:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200414102427.7459-1-philmd@redhat.com>
 <CAFEAcA-PyMisjC25CSGyU5-ASjaAd7gQMabzMCR=uvudSBk-Fw@mail.gmail.com>
 <357e2335-b00f-cd28-4ade-d6286ace144f@redhat.com>
In-Reply-To: <357e2335-b00f-cd28-4ade-d6286ace144f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 12:49:38 +0100
Message-ID: <CAFEAcA8BgkqNQToJZy0=SOSxF2QWgxrP79Gj1qaVUm5xdvm65A@mail.gmail.com>
Subject: Re: [PATCH-for-5.0] gdbstub: Do not use memset() on GByteArray
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Apr 2020 at 12:05, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> > The other implementation option here would be
> >
> >       guint oldlen =3D array->len;
> >       g_byte_array_set_size(array, oldlen + len);
> >       memset(array->data + oldlen, 0, len);
>
> I thought about it but I'd rather not access GByteArray internals.

AIUI ->len and ->data are not internals -- they're
in the documentation as "public fields" and the code
example for GByteArray directly accesses ->data.
(Contrast GBytes, where there are no defined public
fields and instead there are functions g_bytes_get_data
and g_bytes_get_size.)

thanks
-- PMM

