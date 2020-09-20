Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5126C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991B2078B
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 20:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKLn8Dip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK5rV-0003Re-8H
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 16:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kK5qa-0002zh-Hb
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:22:08 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:38895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kK5qW-0003UA-NZ
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 16:22:08 -0400
Received: by mail-ej1-x641.google.com with SMTP id gx22so5877640ejb.5
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nRMkBIqXPszwInDD9n8LAeQdx6PLxnyTBJqYNjsSfHM=;
 b=LKLn8DipZyW7FA5AVLTsBjVPnyXEUHFGq6p79CKvxsw0NidT+swPM0/X9AC8R5tBNy
 lfFEjxncojsRIV4eJUKYD6xijpu4/4PUopScePe/dFoKbEnuBHScyilmO5ZZ4VKpyQMF
 1119OXUFye9kLQLuKDgWw6WrOYLEIcfOoOfLQvgCfu9/NREZPjCBfOaBTo+7ZykH9Je3
 UX52XZF/1hiJIN0O+nphSOcGw1+Nj+rPN/pXqWGEEjUvR0T4hdLydnJklBddZAdPxCAn
 BHlCJ2kGdpmDSlNg3QZ33ZN42WiQMKaEBwP4qk1cRVWLku6FRdfD+BXxAtE3u/Xh8+AZ
 iZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nRMkBIqXPszwInDD9n8LAeQdx6PLxnyTBJqYNjsSfHM=;
 b=fgca1GXG7rCPKpcV/gYjX25W9h+IYCXD6aZxx7wq6MUfLMZ5I6VgPRlGqRU1tf78Ah
 uZO2693WRoFV8wBGeFwuapA82jdUQGNFqkDOk7eGsrMQtFs+egX49sqY+W7JaHbQklLw
 NRzgm7mQnzk9kIRM8Qd58bmifrz06JNB0ayyUu1yAL8vgk4j9OsB2m3/Eg012/BW23b3
 1KfnWhwFjSeHZ+/mROGK8vMy949bFZ9ZdzJztHiblFKnez2TekSCNfe1J9tEUvLp/eLK
 JGHYn3+O8rL6ZuQEoWeslnPBIWNG0F3/pjMY+2c0Uj1RKhs47DK0O38VpwAOlP/aTszm
 jB+g==
X-Gm-Message-State: AOAM5321Vi9ncmi8KRDPMvhU3Zjs8tKvBlxWEHMgNHEWfPegTfmt4W6U
 RSRbP3zOGYNxOEdlRp1oBjSbWvwUNyZpChTCj+GV+A==
X-Google-Smtp-Source: ABdhPJzc9UoJTlkE3MBe+qs70hGB/YCxIix2976FWOi6NCTodp/M4T+y/DrjgZLzU4gkEFphl3pgRO1hfcsY1nBYv6g=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr48933361ejv.56.1600633323043; 
 Sun, 20 Sep 2020 13:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200918204759.225810-1-marcandre.lureau@redhat.com>
 <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
In-Reply-To: <0e14e115-797d-b91b-dec5-7a2a26836d92@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 20 Sep 2020 21:21:52 +0100
Message-ID: <CAFEAcA93ARShU6uxVeecGnaJjRkErj5y788xuy3vChMLHRz3Zw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Convert pc-bios Makefiles to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Sep 2020 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> I don't know, the way pc-bios/ works seems just wrong to me.  pc-bios
> should IMO be its own build system with support for docker-based cross
> compilers similar to tests/tcg.

Yes, I've always thought this :-) It borrows the host x86 compiler
just because it kinda happens to work most of the time in the
common cases. Now we have proper docker cross infrastructure
available it would certainly be nice to use it consistently for
building firmware. (It would also make it more palatable to
have VDSOs for linux-user, which would also need to be built with
a target C compiler.)

-- PMM

