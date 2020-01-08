Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB61CC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A410B2073A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 13:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcPRg8AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410B2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipBKv-0000Ta-Q8
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 08:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ipBKB-0008Ai-EU
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:24:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ipBKA-0004wv-D1
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:24:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47222
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ipBKA-0004wP-9p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 08:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578489877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwxW8pl+SCSupDafHVTP3y7AW8offuPg8JxNose/cgM=;
 b=EcPRg8AKfv4cbTQjuJzt0uFqZnVZ3oAhXp7H/UPk4WvoOchQhZlaGNwJtZHxJW7q6+SvLi
 niJ25K+L3yAoggK3gy08Pmd7a3Iy02s6zPyA9Np20EpnrkOZ08C06wHyp+U6y0EFVB75a2
 wXOrgqEeVY/jOzF6xAVc0N9grXdit74=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-vibyVPFLNiqLTSrFF8J_PQ-1; Wed, 08 Jan 2020 08:24:36 -0500
Received: by mail-wr1-f70.google.com with SMTP id 90so1431701wrq.6
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 05:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oNDO+A95BLiPVx8J03CB2ee6cmruYWFGz72FU4GQS+o=;
 b=PPcgbKAJCZprURYz8NeIPbGq55WSCCYUHE0nNuKNaHn/OuBcNFTZLyyIaZwRa7D3aD
 1pL/qwPwwjbFgCAgcJr0AjOVVX+QfKiFN9sgIm07qITHv0S2+xUT+Kwg8f+D/6QlVpQw
 srgED0i4+q9bi/A34LDKTnEet5l1/7vgO/qMhx9EotKRIwxGMzJo8Di6djqFFo29cWvT
 8jlrvAOD+g+39xtdqBpx8BQgEct3DNBEHyHFJ9YkD63d/iNEltVXpsnNPx7Vq6UrlaiJ
 xdjIXXJgpNqLf8fDzemxMFzjsECQ+z9+VQTERKdM/7rFX5d7dM6yYlw6CZtUV9Wpf1Tl
 TzgQ==
X-Gm-Message-State: APjAAAW8ASXpIrhvYQis5mbSsLsX1UzPfEzOCWKwnUju8/Ohzn5xTDUu
 +iQQQ0aEWqVZ52T0Gvo3/ZNs7qxHF8fwDa6Gygw5dw05xAVESNgT/B5XNPQ+ltEk+IibrGk3xhS
 nQMl6N7dL2MZx0sY=
X-Received: by 2002:a5d:5267:: with SMTP id l7mr4963611wrc.84.1578489875041;
 Wed, 08 Jan 2020 05:24:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8kQ/jRuwVfRiz9agzRYztYzDhD4aZL1BtL9DZ+RBcXPdiLYGJaH8xLWpxFPo5eoCl5wnZhA==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr4963584wrc.84.1578489874765;
 Wed, 08 Jan 2020 05:24:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id f16sm4224263wrm.65.2020.01.08.05.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2020 05:24:34 -0800 (PST)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <58eb34db-7d32-8b0e-d9ef-98648209486b@redhat.com>
 <656169fc-1abe-b521-20a3-e7041739b914@redhat.com>
 <20200107125451.GL3368802@redhat.com>
 <3241dff4-6223-404f-55d4-846991763046@redhat.com> <87d0bujkpe.fsf@linaro.org>
 <da2111ee-0644-1d7c-a111-e4209025a1d8@redhat.com>
 <60ecc0ec-d8db-2cf6-b21a-799f4cb9ab71@redhat.com>
 <20200108131015.GF3386452@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f454912-5127-d2f3-fbba-0d341947e030@redhat.com>
Date: Wed, 8 Jan 2020 14:24:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200108131015.GF3386452@redhat.com>
Content-Language: en-US
X-MC-Unique: vibyVPFLNiqLTSrFF8J_PQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/20 14:10, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 08, 2020 at 01:41:59PM +0100, Paolo Bonzini wrote:
>> On 08/01/20 11:58, Thomas Huth wrote:
>>>> "-accel default" could be considered to have vibes of Do The Right
>>>> Thing (tm) and could in time actually become so!
>>>
>>> "-accel default" sounds like the default behavior that you'd also get i=
f
>>> you don't use this option at all ... what about "-accel auto" to say
>>> that QEMU should pick an accelerator automatically?
>>
>> Questions to answer before thinking about the name: how would it
>> co-operate with other "-accel" options?  how would you pass sub-options
>> to the accelerators?
>=20
> If people don't have a preference for a specific accelerator, just need
> "a working accelerator", then I think it is reasonable to assume they
> won't want/need to pass options to the accelerators either.
>=20
> "-accel default" is targetting the simple "do the right thing" use
> case, so IMHO doesn't need to support per-accelerator options.

So basically the idea is to add an option that means "ignore every other
-accel option and act as if we had "-accel kvm -accel tcg"?  That seems
like a hack to me, especially since you can achieve the same effect with
a binary named qemu-kvm and no -accel options at all.

(As for the reason why TCG is preferred, it's because we already special
case binaries whose name ends with "kvm" and it keeps consistency
between all qemu-system-ARCH binaries).

Paolo


