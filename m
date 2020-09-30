Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A15BC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 865F720719
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjdH5pyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 865F720719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbhd-0004pj-Fb
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNbh4-0004Qw-0R
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:58:50 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:34537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNbh1-0001vk-7W
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 08:58:49 -0400
Received: by mail-ej1-x643.google.com with SMTP id gr14so2705546ejb.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y+TNjGoI+Ocb1adRNgHqoQccGj0PrNfs+A0+zkkc4To=;
 b=SjdH5pyIv9E+EyPg5Z0YxDdN294+Ngt1l0bsN8EPQ/TXDoo35d/CneDjZdMBAZ0lv+
 EFYODcCOOvVHniLErEoKreDiItP6nFv7jYfzrpITIKvuK9hKV4RPtI077jyMl/RsC2Zn
 +Zc7c4Kzm+j0NXzOpVtGdpbvf1hnXu48iK+QyBUbsJtGws92y/wOXw8c/5n2FA0swfQR
 /0apv6X2b8Ax9S+lPzv3NkUK57/i+Ko/9mvRzE2r16Z5fnaKz7xH4f2aYb24Qu6C5aDN
 z4V1ICsm9Cdj+DGgASTBhEFK9Dkn9Qse1y8EbW22O/T6ve+91sqpHPVmN2Hox92ymofF
 Ax9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y+TNjGoI+Ocb1adRNgHqoQccGj0PrNfs+A0+zkkc4To=;
 b=jOWfWHaPe4Dr0iZNP57f+L6Q8nUBwU8D9+XLA65RO0K9zZ9yV1t3WwTGguove4SvYN
 GSDaWYNL88JQHbIo0z8ZrUWeqzg2XQy8yhxlhbOrs+TTCQhP+a+GxHp2LPpPpkj+ffDU
 pkUE2OR4h+ZmkZ3GN3hn83xbXb5IOfkWiRhHVo3xP/dXoOfH/vHcw7RFpbT9XytXiBAE
 GInddsVROSyB+LTc5420Tq4adfGJIGXMh7YqIwZlynIHSeZJSZ/PZBhTRNqWWcuxIwFp
 S8pTVeQzVZPKjTOn6JrwOcyB3Z8GyZqiId1fhj4MOwaCH89UY/Dqhho4Phd1GbTzmrZz
 /FAw==
X-Gm-Message-State: AOAM530wOfgjk71HjaxZ0zxyoWlELEv8IvKwi1Z8EliMsZjzoxnbwJG9
 WXfVNVk/1ie1LNWIZyW6nCv60sirzN2L4b6mmkhT4g==
X-Google-Smtp-Source: ABdhPJzX3Mo3D38dVxEDBWvuYhIWf7dye1snjA6WTVOzVVT1feb69drsPoCQWLxEpLoF7M/Txy+6+ffDGW4jeQXopxM=
X-Received: by 2002:a17:906:71c9:: with SMTP id
 i9mr2629240ejk.250.1601470725173; 
 Wed, 30 Sep 2020 05:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA-wMzZhO-9EdYhPC3aoPatQ-JEtBJ2nSjGepRbLs-5AdA@mail.gmail.com>
 <e0a62d48-62dd-992d-6ca4-25587217966c@amsat.org>
In-Reply-To: <e0a62d48-62dd-992d-6ca4-25587217966c@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Sep 2020 13:58:34 +0100
Message-ID: <CAFEAcA9i6DGTUpbxX-1nSPnpe6w3WbOiUmvy8Q9xh2Fg3EESXQ@mail.gmail.com>
Subject: Re: use of 'apt' in scripting in our dockerfiles provokes warnings
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Sep 2020 at 11:43, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 9/30/20 12:33 PM, Peter Maydell wrote:
> > Also, any idea what this error is about?
> >
> > #4 importing cache manifest from registry.gitlab.com/qemu-project/qemu/=
qemu...
> > #4       digest:
> > sha256:815fb44b573ac7520d148d9b2510c00f31846ca6fa55127d322bc8db3c5d0ec0
> > #4         name: "importing cache manifest from
> > registry.gitlab.com/qemu-project/qemu/qemu/debian-alpha-cross:latest"
> > #4      started: 2020-09-29 22:57:54.371490684 +0000 UTC
> > #4    completed: 2020-09-29 22:57:55.064468936 +0000 UTC
> > #4     duration: 692.978252ms
> > #4        error: "invalid build cache from
> > {MediaType:application/vnd.docker.distribution.manifest.v2+json
> > Digest:sha256:a1e8a5830bb19b7cddda64872c5d71a0337d4b98bed30fd7684d20467=
adcd289
> > Size:1161 URLs:[] Annotations:map[] Platform:<nil>}"
> >
> > It didn't seemt to have an adverse effect...
>
> It seems to come from '--cache-from' from commit e6f1306b10,
> there is some DOCKER_BUILDKIT black magic involved.
>
> What is your 'docker version' output please?


e104462:bionic:qemu$ docker version
Client:
 Version:           18.09.1
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        4c52b90
 Built:             Wed Jan  9 19:35:23 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.1
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       4c52b90
  Built:            Wed Jan  9 19:02:44 2019
  OS/Arch:          linux/amd64
  Experimental:     false


-- PMM

