Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9631BCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0E20663
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XhskgYdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE0E20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0LA-0006eW-Dd
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0EV-0002wJ-1x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO0ET-0000c9-O3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:06:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45845)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO0ET-0000bj-Ap
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:06:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id 41so2116268oti.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gJ/czhl8wcTGR+TDLiE7xOgw7ak8Anrg/+q15fXKPG4=;
 b=XhskgYdIzSF8HQ22mXBsBqJhPZCOmKSLuZaUwhwnhev/N9c6bSUHaIBTiTlaSUGQ+T
 FuxPNwXMgs8MxxBwlQRCjRGXpMPsynoWkJnv6BZkZ5ROxstgip/EXbBDfgJnw3cZFr0c
 eYq1WTOhcUdiDAwB9vrH6LDxBrJ5OSxqEkJhdqBWgrdSFea73F1HNKsibRmdIqi22y+G
 oO3n8PFOL1GJdzUBVMQ1VcdrywqQ6IzbaRNYQC4BZk4+wQpRwbV0lpU+MHABHkYGOToK
 TBgYpSO/p61ZMVZESI1sBwJx4kBoQAg+WxH5xs5ki/mXY76nBw4V2G/hzuiDs8r8Twi3
 kPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gJ/czhl8wcTGR+TDLiE7xOgw7ak8Anrg/+q15fXKPG4=;
 b=YVXlCFaWBggN1KxIDONbZMhfau6tcyjBHFBJ2zL50K8qIXjLEIk5BUjszmFdxSZrgv
 SZHxur2Vb8DOc/7NjL8JehU8gSGg8j3YWF+i5b7O42FvDQVWZ5eTtD42SwiIhxIwxE9n
 CdeUD+eKIGOpHEr0OUiS+268+Mv3Rnld93JgiEp73zPb3Jha0t92m7JzwwEhCyVvOpXQ
 R4rrl3gN3+mrFbJgzox73pFMdbV8H7G8b1OUqMOjTMKZtv4GnluxvguourlD3UZ70Y4u
 QzqJmxSHOdiFFxN90Y1HJxGJ0eUEWX2jnVZ6K0PT2a6i3IuYBJ/rg67CQRUJnErcu+rd
 nAsw==
X-Gm-Message-State: APjAAAUbwvzfonPJd42/T9UWmvOl4ODgy2GITc1KFhMTAhgnT0Z95qqW
 zE414GJW5e6t91spjluM4cyKo3Wn8Ozdb9HuEy6FwA==
X-Google-Smtp-Source: APXvYqwarya0gnCIlCeWY5d/v0i9HIHOu8TI5Kaag1GIkYJGEz/ntZEeWtH54Mbaxn+EPmlEzwDYCzumuOaob4yWvQo=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr3070845otg.91.1572012383418;
 Fri, 25 Oct 2019 07:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191024121808.9612-1-drjones@redhat.com>
 <CAFEAcA9ehcuktCTGR0xpTvZegUkr99H62F_fiT7RY_L_dqgN4g@mail.gmail.com>
 <CAFEAcA981jAU6F9RRWBuzg+_5JDrd-ip-L_awtzdZFqKmewMvA@mail.gmail.com>
 <20191025135159.44siz7g3szpz23og@kamzik.brq.redhat.com>
In-Reply-To: <20191025135159.44siz7g3szpz23og@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 15:06:12 +0100
Message-ID: <CAFEAcA9ZdrAgMhdfUxz0OJnM-dF9XGwR-+FeqnyJAsrntGgL_A@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] target/arm/kvm: enable SVE in guests
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: m.mizuma@jp.fujitsu.com, Beata Michalska <beata.michalska@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 14:52, Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Oct 25, 2019 at 01:06:26PM +0100, Peter Maydell wrote:
> > Fails 'make check' on my aarch32-compile-in-chroot-on-aarch64
> > machine:
>
> Are there easy-to-follow instructions for setting this environment up
> somewhere?

It's an ancient setup, so not really. But it's just an
Ubuntu 32-bit chroot inside an Ubuntu 64-bit host. I use
schroot to manage it.



> I guess the problem is how we're determining if KVM is available, which
> is like this
>
> int main(int argc, char **argv)
> {
>     bool kvm_available = false;
>
>     if (!access("/dev/kvm",  R_OK | W_OK)) {
> #if defined(HOST_AARCH64)
>         kvm_available = g_str_equal(qtest_get_arch(), "aarch64");
> #elif defined(HOST_ARM)
>         kvm_available = g_str_equal(qtest_get_arch(), "arm");
> #endif
>     }

> So we need /dev/kvm and the QEMU binary arch type (qemu-system-arm in
> this case) needs to match the host arch type. The problem is that
> HOST_<type> doesn't imply anything about the actual host arch type.
> <type> comes from the configure $ARCH variable, which for 'arm'
> comes from the $cpu variable, which for 'arm' comes from whether or
> not the compiler defines __arm__, and cross compilers certainly do.
> I guess we'd have the same problem in an aarch32-compile-in-chroot-on-
> <any-other-type> environment, if a cross compiler is used for the
> compiling. I should change the KVM available check to something that
> uses the actual host arch type. I assume the following works, but
> I don't know if I'm allowed to use uname() in these tests, and, if
> not, then I don't know what the right way to get the actual host
> type is.

This all feels like it's trying to do the wrong thing, ie
replicate the logic within QEMU that decides whether to use
KVM or not. Some possible other approaches:

 * If you want to know whether you can run the qemu binary
   with -accel kvm, then just try that and see if it succeeds.
 * Or use '-accel kvm:tcg' and make the test work so that it
   will pass for both KVM and TCG
 * Or use QMP to query what accelerators are available, assuming
   there's a QMP command for that

thanks
-- PMM

