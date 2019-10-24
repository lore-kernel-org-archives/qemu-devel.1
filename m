Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07937CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C731F20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUqomzHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C731F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgEr-0005X5-5q
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfgV-0004Oy-AI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfgS-0004jn-Qs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:09:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43391)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfgS-0004jf-LK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:09:56 -0400
Received: by mail-oi1-x244.google.com with SMTP id s5so5706242oie.10
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CRQTP0QqclB/Q9CjXukjMk6jToaCNMhGrNT1f/9JHwk=;
 b=mUqomzHF1HtJX6R8puwZ49S5vz2jX9wj8gy518geEHaEORatsvFkzBU7NINK0j+Owv
 WxS2kFh6hMoyOzPKj1V8OE/T3pJpbODlUzJTHsLAGwBfIjatw301wudIxa+Zuh/J7BKH
 A53pnzK0+0gGCpEAl5WwDaf9qcqmZnZxgCNW1WtwV13xQlAO2Z0+9bpSCnXiuNqItJ2T
 Shk0sJDemvpe/A9c/fe7MitSaysFLwzSxc5uxEVvq35l1p/lsqFFsOA0Wvh4IlyM+31x
 yUUttI9IBMzfCZLxQ3194t4jdnANnzStAthh+hYveiHQK+svdJ7+Tjp2/FVg15lpsRPu
 4jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CRQTP0QqclB/Q9CjXukjMk6jToaCNMhGrNT1f/9JHwk=;
 b=PC96p7gZRk/xuwCzDFR7Y7yE8syFRKmwj8/HrK89UMvoZrCmQzygynfufGDyia//64
 r9Yl+NeUWN8kjOd5i/L/MNWol/yDAf4qK9zMlW0IPM4/zTN2YhZ7oqG8KQtMzncAkKZw
 wGF0hi1iba7XC69ViPcsbcJs4truC7pGYJjzGN+BBuSKs154TCpA5xEiYjOuB3OM9gtb
 Xk9J8Rq188nSPA4O7jqRIMWdGC1ztjONhlA6Ngk60tSBcsOhUTZNxlyeiY4Wr2mAdrYT
 G+qUUnnEGIyYF6tnjjcWt9vydFUlFX+w3T5KiNMJYgOfIRz3EpGVsQHJ4CIh/TpR3Z2k
 YUjw==
X-Gm-Message-State: APjAAAW180FCFIwHDTZqt45+90hI0twcOpKalDJEkPWlZrF+PRTkvz8Q
 WaIlSYiwBAAiWuanuCBctMKW0ejFLDxqCiS5rPCClHA3v5U=
X-Google-Smtp-Source: APXvYqwuqLg+P/nSgzuIhkvJbGYOojEe0+mMwFLmhy8qCYO8WTncSo+bNV7nBsfpO0YnUqNiBC3USoLSGROgoN7i9Bo=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr5471952oic.98.1571933395520; 
 Thu, 24 Oct 2019 09:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Oct 2019 17:09:44 +0100
Message-ID: <CAFEAcA9uCNm9BxyWJYb22AxWUFm38Es0yqFr4EmT3N_ohmS5Vg@mail.gmail.com>
Subject: Re: [PULL 00/28] ppc-for-4.2 queue 20191024
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 09:18, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit f78398bfe544db81a974825b0a2aa826f6576414:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-10-22' into staging (2019-10-23 16:06:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-4.2-20191024
>
> for you to fetch changes up to 97c00c54449b4ff349f85c6ce409dadd1b935a7d:
>
>   spapr/xive: Set the OS CAM line at reset (2019-10-24 13:34:15 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2019-10-24
>
> Last pull request before soft freeze.
>   * Lots of fixes and cleanups for spapr interrupt controllers
>   * More SLOF updates to fix problems with full FDT rendering at CAS
>     time (alas, more yet are to come)
>   * A few other assorted changes
>
> This isn't quite as well tested as I usually try to do before a pull
> request.  But I've been sick and running into some other difficulties,
> and wanted to get this sent out before heading towards KVM forum.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

