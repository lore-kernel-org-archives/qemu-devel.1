Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C993CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9455C221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tiofBvPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9455C221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3z0C-0008Kf-Rf
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3ywx-0003Vw-Lc
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:46:07 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:46614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1k3yww-0004jZ-33
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:46:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id p8so631386pgn.13
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 02:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ibHVxmsSTyxvJyX9Gm2Ir4+dXdJ8NjJzgCpXCaB941Q=;
 b=tiofBvPqzFQNH/zXATIsBswU9rwLx8SxmxlRiwpBcC4zAeUg7lyD9nLXoIU1GO/deV
 mwMH44crI1pLGImuteUM/1UD5hucw9daKSnry3hzhDpEqD6IO5xl3eyehskATM/Bd0Ei
 qVSF23m1QboVS6zk31VhdMW4oomG4AhcE5Rkz/8Nysaj1Kp5n/REb0MUqlu8amy/PfL7
 7LIHE59eMCs+HVp7SuZG5icKHp8APpWjMB4v7GJ3zdfXttTE4FSraTnD0dNFwDI27OdK
 wSc0ZcDjItoT34W6wtQDm1KmlKZr/+MzFk383PbMyEDzZChqlkEATfT6LJPZGNTiZykf
 gfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ibHVxmsSTyxvJyX9Gm2Ir4+dXdJ8NjJzgCpXCaB941Q=;
 b=K/FbZhy5v5E96QQdWgYpEUk6Ua0TuQGaKIOX5B+EEynAbfXNYZIJsoOu8F47ePTRDO
 39DZUsGyYc0XxJ2bWr2T40UsxlVDuwOtuepIf2/64Wd9lUH79wmhEe6IWBzT/5jppmSC
 +bJl5o5BnvpfIVFbMitCXXJthBY3qAl7psCmq+NsGuSUIrf2RSBVNouSQnw3rG4sgEod
 xp8YxGrAqplwKlF6w9ec9cQ/u5prbUJGn3DrHd2vF5oFwvQECNqodJbUNp7QneBbIHKX
 NPiV1nzMx4lrPGDXJNxgks+fWK5XzkiealhLPuxs8P2I4g0VEGepaUkGIk/jNuFRUYds
 ULmA==
X-Gm-Message-State: AOAM533E+kaVLBYy6GZ3l3GXJv4eJOZ1VT7dDF3tAPXl3H46xd/M48Om
 9mYhKwpkSVALoTR8HqkjH5EW9PNLU5nzZeNVARY=
X-Google-Smtp-Source: ABdhPJwoNDPg79lBENsB0dJe9KNIzj1ZN8fUIqsX3K0sdkCSGex3A1JgFMzrC5Hm/WSKLgJ5dnfprbcXkRy4hJBaOGs=
X-Received: by 2002:a63:ec04:: with SMTP id j4mr10901562pgh.393.1596793564519; 
 Fri, 07 Aug 2020 02:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
 <20200806115148.7lz32dro645a3wv6@mhamilton>
 <20200806120130.GK4159383@redhat.com>
 <20200806133845.maouiwnazkjtpklr@mhamilton>
 <CAJSP0QWJV=DrsAmVR7Mm9Gb_YtMiwE0geGTvq_R2tgQ=BCxKUg@mail.gmail.com>
In-Reply-To: <CAJSP0QWJV=DrsAmVR7Mm9Gb_YtMiwE0geGTvq_R2tgQ=BCxKUg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 7 Aug 2020 10:45:53 +0100
Message-ID: <CAJSP0QVx-oY6bq=1+5r-b=T14r17dZa+9WG7r2D2nJFZPKr1ow@mail.gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Dave Gilbert <dgilbert@redhat.com>, "Oleinik, Alexander" <alxndr@bu.edu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 7, 2020 at 10:27 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Nice, but AFAIK QEMU still lacks the ability to process those files
> > and run the vhost-user device providers by itself. Or perhaps I just
> > can't find it (?).
>
> How about a Python script? It can list available vhost-user programs
> and their options:

Another option is systemd unit files. It's lower-level than a
dedicated tool but gives full control and it should be possible to
bring up an entire set of processes using a single systemctl command.

Stefan

