Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AF0C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:50:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5A420721
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 19:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYia2bwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5A420721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVh6G-0006ms-OU
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 15:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVh5A-0006Dz-Ej
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:48:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jVh59-0000MJ-6P
 for qemu-devel@nongnu.org; Mon, 04 May 2020 15:48:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id k12so812099wmj.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mXip+hTjm40HeHJmA7SEyjy60KFb3pj42XQBnMOIBr8=;
 b=jYia2bwG+Oeu2lOXo8cpmr8Caj2oMREfcjxJWdc9snQTbdBtSUwlNh0qv9/KqSkY20
 qY7/xWOvCsZzUbTM+bO0CyO7JfjCMcy+bGY33yRmzTsrJGSGA/RUGuGfcyqFc+OPIdmm
 PhYnE2EPQjYLEgbD4HLsqFS7ghTMocIeEQFN602j9HC2GeY3UeHz8/1dNP7LHt25UKey
 2hSDOgaj0vekcP+JItcSJxRSwVhZ+bp7+Qc73fFndzeGph7IURgxFsasU5aBdLPub1e2
 VrxDyJq4iFUYCgHAnSXbMB6rQEWYQT6RDe8Pfqwejavd0Hj6BwTQsguWoOreyt4HWhbV
 w8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mXip+hTjm40HeHJmA7SEyjy60KFb3pj42XQBnMOIBr8=;
 b=jDVLqF9t4T+wFQoAMhGoygLz6hCT2o5zWhDPXIl2ic+4kXx4vR+mBhzToX+h77Wkoq
 sDd75AwtzkgDuZAqk3gDxIdVZDKS5UGAVA53ybRC3fp/nxnY645xbYyOykFCMrbahyr5
 NWKUHOlzlG6pJUdyQ7I3ALTFLidSAWsUk+KKTcd6/OfsMZtz+vqGIo/qx8WjFuEwKe29
 TQQPV2nstQgwxpUMt7qzaqVusb6p+AzBILYXIgmsP0As8xhj7/V3Llfc2c9U/mRTGhjn
 VKdK4B/D1DRx/H1quU0jVvzNWJ2epCWMwqE3MPzqPrcEh1ApPkGo2uk/qJnoIysqPfuJ
 ozCw==
X-Gm-Message-State: AGi0PuZiVlDoVPzPJ/pepMjKXY2ok06g8JLGqmAUH5CLIX43UStNiikL
 VTHRAoo5ENwDM5zZTngiPaMbFg==
X-Google-Smtp-Source: APiQypIfTZGd45cFLPESsFJKJuaougBc9mc9UJmZmJfzXzRU7lkPjO5ZUOOZmHIE8Etcb1AM9ddPEA==
X-Received: by 2002:a05:600c:2112:: with SMTP id
 u18mr17214334wml.112.1588621729299; 
 Mon, 04 May 2020 12:48:49 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b22sm1858968wmj.1.2020.05.04.12.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 12:48:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0ADCF1FF7E;
 Mon,  4 May 2020 20:48:47 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-5-alex.bennee@linaro.org>
 <ad941829-a2f3-6ef3-6251-0681b36be24a@redhat.com>
 <877dxvke0o.fsf@linaro.org> <20200504021047.GA13695@umbus.fritz.box>
 <bfdd7881-c9e8-d058-52a8-1c88518b90fb@linaro.org>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 4/4] .travis.yml: reduce the load on [ppc64] GCC
 check-tcg
In-reply-to: <bfdd7881-c9e8-d058-52a8-1c88518b90fb@linaro.org>
Date: Mon, 04 May 2020 20:48:46 +0100
Message-ID: <87r1vz5vmp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 5/3/20 7:10 PM, David Gibson wrote:
>>>>>           - TEST_CMD=3D"make check check-tcg V=3D1"
>>>>> -        - CONFIG=3D"--disable-containers --target-list=3D${MAIN_SOFT=
MMU_TARGETS},ppc64le-linux-user"
>>>>> +        - CONFIG=3D"--disable-containers --target-list=3Dppc64-softm=
mu,ppc64le-linux-user"
>>>>
>>>> Cc'ing David, since I'm not sure about this one... Maybe split as we
>>>> did with other jobs?
> ...
>> Hrm.  I'd prefer not to drop this coverage if we can avoid it.  What
>> we're not testing with the proposed patch is TCG generation for a ppc
>> host but a non-ppc target.  e.g. if the x86 or ARM target side generates
>> some pattern of TCG ops that's very rare for the ppc target, and is
>> buggy in the ppc host side.
>
> Are we actually testing those here?  As far as I can see, we're not insta=
lling
> any cross-compilers here, so we're not building any non-ppc binaries.  No=
r are
> we running check-acceptance which would download pre-built foreign
> binaries.

We are testing the very minimal boot stubs that each -system binary has
in qtest but they are hardly going to be exercising the majority of the
TCG. Basically the $SELF-linux-user is going to be exercising more of
the TCG than anything else.

>
>
> r~


--=20
Alex Benn=C3=A9e

