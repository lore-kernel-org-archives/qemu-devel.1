Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7607EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D8420679
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubN/NZ7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D8420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfi33-00023k-Ic
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfi2U-0001ba-J3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:51:30 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:40146)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jfi2T-0006Gc-Tu
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:51:30 -0400
Received: by mail-ed1-x544.google.com with SMTP id p18so6906362eds.7
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0kaeZh4DmK96G1tPy/6tQUrQ8oYlrXXWFM9QoC9dvWI=;
 b=ubN/NZ7yhAOF9+PTYU/qIIeMBMACAFUPB7IjPjw+9Nqv3FxDnLti7Vy2cMVXsiwPo4
 t2EUeWMQCJ6LblFM6U3b0vaFWEtftvhWd9o8STQ8VEau/GH73zT57i8AGcj/qB8cjnWa
 JgYlbphgDh7BTJSILKDgE3ExbKqPCAKgUXZP02A7vQgm489rtpIC2Xo9aWjfDyIuPO49
 fj1uHlVtE7qp98+dj7xykkFnWHVnxQX0YdX/3OEMBQEG5ahYhwvvhDX0/K3I9kUtN6eP
 SPUmRRSkgAqwzmsDUwpMtjfW+a9IaYW5IPbQ+dKpjNDl5650P5mnEWKKF4pSJDPcRbZv
 NyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0kaeZh4DmK96G1tPy/6tQUrQ8oYlrXXWFM9QoC9dvWI=;
 b=KhfZJrfTsLe+Cx7m0rMq85HQQoIscU6QMhmT7k6i8UD5XTHoXf8AA4XjLYr4fRLOGM
 yqXxVqnJxGIWHybaFyO++sR9RPJbsmeQ5jqDS2hu5L5IfjaadfdpwzbS99cxdoN/vqgi
 VOFoBnSNCE2x/WkbSGxoyPWjRKNl+1jlh4wq5jSc0gcLkIrD6rYoF9Y/4EyAO/Yd4cMV
 pIIGAg5BzYb3rDd0/DTm7Te69DQxZUhagsb8tN1m5JcRDh9NDHSg9UFAD1a7iG3QEbR+
 A49xG2BogP6ao9iJ8k7JgqD+GB0jYax6MT3N1hKjL82D2PAd3yASQRxcJSJQ6dm6usbI
 CHHg==
X-Gm-Message-State: AOAM5304jIYg/0QobjiMwmsSmKRy+My4vQSpoLZQRH3vCX2iPpRGkYvB
 039W6+jwCsPCPCtuZPVO3oZTHteiwg6xzdDITOc=
X-Google-Smtp-Source: ABdhPJxc4Xh7d3wUVeH0vGsJ0MFCvSjOHj0Y6qwMuNMjKdSAzfwFXgeEvlmGd73p3iP/F1rcc4KTc+cCinMLpNR/n64=
X-Received: by 2002:aa7:d785:: with SMTP id s5mr6648671edq.17.1591008688614;
 Mon, 01 Jun 2020 03:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200601092057.10555-1-f4bug@amsat.org>
 <CAL1e-=ju88pJcXiK_KN1w5qbFR5MBNJqbGCo-ZtYnDmVo7O+ZQ@mail.gmail.com>
 <ee1b80b2-3d8c-4b73-1164-7beb4fa866d7@amsat.org>
 <CAL1e-=jqQ_GciNN3jjqV_u6MZMYRMWjwT_V6bUWYfaK6pGegkw@mail.gmail.com>
 <CAFEAcA8ZcGLafvUybVRmiYMH_5pKVsogFisBr-DYn3EqedNNVw@mail.gmail.com>
In-Reply-To: <CAFEAcA8ZcGLafvUybVRmiYMH_5pKVsogFisBr-DYn3EqedNNVw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 1 Jun 2020 12:51:17 +0200
Message-ID: <CAL1e-=iE+yCXyu3sjxo4CkOijnj-99ncA6v8O1gyqkHkErpctQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Volunteer for maintaining the Renesas
 hardware
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 1, 2020 at 12:48 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 1 Jun 2020 at 11:34, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> > You add the utter confusion to a clear thing.
> >
> > "Renesas" is not the same as "sh4". We had "sh4" as a target since
> > forever, and now you suddenly want to change "sh4 hardware" to
> > "Renesas hardware"??
>
> Hi Aleksandar; you seem to be being excessively combative in this
> thread -- can you tone it down, please?
>

Yes, of course, I can.

Thanks,
Aleksandar

> thanks
> -- PMM

