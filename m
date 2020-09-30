Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AA1C4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:57:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A3D7206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qeaTHnsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A3D7206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNhIK-0002G1-7j
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNhHl-0001pL-JU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:57:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kNhHg-0002Gb-GW
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:57:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id q9so566958wmj.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fdD4LmknZ97Ia8xcZ6cDf1cxJbm8hRxwsKwh9c4TDwk=;
 b=qeaTHnsEfUehVFfdewAT0L8ZllkefjJBTbx4zXpvT14o0liRB3YOzXDcIGjQKV8xXk
 yQ8qh+YpaVQbFCLojKfWQYaTJxZJvqZI3b/KJDotE5XoCgCI7PG/g6lSZIPkp+wKWMIK
 48rZeV1t+FpiwJwqnesQffNHkViDJ+SWxkqWAj/dJ3ie2/eR5+HzOwyB8HLuaH9ymeny
 Du0mc0MwG4959jzU4HOwmLu9YBTCv1l6wfzXC5S6a3oFwpQhEcHzPWlku2x2WGjsp328
 4/1WeDdzW8APiWAVGeDKoMS96Mdc22Epc8acJ1XGd+kM5iB4b/X5S+/ME+kV7GNqOfSr
 qcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fdD4LmknZ97Ia8xcZ6cDf1cxJbm8hRxwsKwh9c4TDwk=;
 b=C43Bgsq8pXTKUZa0pEUQMwnUzesYDkVCgm+zWSkP9aoK8lNY9F7QV83LJKWi2ju29Z
 Ps2B43cVy7721ec81gMW5XXpIQRNttD8d6tnJC5ENXU6t3Ym7EWAPD2Qy0Zj7tSOBmhV
 SpEwh75L0Kp0yeLAK7LL8TS2evaPv1P8W8lpJjV7guO4IvwgzgwG9KgE3rdemWPTQWNf
 MlJl7+IQ2x806v8LRupDApvAPz0eC1FFMzT9vTvh1a7JEg92j3ZW6OOAtRw7HYcQiJ6s
 QZuWB16EAzQ4fhNaNkf7c8yTyEaUXLt8G/1T6aeWricczq54Y9DEo7gV6yxPU/eL36Dv
 iDVA==
X-Gm-Message-State: AOAM533cRxOrHeQ5D9VcqAldyL2pc4XcmP1fYyKzTcVnqtDVmuC18Vgm
 00S0sXITBWmRpQ/IAYfvCzSQyA==
X-Google-Smtp-Source: ABdhPJw08PSRpv2eGrn7DsXFrKzaQsbu4ClsHvCeAhvnd3+MhZO2qxjkAXZPBIMsB3PJ3Jfc/P8q+w==
X-Received: by 2002:a1c:9a10:: with SMTP id c16mr4240484wme.96.1601492216147; 
 Wed, 30 Sep 2020 11:56:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v9sm4709930wrv.35.2020.09.30.11.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 11:56:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4E8781FF7E;
 Wed, 30 Sep 2020 19:56:54 +0100 (BST)
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930171529.GR3717385@habkost.net>
 <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
In-reply-to: <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com>
Date: Wed, 30 Sep 2020 19:56:54 +0100
Message-ID: <87lfgrnle1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?utf-8?Q?Daniel_P=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 30/09/20 19:15, Eduardo Habkost wrote:
>> On Wed, Sep 30, 2020 at 06:49:38PM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
>>> This is the third part of a series reducing user-mode
>>> dependencies. By stripping out unused code, the build
>>> and testing time is reduced (as is space used by objects).
>> I'm queueing patches 2-9 on machine-next.  Thanks!
>>=20
>> Markus, Eric: I can merge the QAPI patches (1, 11) if I get an
>> Acked-by.
>>=20
>> I'll send separate comments on patch 10.
>>=20
>
> 1-8 is fine, but I think 9-11 is too much complication (especially not
> really future-proof) for the benefit.

Isn't qdev considered an internal API for our object and device lifetime
handling (which should be shared) versus QAPI which only exists for
system emulation and tool integration? That is of course assuming
libvirt is never going to want to know about linux-user emulation?

>
> Paolo


--=20
Alex Benn=C3=A9e

