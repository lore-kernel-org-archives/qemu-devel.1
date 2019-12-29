Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464AEC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:19:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AA7B20748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 23:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA7B20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55919 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilhqf-000080-9P
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 18:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhpo-00089x-MQ
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhpm-0006UY-56
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:18:56 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:47101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ilhpm-0006TR-0b
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 18:18:54 -0500
Received: by mail-yb1-f196.google.com with SMTP id k128so2508743ybc.13
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 15:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FVD/vhmxptTs5QmedKsL2Cibw7NX9ARIffFjDSdz3Gs=;
 b=TRACIeMTmtO5pNJT9VKE0nVmwG/hImoCoIZCT5sjNjImlCPncvxmCGVlJ9zfP+exEw
 2dPQt0ZujwLr5RHPS+PfpymhJHC76JrTmIhAwFnH7ZTc6HOQEP0LTILSiciy/BbS5daN
 5FnM1RvJiW5hmU80Gj8banj8CQv9cHH+Vx+2HAWzn/zJmhRtkRNOFR5ya9RG3W34FZSD
 gqMNEUo2s+On0ZJZ5wlNBXT37ud7DFmGO0rMt4ijVWMTpL7iS3VbDuKA1LZyr/lVFMMX
 ysByHhCxxUziJlnGnXNcPmlvYB+k7soTZyb+LKmpA+/XeogAFdop1ZcTtkvFsooLT5Z7
 163A==
X-Gm-Message-State: APjAAAVLnIPbGLdE6E0HJGfTAEfJBa9xgdzMqPgicgM6Y1RjQqMXKOig
 nCyLEdfULnnWFLbQjW7TQRcgagXvx8oo+Y8518UlMJr4p18=
X-Google-Smtp-Source: APXvYqw7KtEifJOayWBYruByl+nQ/wjACqCA5l9tlkJbjtyczlN4xstvFij39+G3xCYJDOYFpJ1FXMX56ziEMhKsCtY=
X-Received: by 2002:a25:3182:: with SMTP id x124mr6317525ybx.323.1577661533028; 
 Sun, 29 Dec 2019 15:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20191229224505.24466-1-f4bug@amsat.org>
 <157766026188.19009.2772418918814016586@37313f22b938>
In-Reply-To: <157766026188.19009.2772418918814016586@37313f22b938>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Dec 2019 00:18:40 +0100
Message-ID: <CAAdtpL6pg7zCkrcb5kmZ=mxBucJOmah8cORFQf=tW8FOWMQW3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] hw/avr: Introduce the Arduino boards
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, patchew-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.196
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Dec 29, 2019 at 11:58 PM <no-reply@patchew.org> wrote:
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> Please send your feedback to patchew-devel@redhat.com

Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
From https://github.com/patchew-project/qemu
 - [tag update]      patchew/20191229215158.5788-1-mrolnik@gmail.com
-> patchew/20191229215158.5788-1-mrolnik@gmail.com
 * [new tag]         patchew/20191229224505.24466-1-f4bug@amsat.org ->
patchew/20191229224505.24466-1-f4bug@amsat.org
fatal: failed to write ref-pack file
fatal: The remote end hung up unexpectedly

Is patchew disk full?

