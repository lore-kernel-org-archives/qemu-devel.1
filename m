Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F7CA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3224320874
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 11:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSE8Yood"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3224320874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPlt4-0003n5-9R
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 07:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPlsI-0003EL-8V
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPlsG-0003gg-Lh
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:10:49 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPlsG-0003g8-GL
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 07:10:48 -0400
Received: by mail-ot1-x335.google.com with SMTP id m19so1756475otp.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YAFfz/tfoIOdBntZgvV4kIrxmwfRlXL3Jv3bcHpqZak=;
 b=mSE8YoodJiMZCfn5pmN5OeW5uyKRfZ95bpPG7WX2IvH1s7gpDSXQEO+2/uAGUFkjal
 MdYcahSFZ+rZH76+/tymL/tZZawcKQ2ndexs8X+ECqsMM320QhjEr6d2pEfEDjJwLQbv
 we7YFUOP9jIYQpApdFtR9V/RE3TDzy2rVtCmrKwDnFST5fBiEyJhnMhgAVfmoX1GDdD/
 BhIhLCwXp4QLK3HX1UwqMnV4lu8+e0EVF6wvEXNDtD4YrG3q9NIVrUWJafsDpLesq8PC
 PW05UgiJHEpTTixSYoRxN9iS1xjiMQ+XysOd457QTGJIeSyDvepoZKL+a3obNu4OGv+/
 3v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YAFfz/tfoIOdBntZgvV4kIrxmwfRlXL3Jv3bcHpqZak=;
 b=Ft+Eb+r35TtG7DjOfs7QAaDb1oDJpRKR+0sNHjF5syyAMbquhGpDTGY+cFeFoSn2k2
 /71gnwLW1lDeuKZwd/0m/1oOxHciapSXesxNkKz36g6zWnSw41vBApN4aaooO1R4rexe
 IDO9Vo8pbsdwtUWBEO39VdNeM3UsJqpEHfcGIEFUPJ/r6j5xssduHumeN0E2FyMlxcgD
 D2WPfvueo2VvqLOrx0RbxcVN51N8jaIvs9aUm78zVTEXmWuZlqHixYizK+AI61QQGSRn
 tp56mdZagPtJej4UntpHJsUkUklIOdYlL/xNyQMMJw7Zg/XDUa7BVr6//aHDpCckGal6
 Q3PQ==
X-Gm-Message-State: APjAAAUUX5uxdlSD9/YAGqkulhAxtbKy6niz35wuighW8Ed3NtMnlFJi
 A1SQqXivwQY5XPCKbIvpLZ8qojLtTL+duLCUfG4ejg==
X-Google-Smtp-Source: APXvYqwmzGg1kcIvurHkfIPxGFHjZwVhow24Z2ZgFrTN5RRKY8Um3keY556fIJD8+bS3UkrRaqhQrsmzaI9FN0U2zAU=
X-Received: by 2002:a9d:398a:: with SMTP id y10mr20913064otb.97.1572433847419; 
 Wed, 30 Oct 2019 04:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20191029225932.14585-1-mst@redhat.com>
In-Reply-To: <20191029225932.14585-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Oct 2019 11:10:36 +0000
Message-ID: <CAFEAcA9hk4cbDKi2nvDzLtCv+3CtjVuGgv=9GaW-cT39r99ZFg@mail.gmail.com>
Subject: Re: [PULL 00/14] virtio: features, cleanups
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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

On Tue, 29 Oct 2019 at 23:00, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 16884391c750d0c5e863f55ad7aaaa146fc5181e:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-10-29' into staging (2019-10-29 20:06:08 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to b5f53d04a5a567ac70d33ec95628d35583eba600:
>
>   virtio: Use auto rcu_read macros (2019-10-29 18:56:45 -0400)
>
> ----------------------------------------------------------------
> virtio: features, cleanups
>
> virtio net failover
> rcu cleanup
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

