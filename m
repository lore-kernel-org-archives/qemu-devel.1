Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F764C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0BB206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 10:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e73CoYSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0BB206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfhkT-0004d0-HO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 06:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhhC-0001aI-4e
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:29:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33462)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jfhhB-0001Z6-9d
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 06:29:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so11012487wru.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mLkfz/YrugHPHOMu6u+ikmgFpMqWiCRAofB3gGvkuNw=;
 b=e73CoYSZbhv9t7+T7ytNT9KHNgHBZRU6EW4TeUxBZTU9BRKXIBDZiMDgGJQc7Nmk/A
 9AsMziaxTG4yGG79U4hrEi/+h63ZUY7Qi/RBpVH6LH+1hevD+ze5oIOKQri4l9X7EkWt
 Ou7IqL8iYI0Sg/+iBIo+nY9B/QSec3R9sEVz7Ypov+ILU0oePDA/mh/6K4ZGi6gPEcBd
 JyrddO6MPqYcBEpwzkdbAh5H5kq1zu0DyheYERUyylujHM6gjroBbuAo/Ei/fd6wh3t9
 2LaLVlGx53+GajcFvKOL1O729Ueid9ohuPfix77ck3si+7I+ohfRbLy/P5X/G3Q11ExP
 Pi/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mLkfz/YrugHPHOMu6u+ikmgFpMqWiCRAofB3gGvkuNw=;
 b=Pph/35DqClqRry7CUXA1ibSeYov2MUSajLzBL7JfR6bp5t8Lt0nScoWCko44AVP0IG
 wVKyyfcSmVjmrLtQ4Dv+NBZt993c4AsXNKmV/j0+/e4POzN9hJsMQeoU7tdATEZCDgEQ
 MdmD/kxuiJdNwP2PG2ZVt68KK0TsgnCquBkovKtUf5f/5dY9V6EO2oc3KIH0S/4emKYD
 2jtTH1FUav1+Ej1JmLJmsuCVplDfw+TPzBT4UN5e0nqV+V9BKNX7cXWBsZcM7bfuu6X2
 kJa7PuVs5sbYdpCXgSucHEBVDjTTXINS9ihgPsMJh3bFX4cgzdwKnufkHxFaYNSib/J4
 c45g==
X-Gm-Message-State: AOAM530wWmMUTF5JOwZZIr3bXw5vWM3UbSvOdnoLKL61YNquuBG0P7yX
 49hx8fOEAckZp3evxirBxQISbLqNS3k=
X-Google-Smtp-Source: ABdhPJwy8s1bH2ZE//NGP2m4WwTzFcWIDGRoUOSbPNF0JwfmpxW3dgteR9f16O4XqwuVe7dhQUteKQ==
X-Received: by 2002:adf:ab44:: with SMTP id r4mr20759104wrc.261.1591007367779; 
 Mon, 01 Jun 2020 03:29:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u3sm12998252wmg.38.2020.06.01.03.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 03:29:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0F58E1FF7E;
 Mon,  1 Jun 2020 11:29:26 +0100 (BST)
References: <1589806958-23511-1-git-send-email-frederic.konrad@adacore.com>
 <5ab6f370-6725-1cdb-1b82-24a58cb7642e@redhat.com>
 <dfd77414-83e8-755f-1386-13188b968aef@adacore.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Fred Konrad <konrad@adacore.com>
Subject: Re: [PATCH] semihosting: remove the pthread include which seems unused
In-reply-to: <dfd77414-83e8-755f-1386-13188b968aef@adacore.com>
Date: Mon, 01 Jun 2020 11:29:26 +0100
Message-ID: <87wo4r6pvd.fsf@linaro.org>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, frederic.konrad@adacore.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Fred Konrad <konrad@adacore.com> writes:

> Le 5/18/20 =C3=A0 3:50 PM, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
>> On 5/18/20 3:02 PM, konrad@adacore.com wrote:
>>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>>
>>> This have been introduced by:
>>>    8de702cb677c8381fb702cae252d6b69aa4c653b
>>>
>>> It doesn't seem to be used so remove it.
>>>
>>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>>> ---
>>>   hw/semihosting/console.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>>
>>> diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
>>> index 6346bd7..22e7827 100644
>>> --- a/hw/semihosting/console.c
>>> +++ b/hw/semihosting/console.c
>>> @@ -23,7 +23,6 @@
>>>   #include "exec/exec-all.h"
>>>   #include "qemu/log.h"
>>>   #include "chardev/char.h"
>>> -#include <pthread.h>
>>>   #include "chardev/char-fe.h"
>>>   #include "sysemu/sysemu.h"
>>>   #include "qemu/main-loop.h"
>>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>=20
>
> Thanks for the review, Philippe.  Can this go through qemu-trivial?

Sure:

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

