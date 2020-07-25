Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FACC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEE520674
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 16:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xklen1zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEE520674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzMyB-0000tY-9U
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 12:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzMxS-0000Rn-PN
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:23:34 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f]:42363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzMxR-0004sh-2z
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 12:23:34 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id y9so2399967oot.9
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 09:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SW5cWxj+4yTdrWwMXYJTqEUZQOkkVQZheG2HlhKaAI0=;
 b=Xklen1zSdjkHb6amkCZ31+SZs6BucZisjPZYXHPmwMsS6f4yl5bNr9qWI7Xfi8Q6lB
 NVafSTCidzYGUymI4rgHJgupl14oFxo/7yh17Cv5ASghSofr2ozKpCJDr3QcJNJQyhq6
 a61nJdf8x6tzQlYr2ep0XGHpjgqiJUr2HaUIBRp2FoZ98PeXKr0rzEi5/G2letSIks/B
 0rN58iGEfMbvtKEgCRiBFbuhbNvo7D/mSuXvYc0D476uaJhv4AOFNLEXfTstF92Sm92e
 uz421Q/e7Q9k61sYkGsp1YhyAQSW2SN70/APhHBVR6q6nooZsOFR87x0iAZ9Shx3VksV
 AgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SW5cWxj+4yTdrWwMXYJTqEUZQOkkVQZheG2HlhKaAI0=;
 b=jEqhbIIQHaUV7eMEjebIQgmRhZFIVRzmcrk5a8fq7BWYrrh3vWVYcy5bn/8CEKF+BC
 iekNArqeqYbrNSaJjyexJwl8tWqL4L7W9DczrZc6iGFj5s58HyZQeQaBndZGgMk0YkrX
 cGGU4ka5uctoyGzT3Aaljbtcs4NjnaxtDbqhMw4bR5VTg8380n2h4Qcj8p4e6QWRYtzG
 ZFjK2rHPHVxn5iPuLlKFOI28jp2gePAn7XiqmywBoabeNe/Fj0bQvlBLls+YhsTy9njN
 IU/r6Ssg7OTJhf0fTvx3zfVoEzlGWCz1MXGY58TGevEMfIVEB+K3o2yWq3BJGeMaupwv
 OyrQ==
X-Gm-Message-State: AOAM5315CIM4LFKj7e1Xw1xim1KCNJLAdMqc02yE6JxvdY+n3YaVfThq
 yOPNAt9A7HqmSpZpKlOp71qv8Q27RVM5NhfiZURN5Q==
X-Google-Smtp-Source: ABdhPJy1/vASU1ZYa8gMOwkCcwZIRSzd5u3Sz6O/6QKGfii8RwIrXxYb5fjpN1mtsSMQY1jk/wgIW6PhNRs53A1WmDk=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr10744500ool.69.1595694211533; 
 Sat, 25 Jul 2020 09:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200724134704.2248335-1-armbru@redhat.com>
In-Reply-To: <20200724134704.2248335-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Jul 2020 17:23:20 +0100
Message-ID: <CAFEAcA-wSBw09m6KFwGnb1fOfB1khWDVXVGGT8fuw1LSYv7BDw@mail.gmail.com>
Subject: Re: [PULL 0/4] Error reporting patches patches for 2020-07-24
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 14:47, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 09e0cd773723219d21655587954da2769f64ba01:
>
>   Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200722-1' into staging (2020-07-23 19:00:42 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-error-2020-07-24
>
> for you to fetch changes up to 192cf54ac5408d21c20c17b3794a632970bbb880:
>
>   qapi/error: Check format string argument in error_*prepend() (2020-07-24 15:03:09 +0200)
>
> ----------------------------------------------------------------
> Error reporting patches patches for 2020-07-24
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

