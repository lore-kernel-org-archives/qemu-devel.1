Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58507C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D2492077D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owzggJ44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2492077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBLJ-0001r4-CJ
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 04:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juBKf-0001Pl-SX
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:58:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juBKY-0000DH-NH
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:58:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id r12so8083325wrj.13
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 01:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=GSbfrUNbz6R8ALH9UTb1I8WKnSfcO4troGKG5DndSDU=;
 b=owzggJ44bNHf2h8PEGsiSIGzdKEjs6n1sVSIOy9llhGCHsZMju/kXtlDPf4LCl3n2S
 FmmYv0SNp3dGI+pu1AYIc3GYfm8OG2O3UdohGkrKRZ1yqi/nkzTm2Ueu3Sh8A0+2PCHQ
 sXEVzLyJi0Da926LnhmLce37Q6Ls0f0xLCSaDrMuIAW2MOX1Nh4oAC+cFNT9OBl9pOyx
 5UhEP/K2kGXUwYVN1gvjB/6tg34MSbUnvqmdSCegJMWWFnQftB0f10/EvTlRrHMSYWHW
 BCHrVHiD8w8emN4oA0p8okRC+5z+RqQfQbU9Y6CLwUd8KA7Mt4g1PxRF4UXhLPY9qa3D
 L95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=GSbfrUNbz6R8ALH9UTb1I8WKnSfcO4troGKG5DndSDU=;
 b=Szqw26QmYfxXiXFs+SAS+YJOkcWGe090Q1Z8+q6lseZjhkfSE751+wTfPlIfFt+n1b
 qqJf6MLpoI5hFSd3e/QEwMbQxYYI0x0Uyn3q5G4oZ9VqHe0k+IBLSvplrGvwVUmM6RW7
 AObgLywOXPFl8avAEcU+VUoc8A5Jg+93h0URwoo3r5OtlS5qAA/oiLZW7lcfo6E5/Hsx
 PO+/YP0+vyVTURQZu9gLG2FEheIZuRDprCjTvSaoH8IFdv78GQfl8nQYZumbq0bb5HTh
 VbaVaY5X82+FNZRDscHdHb+d4/53vbkgH53Wtbm87Ctc0HhvE6oClnBfvO1WF1bVrlHH
 IvRw==
X-Gm-Message-State: AOAM533hBOi8PX78rTKKneuBB3xfrDH/E73dT37zwku76ZztDglY4li3
 5feOcixvJo14Sva5a8Awl03ZFg==
X-Google-Smtp-Source: ABdhPJzsfVZKXO/MBtgoZOWpzuc1RosxvfCbL4naeaBxYk56QHfYBYctniiXSkxsjZA8fXqc18Wd8g==
X-Received: by 2002:a05:6000:1206:: with SMTP id
 e6mr41019125wrx.346.1594457876898; 
 Sat, 11 Jul 2020 01:57:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 51sm14743372wrc.44.2020.07.11.01.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 01:57:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 386D81FF7E;
 Sat, 11 Jul 2020 09:57:55 +0100 (BST)
References: <20200710163253.381630-1-mreitz@redhat.com>
 <20200710163253.381630-3-mreitz@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH 2/2] iotests: Set LC_ALL=C for sort
In-reply-to: <20200710163253.381630-3-mreitz@redhat.com>
Date: Sat, 11 Jul 2020 09:57:55 +0100
Message-ID: <87tuyeqvho.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> Otherwise the result is basically unpredictable.
>
> (Note that the precise environment variable to control sorting order is
> LC_COLLATE, but LC_ALL overrides LC_COLLATE, and we do not want the
> sorting order to be messed up if LC_ALL is set in the environment.)
>
> Reported-by: John Snow <jsnow@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Queued to pr/100720-testing-and-misc-2, thanks.

I've skipped patch 1/2 for now as I have an alternative fix but we can
switch it back if you prefer?


> ---
>  tests/qemu-iotests/common.filter | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common=
.filter
> index 345c3ca03e..4fd5c29b2a 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -177,7 +177,7 @@ _do_filter_img_create()
>              -e 's/^\(data_file\)/3-\1/' \
>              -e 's/^\(encryption\)/4-\1/' \
>              -e 's/^\(preallocation\)/8-\1/' \
> -        | sort \
> +        | LC_ALL=3DC sort \
>          | $SED -e 's/^[0-9]-//' \
>          | tr '\n\0' ' \n' \
>          | $SED -e 's/^ *$//' -e 's/ *$//'


--=20
Alex Benn=C3=A9e

