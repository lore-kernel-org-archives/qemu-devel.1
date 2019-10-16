Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8052BFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BA9218DE
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 12:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BA9218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKiMG-0003md-DR
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 08:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKiL2-0003De-PW
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKiL1-000512-FN
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52950)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKiL1-00050l-7M
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 08:23:35 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3306246288
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 12:23:34 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id r21so921788wme.5
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 05:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JKWsoDPBBjCDMlOQoVTrWRxmZwM7yZejHJ/s569Y2yk=;
 b=kGPW6O35Heb/A0hiQ9O2mOYB3KIijuyVWX4TqLQxlIBvanEtc1S8UfwfFP4uGl4yFX
 M/rK3qMIrNX97bztNOqYAWtykiqvJxTuSq5vMb79F0PGCGL7sf6AdtCk4L3HV+Sqs+NG
 hpKyHa4WIsSgbawJ0TqRvbhw2x1MeoYN8yXAQTKyAsz6I9MSgVDkv8/Qjzsrf3qEk7FU
 0rqf3gg38pZB3DXVsrJoSahQAX8WxKtgFCHwb8Gz1u1SYsts/7G3sJHFviDLNZjtImox
 nkVcAR7QHZchC1q0CjGv6Oms/WTOiNHOo95xqObQu0mDxLTFVT40eTwaxyntJ+8R3DBE
 aSzg==
X-Gm-Message-State: APjAAAUVnBhU6mxvXF+FqvDCPrgf+BRNYGvN6d8CCJLh+Wx8OX0Bsm67
 lAwaR8mwbQ0cXjhcgHPeOVBzKhAgZXaPJDSvqR2r8t90xsKG+A1OGgN0JDaNpMD4OhHSstpIsQJ
 1Ei7DT69244PITXE=
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr3238415wmg.63.1571228612911;
 Wed, 16 Oct 2019 05:23:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIioutayyQep4Md+UeBCEyO2VllQdNYk0NI2yesFlPZ+jHpx0lumiDLOwr5V0UVGs9VoSC+w==
X-Received: by 2002:a7b:cf28:: with SMTP id m8mr3238399wmg.63.1571228612700;
 Wed, 16 Oct 2019 05:23:32 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id t83sm4007424wmt.18.2019.10.16.05.23.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2019 05:23:32 -0700 (PDT)
Subject: Re: Python 2 and test/vm/netbsd
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kamil Rytarowski <n54@gmx.com>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <b61252af-9eae-d655-0602-d270ce6223ef@gmx.com> <875zkp5534.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e9698ee5-81f1-4556-d446-1f7332021070@redhat.com>
Date: Wed, 16 Oct 2019 14:23:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <875zkp5534.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/19 12:59 PM, Alex Benn=C3=A9e wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>> On 16.10.2019 08:11, Thomas Huth wrote:
>>> On 16/10/2019 05.00, Eduardo Habkost wrote:
>>>> On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
>>>>> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
>>>>>> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
>>>> [...]
>>>>>>> The configure check also spits out deprecation warnings for
>>>>>>> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be n=
ice
>>>>>>> to get those updated.
>>>>>>
>>>>>> CCing the test/vm maintainers.
>>>>>>
>>>>>> Fam, Alex, are you able to fix this and create new BSD VM images
>>>>>> with Python 3 available?  I thought the VM image configurations
>>>>>> were stored in the source tree, but they are downloaded from
>>>>>> download.patchew.org.
>>>>>
>>>>> Fam, Alex, can you help us on this?  Python 2 won't be supported
>>>>> anymore, so we need the VM images to be updated.
>>>>
>>>> Anyone?
>>>>
>>>> I'm about to submit patches to remove Python 2 support, and this
>>>> will break tests/vm/netbsd.
>>>>
>>>> I'm powerless to fix this issue, because the netbsd image is
>>>> hosted at download.patchew.org.
>>>
>>> Gerd had a patch to convert the netbsd VM script to ad hoc image
>>> creation, too:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04459.html
>>>
>>> But there was a regression with the serial port between QEMU v3.0 and
>>> v4.x, so it was not included:
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
>>>
>>> I guess someone=E2=84=A2 needs to bisect that regression, so we can f=
ix that bug
>>> and finally include Gerd's patch...
>>>
>>>    Thomas
>>>
>>
>> Is this a regression in qemu? How to reproduce the problem? "make
>> vm-build-netbsd V=3D1" ?
>=20
> You'll need to apply the patch from that series:
>=20
>    tests/vm: netbsd autoinstall, using serial
>=20
> (all the others got merged)
>=20
>> I can have a look but I need to know exact specifics of the problem.

IIRC this is not a NetBSD specific issue, but the NetBSD image triggers=20
the chardev bug reliably.

> Make sure you've cleared out any cached images. As was mentioned in the
> thread it seems to be a little host dependant - some host systems it wa=
s
> working and some it was not.

