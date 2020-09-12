Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B37C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 16:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D411C206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 16:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXJiLVD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D411C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH8GL-0002BJ-Um
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 12:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kH8Fa-0001YY-Ba
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 12:19:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kH8FY-00064X-N6
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 12:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599927579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4GJj4M8q6OAOInEcBTsttn28JsCwqVj469cpnZXUcag=;
 b=YXJiLVD7CfS7+3ociiT68o8FnWoCttARlhUMcqVBO1N7bGryXTY+4ZuSOluvaQRG/izrxO
 tYLGoLYScEV+bcaSUpwwQac8NROnIYs+h7N3JDebSOQe5+RpywTRyNF/Rt2E//RS4GlyEu
 K1NlUqt7KscUp2CgTXqkLygERYm4Sbs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-m2WuRjJ3NKunagN_1KZDsA-1; Sat, 12 Sep 2020 12:19:36 -0400
X-MC-Unique: m2WuRjJ3NKunagN_1KZDsA-1
Received: by mail-oi1-f200.google.com with SMTP id u190so4588399oif.13
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 09:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4GJj4M8q6OAOInEcBTsttn28JsCwqVj469cpnZXUcag=;
 b=JzpZqXgLYzLw2RdYcbqoWxoZnwN9AOiMmwrmXLxzaaMPRCabhHLZVg+gLv4xlkyG5q
 EFPvvNBm03Drt3QWCIOLxQETPCLxXm3+/tKyOwAz3Jk+yGes/+U8rWngfCC3Nmw4kp0m
 xHbiARYUtBngjG1hxlXqMmnhGPDL7ZOggKlKN0fCEjzevgj/gePU2Mj9WYteZ89pzF86
 DLMBW5Ts65FVz7DSy3lKblsdc1id7GYNbKeUttoNWVpQAHLwej1PUpj+QXm8lUVP2lo4
 Qntsza9aeX7JyEuF2xpyQbEIn7S6+EktXJE4lHlMyaObzCt+FSUpM0eAnHKu9xQmwLgd
 lvjQ==
X-Gm-Message-State: AOAM531M+dAjB2ZEloa44U0nMl2FMBejXxn2fWSLyPOidtWHnCYpg6kq
 L9HjM1F/OScIm+vnPlBHoULKJZ4F5kf5Xz3NeGPbZVSeJKKkJFRnSc5X1TtBdaeSqGKedHN3Gb9
 4YznaeQkJpEZ92W/pyIV9QC68A6Zm6H4=
X-Received: by 2002:aca:5110:: with SMTP id f16mr4342360oib.30.1599927575474; 
 Sat, 12 Sep 2020 09:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywxjOtskKVi+WLRNA3crDvkrgcV7wn/o4ZNib9D0uTCXzMDVLEQbuKE2g0ltnD1bgx/HqtYg08qGYbqQpCWnU=
X-Received: by 2002:aca:5110:: with SMTP id f16mr4342351oib.30.1599927575261; 
 Sat, 12 Sep 2020 09:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200908094408.27091-1-pbonzini@redhat.com>
 <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
In-Reply-To: <CAFEAcA8JZhrxNgayLaCGqQiGLhybvXo7qrXDUpVmkrX5FmjV5A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Sat, 12 Sep 2020 18:19:24 +0200
Message-ID: <CAP+75-VLh7Q0reVtZ8ArpG3bUSLCngVVpgU=gAh_kKd-iLg4GQ@mail.gmail.com>
Subject: Re: [PULL v5 00/46] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 11:38:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 8, 2020 at 3:27 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 8 Sep 2020 at 10:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
> >
> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to ef6a0d6e3927464de67f70cb13abbfe67361e0c9:
> >
> >   docs: update build system documentation (2020-09-08 07:21:55 +0200)
> >
> > ----------------------------------------------------------------
> > meson related:
> > * convert unit tests
> > * bugfixes for mtest2make
> > * miscellaneous bugfixes
> > * dead code removal and configure cleanups
> > * oss-fuzz fixes
> > * msys fixes
>
>
> Applied, thanks.

Another failure calling 'make' in my 'sanitizer' build dir:

Head of config.log:
'../configure' '--enable-trace-backends=log' '--cc=clang'
'--cxx=clang++' '--disable-user' '--extra-cflags=-ggdb'
'--enable-debug' '--enable-sanitizers' '--skip-meson'

Dependency sdl2 found: YES 2.0.12 (cached)
Found pkg-config: /usr/bin/pkg-config (1.6.3)
Run-time dependency sdl2_image found: NO (tried pkgconfig)

../meson.build:318:2: ERROR: Key OPENGL_CFLAGS is not in dict

A full log can be found at build/meson-logs/meson-log.txt

Tail of log:

Library mpathpersist found: YES
Dependency sdl2 found: YES 2.0.12 (cached)
Pkg-config binary for MachineChoice.HOST is not cached.
Pkg-config binary for MachineChoice.HOST specified from cross file,
native file, or env var as ['pkg-config']
Found pkg-config: /usr/bin/pkg-config (1.6.3)
Determining dependency 'SDL2_image' with pkg-config executable
'/usr/bin/pkg-config'
PKG_CONFIG_PATH:
Called `/usr/bin/pkg-config --modversion SDL2_image` -> 1

Run-time dependency sdl2_image found: NO (tried pkgconfig)

Re-running the 'configure' line without '--skip-meson', then 'make' again is OK.
I ran "dnf upgrade" last week but the "dnf history" doesn't show
anything related to SDL2.


