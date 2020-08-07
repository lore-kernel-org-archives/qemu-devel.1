Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25F3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD9F21744
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 15:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPvLP6/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD9F21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k44H0-00082W-R1
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 11:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k44GS-0007c8-0D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:26:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43156)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k44GQ-0003Do-80
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 11:26:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id l84so2219082oig.10
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mopgShN0psZ5p4wf0vIOjmqoTIaS1rPkDoO0EuymYPs=;
 b=MPvLP6/c3u9WLTo8xnzvt4pShSy5ZlhNRJeFiv5/VDMD9OQyNXA0uaAyOw+KFud9+t
 ywIAfhsijr0YBeYCyukS2w//0UkxuBZ9tef35BwgDuAe0Z1O01Vkr03z0KDsaRaGn9hF
 O+i0TLJFvIvXE7Wt5+cI8atMUoOEai0ZajjqTXvHrbJc7hje361LKqXRtfRQSnCvYVxh
 GroRGCOI9JXmBc/impmtE9SkrMfLkj3U+IkMkpdBTuX+d8P8m6gpCPahNFJXyWEeWYFP
 /9BmtBL8pVWEzfk1R6wxHe58bIXjmZam81gxICdaOr2TAYpSgB/FBD8tY1GWxT1g0o4k
 Tlbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mopgShN0psZ5p4wf0vIOjmqoTIaS1rPkDoO0EuymYPs=;
 b=QdzbKRUDTHXlW4dW6PA6bS7pK7Er5r5Prx0D5Mw7K1g4/jnkpjmD/WMwHwrVcNz+mk
 bayHI/bbI1CR9ZjUpfhQLAipDWXLJ97M7iPyWwGZG0NEOHUdPbVVYng/h4OX0EuGoOqk
 FH0Q14/bfOuiqa2r5C4mOjNXr7DHeHROAEx8ca3ENNC9Lxyq6oyfOzpRA1Ct3vWlzVbn
 8ekrF14Wr3/pf9CUj8VEWc8oxKEIIoLD4u5m8BehCx7JUZjwTU5/v6HGIwltVNX63BqA
 yPnpm1aubsoKIACsLl3IMR8r21IY46sTNbU/q9FIenDaEDaTzAAv8soqu3RxhujTxDZb
 bCWg==
X-Gm-Message-State: AOAM531qPdJBihUXY4YtjqNmxKGX+mMlLUeLBwt70RvFsNAgxkBjciTI
 cvynpHldNpyR9xTurzDuD0OTiXQ0ASaN5PIAP90gzQ==
X-Google-Smtp-Source: ABdhPJwKGKypzmFBnAeS/vPkWcacCQTWFjh4pqfr2IC5i83Ds5rCwQhJLrIZexGE27XWD1tEXna5Pi92HSS49G14B8c=
X-Received: by 2002:aca:50c4:: with SMTP id
 e187mr11214061oib.146.1596813992684; 
 Fri, 07 Aug 2020 08:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <87364y28jp.fsf@dusky.pond.sub.org>
 <9d7b7f59-ec3e-1f74-d1d4-359e3388f0f8@redhat.com>
 <87ft8yd0ht.fsf@dusky.pond.sub.org>
 <CAFEAcA8-qAh9RzAZNqFS9HphAEDuCVVGzZO7vKem-1WCJogyjw@mail.gmail.com>
 <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
In-Reply-To: <f8cb36ff-a98a-9147-1c31-6f6394a4ec77@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Aug 2020 16:26:21 +0100
Message-ID: <CAFEAcA9U80eDOoRV9GkXdqSyg5CpWw2TWQk=DXXF3GXj2XOzNA@mail.gmail.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 at 16:14, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> One important difference between Make and Meson is that Meson is by
> design limited in what it can do.  The idea (which I think has served
> them well) is that they want projects to show what they need and work
> with them on how to build it.  So:
>
> - with Make you can do everything, it just becomes harder and harder;
>
> - with Meson you cannot do everything, plus you're using software that
> is opinionated and conservative in some respects with respect to its
> design decisions.  In exchange: 1) you can always propose to add
> features to the upstream project like Marc-Andr=C3=A9 and I did; 2) you d=
on't
> have to worry about the minute details of everything.

Yeah, this is what I don't like. I don't think this philosophy
of tool design is one that works well for us as a large
project that prefers to rely on the distro packaged versions
of our dependencies and build tools. It would be different
if the ecosystem we're in was one where it was really natural
to declare versioned dependencies on particular packages or
tools and have them automatically pulled in as necessary, perhaps.

For instance, I was just glancing through the Meson FAQ,
and "tell the compiler not to use RTTI for C++" is apparently
something that needed a change to Meson to support, which seems
ridiculous. This really feels like we're going to find ourselves
in the future boxed into "we're using Meson, but we also need
to do X, and Meson's opinion is 'nobody would want X', so we're
stuck". This initial attempt at conversion already got stalled
for a long time AFAIK because it took a long time to get a
feature we wanted into Meson and then for Meson to do a
release with the change in it. That seems like a bad sign to me.

thanks
-- PMM

