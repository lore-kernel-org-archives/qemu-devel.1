Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D11FA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:27:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF2721925
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF2721925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiP6-0005PR-Sk
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKiNW-0004kc-Sv
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKiNV-0005ty-SN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:26:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKiNV-0005td-NG
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:26:09 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AE07146288
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:26:08 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m16so919792wmg.8
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:26:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D3fmE5URL3lZrrxnAvrx/BLBCrKFk1+z6Ak/1mn8qEI=;
 b=b0WeZ+d5/E/5BjfMjm8uKe4Ga5/eM6RZ6EO8wmQF0yFV3Ocmyl6FHrA5knr5kz6lvC
 hTmx+ONW9vhXDEfAH4D4yDOmAUkr2G8KrYFDnvhQ6QhLR5DSzSw8W91i2YoytrrLxW11
 +A+U/j3Y1YKFS+AlqrWoG0ZxbUor8q2fFDhQezY6LhNm9r8ytLqyajFw/h4Z2vyxA9ei
 bpNijWeqREYOxjDSYFnUj6MJeUZbOrnm774Bszb8BRKZdPbiXk8RKd5hxA7ngIqiKrs6
 styiyRrea/gqbRmOA/XSqG0Mm1OGQFoYipkOHqyeW2Ocwv+Qek7BcGVGEohPrfqEscoA
 HcHw==
X-Gm-Message-State: APjAAAVBuU52NIgcy27JaNlN9F8zJM3sKB9CrbqdJtDH0boWhoWsKIIN
 1FeaS6yW1Bz3ube3SvCdmrb6/1Sv00ELi7+EyTri0vfT5TBksTGX5X+0voB6MRTEFxJBYhhDR1k
 fJNuUw4slaL6zzhk=
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr2617983wrw.72.1571228767508;
 Wed, 16 Oct 2019 05:26:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwtO9IHpr8cTDR+Rdxy81y1+H6Ec4Fdkln1QJY8HWz3n65qYdYBvJ7waMBTnTXAEs3Xp/BDsw==
X-Received: by 2002:a5d:67c5:: with SMTP id n5mr2617960wrw.72.1571228767320;
 Wed, 16 Oct 2019 05:26:07 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id q124sm3814325wma.5.2019.10.16.05.26.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:26:06 -0700 (PDT)
Subject: Re: [PATCH v6 2/9] tests: arm: Introduce cpu feature tests
To: Andrew Jones <drjones@redhat.com>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-3-drjones@redhat.com>
 <cec54f08-9508-13e5-600f-3442962a1642@redhat.com>
 <20191016122103.l6vz423k3gpdr2bv@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <626412a4-5c61-1f6e-0f18-7b0d9f754baa@redhat.com>
Date: Wed, 16 Oct 2019 14:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191016122103.l6vz423k3gpdr2bv@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 2:21 PM, Andrew Jones wrote:
> On Wed, Oct 16, 2019 at 02:05:24PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>> +static void test_query_cpu_model_expansion_kvm(const void *data)
>>> +{
>>> +    QTestState *qts;
>>> +
>>> +    qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
>>> +
>>> +    assert_has_feature(qts, "host", "pmu");
>>
>> Have you tried this on a ARM host? I wanted to but don't have access t=
o one
>> :(
>>
>=20
> Yes. All code in this series has been tested; covering these
> configurations
>=20
>   - TCG aarch64
>   - TCG arm
>   - KVM aarch64 without SVE
>   - KVM aarch64 with SVE
>   - compile tested arm code with CONFIG_KVM enabled

OK, I'd appreciate if someone with ARM hardware can test:

     - KVM arm

Thanks,

Phil.

