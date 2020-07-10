Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C11C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD7E2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZSJo6xzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD7E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jto7E-00052u-MC
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto6Z-0004Re-UQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:09:59 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:36719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jto6Y-0002eP-EP
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:09:59 -0400
Received: by mail-oi1-x22f.google.com with SMTP id h17so4145246oie.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HJeIKqh69VZhJUijKQU0waW5RlliDXLFOROv1dON+Sg=;
 b=ZSJo6xzlstnefKZyapQP62zjuY7QlDiAnM07qofvsp16sN2d0Omn0wCBVpCYacIHEy
 sYAvhDYxqgdYAGDW2MrZOwF7W4XBwhDRGHrbxwV+5A2i6AQKF69Kr752hrEj7RLcw1ee
 nQWKsctUgKg2V98TAmn2GME/oYrJMcaUvIqdQYqeaph4h1D+Jm+cXCSF3DefrUxD9CFx
 Ip/oj5PT+YHkpQ7zK0frZtOCb1epxl0R/pmR0FjxCWVGlT/SFm8dvyRz5pwY19/g54Ho
 FTG0PbRQTruJh1eDXZfurWpl17R7E9F9gL6Uttgf+ZeMqzyrhSeAMgq5dsR1Nxs0Mq8u
 o48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HJeIKqh69VZhJUijKQU0waW5RlliDXLFOROv1dON+Sg=;
 b=I+q/NVQO1kG5KE836geVDjFyRpZCmhyzEqCBcRbtyiCf9UQ1W2/frnctMKmEGIoMqG
 cprCL0AQqftFsgxvGDVD67FIgA08Axg3L/FtmPoo4X2i52kyQ3a4xvSNYfzL5CaInLwW
 qT0lFz3fYryiDmwaX69t05eRMqgFuC5ROVpxGK6NmjK12D+VpaPxfuc4dhNbvkXOD1EH
 3jw5XrKFXmd5Oo7fjwRRW4eKffs1tWgSkiuM1QNmqzepmYwr4766F1pqi1qwNlxzjhGX
 8a78vfQ0AFAhw78Mfbny49nfwfZp06Retd2+dbqI/0ewHWcKOkJx687lzjqJAhxstMDY
 P2WQ==
X-Gm-Message-State: AOAM531y8a3zT4GlL5nESDI7Q3/3m/ZZi0Ac/z+Z5BI92VOnO0ltem3L
 x0Pmf7UXvoDCQt8M4Yw26UrRlsD7Ng1mhkyv8vVh7A==
X-Google-Smtp-Source: ABdhPJzTbb1wDBNT8Q3gsO+WKfX+eb73Rq3C4GlaCTxsqEiaSzLs1uIZZaMx+721mam3K/YHfaKjokgMk0fOxYEWzMk=
X-Received: by 2002:aca:2819:: with SMTP id 25mr3115305oix.48.1594368597027;
 Fri, 10 Jul 2020 01:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
In-Reply-To: <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:09:45 +0100
Message-ID: <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
Subject: Re: Separate notifications from list messages?
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22f.google.com
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
Cc: Liviu Ionescu <ilg@livius.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 05:20, Thomas Huth <thuth@redhat.com> wrote:
>
> On 09/07/2020 20.14, Liviu Ionescu wrote:
> > Now, with the migration to GitLab under way, could you consider separating the notifications sent by GitLab from the messages exchanged on the list?
> >
> > I mean allowing those interested in receiving the notifications to explicitly subscribe to them, and no longer sending all of them to the full list.
>
> That's maybe a good idea. Stefan, Philippe, what do you think about
> creating a qemu-notify mailing list for notification e-mails?

What sort of notifications are we talking about here ?

thanks
-- PMM

