Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F44C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D05220665
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D05220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyAm-0002YL-Gp
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35273)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hmyAa-00029i-KX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hmyAY-0000YF-Jt
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:25:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hmyAY-0000Wp-El
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:25:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id u15so12259195oiv.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 03:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=QJe91/oeuGV5zj4hUXggxgWQygb/5mot1rOiQDRAi0M=;
 b=SrqaIqIvE6bUq2yWbqHHm3SmYxBwrNZsTAtDoN3ghacWlGCD208LpQg38gacj9BWIL
 LbcYecXlLvhg/1R6PUII27/J3dhYr4JH5ybwqheoGxzdnWE2RUfGgjGYUT2rY6wMJ7Q9
 5soi3efwxzTIcrQdyrR9dIkmq28f1M+Bh8aInyUm+APZbzYiNdptYHpfu4A/yC/Unvfw
 hBhAmtD6AbKH9k1DGkNcKJ/iZa0RD6z/vo5pBALc5L1HNiJvzHpa/s4WyKwF59RyG1cg
 aN6bbJSFoeva/uHVUNdLaWQ4HhH/nxaIr6aWcU1J+i+4jOWmXtCgNUDGGQb3W9UmG9zK
 /J0A==
X-Gm-Message-State: APjAAAWSOuxrtOUIw9OSiIkCbNsZyBXu+slds7ou87M29xPZWEZgdjyo
 tm7Orrt4nLXWGqep+4caDQ6/Sylms35FksYgeu9vnQ==
X-Google-Smtp-Source: APXvYqzw4cJFq170iTNICjFpldg64oz+8s0KmL8Cd2WSoiMoC9bzMu8g4Vylk38wWpSyr50Ff+g5lVR8opylq25tQoM=
X-Received: by 2002:aca:4d12:: with SMTP id a18mr6567021oib.33.1563186314534; 
 Mon, 15 Jul 2019 03:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-7-marcandre.lureau@redhat.com>
 <20190715094026.GC30298@redhat.com>
In-Reply-To: <20190715094026.GC30298@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 15 Jul 2019 14:25:03 +0400
Message-ID: <CAMxuvawZ6nCt-6KtnzPUnX4PWbvEs1tycufZK4c4tMr1s2T0ag@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.194
Subject: Re: [Qemu-devel] [PATCH v3 6/6] test: skip tests if
 socket_check_protocol_support() failed
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Jul 15, 2019 at 1:40 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Sat, Jul 13, 2019 at 06:33:11PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Skip the tests if socket_check_protocol_support() failed, but do run
> > g_test_run() to keep TAP harness happy.
>
> Did you actually find a scenario in which it failed, or is this just
> doing the change for the sake of strict correctness ?

It fails under podman atm (https://github.com/containers/libpod/issues/3535=
)

>
> In any case
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>

thanks

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

