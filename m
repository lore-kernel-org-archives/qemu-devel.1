Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74122C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3BC206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 06:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itlxGQm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3BC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igN8o-0000c1-BW
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 01:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igN8D-0000AH-JL
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igN8C-0003s7-Ih
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:11:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29405
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igN8C-0003rk-F2
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 01:11:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576390311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kuvB4Usjbqo4QPew21p/ESiMUAeH+n/rvkrikzhGF10=;
 b=itlxGQm9SFJlXJph5aq2cNrpjThM8KLi94ozSxtzQS9WVd5nL0Q+mnRsQIn46NXeRF8Pru
 uG9TfOHWHt8IR3A4jJhz7SiZh/kPNMeXWgI1DuomsT16SRfvohmFWYg6vvMIlcST5l61H+
 gEspqY0igcuCpD7ZpoOxlBCjMlkfMa4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-_QxHQus2O_WyPMq2AxJHZg-1; Sun, 15 Dec 2019 01:11:50 -0500
Received: by mail-wr1-f71.google.com with SMTP id b13so449165wrx.22
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2019 22:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NmCnaIefhZ0Y+maPy8phtdkS+1uAbfwbVki7WnYKDlY=;
 b=KwOn+xm1XQcbUIvFUj0y05XNuMCZU5+c5ZmtYz8SaY/anbjmiQUNaiHHhTvFazwGcF
 nJ31GCmfkoPhTdgCl27jVTTb3/lf4R7h6IsbqPhAS8alLSyYeWB/DIUVDOtQzrkn+/Ar
 FZ5FhDmsLUdZV4k0P47kf6cuVZ0b1+ZEQLI8dBrpUC8ypGzquO9TbxFVSh1KxPnsTrAE
 vR7aFf8IuABLkKRggWFPk0Vhm1k74Dmhvgab9YlTAVs4bXGkso9ywo/TvxGhDmD91KVj
 kfj2Q2inHRCyvOp2pJ75LoCB4/sF3N1i1PhBlFqNR12JNBld6d18VJ+2klEXNvRPZNUb
 miNg==
X-Gm-Message-State: APjAAAWjeA7/WYvjDWENbtZMnMSEe9coeE1oc0xiEgsaeEI0MXw6ReyX
 BKwZ/wkQC8EV6HKMcsAYsVY7k7rVTFb1ykn/JdtmPPE1hneyDOkXZOjUzAnxmMYYN+mLH+LhWKI
 wRuKPixsJxzY3snA=
X-Received: by 2002:adf:f091:: with SMTP id n17mr23408427wro.387.1576390309233; 
 Sat, 14 Dec 2019 22:11:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6wyplhm0mZLoc68qRV1BaoeqQrAXHjySQKtYD4cGZltw1WU2BDjWXp07tu8UXXrcAICDkGw==
X-Received: by 2002:adf:f091:: with SMTP id n17mr23408405wro.387.1576390308898; 
 Sat, 14 Dec 2019 22:11:48 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b15sm7535027wmj.13.2019.12.14.22.11.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2019 22:11:48 -0800 (PST)
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAJ+F1CLS4HV-SckggfYNRKXxPa0R2BxSQrpPv8CRVkfvRB3E4w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <77317847-6a14-cac9-3568-2ad4bc6cc783@redhat.com>
Date: Sun, 15 Dec 2019 07:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLS4HV-SckggfYNRKXxPa0R2BxSQrpPv8CRVkfvRB3E4w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: _QxHQus2O_WyPMq2AxJHZg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Marc-Andr=C3=A9,

On 12/11/19 1:01 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sun, Dec 1, 2019 at 2:19 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
>>
>>
>> - "chardev: generate an internal id when none given"
>>
>> As explained, this is necessary for qdev_prop_set_chr()
>=20
> ping
>=20
>>
>> - "serial: register vmsd with DeviceClass"
>>
>> This is standard qdev-ification, however it breaks backward migration,
>> but that's just how qdev_set_legacy_instance_id() works.
>=20
> See thread, someone could review or nack (if backward migration is a prob=
lem).
>=20
>>
>> - "sm501: make SerialMM a child, export chardev property"
>>
>> review?
>=20
> ping

This would be simpler you include "hw/display/sm501: Always map the=20
UART0" previous your changes.

To finish the serial QOM-ification, we need to make serial_reset a=20
DeviceReset, then we can remove the qemu_register_reset() call.

>>
>> - "qdev/qom: remove some TODO limitations now that PROP_PTR is gone"
>>
>> This should be straightforward.
>=20
> ping


