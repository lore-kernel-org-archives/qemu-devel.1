Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CA420771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oksduS6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CA420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCyT-0007ui-0Q
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyCxs-0007UT-C7
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:31:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyCxq-0000nn-PZ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:31:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id z15so1541795wrl.8
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=q87D37DrSdpJuTWxAIs1C7Vif2xYUWHjuNEGHKL853s=;
 b=oksduS6xd4/hxsSRLEEyR68oEWXak4FxVKxVg+XJo6ixDtNpaEpcioJUTmH5UYH3xy
 SZEvWr0+nv4eiJ0USYVNjg0ZojjThSz1Ijx0rfj0e5C8Gcw9ku8Bqb9JveHfAozwqPGl
 n4xIYDGsCEekN8wFrdKRbKgDYCxtxe2bFynIA0WbZ58dd+YV/IWQ4iyInjkjOcLbnw6k
 rdaKxNZtBjwRO31/mjecJ5Z2vL9uV6N/BnAWWxG8SatRTgASlCBCJn4pmjmENlVxxY9r
 uCvjTjbw2bZWlDVHWRsI0Qy+CsAj6RpOtiz+VnyCVdeXe0jTMzsMzxTaU75ODJJ8pUTc
 Kh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=q87D37DrSdpJuTWxAIs1C7Vif2xYUWHjuNEGHKL853s=;
 b=kRH/pSwf6eIWaGVT2lqKI8JdVZYmBi6bBv1B25z/kct6jdQqio2prfq7K6uZPQN/cT
 SEc06vh1xMnaPMTG0G4fFzayydz87Z8a2QXfQTnhuYsxdAlN6KsDOASLGSQFuFiaq0ZQ
 +xOX7bNFG7RK3v9ztbEibVYzvyIEVx7gP1ZvX5q1Y+1XNe6gg91nDnsq/4QRwz7ZhdlS
 FtHIueJu7xpMSR8AkMRhj00o1ma1bcx5bjgrTIPajDsfPpfbiWNXnAKkM05dhbDLWGve
 k0YIVTPSUIjafE8d+OdjbU6yoaOXi9UAsTHHtKrhQHwx9eKMqEjaGuM6M/krjpLkC5MI
 hIlw==
X-Gm-Message-State: AOAM531mhp4To6bMR3F+Yrgz04ghPDDHWeMQ5pHdfwDSMtENoHJMnsAv
 rX2LJv+0bnl2I2T3RO7UCeK3Fg==
X-Google-Smtp-Source: ABdhPJxO93VAdrDnss9Y7IedzIV1I3nEPjuOEk7DFlqnGT4d6klyzXdeum+DFIfM7UItr2Z5N/uvBA==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr22661854wrw.363.1595417468879; 
 Wed, 22 Jul 2020 04:31:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j8sm25597603wrd.85.2020.07.22.04.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 04:31:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DBD571FF7E;
 Wed, 22 Jul 2020 12:31:06 +0100 (BST)
References: <20200722062902.24509-1-alex.bennee@linaro.org>
 <20200722062902.24509-6-alex.bennee@linaro.org>
 <CAE2XoE-OiXaZRBqW1PnWQO1QntGtckQXOYD1Nqycp7V73MJ3RA@mail.gmail.com>
 <8d9ba727-c833-ad4b-619c-e6d845848844@weilnetz.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH v2 05/12] util/oslib-win32: add qemu_get_host_physmem
 implementation
In-reply-to: <8d9ba727-c833-ad4b-619c-e6d845848844@weilnetz.de>
Date: Wed, 22 Jul 2020 12:31:06 +0100
Message-ID: <87zh7ru6px.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 luoyonggang@gmail.com, cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Weil <sw@weilnetz.de> writes:

> Am 22.07.20 um 12:32 schrieb =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo):
>
>> I would suggest use loadLibrary to retrieve the function, if not
>> available, then return 0 (For Win Xp and Vista);
>
>
> Maybe using GlobalMemoryStatusEx is a better alternative. It is
> available since XP.

I would welcome an alternative patch. I have no way to test if it works
anyway.

--=20
Alex Benn=C3=A9e

