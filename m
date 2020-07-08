Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D2C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7015B206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxpXw8mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7015B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDQ6-0003J1-Lg
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtDPR-0002cx-6I
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:59:01 -0400
Received: from mail-vs1-xe43.google.com ([2607:f8b0:4864:20::e43]:43445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jtDPO-0001mS-MJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:59:00 -0400
Received: by mail-vs1-xe43.google.com with SMTP id j186so2884550vsd.10
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KHjhQ90X9ZZ9sieM2RIg9LZWiZLzKRSkK8gH6rPV1Hk=;
 b=pxpXw8mMxWEsL4aHJUxaN+8qxt1xc6rfJh0z9xz8dGAi5iku2zbFG1shnSUR73693H
 jFAaqu5OJzj2By0G7dHbHXKx/7xBo2DolSKRCPi6qwonyEM8Yir7kW6dAzEfiXTj5CH0
 l0lVCkhEqt19aSxPy6ooUHlcsPS6MbQAhKyXtmy2qOlDaq9VvroxDsXfZ/WSWMNs1MzX
 Jw5SLSzRFZikrUJPL7OJBH0uxmUUguwbkN3g6376eM+l6b+kINDORFQxhSk+DnA+l+iI
 buxxgBdW/hZrucyQnD81eCdc1sXMECKwPV1IsyHFj3dSgYgRHTZAk/pzXe3BWvVVd63S
 WnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KHjhQ90X9ZZ9sieM2RIg9LZWiZLzKRSkK8gH6rPV1Hk=;
 b=bkBSL25yVx28cafG+8FXnCzXOJ5rnYQZVbBFYsawHQyVciw7CP5GmichNg4bAoy51E
 0EVVINxA1OU+7y5jxvAFP3/1byg6FPy3CELrtUGetyIiyAZumUwKYDd8SoB2pgv8xy1h
 t1Uqy1bnY/sHotqX4/N0NFCOPuBWNfcHKh/JIxi92qYmbBPF/JvVpHzf7cz9h6QEKKIx
 lVNEy3cKFN45OcxfNed6Fd+Rip4KlhiyrY5jk2fzCbGH7DMIQx1YnEv3xqNMSUY/srLA
 akfH7jv6v7YdHQtnzHecVN126GAoPfW/xzoI4HrY913Hb61UW29yv76CqF7RDBuZ+4v2
 q8ww==
X-Gm-Message-State: AOAM532X7eVYw5bJdZ5jEn336SvHt2dCML0kbgKfMcwokrAnhViLmZid
 3EwDdLA6vAYIMnuyHaV+Gm81OvzVQKZtZ1jr6Nik7g==
X-Google-Smtp-Source: ABdhPJwAGcsnNR5nCl+vqWnToSl4zh6haGb40a/UFGaWxzKyCZ7W1zGXpdAdyudCuh291MyamolsqZ1WxOTJeAhLCYE=
X-Received: by 2002:a67:2f55:: with SMTP id v82mr45814448vsv.207.1594227536275; 
 Wed, 08 Jul 2020 09:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200707184730.3047754-1-hskinnemoen@google.com>
 <20200707184730.3047754-2-hskinnemoen@google.com>
 <9b824a33-13d4-445d-4986-0c5a135c4bb8@amsat.org>
In-Reply-To: <9b824a33-13d4-445d-4986-0c5a135c4bb8@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Wed, 8 Jul 2020 09:58:44 -0700
Message-ID: <CAFQmdRbbDf9bSpO9djfOhXhFUjr4HwxAm=q-n44D1ATb4V=iDg@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] npcm7xx: Add config symbol
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e43;
 envelope-from=hskinnemoen@google.com; helo=mail-vs1-xe43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 8, 2020 at 9:56 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
> > +config NPCM7XX
> > +    bool
> > +    select A9MPCORE
> > +    select ARM_GIC
> > +    select PL310  # cache controller
> > +    select SERIAL
> > +    select UNIMP
>
> And this in patch 5: "Add NPCM730 and NPCM750 SoC models"

Is it still OK for earlier patches to use $(CONFIG_NPCM7XX) in Makefiles?

