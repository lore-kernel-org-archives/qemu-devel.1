Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91EDC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7264520720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVwHdbHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7264520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttDn-0003hh-OY
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtt27-0005rJ-7W
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:25:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39055)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtt24-0003UO-TG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:25:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id 18so4178659otv.6
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MFCeImX5ooKRV/2bwGukA3M2+Lqtr4UmmsiIQA8M91o=;
 b=SVwHdbHDUEn+EYKjjNG+fANQzGKSsVJlnOcV/0R7C6tagRHXNpb0wg2cne2HlEz+Rl
 C5BaEooeOC+8llgF8nSh+FJ5qYJbuHHRMs56tvsg0xIDnM9Slibk/iu1XmQBkDLVwGxh
 VCdb5AZ4STDBh9xvCUXmmwp+I3q6oYlWHOl8A0PboT+fur3eZwBqLkHhzNLPRpsQTICz
 QboeFaGAlyhvJfYt8Cr24+gvleZEWhNJg7tULojb0bzS31XluLBfb6LKcxVRlqOZkEZC
 8Eg65LwRnCHELCrDhN8TgWMGHqz6UABK9IeyS5sBRcl7SSnxbqBiqvKew9KI02H1r6Zz
 dAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MFCeImX5ooKRV/2bwGukA3M2+Lqtr4UmmsiIQA8M91o=;
 b=UrjRc+ZMs/gOd0LEqj3HTGNfd9OGgrMfAgf2+NdN4ZHRurUIC4FihzOY/o+zpK+kaR
 dFaULJJ/lZ/xe//Fc3P5wdt+84v4CXQAyf11Kbf6PKaekQDLYVor4NuwKdjX194kTp5h
 zRaPsERzHwg0237WFy82XTE4uOhibejaWr3K5JpMBQlJs//BbJQP/wWwcWOdM31b0B4b
 en4riun833aWmNqpslMXp8kN31TZ+tu9kb+qz4nAG67M0HDuq1LY4uA5nak1rN+BGm3/
 PWN79/byoaxK1wnMaj4qOxyE7bkH1bQNrA8asTLfuJ9Q73P9oGlkP04saEh3k66VJTCa
 9gKw==
X-Gm-Message-State: AOAM5315e1GRNw5wpSd7BHDJvs7pppU79sWNy5jR5m5lfkwHiZH0yFxc
 zn64EIRW3QnxWowvAtFS2tjNuiBddXkTCSI01ECOfA==
X-Google-Smtp-Source: ABdhPJzF1fl79EdU+rjNxGrDTvNqIOOto1ku12zcE/ky/AV7tRe0pNk6Q52SeTpb2YQeAP1O/Dtap4p9QC962I2fdaE=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr51356976oto.135.1594387539187; 
 Fri, 10 Jul 2020 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200710045515.25986-1-thuth@redhat.com>
In-Reply-To: <20200710045515.25986-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 14:25:28 +0100
Message-ID: <CAFEAcA8vdzu0Td320VxOFHM9+Q3oxQ0ER9-FF4iOS+GsGuc=Zg@mail.gmail.com>
Subject: Re: [PATCH v2] Remove the CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE switch
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jul 2020 at 05:56, Thomas Huth <thuth@redhat.com> wrote:
>
> GCC supports "#pragma GCC diagnostic" since version 4.6, and
> Clang seems to support it, too, since its early versions 3.x.
> That means that our minimum required compiler versions all support
> this pragma already and we can remove the test from configure and
> all the related #ifdefs in the code.
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Keep the !defined(__clang__) in coroutine-ucontext.c

If we're going to mandate "at least gcc 4.6 or clang", perhaps
we should have a sanity check for it, something like

#if !defined __clang__
# if !QEMU_GNUC_PREREQ(4, 6)
#  error QEMU requires at least GCC 4.6
# endif
#endif

(maybe also check clang version, though that is more awkward
because upstream clang and Apple's compiler set the version
number defines differently.)

We could put that in compiler.h. Checking in configure would be
more userfriendly but maybe a little more effort.
The other advantage of this check is we have effectively
some internal documentation of our current minimum
compiler requirement.

There is also some tidying up that can then be done:
several places in the code use QEMU_GNU_PREREQ() to insist
on "at least gcc 4.4" or "at least gcc 4.6", and that
ifdeffery can probably be removed (though some caution
is required as I think even modern clang may advertise
itself as gcc 4.2. In some cases __has_whatever feature
tests may be usable instead.)

thanks
-- PMM

