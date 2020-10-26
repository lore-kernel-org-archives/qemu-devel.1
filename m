Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42D3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58ECE22250
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 15:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58ECE22250
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=getutm.app
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4VG-0004Pr-8Z
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 11:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kX4SY-0002z6-L8
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:30:59 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1kX4SW-0000GA-LT
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:30:58 -0400
Received: by mail-il1-f194.google.com with SMTP id x20so3343370ilj.8
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:30:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7f4aSgUAUPH+Sku4LuEXFFpVpZuU157C+jvRgwtUr4g=;
 b=fIJBk2FuXV6JtYcmMEl+Al7W6MdsJxltFJWO12U0hmzxaWjmXrLWFy8mcCRzHFQn74
 4AOl9WXmL5Acsm47Uz9kY0YSToXSiKsAAfEJ+C31URlyr1EstjpFpXtvFsL/N55D3PoB
 610mHrry2Rps6FwwISuxumkRddBvxlSprWVGTeO+mbb7yZluIc/akhyBCUFBbQdC0qA0
 /MqjJoxAKNPN2xqHmXRvIW0kTbRsBl50yCgqfu4Mh76BLuMqjFd4ejCwnaGDZ0c7nGPa
 2SO+TRJPy4q2vYGudtfUAmkeZEJ7GdpGbbut6Egu0Fbqm7Gee31bHT7zbLPtS7eBgV9S
 w6KQ==
X-Gm-Message-State: AOAM533R2oinT+9+S6Y4oDweEy7ANSv3mh8boM/pI3Vt0wO1NORdFkOU
 mnTaB8ksfCSEAxeEh+hoNQAo/W3Ppuw=
X-Google-Smtp-Source: ABdhPJy8y75lMzGeDF44bWZ+DWM5laZdGPuGGkfcpPLXciRTYIL9po5rNHNEkidKMdhplGjwXCA9Nw==
X-Received: by 2002:a92:b6d2:: with SMTP id m79mr10224477ill.216.1603726254417; 
 Mon, 26 Oct 2020 08:30:54 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id w15sm4165199ilm.57.2020.10.26.08.30.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 08:30:54 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id c11so5640320iln.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 08:30:53 -0700 (PDT)
X-Received: by 2002:a92:dac1:: with SMTP id o1mr10002993ilq.191.1603726253462; 
 Mon, 26 Oct 2020 08:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201019013928.72770-1-j@getutm.app>
 <e96f95a1-70ae-b64f-3208-6cdbdef46ec5@redhat.com>
In-Reply-To: <e96f95a1-70ae-b64f-3208-6cdbdef46ec5@redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 26 Oct 2020 08:30:42 -0700
X-Gmail-Original-Message-ID: <CA+E+eSBh-BCgxpJcyLdEhwD0G75-7iqjFpE5QU6UVZybAHKGaA@mail.gmail.com>
Message-ID: <CA+E+eSBh-BCgxpJcyLdEhwD0G75-7iqjFpE5QU6UVZybAHKGaA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] iOS and Apple Silicon host support
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.166.194; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f194.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 11:30:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Oct 19, 2020 at 1:30 AM Thomas Huth <thuth@redhat.com> wrote:
>
> On 19/10/2020 03.39, Joelle van Dyne wrote:
> > These set of changes brings QEMU TCG to iOS devices and future Apple Silicon
> > devices. They were originally developed last year and have been working in the
> > UTM app. Recently, we ported the changes to master, re-wrote a lot of the build
> > script changes for meson, and broke up the patches into more distinct units.
> >
> > A summary of the changes:
> >
> > * `CONFIG_IOS` and `CONFIG_IOS_JIT` defined when building for iOS and
> >   iOS specific changes (as well as unsupported code) are gated behind it.
> > * A new dependency, libucontext is added since iOS does not have native ucontext
> >   and broken support for sigaltstack. libucontext is available as a new option
> >   for coroutine backend.
> > * On stock iOS devices, there is a workaround for running JIT code without
> >   any special entitlement. It requires the JIT region to be mirror mapped with
> >   one region RW and another one RX. To support this style of JIT, TCG is changed
> >   to support writing to a different code_ptr. These changes are gated by the
> >   `CONFIG_IOS_JIT`.
> > * For (recent) jailbroken iOS devices as well as upcoming Apple Silicon devices,
> >   there are new rules for applications supporting JIT (with the proper
> >   entitlement). These rules are implemented as well.
> >
> > Since v2:
> >
> > * Changed getting mirror pointer from a macro to inline functions
> > * Split constification of TCG code pointers to separate patch
> > * Removed slirp updates (will send future patch once slirp changes are in)
> > * Removed shared library patch (will send future patch)
> >
> > -j
> >
> > osy (9):
> >   configure: option to disable host block devices
> >   configure: cross-compiling without cross_prefix
> >   qemu: add support for iOS host
> >   coroutine: add libucontext as external library
> >   tcg: add const hints for code pointers
> >   tcg: implement mirror mapped JIT for iOS
> >   tcg: mirror mapping RWX pages for iOS optional
> >   tcg: support JIT on Apple Silicon
> >   block: check availablity for preadv/pwritev on mac
>
> Is there maybe also a way to compile-test this automatically in a macOS
> container on Cirrus-CI or Travis, too? ... otherwise I'm a little bit afraid
> that this support might bit-rot quite fast again, since most developers
> don't have the corresponding setup...
That's a tough one. In theory we can use the cirrus-ci environment to
build for iOS but there's no easy way to get the dependencies. For
UTM, we have this complicated script
https://github.com/utmapp/UTM/blob/master/scripts/build_dependencies.sh
which downloads and builds all the dependencies from source. Adding
something like that to QEMU would tie it to specific versions of those
libraries as well as the download link. Not sure if that's desirable.

I am currently refactoring the code so the bigger changes (mirror JIT)
are separate features that doesn't depend on iOS. Other features work
on Darwin so they can be tested in the macOS builds. But there will be
iOS specific code that I don't think would be easy to CI and that's a
general limitation of open source projects on iOS.

-j

>
>  Thomas
>

