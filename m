Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9F0C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11A7E21D81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 08:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A7E21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGJMY-00027j-6t
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 04:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45574)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGJLH-0001UA-JP
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGJLD-00066A-S5
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51362)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGJLD-00063u-KF
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 04:53:35 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C739481129
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 08:53:31 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id f63so1342602wma.7
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 01:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iCyOJx2gQSlKGDov8X7GkudJaL7qr4ay8ojEoGGffZw=;
 b=IHTKNxqrKQJdJr0gSXcEWr2Jx60CNhR7CnMWmSgCAoKmnxd7z0SMJ+xbYNRgUErwb1
 Kldbw/ypo5rWdcQ7Yo3vdHZaUmob4NqI3R5+nOeeEPQMHyIv1ILL50DcmGKoddlXOkkv
 5qJ+igY9PYxnoV/eZxN1CDwaqdOBh2BJfIbFjTRXUSWG3yONWF3gcXRwhS67rDaqrBGi
 tfgsJCdo3sHPmRcuhf70W0tAcj7pSD97yBY3nVZGVTq1b1jMLy20aQmv+vy3rp9EMYDH
 OPGQliUVtoF3OX8fvd0mXRuu4f8QBP6pHvlAE+hlBnzwCFpF+rjKoYdYtaEKRqozhihM
 C7GQ==
X-Gm-Message-State: APjAAAW7h96wp1SesXUYFYxFpLkdNoqdxc5TFEn950Zk+EEFieq2DtU0
 ybCnxkelV3mu9oTY+HA1gnAhq4fsTsv86wk6DGxDMicEHbj+kyZgTm9IqofiOglSuoaeZB48ch9
 PBj7CGNauMCZY9YE=
X-Received: by 2002:a05:600c:284:: with SMTP id
 4mr9541308wmk.107.1570179210550; 
 Fri, 04 Oct 2019 01:53:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy11ff0nxnoxNoWtS8LvRfqP36AYLMOfXuCkX8h+3wR4X78y+Qa/8TiU45MLh99WH128YwO1w==
X-Received: by 2002:a05:600c:284:: with SMTP id
 4mr9541289wmk.107.1570179210272; 
 Fri, 04 Oct 2019 01:53:30 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id h7sm5442998wrt.17.2019.10.04.01.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2019 01:53:29 -0700 (PDT)
Subject: Re: [PATCH 7/7] tests/fw_cfg: Run the tests on big-endian targets
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20191003225437.16651-1-philmd@redhat.com>
 <20191003225437.16651-8-philmd@redhat.com>
 <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3e5e4211-2872-3908-6654-83a5e7f16d72@redhat.com>
Date: Fri, 4 Oct 2019 10:53:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1932cc2e-830c-e542-817d-a6e5ef750c6c@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 10:05 AM, Laurent Vivier wrote:
> On 04/10/2019 00:54, Philippe Mathieu-Daud=C3=A9 wrote:
>> We have been restricting our fw_cfg tests to the PC machine,
>> which is a little-endian architecture.
>> The fw_cfg device is also used on the SPARC and PowerPC
>> architectures, which can run in big-endian configuration.
>>
>> Since we want to be sure our device does not regress
>> regardless the endianess used, enable this test one
>> these targets.
>>
>> The NUMA selector is X86 specific, restrict it to this arch.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/Makefile.include |  2 ++
>>   tests/fw_cfg-test.c    | 18 +++++++++++++++---
>>   2 files changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 3543451ed3..322bdb36ff 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -242,6 +242,7 @@ check-qtest-ppc64-$(CONFIG_VGA) +=3D tests/display=
-vga-test$(EXESUF)
>>   check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
>>   check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(=
EXESUF)
>>   check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
>> +check-qtest-ppc64-y +=3D tests/fw_cfg-test$(EXESUF)
>=20
> Perhaps only a detail, but ppc64 (pseries) doesn't use fw_cfg, but ppc
> (mac99, g3beige and prep) does, so perhaps you should rather add the
> test to check-qtest-ppc-y (and it will be inherited by ppc64)?

The test only runs the mac99 machine.

What happens when running "qemu-system-ppc64 -M mac99"? Does it runs in=20
64-bit? Else it is probably pointless to run the test in ppc64, and I=20
should restrict it the ppc[32].

