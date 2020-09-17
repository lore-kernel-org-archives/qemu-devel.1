Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 076C320678
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8gofYlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 076C320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kItIP-0008Aa-Of
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kItDd-0002qX-En
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:40:57 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:39660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kItDb-0005py-IX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 08:40:56 -0400
Received: by mail-ej1-x634.google.com with SMTP id p9so3056239ejf.6
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Jx9bQR3SOzEdG3/ANboftMpqjSRIpZ0h4XkgmtrzA/0=;
 b=j8gofYlJY04w/lTHwauT09Tzoxn39Hsg2LxIul/PO3FqF4pwgtGiaGfOkH7FoUIzuG
 3u5IvdJIehdMil6yhxoQKoq2GbXjqSksbRKTvhmxQgoKv3s+2sJMWIGgfpbIV0BA3kfA
 WXG17xNAkOB0fmlUpsBfSl7zI034WCsOcCzkJAZEpqYW0UVgOq0gcS//odI8AKMOt8E4
 9M8ggNLCQUg4O5DL9Olq9LxcHF6pfKdGBQiYmlyL/pY6toNQEuggaK01PliYRgCNVFNJ
 EPOg2rhf+3or8cu6W8QoSgek4paCdHXF4kHvaxDSZVZmr7nxshVLxddRmZQHvkR33dMg
 Pd/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jx9bQR3SOzEdG3/ANboftMpqjSRIpZ0h4XkgmtrzA/0=;
 b=AeFGF3/hrzTYXzuAz7VqCXGwTvpYDt2fIli3SCG3ulqfkqMuczInbiBXfM7yObem4g
 DaGBq4/HAY2XzK818odDf2UCGZ32zDG7ogU5BIZWA7Phok1oy5yvcNWuJ/+QZS3Pyaj8
 4gTURv+BsycsERtCn6aJ+lZJQmVsLZwaPLdYj83+6XvJ7Oj6HJbikuRhb1ABUcAPjY+h
 JMkyzybLrjHY1r1NGKLJ5ParKqqVxw4YUBsyfckIAVM3B3vE+Qw3QI50swvpJwxpynaq
 mF6io8F4iBP5Aqo30amqCQAC+qQ64eUQEHACffITallaj3JVG0SAQniQbLrvfjGaVudh
 sA/g==
X-Gm-Message-State: AOAM531w6jZjsWo56nQ08tPxb62GNPM+JipQ7+kgmoPIW+OI62TjNlb0
 q/a3z0DZ/0P4pEJggwJY/rQ8me6OEWm7vaRyWk1J7Q==
X-Google-Smtp-Source: ABdhPJzJZzZzwNS7cnRtajEYck2mc8ljTWEG44SnEgEIWYMfRIuajb2vcoizvTF3fZUQn7JiJfpMP/57P84TsZdHjrk=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr29133573ejb.382.1600346453688; 
 Thu, 17 Sep 2020 05:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <1836935.RIYQIvKipu@silver> <20200917093756.GC1568038@redhat.com>
 <8e3f59a3-925e-d89f-2073-6c9654bff75f@redhat.com>
 <2029663.ApTj1TM13Z@silver> <20200917122445.GB1597829@redhat.com>
In-Reply-To: <20200917122445.GB1597829@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 13:40:42 +0100
Message-ID: <CAFEAcA8JVV79RbDGfTwA=UFYWnj_SW8aGFHuUw=UJ0jVM8+e2A@mail.gmail.com>
Subject: Re: QEMU policy for real file tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Sep 2020 at 13:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> If creating in /tmp then stay below 100 MB, as it can be surprisingly
> space constrained in some cases.

Also if creating in /tmp/ it's nice to use an obviously qemu-testing
related filename. If a 'make check' run falls over partway through it
is prone to leaving files un-cleaned-up in /tmp/ and it's much easier
to know you can just delete them if they're named 'qtest*' rather
than just 'tmp*'...

(Ideally we'd put in some more consistent framework for temp files
used by tests to put them all in a single subdir or something, for
convenience in cleaning up afterwards.)

thanks
-- PMM

