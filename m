Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE37C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91A1F2084D
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A1F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnBr-0003pC-Kp
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iSnA6-0002th-Tg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iSnA4-0006Y2-Rw
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:09:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34548)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iSnA4-0006X2-JK
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:09:40 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 79814C04BE1B
 for <qemu-devel@nongnu.org>; Thu,  7 Nov 2019 19:09:39 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id d140so2762767wmd.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 11:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16r2Lo1JPA8EbWA2hCflj2bRrHuTnN6bxDYwViD8zFQ=;
 b=nL2V7AdxR4CGldCjyHseHVQUMRJ9UjhcAsROLNKOn9odSM7/6t14v8dA45ag2IBRmJ
 vfQcul1lE1cuNHOx5EmL1QI+K5X0Cu0wfwqLWxlWLx7trkS+JoG4eUt863JZe4s4E+i2
 uSXblrRmXBL6eiS3w4ENMpDNOGTXGu+QPp0Zt0ArBvyyFmDk3pwISw5xjykMZp/DCXrl
 M8Lpz8mNzeG1evBaXsptXtnAY2pn5c7cDD6szVGYKp4jTS93f+ADePf8clgDoeAg4iDh
 6j0sXb0QGdChCU6z8H3uim4dQV8WydEGTZvN6NmH+OugLq1m5NUeYDoe4epMUK2+kDSo
 RWAQ==
X-Gm-Message-State: APjAAAUzdrxgb3P15Hpr6cElisyGSacmbQUPJsTzonzYu1qfp6Ly/2kW
 wVC8ElelXD2ftpT4Fd5DUxTJAGw4EuIWiM6fcJyIHLXQ0VUN2HscMQku/dZkVBQ0qUOkMPynaRM
 5Z/fIBgG5ofkYZIc=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr4337187wru.52.1573153778105;
 Thu, 07 Nov 2019 11:09:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPJahG0411YswcM6yeLFS4yVyKsGDEEcyUXwpKWCexjT0nI0QQlyCWMruQ+gcx+92YLLud1g==
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr4337156wru.52.1573153777811;
 Thu, 07 Nov 2019 11:09:37 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id b1sm2922565wrs.74.2019.11.07.11.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Nov 2019 11:09:36 -0800 (PST)
Subject: Re: [PATCH-for-4.1? 0/7] vl: Allow building with CONFIG_BLUETOOTH
 disabled
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190712133928.21394-1-philmd@redhat.com>
 <421f2fb2-6e8d-7579-029a-e8de726c6a5e@redhat.com>
 <56d102b4-3f55-7070-c012-56ad65138873@redhat.com>
 <CAFEAcA8axpVeXjWV+2cz8PL-gR_6GvU=i0BMt01pYhff_1LOwQ@mail.gmail.com>
 <4ed2e2b7-91b0-197f-7532-bf9daac075bf@redhat.com>
Message-ID: <d79cec06-ff17-a118-7bf9-91ae1791c014@redhat.com>
Date: Thu, 7 Nov 2019 20:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4ed2e2b7-91b0-197f-7532-bf9daac075bf@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/19 2:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/13/19 4:04 PM, Peter Maydell wrote:
>> On Tue, 13 Aug 2019 at 15:01, Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com> wrote:
>>> On 7/15/19 3:13 PM, Thomas Huth wrote:
>>>> On 12/07/2019 15.39, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> A series of obvious patches to build without the deprecated
>>>>> bluetooth devices. Still worth for 4.1 or too late?
>>>>> It is clearly not a bugfix.
>>>>
>>>> I wonder whether this series is worth the effort right now, or wheth=
er
>>>> we should simply nuke the bluetooth code after 4.1 has been released=
?
>>>
>>> Well, perfect is the enemy of good :)
>>>
>>> This series is already done and is an improvement to what we have.
>>>
>>> Regarding nuking it, it depends on the Nokia N-series boards, they mi=
ght
>>> become useless without BT support.
>>
>> Er, they're not useless at all without BT support. The BT
>> hardware is a really tiny part that I doubt many users of
>> the board models ever used. As long as we retain a "simulate
>> doing nothing much" model of the BT device to show the guest
>> I don't care whether the BT backend code disappears.
>=20
> OK, I won't insist then.

Bluetooth is dead, long live BT!

v4.2.0-rc0 just got tagged. We should stop linking unmaintained dead=20
code. If nobody step in to nuke BT, we should consider applying this=20
series before we release QEMU 5.0 with dead Bluetooth. This approach is=20
still better than burying our head in the sand.

