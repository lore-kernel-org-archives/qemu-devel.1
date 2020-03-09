Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD40C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54ABD20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ATH0JDLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54ABD20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBLgF-00017v-Iu
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLfP-0000Y3-8j
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBLfO-000181-59
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:54:11 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBLfN-000156-VQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 12:54:10 -0400
Received: by mail-ot1-x341.google.com with SMTP id j16so10272526otl.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BQnAqPzr5DDvBpluWBDNO8W8klH/WinH9MZYi++wetc=;
 b=ATH0JDLbOjq/PDbEGeLwUeIzkkbtEyo2IYRZRvnIjJE9NFHLG73jydaHTx3XATqPHr
 1P2jbyZvmp5Dz2A6cKZQ/8XQuEI1q8vzabxNn4ykypT/21LU7U7w0YyuYrBMq0NwOl4I
 qjbXIuoafV7Iz03lhzGj/YE+nN9JJlNuUaTLy+qOBQRDmvFu3iN344j7lIUIvMNm813H
 1wD7C4yfto3S6lE0yCdKSDQq6Ygh2nZNK/fkiGXgpfe8qtBaBr3R2sBvABIElnWeHtNC
 W3zT/K7fuvdiORRHZk5jvTiv1H4ePwcgr9u0JOd7G7iwdHcN4s6/Th/LtYbwbm5R+xxH
 6SXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BQnAqPzr5DDvBpluWBDNO8W8klH/WinH9MZYi++wetc=;
 b=O06iT+z+/VeBMXOB4RUxdETUkql5U6ZjM0iEjY08H7qRHip1yEYvUbpkQHR1VUzEZm
 s5BrblE2G99hOtEhoMLJC7cquf3JZc7Agtx6Ft4a2V1wK7nSQuahGjT6+EKTvTxrKhLV
 bWSzZMYZDSBp81iVs3bplAvYJsh9urkMFmsYEuBq3L/u47PWn+iuTWXF+IMdaXWjcEHm
 KXctCdutRaKSjzLqDdWNRuFZEHpaUuvep55VqNH6Yi1k+gXDZ9oRNnMC1iIktmnLcbF0
 Ov1DLO/BKbIDEgGyL59BnIi7WtNorN78JyUnAwGRtK/XP4X6SBt3zvYNPxEFsyHZbmsd
 vn8w==
X-Gm-Message-State: ANhLgQ2aA40FyC9yAR/buH0wUZfdQG3bRDiFVluERckngyR2CemEfDaM
 EUdD0jHvpGt8nNeykeq6nM+Z8/COWbGIA1v1IhpFfA==
X-Google-Smtp-Source: ADFU+vszFYzymuRQjSSgFO5C266qZEk9LVwkoGifAB3yp0LTDkjRuVtZIuIYHEiqghCgV8+/NqwIixNKS8YYC0RTgbg=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5077156ota.221.1583772848922; 
 Mon, 09 Mar 2020 09:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200206112645.21275-1-clg@kaod.org>
 <7ab3522d-54ae-ca24-592e-68d54e47de7d@kaod.org>
In-Reply-To: <7ab3522d-54ae-ca24-592e-68d54e47de7d@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 16:53:56 +0000
Message-ID: <CAFEAcA9cQx82NgpXR5h7pX+NJY4dxjy-JaLk14d7GriNLeTpCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] aspeed/smc: fix data corruption on witherspoon
 machines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Andrew Geissler <geissonator@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 16:32, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 2/6/20 12:26 PM, C=C3=A9dric Le Goater wrote:
> > Hello,
> >
> > We have been seeing a squashfs corruption on the witherspoon-bmc
> > machine for quite some time. It boots but quickly after boot
> > corruption errors start to fill the console. This machine has two BMC
> > chips with UBIfs on them. The romulus-bmc machine has a similar
> > problem when both PNOR are enabled.


> Hello Peter,
>
> If you have some time to take a look, it would be nice to get this
> fix in QEMU 5.0.

Oops, I think this just fell off my list somehow.


Applied to target-arm.next, thanks.

-- PMM

