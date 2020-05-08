Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460D0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A8C92083B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8C92083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX8Az-0006Yz-8J
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX89x-0005sZ-3G; Fri, 08 May 2020 14:55:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jX89w-0006ri-6C; Fri, 08 May 2020 14:55:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id r16so2110861edw.5;
 Fri, 08 May 2020 11:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=rqoYWcF11oeon9xa62Wgu6Y/ipqAYiXqYY2Y9ezED1Y=;
 b=Wfq1qHLT0tUrAX4PnwCbaV40YSphvjdm4TwC3hXLuqBYuNU7thoyaApN3DglPWis68
 1NB7sG3icvWyb/KHcPtGcg1tlmGP/lOILFqfxzRoDOQ/lgViEMQbi8INZI8hnVmp34GS
 BGKO7QKJ8U8rJ+alWQbn9CsDbRnTT2cAvoa4O7fQ4Xy83v46L1hrSGwBCiVKVcT6d/7b
 J6tnWddKdPsfdMpHbqsVlaxNxUoP/BDw5WgwoftUXnlHGkR1MppsWXi6H15pRu+rVq8o
 +kfnI9r1FyU3opfR8KwIbE+0ii/c7MFWd4E4jzuruTzqzMSU+pSZ5nNcv7wUK4BG6++t
 lhQA==
X-Gm-Message-State: AGi0PuYwnm/RJrvmkfOukjWky/oxsDvR9JWAYkrCwj/E82l2fM+oOhtF
 BQho2w1LBrZq3vUNWdF+YNBKW8OqqIP35paclj0=
X-Google-Smtp-Source: APiQypL6uhnwaTLOk+AVd/CGE4fOpYsNZISTewzxu88FE85unGydu7X6mwxnfxs1ZFQ7pMs23cWZIpzsUQ5xT5JX+ps=
X-Received: by 2002:aa7:d60a:: with SMTP id c10mr3569020edr.66.1588964141327; 
 Fri, 08 May 2020 11:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200504082003.16298-1-f4bug@amsat.org>
 <20200504082003.16298-3-f4bug@amsat.org>
 <59e5a700-e2fe-b053-3bbd-71c36134c116@linaro.org>
In-Reply-To: <59e5a700-e2fe-b053-3bbd-71c36134c116@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 8 May 2020 20:55:29 +0200
Message-ID: <CAAdtpL5e+yw7AaweRxZ69KVxyzyJXhXcvJMeKDX8pFXJEvsTsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/display/edid: Add missing 'qdev-properties.h'
 header
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.67;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-f67.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 14:55:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 4, 2020 at 8:38 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/4/20 1:20 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > To use the DEFINE_EDID_PROPERTIES() macro we need the
> > definitions from "hw/qdev-properties.h".
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  include/hw/display/edid.h | 1 +
> >  1 file changed, 1 insertion(+)
>
> Does this not currently build?  I'm not sure what you're fixing.

Because when trying to use this header once included, I get when building:

include/hw/display/edid.h:24:5: error: implicit declaration of
function =E2=80=98DEFINE_PROP_UINT32=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
   24 |     DEFINE_PROP_UINT32("xres", _state, _edid_info.prefx, 0),    \
      |     ^~~~~~~~~~~~~~~~~~

Then I've to grep for this macro and figure out I need to include
"hw/qdev-properties.h".
I am expecting a header providing a macro to also include the
pre-requisites, so I fixed in case someone else run into the same
problem.
Does it make sense? I can reword the patch description to better explain.

>
> r~
>

