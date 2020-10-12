Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29274C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:49:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAB32072D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6ivDiDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAB32072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS5hX-0005s7-2N
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS5gG-0004zg-QQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 17:48:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:46603)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kS5gE-0003aK-3y
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 17:48:32 -0400
Received: by mail-ed1-x52b.google.com with SMTP id 33so18603192edq.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=045G/Pgnh1iTdG38FJOh5bvq2GQTG8UpTdl3/0H7WTk=;
 b=Z6ivDiDigpQzvyMxZ+X6R+y8Q8Frm8/bG+qe34ihH9d1O+4FdTpr2MdADCfXE03TVQ
 gNeBvGEKmy0rSNVXqO7LywgD4BJSaz/U+nx9AqGlKinv/fAXjcUjTWhlyzLemJGmE4lF
 kZ5g2h/32MFw3bVvJBwTcDYpKWo8/fM12anij/paZ61UoK1ROIgfbBBpqM148QGDcIoO
 Sc2/+qqerwIL2mldSrtyRlJVH3Oxnkko4bYTHgrv9aBJXemIWeuUdrKp9KxI3uyJxC2F
 rhgY6rldNaS3J+pRvQyx/eI8ramJsZOYQk5r3PEJ2/WsbxDHxfisqqfu7B12iJAacpgK
 9JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=045G/Pgnh1iTdG38FJOh5bvq2GQTG8UpTdl3/0H7WTk=;
 b=jjgTurmDqA/5qi/jNk/FmbicFLHVoCv/w+c6EmdLuDD1et/uu8PZPTqAuIghER4oSd
 y/NqALDpgOZqQ8BQIRWZH++L5Bt1xcx+98Wd+zaGWH+1JTJcwxIWG2jNKI4uZMbpqOFo
 5lRxgCvg9zcxWZG6I0ivtRfLs7RvdVsqWCSc9MEo5YHh6T/L3PSzaTQjheL/HDf19w9t
 shabqySx4Wnobcq0x50m9+JZc9iogBBjbvUv0VGesiPgK7jAR44/p6HAYQDZ3jorfcST
 6mEzmp89navjNOEIk5/I4kRSdgXLBGcQnMYFDbRy5jFLMjQYvC0n1BPrtBGlo5fgGP8i
 WjDQ==
X-Gm-Message-State: AOAM533TZyYgNg4Zb6AIHJse0KFBek+8QRi92omGJW8v7Jq96ejd+pot
 tByYhFsy1WplKHa5keRYCuh45zByhIPqD17R/Fs1lQ==
X-Google-Smtp-Source: ABdhPJxPW1CuR0NUjuRcZlkhqpMwrFWo2ixWl1wYkLmDfd3tMsr4srBzlmhqN3UYyoeaM2Pue/Yl9wQsoEdXRMsetKM=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr5302949edq.251.1602539308515; 
 Mon, 12 Oct 2020 14:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201012182800.157697-1-stefanha@redhat.com>
In-Reply-To: <20201012182800.157697-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Oct 2020 22:48:17 +0100
Message-ID: <CAFEAcA8Th3Bf8gN1eDcHMKP4FpvSHaxhV6kjYP92vLwbSwL=3A@mail.gmail.com>
Subject: Re: [PULL v2 00/30] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Coiby Xu <Coiby.Xu@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 at 19:28, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 2387df497b4b4bcf754eb7398edca82889e2ef54:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2020-10-10' into staging (2020-10-12 11:29:42 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 3664ec6bbe236126b79d251d4037889e7181ab55:
>
>   iotests: add commit top->base cases to 274 (2020-10-12 16:47:58 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Rebase and resolve conflict with commit 029a88c9a7e3 ("qemu-nbd: Honor
>    SIGINT and SIGHUP") [Peter]
>

Build failures, OSX and the BSDs:

Compiling C object
contrib/libvhost-user/libvhost-user.a.p/libvhost-user-glib.c.o
../../contrib/libvhost-user/libvhost-user.c:27:10: fatal error:
'sys/eventfd.h' file not found
#include <sys/eventfd.h>
         ^~~~~~~~~~~~~~~
In file included from ../../contrib/libvhost-user/libvhost-user-glib.c:17:
In file included from ../../contrib/libvhost-user/libvhost-user-glib.h:19:
../../contrib/libvhost-user/libvhost-user.h:21:10: fatal error:
'linux/vhost.h' file not found
#include <linux/vhost.h>
         ^~~~~~~~~~~~~~~
1 error generated.


Build failure, 32-bit:

../../util/vhost-user-server.c: In function 'vu_message_read':
../../util/vhost-user-server.c:119:30: error: format '%lu' expects
argument of type 'long unsigned int', but argument 3 has type 'size_t
{aka unsigned int}' [-Werror=format=]
                 error_report("A maximum of %zu fds are allowed, "
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../../util/vhost-user-server.c:121:39:
                              max_fds, vmsg->fd_num + nfds);
                                       ~~~~~~~~~~~~~~~~~~~
../../util/vhost-user-server.c:120:45: note: format string is defined here
                              "however got %lu fds now",
                                           ~~^
                                           %u

(you might also want to wordsmith the English in that error message)

Build failure, Windows:

../../qemu-nbd.c:158:5: error: "CONFIG_POSIX" is not defined [-Werror=undef]
 #if CONFIG_POSIX
     ^

'make check' failure, s390x and ppc64 (ie big-endian host):

ERROR:../../tests/qtest/vhost-user-blk-test.c:448:idx: assertion
failed (capacity == TEST_IMAGE_SIZE / 512): (2199023255552 == 131072)
ERROR qtest-i386: qos-test - Bail out!
ERROR:../../tests/qtest/vhost-user-blk-test.c:448:idx: assertion
failed (capacity == TEST_IMAGE_SIZE / 512): (2199023255552 == 131072)

I also got this on aarch64 host:

ERROR:../../tests/qtest/boot-sector.c:161:boot_sector_test: assertion
failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)
ERROR qtest-s390x: cdrom-test - Bail out!
ERROR:../../tests/qtest/boot-sector.c:161:boot_sector_test: assertion
failed (signature == SIGNATURE): (0x00000000 == 0x0000dead)

but it might be an unrelated intermittent.

Also a hang on x86-64 host running qtest-ppc64 qos-test, ditto.

thanks
-- PMM

