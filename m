Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7BB20760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rcp6sIqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7BB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiE3W-0006sy-RP
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jiE2l-0006Sk-C3; Mon, 08 Jun 2020 05:26:11 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:40946)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jiE2k-0008Bn-Of; Mon, 08 Jun 2020 05:26:11 -0400
Received: by mail-pl1-x644.google.com with SMTP id t16so6425974plo.7;
 Mon, 08 Jun 2020 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/66CzN83XjT6UKheMQseDyISQ3oxqXewkdQNbT+2JuM=;
 b=Rcp6sIqV45tkkRXtsa1NQNnrvPISXYcsdoSa8MelQ22EWQIzun3WjSTit5YZMziWtj
 Rfp1ozb7kwwzj2dAV/5jt50Sehx45JpO87XtMs6NC28j+UeDCMIxmMkJwmifbHibgFOF
 XL136e6LbuT8xL7lvhFp6K/gg781VQ5x4OA7dLKYHEqT+fs71Ht7+0TRdkr7XI84H5No
 cwhBwTcKnntEGRO57mQcip7+OkrIn072ltEYOHS9SF5me0XmZBKvCtegU2ry+4rH/Itn
 lxIFE7LSzrGJqnSNeZK2pQTXpG66l9mj+Uf+hSPbJSGB0UsI2lryZd3I78kut83NWWrk
 kTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/66CzN83XjT6UKheMQseDyISQ3oxqXewkdQNbT+2JuM=;
 b=GHZfK22rTrzaLCf4R4Iw1fvbcNIxPTvCQDH4ySHcj6GTeW+bQpgYNU/dZ9echxfjIF
 QY/a/FChvSrgUWTJEw4DGlqtfjB9wB/gFddcU9GDlfWI4+J152s+CRa3LPEDaESSGV5C
 fGW86xVDGDrXR7VJMP77bTobkfvBFI6GmaINNpy2o0C2wL9jX075w8OQKKLYIOi+ugPC
 gF8632vCuvDOuQopO0M0hCoQkuHLhClArz/Lr0tBYzY/2ZuKGHAfS6wR6jF7oIYqGF4F
 F4+U/jlZbr8Ou/bmicnR09DxB8xGkrCkcfdhHp9pfnE7pDleaHGOSVr6VLsUdmYln0eK
 8eog==
X-Gm-Message-State: AOAM531g2M58HS9r3H7kYz0G/18xYBfu3kK10g/B1wGdOxkI1loHu1fr
 IjrcFR1+l6R/EFgMQ/v6CoSJRmRRAgfCqTMm1Y4=
X-Google-Smtp-Source: ABdhPJxPCMdxhzqCXOoZltxeiE2rn3B21lz+7h6n5hJOXWw2aXzN/ovKIR1g2ftTZAU4sn+uhQkOOwQ6PIv3au3Wmk0=
X-Received: by 2002:a17:90b:3755:: with SMTP id
 ne21mr3217865pjb.7.1591608368634; 
 Mon, 08 Jun 2020 02:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200608091508.19838-1-f4bug@amsat.org>
 <20200608091508.19838-2-f4bug@amsat.org>
In-Reply-To: <20200608091508.19838-2-f4bug@amsat.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 8 Jun 2020 02:25:57 -0700
Message-ID: <CAMo8BfKyP8YFqgfT1QfJJQO0rdYOMNjwpq5_OCJr1cMhmPhomQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/net/opencores_eth: Use definitions instead of
 magic values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 2:15 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> Use definitions from "hw/net/mii.h".
> This also helps when using git-grep.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/net/opencores_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

