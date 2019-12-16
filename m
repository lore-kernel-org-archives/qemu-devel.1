Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14190C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D75206CB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 10:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6YYYETs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D75206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igncJ-0003nf-Rs
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 05:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ignbj-0003Mh-8U
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ignbh-0003h7-M0
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:28:06 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ignbh-0003cq-Gt
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 05:28:05 -0500
Received: by mail-ot1-x333.google.com with SMTP id x3so8567852oto.11
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 02:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=q+DmfKZyEvJM2qRudqckmD+3Zg92N8tPKA78Mvgilks=;
 b=Q6YYYETs9DvCpMwybJWc1D9JKVf7oENnRA3qW+Z9IRus1LYZuXEt15W7Z5NE96nc31
 UiOZFLHLeVCRJGMGtuqaslmwTfM7QNqn9yMI3lQA/UNXKaH1Wktm4SuPaErs3lOXower
 jE/3LhrUK6p/HxUY3Ctj2IIWTROTRDaR+OM2xGff6upcloUMfqbY/LltDTHaOrIq49QF
 anj8DSzzQZgoszXUz+BaH/YfrhR34bS4DwRpiUgYyy60dIhtZjkcmumfiTbQO7W/4na8
 cDVhJroBEq7Frvt3/BYjvemazQREYI2EynYjvSdtWD/Sa4V6tDLwWHtjD8z2+5Nxq7iN
 YTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=q+DmfKZyEvJM2qRudqckmD+3Zg92N8tPKA78Mvgilks=;
 b=UeN3Z9UMrXa5l9dV4d9WA/yTkABxfXpM/hCK/ZuKAEg77FlRjvjYkuM6yF8YQO8Ps0
 wIGALzYegj0rbHSNiSte4jabaPBTZs6lmjuSBtu6KGgGeVoIG2sxOwGoxT6pAo1eUZow
 +pfIms0QtjIwGOd+7WvU25U7OHyWcY/87P+x1zGJ8+R9SwbkmanNgD6vjGRHNCPpHZtM
 owY96AwXszyPz08uCbrmNB5EAqJ4JXmxYED/EE0aHExfAqr/YzumLt8tfVVbPbz70dbo
 SwYhdDTNL6YbM/WInktEP1uPWh95cidzYpRTeNWumdxmqr9H/h/6DmPl/B6WtNCeAdBl
 dCWQ==
X-Gm-Message-State: APjAAAXwsgWpCnPv50S55dZW8CDxY2DxiBsYzcgIOJ19B0qNiGJaiAxB
 mu30elrogumCIxqWEt82Ua4CXRaQsTgJPR3ziozq4g==
X-Google-Smtp-Source: APXvYqzNBigVv3+0es+HmShsvJ+qZeR2aQRwHjEOqrJ2f9TAyPXP5u5897ci+hwdLhWJstwpDBOUfnBVgZAbyb8WF+8=
X-Received: by 2002:a05:6830:2001:: with SMTP id
 e1mr29641149otp.97.1576492084211; 
 Mon, 16 Dec 2019 02:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20191212185424.4675-1-thuth@redhat.com>
In-Reply-To: <20191212185424.4675-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2019 10:27:53 +0000
Message-ID: <CAFEAcA_RQC8yswF4X8h9ya_CGLNAsJYZPZGyiqzG6sPq0bSLSQ@mail.gmail.com>
Subject: Re: [PULL 00/10] Bluetooth removal, and qtest & misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019 at 18:54, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi,
>
> the following changes since commit 52901abf94477b400cf88c1f70bb305e690ba2de:
>
>   Update version for v4.2.0-rc5 release (2019-12-10 17:15:21 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-12-12
>
> for you to fetch changes up to e38f04c4db40a9219cc0c516a6c68b9ca0a783d0:
>
>   tests: use g_test_rand_int (2019-12-12 08:16:24 +0100)
>
> ----------------------------------------------------------------
> - Removal of the deprecated bluetooth code
> - Some qtest and misc patches
> ----------------------------------------------------------------

Hi; this fails to build on some of my build hosts:

OSX:
[...]
  GEN     target/sparc/trace.c
  GEN     util/trace.c
  GEN     hw/core/trace.c
  CC      qga/main.o
  CC      qemu-nbd.o
  CC      qemu-img.o
make: *** No rule to make target `config-all-devices.mak', needed by
`aarch64-softmmu/all'.  Stop.
make: *** Waiting for unfinished jobs....

ppc64 linux:
  CC      chardev/char-mux.o
  CC      chardev/char-null.o
  CC      chardev/char-parallel.o
  CC      chardev/char-pipe.o
  CC      chardev/char-pty.o
  CC      chardev/char-ringbuf.o
  CC      chardev/char-serial.o
  CC      chardev/char-socket.o
  CC      chardev/char-stdio.o
make: *** No rule to make target `/home/pm215/qemu/hw/bt/Kconfig',
needed by `aarch64-softmmu/config-devices.mak'.  Stop.
make: *** Waiting for unfinished jobs....
  CC      chardev/char-udp.o
make: Leaving directory `/home/pm215/qemu/build/all'


windows crossbuilds:
  CC      chardev/char-serial.o
  CC      chardev/char-socket.o
  CC      chardev/char-stdio.o
  CC      chardev/char-udp.o
  CC      chardev/char-win.o
make: *** No rule to make target
'/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
'aarch64-softmmu/config-devices.mak'.  Stop.
make: *** Waiting for unfinished jobs....
  CC      chardev/char-win-stdio.o

It's possible this is a lurking bug in our makefiles
where it doesn't regenerate the config-devices dependencies
properly; I'm not sure and haven't investigated.

thanks
-- PMM

