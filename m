Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF03C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0E92086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKFHB+M+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE0E92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBN5X-0007lU-T2
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBN4d-00076X-Pz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:52:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBN4c-000457-E4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:52:03 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33073)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBN4c-00044f-9c
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:52:02 -0400
Received: by mail-ot1-x344.google.com with SMTP id g25so6944154otl.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qHVEWbXReJXqdojqm1/zjyXMsnYbx4GikiKl5DoSRkU=;
 b=bKFHB+M+mh2fxRGhkOuTTF9MiHZNv1kYmdxJo78E9BGgunpdSU3AvuOHLzXUpjIkuD
 5e2ZC+oNC3siA/mEOcwWAGkqGORzgLTkZq1nCgdeTJn6npQ7Qc304GDvvpkAyTMv84Yh
 JLcE7BlW6saXDwaJLAvWKa5Ku8nZCJQdKyDwM1fgDf113q2xzlfmLNkX/Tc5RR3SPMS1
 xJy3pPK7XP8B+3qqonVDEaLJMXyLfCtSvw1n7u2Uuv1OOlYdIC5UU3/C4hzD3Qf8tDlu
 6jiB6Zg3J9ayopSci1i4brgggR+62wHQ58+Z3VLm92ZkGAsYx9hz2dNvsNBP6XnCgYuv
 OFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qHVEWbXReJXqdojqm1/zjyXMsnYbx4GikiKl5DoSRkU=;
 b=VsqujxlDXE7oeC1BTfTnQgDxqwGU833dd3Le39HfZG/FgXBClB5raU3wTkGrZOGudA
 LtImZVfEfW6fvKTH1BjtgyjdFdwKdrqBMpPAvSkQvY0m/0szAHF+ArMci+5+hb6pUxNd
 qFonPSqFBoTKfALREwJZXRdgsAGEn/TOD/uWLZhQPbiykA/h4R5U1I20wC9uSOJN+83M
 mxCY3rbLeK3KQMbyJ6HoK2lvdPg1/xlU7+kfIPpNk9LoOdTggeyZweh9nbeHqQaIoLCq
 yvF+jcii5zzPYEJSC6CWiD3Neu1OvqS2szf8BQuy4O1Tw5DXuruyafvwBSwoFcgRjsui
 ADoA==
X-Gm-Message-State: APjAAAXEG77XBxUuQQcp4SxM/2vIO/ClTnLtyV1iKXfKnDemjwUwq6Yh
 cukfT3r/dM5mvqAxHy/ndnYlRfrbv4mETbaafA/Dhw==
X-Google-Smtp-Source: APXvYqwgQ5O+3zGgHPgH/9gBpOJ7qHiZxLRMFUMgmay33868jzSTbXH+GoRKAlg2Z3ZeOfLlaUaiEgTl2Hk/s4Vs7sA=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr12473992otq.91.1569001921387; 
 Fri, 20 Sep 2019 10:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190919213924.31852-1-minyard@acm.org>
 <CAFEAcA-wEcsRDSjs-QD2kWspTx=mHmcY9etO7KgPVcyRh_XxUw@mail.gmail.com>
 <20190920173653.GE31565@t560>
In-Reply-To: <20190920173653.GE31565@t560>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 18:51:49 +0100
Message-ID: <CAFEAcA8pd795H_6cB6u+yjfpwtu8f8WrF8nN5ozFS_F1r5nE5w@mail.gmail.com>
Subject: Re: [PATCH 00/15] ipmi: Bug fixes, add new interfaces
To: Corey Minyard <minyard@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Fam Zheng <famz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 18:36, Corey Minyard <minyard@acm.org> wrote:
>
> On Fri, Sep 20, 2019 at 01:57:48PM +0100, Peter Maydell wrote:
> > Hi -- is this intended to be a pull request to be applied to
> > master? It's in the form of a pullreq but the subject header
> > says "PATCH" and you seem to be asking for more review, so I'm
> > not sure...
>
> Dang, it was meant to be a pull request for master.  I would like
> more review, and I didn't think I would get any, but it turns out
> I have gotten it for the most important parts, so pulling it
> should be good, I think.
>
> I can add the reviews and request a pull properly, if you like.

If you got some extra reviewed-by tags it would be nice to respin
with them added, I guess. You can just resend the cover letter,
no need to send all the patches again.

thanks
-- PMM

