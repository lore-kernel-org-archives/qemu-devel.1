Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676AEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B8B20771
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wMVZTDiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B8B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5v7b-0002HJ-Et
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k5v5f-0008JW-7C
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:03:07 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andreyknvl@google.com>)
 id 1k5v5d-0006bl-ES
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:03:06 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ep8so1527335pjb.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZVCJ0LIzd9SJelM1RaTPViAl08SZjKaUJOlZxjIyNiA=;
 b=wMVZTDiWfbRIB9An+AnVlauHRbWoykZgCj2QkfFkRa6tyDDYU8eYcrZQ4a5HRf6Hop
 +28ZRsA+6AxgxEaIUhr2Ozi125TqgzR/bew44ACW2Z2Ao1+5IOioaZ3pitv9ydePGEkl
 eEUnAH/r4wXc31Nda/kilHT8DSVG93owMoTA8nFHKfrBxNVbnrUpKapO5nxYlzocBKth
 WzrIh0nM+hHX0RcNaFKF2Z9Q7NpY2h2+wctNoB/qL3ob4xtN163M5ZIhgjIvdauP7EwI
 zsz4p82guJdRS7+5YtJPVOJerTbkC8szIo0Dbhhb28otAfcAN3xuZ6xx2xLZFnwhUDOc
 5zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZVCJ0LIzd9SJelM1RaTPViAl08SZjKaUJOlZxjIyNiA=;
 b=R2QESYZcAkAmWrDk3EpSSDc3lkoc+D54j8el3i7nY+7UC18MoA08IlEXfSSrNjiUPD
 ON+N03eifj2YvXCu+yWU7SML2BN3nPLSn7S62BHjoP44NrIk6IQhWV5hhkRRmmCtEJsg
 dwL/loU7uifxR/aaf9wz1RSvOAuLahRqMDcTFR/mXIKu2awupkf0fY8BthbVBiKajb/C
 n19FwNUpjHkkR3tGEOK0rtT13FhaP1mYJZSRFRRS1HVbbQuJH8HGBeJemlReY4ZiLjsL
 7bq71GEkfzFA13HgoGu0224RnnWIa8Gf1gbhPMc4fgWMSXRWXRms+M2XA9OyxKMb8FbM
 8Tvg==
X-Gm-Message-State: AOAM533DWcdyd+LyyZY+L2MM/7CfuTEcWaWETEFZjO2vKyZJIMmFMuud
 S1BpZvqt9HkXsLBFm6iRaAsbRwPblSVrzw64S3jI/Q==
X-Google-Smtp-Source: ABdhPJw0CGnTfz6WuONf6Gto3junK0z2193RYXeokxnmJkuo8f9PDlOqkWpHvrF1oXEPqON4pHKj/bEc5FAfDG35Mn4=
X-Received: by 2002:a17:90a:6a8d:: with SMTP id
 u13mr1156064pjj.166.1597255383709; 
 Wed, 12 Aug 2020 11:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200812171946.2044791-1-richard.henderson@linaro.org>
 <CAAeHK+z=CU5dQepy+SBtVMAp-=k8BODorG768CYwoR3NEKCWFg@mail.gmail.com>
 <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
In-Reply-To: <b2d524a2-1523-d03a-72a9-407ab03fa897@linaro.org>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 12 Aug 2020 20:02:52 +0200
Message-ID: <CAAeHK+zD3ZdjpZOBny3QuYtKe-qzhmEfd9w+nr3NrzEuzHHRvw@mail.gmail.com>
Subject: Re: [PATCH 0/3] target/arm: Complete ISS for MTE tag check fail
To: Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Branislav Rankov <Branislav.Rankov@arm.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org, 
 Evgenii Stepanov <eugenis@google.com>, Elena Petrova <lenaptr@google.com>, 
 Kostya Serebryany <kcc@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=andreyknvl@google.com; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 7:52 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/12/20 10:38 AM, Andrey Konovalov wrote:
> > On Wed, Aug 12, 2020 at 7:19 PM Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> As reported by Andrey, I was missing the complete ISS info for
> >> the Data Abort raised upon a synchronous tag check fail.
> >>
> >> The following should fix that.  All the twisty little rules for
> >> the ISS.ISV bit are already handled by merge_syn_data_abort.
> >> Probably the most important bit that was missing was ISS.WnR,
> >> as that is independent of ISS.ISV.
> >>
> >> Andrey, will you please test?
> >
> > Looks like WnR is now being set properly, but SAS is still always 0.
>
> Are you looking at ESR_EL1?
>
> On page D13-2992 of revision F.a:
>
> # ISV is 0 for all faults reported in ESR_EL1 or ESR_EL3.
>
> which means that ISS[23:14] are RES0, which includes SAS.

+more Arm and Google people

Is this known? Do we not get access size when MTE fault happens?

