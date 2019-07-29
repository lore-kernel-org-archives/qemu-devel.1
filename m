Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F807C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C0D206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 09:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C0D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs25W-0002Xy-O9
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 05:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hs253-0001n5-Mb
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hs252-0001yt-OT
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:36:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hs252-0001yO-GQ
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 05:36:32 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so52836060wmj.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 02:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=k+b+0w7sdl6bhya1EhD8uwlNEB7i8PaOX5OKlwRFLbY=;
 b=iB8qlX6SpocMOcrqu9RADSbaecmU9gXjx3Is/mt2t4f3GPETujTYE34BPyX7v8pmKA
 OlrL5L8gWSfpNnoPIJmR2NUf050/PG1I/YcfGxeprtgGkFfgjaGPZCn9L6XLC+tS+Bfl
 wBH8e+lcTymHB66iABMcKniiyfEEqA7wGPa9aaD/MUZme6csdrt3vU3wdwOh4dl5kBjM
 Tfd54uv04c01w9vBCA8t1uU9rWZ6uz8IL9lpLvy1YwJqR1KrXn2CsP/XsFvSEoo2x+T4
 ddFi5Up0kOk7YpXKSkhBMVKPGibMMCJrCOp8Oa4md32BZ8+REt1Cp7Tx9HfmRf/gQ5qb
 q7Pg==
X-Gm-Message-State: APjAAAXdt3DAmfFHD50Rd73gJPFXq1GZJm0dpoNUsls6M+HSRqQV29Mw
 sDCyHXbrV0oRcttkbWUbYnaixIu4Deg=
X-Google-Smtp-Source: APXvYqyngs9i+tjhNmjzzQmJ1PlrH1QKqHJ5JknZOFRzc7DEDLgH7VWht9VcA1UzfgKuM3sETpE+Gw==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr100397628wma.78.1564392990890; 
 Mon, 29 Jul 2019 02:36:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id g8sm58871192wmf.17.2019.07.29.02.36.30
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 02:36:30 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
 <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
 <CAFEAcA-Egqpz3MwC2Kk-h_iCP4U74rYh66Nb2oaK5rdjD=7JMQ@mail.gmail.com>
 <aa4801a9-ad0f-a6b8-e167-1fc5f4e6925e@redhat.com>
 <CAFEAcA9X=F2=XP97pf171LJ0PiKHTPNNtKZSqJ8g06CmqWmzUA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e20ab776-602e-5555-6320-218d0b9b4f50@redhat.com>
Date: Mon, 29 Jul 2019 11:36:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9X=F2=XP97pf171LJ0PiKHTPNNtKZSqJ8g06CmqWmzUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 11:32, Peter Maydell wrote:
>> The NetBSD thing could be worked around with a static library but
>> instead those -D options could be added as global C++ flags:
>>
>>     __STDC_LIMIT_MACROS and __STDC_CONSTANT_MACROS are a workaround to
>>     allow C++ programs to use stdint.h macros specified in the C99
>>     standard that aren't in the C++ standard.
>>
>> Likewise, the -Wno-sign-compare probably should be added to all files
>> for GCC <=4.6, but in fact we don't support anymore GCC 4.6 so it can go
>> away.
>
> I think it's an indication that the mechanism in general is
> useful. Switching to a new build system worries me if we
> already find that it is lacking flexibility we're using with
> our current build system -- it suggests that there's likely
> to be missing stuff we're going to run into in future as well...

I agree that the mechanism in general is useful and it's worth thinking
twice about the consequences of not having it (see the CET example).
However, in both of these cases it seems to me that the per-file CFLAGS
were used when they should have not.

Paolo

