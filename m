Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C230C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 17:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6757B206D7
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 17:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdk2Bpdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6757B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzOGD-000095-Ey
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 13:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzOFT-00088l-8p
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 13:46:15 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jzOFR-000812-Ot
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 13:46:14 -0400
Received: by mail-oi1-x244.google.com with SMTP id 12so10883792oir.4
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Qmg09JC1kJW8R0gGE00bUJ+Q2k6CpWQe/OA+hyrWSc=;
 b=qdk2Bpdw9FtKNWjMdtE4cMUspO8210eMGvSHDWYvy2cAFxr11/5yla3WgHXxNJ1PIh
 wtIqsrb20PJXqK97VekJTDWoxZy9961NXvpC6Y+Gvx9tuOFGruhi3zDXhpgRlQSzZ2Rg
 Zeb3cAItsp62R1hAkgCSmIOaJ2LPmODYBC3WutIVuiil1nXFBv8DA5gKSYBusC+QJODv
 85HP3fjSgujD7I5xizyCkrDYxRD7kpa+HmjaKjXBzZy+E+/jCtAFYXuHSOMJabKaXhkO
 z1TFba7pYs/7lXCJWL38p7dsCcs3smiaEC2FHTVSHDs1AkCGxmuqrMHvJmSj6dRfERJN
 sGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Qmg09JC1kJW8R0gGE00bUJ+Q2k6CpWQe/OA+hyrWSc=;
 b=jcF7duxF57jajhAeLbFJiun/2TO4qL5r7+hi2GKyI5pXQQ8Gnj5i8br7jZ/Dqa/h+N
 AUV791gxDR/vJPXKF8OTkVvc1uLko8HYDVa6nfehzmAeiX0UTPaDEFH/SOgAHvrYMaCl
 Nl8kp2t3SGB5HHEhK2VQm66UVb4HlyRbzgEFUaQRKEkDuZ9l1BPgf7gKV9wXZkkB1QVG
 YH+kgn6wmtnxRKm9HzEokn3FN7WqBl7tu51zMSNDRfTC3lXIls/yVH/eRO8No6iQP+0O
 q/AWkCFRzSf3HHqEPuY00c4PUUgGzsvhU/HH3b0NZk6BLQl74AmjMzRL+SlJw5cWh43y
 iaHw==
X-Gm-Message-State: AOAM532/Xp3N02CH0oqxmHs+DRDN0DGt0RBorak+fv+mxRt8tqakIJ29
 AJgohMT4CIHGKSB5qErbSMfsY+iYvaOTNqhi0fctOg==
X-Google-Smtp-Source: ABdhPJzR3wBs7drcH4FUpLCFhXqn20L8ECko3UWk/8A5Yu64WKMq7QFMnhj5Lt9G2SOS4h+ZSAFF9VC0qNI3/o9BVf4=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr12678878oib.163.1595699172382; 
 Sat, 25 Jul 2020 10:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200720160252.104139-1-jsnow@redhat.com>
 <20200720160252.104139-2-jsnow@redhat.com>
 <20200720202038.GZ1274972@habkost.net>
 <c3989867-effe-e763-dbc7-705d5f3827c9@redhat.com>
In-Reply-To: <c3989867-effe-e763-dbc7-705d5f3827c9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 Jul 2020 18:46:01 +0100
Message-ID: <CAFEAcA8LWMp_GPaDCoMmASB+moH3wsxxR4=g27yVpOnmz3WoOA@mail.gmail.com>
Subject: Re: [PATCH 1/1] python/machine: Change default timeout to 30 seconds
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jul 2020 at 17:31, John Snow <jsnow@redhat.com> wrote:
>
> On 7/20/20 4:20 PM, Eduardo Habkost wrote:
> > On Mon, Jul 20, 2020 at 12:02:52PM -0400, John Snow wrote:
> >> 3 seconds is too short for some tests running inside busy VMs. Build it out to
> >> a rather generous 30 seconds to find out conclusively if there are more severe
> >> problems in the merge/CI tests.
> >>
> >> Signed-off-by: John Snow <jsnow@redhat.com>
> >
> > It's weird how the hard shutdown method has a more graceful
> > timeout than graceful shutdown (60 seconds vs 3 seconds).
> >
> > I would make both have the same timeout, but it's better to try
> > this only after 5.1.0.
> >
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> >
> >
>
> Peter, do you want to take this directly to see if it starts to fix the
> merge tests for you?

Applied to master, thanks. We'll see how it goes...

-- PMM

