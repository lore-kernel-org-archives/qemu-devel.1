Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EEC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771762064C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbQ7B22b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771762064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOM18-0003vb-IZ
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLzz-0003Hd-Ro
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:25:31 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:45148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kOLzx-0002Kp-Er
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:25:27 -0400
Received: by mail-ej1-x644.google.com with SMTP id i26so2229902ejb.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Um0em6gfmT5YBz2tgXrVzVDZGokixIY7qWf8KsnXuCA=;
 b=KbQ7B22bH0vT/Gkk8/HKpBjMBKR0gylt7+p3Q31PC6oiIh0KBfW+tHwEUsH5RLuA0L
 u5ra6MFef1ZuCqLXYYA8WFgTj7rBh1JiW+coCSA1K7w9SVoGBDcYt9Gcpn+PGlX64z+3
 Fzofu8AMmNPvSLE5Ot2mZ6UGWA1OOuvqmDe6i604VFu5OtHqnMz5G5RWfxEAEHdlPcv3
 a6OfyX3cVr5uXaOAHf6/KOHg5QNkNhXgCyHMrKGQCZ6IpK4OwHzyKwavJmzwxt7tDvS4
 5jboqG8UMKs+LsHGH/ivI3Dyr4SaWNOsX0X5YciX+q6eFDP8jv6iBhJZjy5m946REfqP
 94Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Um0em6gfmT5YBz2tgXrVzVDZGokixIY7qWf8KsnXuCA=;
 b=it1oRRg7HF+vyBR/GUfthDwto+mL/Afu088BGGeKMzO7Peb2IFk69hmvz8rLiH0Kka
 6hngoOkW+n2WkteiYGkRyV/SIOpSwFpCOlvxz3I7dBE44UvKxAgTB6lkWh8atBRSfrBt
 uqPjO7FLHFVFIGP8p46utU2qetT/VYHoZ/pMJQGmrG+a7p/ZYVjH8S4SjrwlzaDhxExS
 EAFQZeWvfZBTkhT8DrTYYjp6IbJ4SW6Zb+oGnmPkXhhg0Hetirf2LHPigKKeMWZsuJzH
 +wY7q87QWxKpM/DsoPPhxyuZpqQAxtGz32t3VCEOKHxY5lp29Q1fBG5q7XWlHr/fhC8L
 kz2w==
X-Gm-Message-State: AOAM532+ZHy/4c267OOyBFGSKeyWKph8/48ORpwkBdDr3gbpcc+Y4wt+
 caLy6bwVgxWfOVBf/P443DydTLkVq3vqz4iYOaczHw==
X-Google-Smtp-Source: ABdhPJyMg6MhiIOcFHjcOVQkx/tQDtgvxHvhs5UQwjveESR8ymYMNRQzTqqwbnITRC1VRTzVYnSwjJ61FSvDD6pacIo=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr2458688ejb.85.1601648723733; 
 Fri, 02 Oct 2020 07:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
 <20200922163441.GA2049853@redhat.com>
 <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
 <20201002131130.GB2338114@redhat.com>
In-Reply-To: <20201002131130.GB2338114@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Oct 2020 15:25:12 +0100
Message-ID: <CAFEAcA-PGNqugn-deNMJv1v49GRB=8UbhXYL3Fpko9do4+rsWQ@mail.gmail.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: Dan Streetman <ddstreet@canonical.com>, Michael Tokarev <mjt@tls.msk.ru>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Oct 2020 at 14:13, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> Assuming you're just using git for conveniently applying local
> downstream patches, you don't need the git repo to exist once
> getting to the build stage. IOW just delete the .git dir after
> applying patches before running a build.

...then what do you do if the build fails and you want to
edit/update the patch before retrying? "Blow away your .git
tree every time you build and reconstitute it somehow later"
doesn't seem like a very friendly thing to require...

thanks
-- PMM

