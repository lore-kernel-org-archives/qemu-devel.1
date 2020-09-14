Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCDCC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D021720EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy30gJyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D021720EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHr6B-0008Eu-At
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpZg-0001rs-Vx
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:35:21 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHpZf-00035t-5a
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:35:20 -0400
Received: by mail-ed1-x544.google.com with SMTP id l17so17812920edq.12
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y+cs9bt4xfJAtGPuMnNnQL0IUVSo3GVRsmbO1VjuISY=;
 b=Oy30gJyzE9MacJWqpcnIeVzw7huUDAo4BeYJJs/oQam+Xoli3S5J+n3SHjz2RPQtAH
 RrOL3uCDnfV3EJCyYkrylK/+SOn2G0zXNxrSPMnpPxD6urIc6osbaWBz3NdXLcmd8rCT
 I1ORjGFYkfqsVkqnu2veJTE8txAye8mWcR76k0xeyJGPnbtFv/udtAC1JFqVaOMFzQv2
 bVb+RuH9QlJJBSJxzIEEQFOsKwhLsRVn7HOW71dH1xkBPW1GLc66toXxDs/PC2s9EuPy
 gKqPMZC6j4N7sq9VVvd0LHT44cFQ7Cf7bpHJX/jmwTrvYK9FvXZjrTgiDtlUPZarCc5E
 eQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y+cs9bt4xfJAtGPuMnNnQL0IUVSo3GVRsmbO1VjuISY=;
 b=DIryJQQ0XiACembY3uMR25KDoDVvxwNZIyYD4WHFODgK4aZPz3yTA/j/KyAoWJlyM8
 dQmABxcCe20C/P2aiIaFcPehKVr8mIyHRIrNFYv9owOYzgqxsgPtZHFuj8Rzi20tceER
 bM9WkF0CVVIwuipwQhT3fF5aZ/0PQxd3b8qapYps4Y8j2HMUVHYSjDQb29oufdBk/HC8
 VPRsQAW31YPBqdih2o9Hv31/alhcda5ERK0RFrQYctcv+KoK8lE2jy7wcecUOL0ydnPO
 Df1Ox3NTyr3/ouoEWhJoIQyXs1Jhv3nNyZrtlsL1oknXhffQGO8uEX+/T7Q2YSw4fnxd
 IcpQ==
X-Gm-Message-State: AOAM531uOypv4Mp3nm9yFD5+ttYCvLWW3Tiu6kR34euUY+M9yBDEMFjR
 oU6cwN4JtKA2VeV+KLyhZ+nJqFpC8P1HX4rFF8laIA==
X-Google-Smtp-Source: ABdhPJwjgjApoqbZDJap7Run8v4lYS2WBK+bg8hFH//3sISTeGHeiWPbFFYNG5i+NkPx0s9vMU3wnsKKgWun6pzYQlY=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr17237452edm.44.1600094117306; 
 Mon, 14 Sep 2020 07:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200811104736.17140-1-stefanha@redhat.com>
 <20200914142146.GN1252186@redhat.com>
In-Reply-To: <20200914142146.GN1252186@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 15:35:06 +0100
Message-ID: <CAFEAcA-_DMaQrfVOBpEDcvQrKoXAPF4nUVkL9-T_KmvwDi1NGg@mail.gmail.com>
Subject: Re: [PATCH] docs/system: clarify deprecation scheduled
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: Libvirt <libvir-list@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 15:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> So we're changing
>
>   The feature will remain functional for 2 releases prior to actual remov=
al.
>
> to
>
>   The feature will remain functional for 1 more release after deprecation=
.
>
> How about
>
>   The feature will remain functional for the release in which it was
>   deprecated and one further release. After these two releases, the
>   feature is liable to be removed.

I think the thing which tends to confuse me about the wording
is that it's phrased in terms of "releases", ie point events,
(which is OK for users) but the developers who are adding
deprecation notices and then removing features probably think
more in terms of "release cycles" (ie the periods of time between
the point events), or at least I do, so I have to mentally convert
"functional for two releases" into "so if I deprecate it in this
cycle, then I have to leave the code present in the next cycle
and then am OK to delete the code the cycle after that".
But I don't have any good suggestions for wording, and your proposed
text is definitely clearer I think.

-- PMM

