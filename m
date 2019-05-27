Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23074C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF45F2147A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF45F2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47989 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIJS-0007l8-TE
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:17:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVIIO-0007Dh-51
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hVIIN-0006yo-36
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:16:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hVIIM-0006yG-U4
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:16:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so8588286wrv.6
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:from:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mTQh6ovPz6oeq8oighnh2RzCGDPakoPCn9Rtml4cugE=;
	b=KD2eNoSlWWZWPBdxicE3qq9Z6pgdU3QgZhG25O6Vn9NB+M0PfqWXbLD9KhUg94tDMu
	U+ztJXk3spSAi33ZBX933crV6ihWJfcI+C1jb2gj9/PSP8dNvcE/1bX6ao1LzWn+qKsr
	Wwd3bhFVuP2m3zwoYV0+1eTx95plbwF5Z746p4hWvJrYV40C+hLhHEelaTSmojRWc/FW
	+1mMdbZ3b5Od5j7HHgQR/qv/Gr/gyP1wKBtiPQ8wrTFap44hUGqTz3w1uoJFpFn72Hzr
	iUZ7wo5Git3nMgl/zqQWDl5GcRtz8Oa9RK+r5rq0jIBl9GJpTbq3X1VjIijsmZ6c3wTi
	QW6g==
X-Gm-Message-State: APjAAAUMFxe9i3TRzhF06BdRHVRhtISsASKJffntrGoKzyPDGN2PBdND
	u0UrbuNdHRO+7ZZ/Spc1RGnAHg==
X-Google-Smtp-Source: APXvYqzFnpCZ0EtWd8mFVTdAY5a5cdU4W9b3l/E1bb/8bfRjw7GzU7d34XfkXmEXQPCEYRL42fY82g==
X-Received: by 2002:adf:fa88:: with SMTP id h8mr24731345wrr.32.1558973777688; 
	Mon, 27 May 2019 09:16:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c92d:f9e8:f150:3553?
	([2001:b07:6468:f312:c92d:f9e8:f150:3553])
	by smtp.gmail.com with ESMTPSA id
	v124sm21305691wme.42.2019.05.27.09.16.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 27 May 2019 09:16:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel <qemu-devel@nongnu.org>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Message-ID: <7628c6fa-5bfd-5633-69b4-811aa448dd80@redhat.com>
Date: Mon, 27 May 2019 18:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: [Qemu-devel] Status update on Meson features needed by QEMU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

if everything goes according to plan, Meson 0.51.0 (out in a couple of
weeks) should have everything needed for QEMU.  I am not sure whether
I'll have time to attempt a partial conversion to have something to
show, but anyway this is a status update.

On 06/03/19 19:12, Paolo Bonzini wrote:
> - ease of use for test logs and the ability to cut and paste test
> invocations from the logs to the command line.  For this I have started
> "probing" how the Meson developers feel about this kind of change[1],
> and intend to follow up until the meson test driver is comparable in
> usability to QEMU's "make check",

This wasn't accepted, on the other hand Meson has an introspection
mechanism to export test definitions as JSON.  It should be easy to
generate Make rules from it and keep using the current TAP driver.  I
have a pending pull request to fix a bug there, which should be accepted
in 0.51.0.

> - ease of converting Makefile.objs files.  The Makefile.objs files are
> very nice to change for simple modifications, and any replacement should
> have the same feature.  This will require a Meson extension.

This was accepted.  The final syntax looks like

    obj.add(when: 'CONFIG_VIRTIO', if_true: files('virtio.c'),
                                   if_false: files('virtio-stub.c'))

    sdl_obj.add(if_true: files('sdl.c'))
    sdl_obj.add_all(when: 'CONFIG_OPENGL', if_true: opengl_obj)
    common_obj.add_all(when: sdl, if_true: sdl_obj)

> - ability to use the Kconfig declarations for dependencies.
The Kconfig parser was accepted.  It should therefore be possible to
invoke minikconf from Meson (rather than from Make) to process the
dependencies, load the result via the parser and use it as the input to
the source code selection rules.

> - Meson generates a build.ninja file rather than a Makefile

... and requires Ninja to be present when Meson runs, in order to
generate compile_commands.json.  For this I added more functionality to
my ninja lexer/parser so that (in addition to generating a Makefile from
build.ninja) it can also be used to emulate the "ninja -t compdb"
command which generates the file.  The resulting  tool can be found at
https://gist.github.com/bonzini/fd3b69f5682f7e2eca817fb797c2db0f.

Paolo

