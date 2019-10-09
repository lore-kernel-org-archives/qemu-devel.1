Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D6C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34D220B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34D220B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJVD-0006fc-Gb
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iII2F-0004zX-4O
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iII2D-0005wU-6W
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:54:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45308)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iII2B-0005ut-Rh
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:54:08 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 915416378
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:54:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id z17so1588741wru.13
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yhLQfKwQzysLnNGTIoM2Ddezqq2EgVAjwUcO4DhzQJo=;
 b=DxfzHx7t4RvMBL+BHo1pL29WDgWXfQOfZ0CPxHlUcppY9SKJdM4QZMweufYF5QJkeE
 kLJx5MGfy08TaJiZImHh34B392Y5l60SL43CVeo77pDTGL3inJqwTdbF57XAEEwYkCey
 Bxw34+Ir79hb2+AoMWXPi6KITlmvTIXRHxZlz5WfH7e09agMyaYFMdvTSQyURJ1TIRlZ
 rDn44wuxoxwIldCREXmHhDEkRTjc5A7zLEtTBdxCjMnUUPp58J6FBaC1RoOVD2BMncj9
 UU4gn2anpUsaCwPTpyy9plUt3k28v1i0apmShr8TMdj2/QBQDdn5kzcuHZy2TwPkOoN+
 vYeA==
X-Gm-Message-State: APjAAAWbCrI6NX98/4VHCFKHAMk4tCzcJxJwXPA51NU6oud8m1eFnLtA
 WwYnsmTW7Zv1oa5qjW2Cz088CWcogiucRL7gMvh5a3e5jbQW8NWp72enexxpVtiTrrqBtALAWMH
 uQHi1YcdOqo/je1A=
X-Received: by 2002:adf:e48f:: with SMTP id i15mr4681726wrm.288.1570650845304; 
 Wed, 09 Oct 2019 12:54:05 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGhuhC91PW6fwdDTQhmRcOHfJFmV98WGBb1qCq+QVk/NuDXcd/OmNNKWpnE/oWoB2nbzARhg==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr4681706wrm.288.1570650845114; 
 Wed, 09 Oct 2019 12:54:05 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id f18sm2021168wrv.38.2019.10.09.12.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 12:54:04 -0700 (PDT)
Subject: Re: [PATCH v2 0/8] hw: Convert various reset() handler to DeviceReset
To: Li Qiang <liq3ea@gmail.com>
References: <20191008142539.7793-1-philmd@redhat.com>
 <CAKXe6S+JX_O8pUS-vtJSML5c4qTqoX-PWWfTYQLJVq6DPO37Zg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f6876b2c-547f-6254-9796-47e293a021bc@redhat.com>
Date: Wed, 9 Oct 2019 21:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+JX_O8pUS-vtJSML5c4qTqoX-PWWfTYQLJVq6DPO37Zg@mail.gmail.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 10/9/19 4:28 AM, Li Qiang wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=88=
10:47=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     Since v1:
>     - Removed the pci-host devices
>=20
>=20
> Hello=C2=A0 I want to know why=C2=A0 remove this?

I haven't removed the devices, I simply remove the patches converting=20
them to DeviceReset, basically because I've not enough time to check if=20
the are on a bus that would reset them. I added these devices on my TODO=20
list for later, so meanwhile the other devices can be easily reviewed=20
and merged. When few patches from a series are not reviewed or=20
incorrect, sometime the rest of the series is not merged, so I prefer to=20
split it and get these patches merged.

>=20
>     - Removed the vmcoreinfo conversion (elmarco) but add a comment.
>     - Added Igor's R-b tag.
>=20
>     Following the thread discussion between Peter/Markus/Damien about
>     reset handlers:
>     https://www.mail-archive.com/qemu-devel@nongnu.org/msg617103.html
>     I started to remove qemu_register_reset() calls from few qdevified
>     devices (the trivial ones).
>=20
>     Regards,
>=20
>     Phil.
>=20
>     v1: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg06367.=
html
>=20
>     Philippe Mathieu-Daud=C3=A9 (8):
>      =C2=A0 hw/acpi/piix4: Convert reset handler to DeviceReset
>      =C2=A0 hw/isa/piix4: Convert reset handler to DeviceReset
>      =C2=A0 hw/ide/piix: Convert reset handler to DeviceReset
>      =C2=A0 hw/ide/sii3112: Convert reset handler to DeviceReset
>      =C2=A0 hw/ide/via82c: Convert reset handler to DeviceReset
>      =C2=A0 hw/isa/vt82c686: Convert reset handler to DeviceReset
>      =C2=A0 hw/input/lm832x: Convert reset handler to DeviceReset
>      =C2=A0 hw/misc/vmcoreinfo: Document its reset handler

