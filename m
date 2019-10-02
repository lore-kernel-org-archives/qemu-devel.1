Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB4ECE58A
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F7C21D82
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 17:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNEJlvPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F7C21D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFiVM-0001l8-P8
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 13:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFiU5-0000uZ-24
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFiU3-0005Np-8b
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:32:16 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40837)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFiU3-0005N1-0K
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 13:32:15 -0400
Received: by mail-wm1-x341.google.com with SMTP id b24so7785422wmj.5
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=G3Y/6yO5yEQvrRk8hcj1TrzrxqS+cBP1+8cDxP2rqOo=;
 b=eNEJlvPoRsFK8dxcuhgjnuES9CAYhMYZFyx7L4FMno7BeMW9Z6Z9b2y/4rPbs2a9jC
 wYs0Jv8uRhW8Z3v8tH92+xzU7htHs/Ff0PKtPNQYYsZFSdgcLBCqwLWck0lBel0ax7B+
 W424TWCUvCGlrhcqD9DuHNtbaCE7Gr4D2oI3Hugf33MI6Fmxn4ehXsimnMhRZ00NBJhv
 u1zc43Nj0VTfyt9/zOMmiFvfe6U2Grmevg3qQOFNYRb9m1epnc6B0osqSKiwEb8UepYy
 eeRhWry2cOKvYGUIGlv/zPl384VEiBlQ0NEsc+x8ciPOSMOsTPbVr8CCLithv70z7qCQ
 ShrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=G3Y/6yO5yEQvrRk8hcj1TrzrxqS+cBP1+8cDxP2rqOo=;
 b=Gcih48p5uTWyOLxzU51mJB/QfdqGd1Ah8N5yyxd8/TO9tb+5tStmyBr4sH0j/wV9cZ
 dh+9s6sMu2reat2xn8y0FxN9i0vANhKZWU8SI6vYYVo4NncUmU9vNYp9gxiFuCz7fGXw
 lhQjncP/OaVcVyAdeIQznF7Qgy6BxiEgab4fpVw30weJu1AhResPHxm9BzDPSe+BBcp0
 thwYsqg3i7d/T7UFL2yNA3DTdK7JP8UqmX9ySA2yd9+K0xFhVQWaCM0rgx8J4kROszFH
 DeR/vitK5tkJpqf6xgvRiWtj5Eej9PmQvfcM0uafJGr63wM1Pc8ryLHNbeS/PhYUxsiB
 ytFA==
X-Gm-Message-State: APjAAAXVFZ9UOXR6AY38ctYesLuSypI3QkCcj5odupwoaHpHdy1k5Byp
 bFBjhwpORscU7ObE2XQYELFUew==
X-Google-Smtp-Source: APXvYqzojAFojECYiNrwIIv/H4W0VNcRab50PVfuyMPYgWDDwMr88BVVpqWoEBBbMzwJOd39ylscgQ==
X-Received: by 2002:a1c:60c1:: with SMTP id u184mr3653637wmb.32.1570037532742; 
 Wed, 02 Oct 2019 10:32:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q66sm6713487wme.39.2019.10.02.10.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 10:32:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C641B1FF87;
 Wed,  2 Oct 2019 18:32:10 +0100 (BST)
References: <20191002142146.6124-1-thuth@redhat.com>
 <20191002150329.GA30342@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] iotests: Do not run the iotests during "make check"
 anymore
In-reply-to: <20191002150329.GA30342@redhat.com>
Date: Wed, 02 Oct 2019 18:32:10 +0100
Message-ID: <87wodnjbol.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 02, 2019 at 04:21:46PM +0200, Thomas Huth wrote:
>> Running the iotests during "make check" is causing more headaches than
>> benefits for the block layer maintainers, so let's disable the iotests
>> during "make check" again.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/Makefile.include   | 2 +-
>>  tests/qemu-iotests/group | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> I don't have any objection to removing from 'make check', but I feel
> like this commit should be modifying the travis.yml config so that
> it explicitly runs the block tests, otherwise we're loosing automated
> CI and the block tests will increase their rate of bitrot again.

I think we run a subset on gitlab as well. Do the iotests need any
particular build of QEMU? Lets try and avoid adding unneeded targets.

I must admit I've been out of the loop here. What headaches are they
causing? Too many false positives?


>
>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

