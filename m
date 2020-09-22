Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3198C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21CF72399A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 12:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ohw8RBon"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21CF72399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKhtO-0004f9-0k
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 08:59:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKhsU-0003n4-Mv
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:58:38 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKhsS-0003vh-K8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 08:58:38 -0400
Received: by mail-ej1-x643.google.com with SMTP id gr14so22782931ejb.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N5Z73QvtiNAUArAvX+uxmifGae2fI1/AqJ7D0KhemjE=;
 b=Ohw8RBonCrsudP34g/KmbVl8rjaoYIm/uZAE/rKvBt4RGUhuQ7aHLwqL7KV8sM+VrK
 fX9A70ck6Bvi3wvFW8RqNjAfU/RzNUjxMvEtzabzuLo7VtvdP/fdxwgv7MUFkCGOll/+
 2zNzglFq9v7bYdIebUXpbUdpFeS5d04pCkbR+yNfWCg2xATJ3StN0+aDwDoipTibgjCA
 Zojixq2sF2iPTqZyu4blGkwvCoAScqPJ59Gpg9xRhEopHFUqiM/kpD4cgvUzr1ui8Kbl
 NoZ+9cl8yYyTkBZzJjrjCi007/+gyhDPSSz1FG5CSqzeJ46pdn5UXZlXQDF70FBnAJYF
 PN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N5Z73QvtiNAUArAvX+uxmifGae2fI1/AqJ7D0KhemjE=;
 b=iroDEYR04bXP2ASNuVHzp2Ha1lDZjIzHO8DzVoIDVKuKm3cpRkWR3xi1cVCNZNh/42
 98aLwUod0BulPJN+UsXxzzUrZioZ9fJNvSxCq35hbn/wvSD7WE5QZfbGbuRSnObMbkh0
 7yzRFdtzHVz2nneiayGGxWUMgK7B4AubMNmVJlVSMunveXcSBx8YRtXHfBpsrewHqscO
 r5DLneMXw1ZqzkMtXiCJNhQ7sdlXwZTTA+n+U6URdsCv3GxxJHklLR628oEkuLYcQHui
 7zzQcU8z4X7vmF3Pqde+aTMYCrG8pQe6fio9QI0AfCe/izYE8DOEBU7riTNgL93h4uO8
 OW7g==
X-Gm-Message-State: AOAM5332B9Salho3NvXr0amft1RDI3uMXz8N7NT2Yb/ITrVf2MU/KEy2
 RVSwJG2o3bITG6qszj3ugXuF9RROq0IwT5o/r7Hr1Q==
X-Google-Smtp-Source: ABdhPJxMtwfLAIAUBoCH6LbyrsFfKp2M4m6Sa7MuQbaJ5F4Ol3uzrFjjJtUoPwX1jIMi+W+aVQr+eqabsR4CMnIcweQ=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr4694565ejk.250.1600779514951; 
 Tue, 22 Sep 2020 05:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
 <87wo0mqavm.fsf@dusky.pond.sub.org>
In-Reply-To: <87wo0mqavm.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Sep 2020 13:58:22 +0100
Message-ID: <CAFEAcA8uYhrpsYM5u+0MJKOK3R_NwPefC1jdJMYF3VWohe4mfA@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 at 13:01, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > The Sphinx interop manual has the usual footer:
> > https://www.qemu.org/docs/master/interop/index.html
> > "=C2=A92020, The QEMU Project Developers."
> >
> > The system manual has an explicit "License" section:
> > https://www.qemu.org/docs/master/system/license.html
> > but that's documenting the license of the program, not the
> > manual (it's docs/system/license.rst).
> >
> > We could do any or all of:
> >  * decide that we're happy with the current situation
> >  * expand the "copyright" footer to something like
> >    '=C2=A92020, The QEMU Project Developers; this manual is GPLv2'
> >  * have a docs/foo/license.rst for each manual, and expand
> >    it to mention the documentation license as well as the
> >    code license
> >
> > Given that the Texinfo generated QMP/QGA references don't
> > actually present this text to the reader, my inclination
> > is to say that this is something we should address in
> > a separate patchseries, not as part of this conversion.
>
> I think the manual should have a proper copyright notice.

It does -- that's the standard Sphinx footer that reads
"=C2=A92020, The QEMU Project Developers." What it's missing
is more precise licensing information.

> If you'd prefer to (re-)add it later, stick in TODO comment.

Where would you want a TODO to be ?

thanks
-- PMM

