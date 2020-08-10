Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58939C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234FC207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WV8vtepM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234FC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dbs-0008U3-De
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dax-0007Nb-W7
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:36:32 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Dau-0003LI-JG
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:36:31 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so8218258ota.10
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jmC66cK42rMzcywVB2Tc8qaAa9WskxglF9ck2bz72Ls=;
 b=WV8vtepMejB5dT/q+rkS35Hp1WNpTqgWmIHlGduC76NAVF9hmIQnIiUXuKJbdsDCOb
 BwrHAjJNUaPaHqekbzaPFn6irW0QqvS2ZJUJOtkDXGLA+g5lbIOe6H0aHCYGJP+joVae
 t0SPqf1pu/B+yA7VOUzQt8O996EI6mhbZi55+WW8RfHaLSJNWS4HGeutOuQPAHjSuLNx
 bCeBnho0QZAfu3AbJq7r4ym3R6vvOM5d1XwCI9ujMywzKnJf2Kv+0wNiH2IcnbYoTvbX
 uhih5wTyLcKYp1g6lxgpttL9u7jdQm+0PRtS5aK/2nI05IS8ezF+colcpX9X5+QsGRZn
 gViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jmC66cK42rMzcywVB2Tc8qaAa9WskxglF9ck2bz72Ls=;
 b=qH+agGAFF3c0F+CLgaqIcOdouKn9+/+br2xvA5sQghJASmhtKB5voYat21kpQB+bAx
 fDSX4N8aY3iWiyfVX+yOTiJcB2pWOUHug98mRVUO0NVr05uWysdDJeeaLYuyjuBRtI9b
 TGV9bu7NiPxGQBzBjFf8ES6cQuOzyisJuEKOJPIpJWFi8UDNhrkDZ8Hx47GtDt5sgPyq
 wQy9Ounloi9W7bdKxa89IochwyyqSx1cu5xDLSQoHSlEiK/WKyPkaq0d4hJIVTCDjKEs
 z6kI57AWGxE9tsoKergycza4Ifs94Xze2XQP4MVO68a7eMsrl8UminsKFx0jd5jTveeC
 WK2w==
X-Gm-Message-State: AOAM531NFLaUvLslnbfbVg0CfzCju3nJOUxX1rJcjR9JCHr9qi21/CON
 sFVx+WNxHHcAj70q6yAyz4KvWvs+/UBkJAnShj1XyQ==
X-Google-Smtp-Source: ABdhPJzMZkpMhWcCPXkqqShxQ1rKekHgqFa9hWCVT6iQpmYmpzbTVI+S2yf2bydF4BXOn8hmPIEbmJatvonfS2BBIrc=
X-Received: by 2002:a05:6830:1305:: with SMTP id
 p5mr2083273otq.135.1597088186726; 
 Mon, 10 Aug 2020 12:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <1597079345-42801-136-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8J3-Sb4r4CqmLE=cmZHL311_B4EZD7L5+N-OhHD+X9jg@mail.gmail.com>
 <0c4c75a6-0165-6549-6d3d-24c3f3f7d180@redhat.com>
 <CAFEAcA8o6PvVMhxS5VPmqMiXEjCdFf194-LAOqrMm4VhaOAV6w@mail.gmail.com>
 <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
In-Reply-To: <85e3b495-9855-dc16-986a-1042de99237c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:36:15 +0100
Message-ID: <CAFEAcA8Azxzyjwg8YG2ALmEkXGrm0csFYPzJRdzYMkdHag+01w@mail.gmail.com>
Subject: Re: [PATCH 135/147] meson: sphinx-build
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 20:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 21:21, Peter Maydell wrote:
> >> Yes, because the Makefile's approach is not maintainable in my opinion;
> >> *.rst.inc files were already not included in the Makefile.  I'll look
> >> into using a Sphinx extension to produce a dependency file.
> >
> > Yeah, agreed that the makefile approach isn't great. (It lists
> > some .rst.inc files but we added more without updating the
> > dependencies, I think.)
> >
> > If Sphinx can be persuaded to output a dependency file that
> > would certainly be the nicest approach; I hadn't thought
> > of trying that.
>
> It should be possible and probably not too hard once I figure out how
> Sphinx events work.  It's a fair request since build_always_stale is
> inferior and Meson requires no particular magic to include the depfile.
>  Maybe that will win you over. :)
>
> I can also leave out sphinx from the initial conversion.

If we have a working-but-build-always conversion for Sphinx
I'd be happy to take that and then upgrade it to processing
the dependencies properly later.

(The thing I'm not really looking forward to is updating
the qapi-doc-to-rst patchset to Meson...)

thanks
-- PMM

