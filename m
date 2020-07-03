Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6E1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8692207DA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="einKbsbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8692207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJFc-0003dl-2k
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrJEa-00032l-FE
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:47:56 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45692)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrJEY-0006UE-MX
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:47:56 -0400
Received: by mail-oi1-x244.google.com with SMTP id j11so23498347oiw.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 03:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Xe0t1B1OTczk7tDAkJTP5/N3zoJrfuGIFqb847H4X+Y=;
 b=einKbsbT8KKzbVSlx7017XWNRnaCm5FElH3gJ5+fW15sO4xCczHaga6bXTlR/D1QvN
 YuamYH1jhNa/PdeAV2UPIThlJp3O121IeeHoikebTJgsB9NtLP5e0U9DY6QbSu9sryTm
 wnnxWpeOp1RKbfg+LRZ+u2LAPBeBhiJCRtpxCLmbar++NfumO1isCmfq1HRCNPhemMPL
 FUzikKE4MkT0MlasrPhyC5eGkheZwFZ2wRn83O8OpTURYHTrwL6JaeNhjdE/rgUA3vYW
 CtpiLPvKPnP87M5y3Lq5YZ5rj9RJNB9iqb7LdXPlCa4Fyc26pDuZ2cONcFqPg3CuqGvj
 MNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Xe0t1B1OTczk7tDAkJTP5/N3zoJrfuGIFqb847H4X+Y=;
 b=QbbM0pnKy1Qy/ujozVj41B0nH5f6O//Y8tOEQus6K7M5WNYYcHMV+BvF3hm7qrE5o1
 R2K401dQc/01BQA0lZmWLZchSI0mPmHiePnW28k283ZsI6Gd2kn0C6nL9PRigNv4f3zp
 9s+1o2N0R0oQLdTANmUOFQFSg2p3jfYQclBEuXunCyJEeagimKM8WbrJSHn1gWArP7is
 MZRPHer1C60Bnr2C4XgokWhynQEsfjyX4u7xr33ZsJ/sFL7qn9zL/fxdIN4x8hQnze71
 gY35GMTeLycC/43jU/gEXashiZkaRyBXiN7zT9rRVoJ3v1OpWLk2QzZfI/qRSOYIkNEP
 yFdA==
X-Gm-Message-State: AOAM532YfMo+oI9KGFf5mp4D0Lb7ybm1UaRYD2tRj/O13QvBsRTHxyYx
 fRA0rPenUTsKmj/wyhwTJh9ElyjLMIBJpStCEpGDEQ==
X-Google-Smtp-Source: ABdhPJztVPqVMDKLqAlRJ4DR0G8Ng41oXlof6kZ2urUWaX9ZT4PrvtY7e9gEJ3xW1tIX1V663NSVWu5AbhtqQYrZZuQ=
X-Received: by 2002:aca:1706:: with SMTP id j6mr42826oii.146.1593773273414;
 Fri, 03 Jul 2020 03:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200624081349.121791-1-mreitz@redhat.com>
 <fd4e80a9-c7b1-08d0-0ae6-cf74946d6c5b@redhat.com>
In-Reply-To: <fd4e80a9-c7b1-08d0-0ae6-cf74946d6c5b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 11:47:42 +0100
Message-ID: <CAFEAcA_d81NP1iu8kNSypou-rd7aVPznix6VOEoDTog=LX7aLg@mail.gmail.com>
Subject: Re: [PULL v2 0/2] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 10:52, Max Reitz <mreitz@redhat.com> wrote:
>
> On 24.06.20 10:13, Max Reitz wrote:
> > The following changes since commit d88d5a3806d78dcfca648c62dae9d88d3e80=
3bd2:
> >
> >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-hw-2=
0200622' into staging (2020-06-23 13:55:52 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/XanClic/qemu.git tags/pull-block-2020-06-24
> >
> > for you to fetch changes up to 24b861c0386a17ea31eb824310c21118fb7be883=
:
> >
> >   iotests: don't test qcow2.py inside 291 (2020-06-24 10:00:04 +0200)
> >
> > ----------------------------------------------------------------
> > Block patches:
> > - Two iotest fixes
> >
> > ----------------------------------------------------------------
> > This is v2, where I dropped Maxim=E2=80=99s LUKS keyslot amendment seri=
es and my
> > iotest patches, because both caused iotest failures on some test
> > machines.
>
> Ping?
>
> Or should I just send another pull request that includes Maxim=E2=80=99s
> original series to supersede this one altogether?

Sorry, your resend just fell out of my to-process queue for some
reason; I can put it back in the list to process.

-- PMM

