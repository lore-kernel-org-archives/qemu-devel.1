Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3E1C18E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B19D2051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pL+dBtWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B19D2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDq8j-0001XW-9w
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jDobd-0000Rj-UZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jDobc-0006Bo-FJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:29 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jDobc-0005zq-9e
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:12:28 -0400
Received: by mail-oi1-x242.google.com with SMTP id b17so2528813oic.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xA/NkwmBQS1Ovh/Xq0r0lrVPATIm9+TuTnIjrlEFY8Y=;
 b=pL+dBtWV+hPjTE18GX3gS/DP3w1IA0EvZqVpgxznSgI0vsX8H5qW4bd/KmEGh3SFIT
 igDOrQI0ajFrNdD9DPRTzf4aOrm8nrHfFGAlB+ZLC7tjT02b46vRl5MyMc/EdNfZlzZC
 pr6FrRlRzGTu3SoWfe4IyejIMxio1JEXxQP3aQfIBryTLy1Ur5z1f9/WDPiNXVoFBw98
 gWDTF97VAsWADMqwYINizkuLDRsT1hKDxTLnKjrAFxQaSHXIZpoJ2on4h32mdQ4tEc2e
 aAmpAleBGrA2d+RG3f/U0AFFhui3bOHzqeZKvQxshe1kTopsL+9Mp6yEfwXeflM76Lsx
 AHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xA/NkwmBQS1Ovh/Xq0r0lrVPATIm9+TuTnIjrlEFY8Y=;
 b=L8vEq38Nd9EbquIBaypYKnetpDVlnMZnEOALJ+tdVym6JLqeyB8vUtT5jBJWEvky8+
 ti1R6lP448QofvwwwxGp1DjezTWpb/6GJHvmXW349ctQUcmtCeVoKxPAzHeUqAVG/04z
 8RFuApPzt2oVQ703w08V0Rrmj9sSFH68FGgIRJYiMDoWgxjs5h7uyRVS4lZJMqteqv86
 ieBBryh5AnQfnv6AGbsZg3DYLz7IVdD2s7nlpK6p2STSmtd8wjo+KFliGxY91Jd6Gv4e
 AJBLRLOSvykmHjdMF0CpFTnsLpgdj1q7mpgTt7COLT1KrXad0Du902yoPY0EdYUbSYuJ
 ulHw==
X-Gm-Message-State: ANhLgQ02UHSKpDGrDgPE3++DlMfTr1064kg9seHQNAKR0CsuUrldnO62
 APKFyGl8CIkt6LWqPoN2BHQkC55zc3q8/tI1oTpHwA==
X-Google-Smtp-Source: ADFU+vu//EMTq90o9vQiWKqx72DkxmkAoGtZEN9JXuzbrpClRgeer3NU6+J49pc+PXOVBiR7tP6+fVEfTvddrDlzRjw=
X-Received: by 2002:aca:190f:: with SMTP id l15mr6339972oii.48.1584360747205; 
 Mon, 16 Mar 2020 05:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
 <CAFEAcA8=3zcffu8FYEenyNR5O=kHh8OJmMCJj6Uwh5HJw_b-WA@mail.gmail.com>
 <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
In-Reply-To: <1367332727.1329619.1584360253413.JavaMail.zimbra@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2020 12:12:16 +0000
Message-ID: <CAFEAcA-jiZ=Pv7Co6gdkqKans=m6-9RwKAQuB9mri-baM5Gssw@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 at 12:04, Cleber Rosa <crosa@redhat.com> wrote:
> A few possible reasons come to my mind:
>
> 1) It usually takes a few seconds after the push for the pipeline to
>
> 2) If you've pushed to a repo different than gitlab.com/qemu-project/qemu=
,
>    you'd have to tweak the project ID (-p|--project-id).
>
> 3) The local branch is not called "staging", so the script can not find t=
he
>    commit ID, in that case you can use -c|--commit.

Yes, the local branch is something else for the purposes of
testing this series. But using --commit doesn't work either:

$ ./contrib/ci/scripts/gitlab-pipeline-status --verbose --commit
81beaaab0851fe8c4db971 --wait
ERROR: No pipeline found
failure

On the web UI:
https://gitlab.com/qemu-project/qemu/pipelines
the pipelines are marked "stuck" (I don't know why there
are two of them for the same commit); drilling down,
the build part has completed but all the test parts are
pending with "=EF=BB=BFThis job is stuck because you don't have
any active runners online with any of these tags assigned
to them" type messages.
=EF=BB=BF=EF=BB=BF=EF=BB=BF
thanks
-- PMM

