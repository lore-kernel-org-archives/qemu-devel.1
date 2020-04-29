Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84332C83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5413221D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ypGf2sg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5413221D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrPb-0003Tb-ET
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTrOq-0002rn-M3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jTrOp-0006lA-1Z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:25:36 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jTrOo-0006gZ-JE
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:25:34 -0400
Received: by mail-wr1-x433.google.com with SMTP id j1so3770813wrt.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0jzzCWf2fvbVbXzVXOPue4rdF/n2PzQn71bF47MOdbc=;
 b=ypGf2sg1KDJI4jztKNSpM8l6I4Gch+k0T0zm3TATd/WOlq1SpY8guifrkQ3b0tYPud
 M5ZMttVts0r2aGC9KY/DQI80DR65vUIbPzRvGSG0pve0Fw/4DPyvdcfKxvsHbSHIxsqx
 Z6pX+Z70b6Ys8Ls1B1JUAvInzQBR8hl33SunFr9L0i3tZVGSk4W0wZAfI5x7Znd7Yvj/
 MYzk6X+Y7thoubdHwEpp3TcuSPoEXuHOP3ghmyYRxCanDwpFM0Y2hyvEVUG4uShKxoE9
 byzaFxBlRLCS9m0CYSDQjma5XDuW9Yok55INWOk8KzLB7VI3EmRNAo6bkxrrQ4diFYnI
 gbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0jzzCWf2fvbVbXzVXOPue4rdF/n2PzQn71bF47MOdbc=;
 b=WIDM6afI3VrgiClg3+q6UT4eGJgw+k+uoLwN82gAGMDSoQ+/ZJhQVbl2pcAc2CtJ5k
 ate08PzGnfm3WrtADCgAx826D8UnqvAqr7bXhAOGa1RzajiagQNPT9pElLXYfz3Uoxo5
 SBWtz3zsKhTPsh5ATLJq81CXfJwhevOJaUqD+xQbPrw6dEvlTW7brd7/38eecW9NcsqM
 YfT6e0NK16E5j0Z9RVgurhVIWRC17UgYXz3QbyNuNFKbeqLFCHjicc8qku2DJMhTtAsf
 cgPepze8DVV374zRYi3JNmt/2wrMGs1+7KaDiUyOjG8ObbB7VvpUElUrDrPRg2zGOUiB
 35rA==
X-Gm-Message-State: AGi0PuaG9tk5SwnlN0QHDrdEsV4ouOkdrqs02AVNgqLReUdXlSOczlFn
 l4EWjmXjEoSP5wnavD+Yo4IGlw==
X-Google-Smtp-Source: APiQypKzFig62LVUsUUiLRthX30+aTes/UR+uhzLegXLhVJy1m0pWmmIggJtmPD5hDRlP6nv4nsfMg==
X-Received: by 2002:a05:6000:f:: with SMTP id
 h15mr39908437wrx.408.1588184732416; 
 Wed, 29 Apr 2020 11:25:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a67sm9364647wmc.30.2020.04.29.11.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 11:25:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 75B071FF7E;
 Wed, 29 Apr 2020 19:25:30 +0100 (BST)
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dino Papararo <skizzato73@msn.com>
Subject: Re: R: R: About hardfloat in ppc
In-reply-to: <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
Date: Wed, 29 Apr 2020 19:25:30 +0100
Message-ID: <87sggmjgit.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dino Papararo <skizzato73@msn.com> writes:

> Hi Alex,
<snip>
>
> I leave to you TCG's experts how it works and how to implement it, I'm
> only tryng to explain a possible fast way to go (if ever possible) =F0=9F=
=98=8A

This is all a theoretical discussion unless someone cares enough to
improve the situation. While I have an interest in improving TCG
performance I'm afraid there are many more easier wins before tackling a
target specific hack for which I'm not familiar. No doubt this thread
will be referred to next time someone wants something done about it.

> ..Large majority of software don't check for exceptions at all and if
> I really want to pursue max precision I'll go for a software
> multiprecision library like GMP or MPFR Libraries.

However for QEMU we regard failure to correctly emulate the architecture
as a bug - we don't code to common software patterns because there is
plenty of software out there that doesn't follow it.

> So the hardfloats 'should' be set as first choice and only if
> instruction requires precision/error check process it in softfloats.

Sure but someone will have to do the work to support that.

--=20
Alex Benn=C3=A9e

