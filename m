Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7F9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 399A8206C1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 15:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUDhCM0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 399A8206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxBpR-00075H-IP
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 11:01:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39349)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxBoQ-0005y7-TS
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxBoQ-0001xv-0e
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:00:42 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51925)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxBoO-0001w5-3J
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 11:00:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id 207so12488525wma.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pgbcHeuDIrR0tqfydCTdm0SqQI83SF4IyYREZOx8bdM=;
 b=IUDhCM0r+pqag+PV98uFJ7tjPhi/hCsxtVITGX07h+2mFECWUvDB+UmlqJ6YsUNUG1
 FPMEiDc9UqJy4wnuqWyf6MxB3DWM5n87q21JD4Uv2gJQNHdWTBujh5ka77skWEmr2G3V
 etFsk8V96Kzu5/fgr0LoeymFGZIZCBzfo4M2JjSkEgGmlOGAb015Si+kK50MyTRcnRH3
 CObHRlcg+lXysuG1qTqfTZqKPp7Fxs+gSvruPKaBWNXuWiXurb8eW6dF4ZdJ1NWoHpdP
 kCLFeh+Pxs1eVebfgXvxArr7azYPs7GsIVsvM5gMfSrzXL0H2w3g42NJsLvH6nvNiAY/
 RDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pgbcHeuDIrR0tqfydCTdm0SqQI83SF4IyYREZOx8bdM=;
 b=NXDo9ZRicqG3ytowOw+9OVdl0QgR/9Vxkr0pSdINu9p7ruZVrpgnFp1Jqi0BpJWC/m
 Gj1DZ3EjBHNWY6sxi/cF34xQu7AsjHfbNtaSlgiQv585JXYHZ8ZMHNbHptJv274dyHuq
 EWLsdg25AcxBLK1nRVwKSFecRYrHzMKeS9mc5GmXZWr3K2Cdk/PiUt2Ne3GaAal/8Ugp
 kFlGNx5lvBKnvTxLru2sIwOCkRlD5KRR89ghsMg+bx5ceAPAmC1QK1/hJHT+cMKjYu++
 zoiyPJQrzloqaJUEARISfV2E9dsoMBb7laNDquq8eJxrSQPhfa/2xG88IskH7K3gZcFw
 b55A==
X-Gm-Message-State: APjAAAVJyrPs+kEN/AOBiG92hBp4FPOji71gW2sHLKjJCEdLHVmC583L
 OMIbIovGsPWaYvTPOgNQYehV+/Lniz0=
X-Google-Smtp-Source: APXvYqzGH4+BeZDN35xbghaJZmbVFbly3IuW/frQXfLB8a516KeCDSvA/0r+aFRmHlhVkq9pSKB8iA==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr4005896wmf.84.1565622037554; 
 Mon, 12 Aug 2019 08:00:37 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p9sm6111665wru.61.2019.08.12.08.00.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 08:00:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A45E91FF87;
 Mon, 12 Aug 2019 16:00:36 +0100 (BST)
References: <20190812052359.30071-1-armbru@redhat.com>
 <20190812052359.30071-29-armbru@redhat.com> <87h86mofw3.fsf@linaro.org>
 <87o90utro1.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87o90utro1.fsf@dusky.pond.sub.org>
Date: Mon, 12 Aug 2019 16:00:36 +0100
Message-ID: <878sryo2cr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v4 28/29] sysemu: Move the
 VMChangeStateEntry typedef to qemu/typedefs.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>>> recompile of some 1800 out of 6600 objects (not counting tests and
>>> objects that don't depend on qemu/osdep.h, down from 5400 due to the
>>> previous commit).
>>>
>>> Several headers include sysemu/sysemu.h just to get typedef
>>> VMChangeStateEntry.  Move it from sysemu/sysemu.h to qemu/typedefs.h.
>>> Spell its structure tag the same while there.  Drop the now
>>> superfluous includes of sysemu/sysemu.h from headers.
>>
>> You should probably mention you also fix the struct definition to meet
>> our coding style. Otherwise:
>
> I did: "Spell its structure tag the same while there."  Would you like
> to suggest a better wording?

Apologies - my eyes obviously glazed over that part...

>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Thanks!


--
Alex Benn=C3=A9e

