Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDA1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25986206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxULtvSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25986206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtCv-0002Ka-24
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMsb3-0001Os-Ab
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:49:37 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMsb1-000768-Gn
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:49:36 -0400
Received: by mail-ed1-x541.google.com with SMTP id ay8so1160089edb.8
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 05:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=unU2vF4B9JIfCX9WkfipD+v6wjBgokVtk3hBtGM1alo=;
 b=GxULtvSwet1pzMY2Qagyva/xWIsxrZTg+d4twtYbt9vIWM01qF3puqeP4IOKBbq9bp
 05twcnJ2lLM2GoeBNK3MdT7+85U6d7WymvE1SCEOoYAbDyr9pChZXwZNxfVF/PJ3HrHV
 z73Rv8s5CxDOrbcynhh30fORqZdGfkSyaQjzwCXZatgfXGDGmz1EvtwmfA+JJ4T1j+Aj
 OUnRh1Z68O7FmQONLYbZPwYLhzUjfiScT8F5BEf8/cX3aSncTkFwWkaZVprDvgW5bVGD
 oF4uNYtJApKYAQhszYzP3nv4lFy9Elso9o4LgM97YM3tkRUtmK49bhfdnJPzTqxcOpmg
 79/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=unU2vF4B9JIfCX9WkfipD+v6wjBgokVtk3hBtGM1alo=;
 b=B3X9Vd1Fa5bSeUjOEPXfRAhGASScVgj6MdFQUTWl8jANBOBWf2Zs0H/HIm1hyUQXus
 HLxWnjq95Z1wcw9saaiNn0CoIrUw3h3TZR1y3AeQhe2JGh2285ZnJ8tL99aX55dOpjWz
 oj5xQELJio+H/HR35jcUC61mbMYP3MsuTtHHe3JJ88nUGGxHVH19CY7xAAy2c61BHvHk
 Rsn9xcfmWJ9dWJIScFPacdDYIMVHRQu9II3NNVEhJn0q7z6nvSwqmMWiuLUIBtBkgu0a
 qVbSVFw89XVjJfHscRJP0Lu8UmXVAzwNVEZUWTaO4cYrJCgGDZifLdlQhlQAjvGnl2yL
 bSqw==
X-Gm-Message-State: AOAM531wX1G/+sqsBvHO0LjlT41+4vh3cJhl5pXtxATa+oPDXTAJpqtt
 PrGAX2aEBaP4MRGIN+9qzQMURUgZvtMmwGEwza9tNg==
X-Google-Smtp-Source: ABdhPJysDZf4+DS7RUi4NhDNKvHOq/NHmFsbeAUxG7b5rMzcE0g/1lo2JHCuzf5Anpd9c+P2UYJfsEv2XFZuTJXSWOo=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr1490454edw.251.1601297373400; 
 Mon, 28 Sep 2020 05:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-3-peter.maydell@linaro.org>
 <87sgb2f4xz.fsf@dusky.pond.sub.org>
In-Reply-To: <87sgb2f4xz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 13:49:22 +0100
Message-ID: <CAFEAcA85d59WbSGko-1W6ck7K3C5RB4avP6_Wte9YAUrgsqs-Q@mail.gmail.com>
Subject: Re: [PATCH v6 02/21] qapi/block.json: Add newline after "Example:"
 for block-latency-histogram-set
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 13:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > The block-latency-histogram-set command is the only one which uses
> > the Example/Examples section with the first line of the documentation
> > immediately following the ':'. Bring it into line with the rest.
> >
> > This allows us to avoid special-casing the indentation handling for
> > "Examples" sections; instead for Examples as for any other section
> > header these two indentations will be equivalent:
>
> I figure you're talking about PATCH 5 here.  Correct?
>
> If yes, I'd like to tweak this to "This will allow us".  Okay?

Sure. (In my idiolect both those phrasings have pretty much
identical meaning in this context.)

thanks
-- PMM

