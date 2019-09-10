Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F91D20872
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 13:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F91D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7fnV-00021w-0K
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 09:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7fip-0008TD-Gv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7fim-0005pT-Ab
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:58:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54420)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7fim-0005mu-30
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 08:58:12 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 37FC777342
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 12:58:09 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id r21so1319435wme.5
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 05:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K6wtmp1BYHhxcd43QNkip5vQTnFqFsq9MvbW1f6s8iM=;
 b=VriJYGejirclPUbOnqZ1D7uwVsW2yXCHVN7es/+/PZx+lafypFkkFgUQTK6+KxVL9F
 hsB0z+QKk5t/NjZnJKQ21VT5cvlYbSK4w1DZba8T3ADweZUu6E7pFa/e8VSjg6gftiE4
 jdH19oz1fO7i07JikTJkZ1Mw6lRx7T5EkzHdAtZ39ewL3kcdHjpdrjh/vwQKl2AGPyJi
 poT81XZ3tVe+CVUc9R0YIfa2NShIT7OeOQMFiLkz9b5KSCDErw1VCdsLmrbtCikM4Pyd
 nrmGlddnBe+PmWkS/RCWtsYVUw9Y0ubCFfOu3VMon2nxQw0JKvzoVHe0oSG5ttPFv5rs
 zUWA==
X-Gm-Message-State: APjAAAWhVKTi9umeCc6quMSG0tyxp0jQoQpqXoQwi1a/zy91uKrcTi9E
 I0ZxBWRyfA1dBG4jWofOXFRdEDRSjE9GsD9Ggmicr6wHBgI4uhWhBWkegjRoLF9CwCnz3D1HIrf
 ZSDxW/ZqKAjRlFdg=
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr28353675wrb.61.1568120287556; 
 Tue, 10 Sep 2019 05:58:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzkwdammfRpWsKXXS+2cMgz5YvIgUG8K1oP3ht6ff8kAXocK1ChGOd3Gdl8LoMlvFBE8ranYQ==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr28353646wrb.61.1568120287354; 
 Tue, 10 Sep 2019 05:58:07 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t203sm4264601wmf.42.2019.09.10.05.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2019 05:58:06 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190907154744.4136-1-huth@tuxfamily.org>
 <20190907154744.4136-8-huth@tuxfamily.org>
 <CAFEAcA_NHnNNC8jdVc7CGEQ=PDhDjQfiRb++=ZgdjKUPqi2f=w@mail.gmail.com>
 <a4de8c0c-5758-13a4-0f74-3e7a0208ad34@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <456eb793-dac0-618a-bf55-01848e6263ab@redhat.com>
Date: Tue, 10 Sep 2019 14:58:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a4de8c0c-5758-13a4-0f74-3e7a0208ad34@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 7/8] tests/acceptance: Add test of NeXTcube
 framebuffer using OCR
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/19 2:07 PM, Thomas Huth wrote:
> On 10/09/2019 14.02, Peter Maydell wrote:
>> On Sat, 7 Sep 2019 at 16:47, Thomas Huth <huth@tuxfamily.org> wrote:
>>>
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>
>>> Add a test of the NeXTcube framebuffer using the Tesseract OCR
>>> engine on a screenshot of the framebuffer device.
>>>
>>> The test is very quick:
>>>
>>>   $ avocado --show=3Dapp,console run tests/acceptance/machine_m68k_ne=
xtcube.py
>>>   JOB ID     : 78844a92424cc495bd068c3874d542d1e20f24bc
>>>   JOB LOG    : /home/phil/avocado/job-results/job-2019-08-13T13.16-78=
844a9/job.log
>>>    (1/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.te=
st_bootrom_framebuffer_size: PASS (2.16 s)
>>>    (2/3) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.te=
st_bootrom_framebuffer_ocr_with_tesseract_v3: -
>>>   ue r pun Honl'=EF=AC=82x ; 5=E2=80=98 55=E2=80=98
>>>   avg ncaaaaa 25 MHZ, memary jag m
>>>   Backplane slat =C2=ABa
>>>   Ethernet address a a r a r3 2
>>>   Memgry sackets aea canflqured far 16MB Darlly page made stMs but ha=
ve 16MB page made stMs )nstalled
>>
>> By the way, do we know why the output from this test case is
>> garbled like this ? It suggests that something's not right
>> somewhere...

I got better result using few options to tune, but later noticed they
differ on Fedora/Ubuntu.
Tesseract v4 has better result but it is alpha and we need to install
train data. Not that big, 15MiB:
https://github.com/tesseract-ocr/tessdata_best/blob/master/eng.traineddat=
a
I preferred to keep the simplest tests with acceptable result, we are
not interested in fully understandable text output: we only want to know
the framebuffer model works. Reading "Ethernet address" is good and
quick enough.

> The text is created from the framebuffer with the OCR-tool Tesseract -
> which is just not good enough to recognize all words properly here.
>=20
>  Thomas
>=20

