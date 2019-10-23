Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B8CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750662064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750662064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNEpm-0005pI-SM
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNEBL-0000Tw-0x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNEBH-0006V2-OA
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNEBH-0006Ua-FW
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:47:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8A2AC81F13
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 10:47:52 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 6so4059803wmj.9
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 03:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tk4BUPP+rPwfc0L6tXLGTogKMBLg6zQUR9RBveb4iJ8=;
 b=JjN4JKRT8YALABW0q3Hu9N4bZJgNsEYiIh0iBj0mcnNzYMp2j8QFHbR2rdRSDXrfd8
 gZBL7DPtJuCjRmZEgxbfgVm4Y2dQmtD5Ktcu02UIvEZQRQFm1taJvUhdwoMztB8jzUeg
 fZ7I00tHMt0jlaqRL/BcgPQuy83n6Y5LuSXlocKFtxpoJMCyQWjBkdGjeKbz0coUQJGf
 cJnIvZTAo0z5CjEs5yZoutN6ryD7TwYom6rismTe3YjxDCiQPqyj7qFzED5NITmuJ8N+
 nrihGX7rR44D0vboTCtgC/jT4b2s7+Dl2xSpVGTNq1eqJVem6Mxo6aVnG8lvi8Lg2Ex9
 BDjg==
X-Gm-Message-State: APjAAAUdv78TLIPbVsMLysRxvwBerUEcApEH2v92AOht0NRizpsGmseJ
 LqyYW/p98Kzy+xA68TOCoTxxklGGXTXnwTKT71M5m2ze4atkHbovwB0+Rro+5cHnF91aiNOPWZ3
 QIRDpdeW5bQJ2k2A=
X-Received: by 2002:a5d:488f:: with SMTP id g15mr8314521wrq.9.1571827671232;
 Wed, 23 Oct 2019 03:47:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzxD6dGk+L/p3d8NRYOuR+o4250ZqkdOgvFS3adAgLY343wvFC8LBh32hZgnaA+cWd7dDwJXQ==
X-Received: by 2002:a5d:488f:: with SMTP id g15mr8314488wrq.9.1571827670906;
 Wed, 23 Oct 2019 03:47:50 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id o19sm20317772wmh.27.2019.10.23.03.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2019 03:47:50 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH] pci_bridge: fix a typo in comment
To: maozy <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <20181108122102.9915-1-maozhongyi@cmss.chinamobile.com>
 <1898dc23-c512-88bd-cb73-5a2cffccd176@redhat.com>
 <7f3e7954-3574-9f44-7710-4a488c1d0fe2@cmss.chinamobile.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f68aacf9-2ac3-2a9d-8aab-6a86c52cbacb@redhat.com>
Date: Wed, 23 Oct 2019 12:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <7f3e7954-3574-9f44-7710-4a488c1d0fe2@cmss.chinamobile.com>
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/19 5:32 AM, maozy wrote:
> ping...

I'm not sure qemu-trivial@ received this one because the email address=20
looked odd (now fixed).

>=20
> On 11/8/18 9:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Cc'ing qemu-trivial@
>>
>> On 8/11/18 13:21, Mao Zhongyi wrote:
>>> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> ---
>>> =C2=A0 hw/pci/pci_bridge.c | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
>>> index ee9dff2d3a..da8daa3ff2 100644
>>> --- a/hw/pci/pci_bridge.c
>>> +++ b/hw/pci/pci_bridge.c
>>> @@ -310,7 +310,7 @@ void pci_bridge_reset(DeviceState *qdev)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the default values for base/li=
mit registers aren't specified
>>> -=C2=A0=C2=A0=C2=A0=C2=A0 * in the PCI-to-PCI-bridge spec. So we don'=
t thouch them here.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * in the PCI-to-PCI-bridge spec. So we don'=
t touch them here.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Each implementation can overri=
de it.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * typical implementation does
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zero base/limit registers or
>>>
>>
>=20
>=20

