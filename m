Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B832C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A28C21907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 12:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dir84AqM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A28C21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYcz-0006ah-If
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 08:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAYc5-0005tV-Hz
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAYc3-0008TK-Vy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:59:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAYc3-0008Sr-MM
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1568807951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=vRrFpQdvhn13VEo29DYcC/ksvktAfVcnL7kMrjSK5OQ=;
 b=Dir84AqMj9PyhkiIUhDyBE1rhp5aBSeFmemyxlu250OMwQfaa/Pcu8EGqFepLicXnfd34L
 t3cWdqCm2bdJSUtTyPMYaFMQwt6z/uT+t9C1nHUEGNaZ/wXv7CPoEmBemJkPz7kp52xNGJ
 rJuNtJMeuy+sstPr665KPqsu5o1PrfI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-TAL_zJNkPpmU1GDeM2pGSw-1; Wed, 18 Sep 2019 07:59:09 -0400
Received: by mail-wr1-f69.google.com with SMTP id v18so2263462wro.16
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ztxgd9cPyTeJAUChrJ+kVnunbbBbNemXXkZzuIt/Ho0=;
 b=sL9gDcZaw2lCC8hyaz+uYP0HWrWM5R/FrNv+Cal2FQ2LEGAgqFGlAIhHcrNArGxT3L
 Yb4P1PQnrp81kL13jLFDn2DrxqwEQafWoZxkvej34HgaSlPTkk24U/SJP0pF8ry5OQit
 bDwAcDAwSUUynwnYcN33OAWwj46DlUev3ZN9D0hT2D3OYcnTT38GbM2VvJp74wU/YwyN
 Wo7P8wQAnluZhBeGrCNzSC8UsA3m6pnDYIS+GIrN9j83ABTiVRfyuIN/aNbvanFrczyd
 hxNzl97FUi/S+7pSXuoH8tpPDHEWiWo2d2sGigwfjLV7jRGbrmsYY5xhMwcyd+Aqap7f
 jj6g==
X-Gm-Message-State: APjAAAXrobMthjZQFmCbNqrm6jYsTQH707qmxKJuaCQd2CXDssA1DqDz
 6gLpkzMvodB52mVwgxeQ4Txz77lKosTwrXVhYAUTW0dRDDSPhQa/CIM/i0tk6VwKXJlHgCoxHEF
 ucYYUS4wZNj+GCow=
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr2902109wrd.33.1568807948209;
 Wed, 18 Sep 2019 04:59:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzghD3s941NQTwlLPJpMoxU9dDIkqmoMbR24uz2Sw/vZYtmNXub9tNspFMG0ywXcZ3NxM00vQ==
X-Received: by 2002:adf:b3c1:: with SMTP id x1mr2902094wrd.33.1568807948016;
 Wed, 18 Sep 2019 04:59:08 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id d10sm2172396wma.42.2019.09.18.04.59.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:59:07 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Ilias <i.maratos@gmail.com>, qemu-devel@nongnu.org
References: <CANP-_LDVvnbXnk1GpNRbQ3zKBsh-z6_w1qn-t9LKbtGEEKUV-A@mail.gmail.com>
 <ed7f417a-8f25-fcf2-b2d8-b1535fca4422@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e6606568-4126-ba95-5595-19725b183f31@redhat.com>
Date: Wed, 18 Sep 2019 13:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <ed7f417a-8f25-fcf2-b2d8-b1535fca4422@redhat.com>
Content-Language: en-US
X-MC-Unique: TAL_zJNkPpmU1GDeM2pGSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
Subject: Re: [Qemu-devel] WHPX build broken
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 1:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Ilias,
>=20
> On 9/18/19 10:19 AM, Ilias wrote:
>> Hi,
>>
>> Your recent patch
>>
>> https://github.com/qemu/qemu/commit/12e9493df9242a2051701e7eb64175d4e904=
acba#diff-d98f9b48cc332d226892f0db74a86b87
>>
>> to the file
>>
>> target/i386/whpx-all.c
>> <https://github.com/qemu/qemu/blob/master/target/i386/whpx-all.c>
>>
>> breaks compilation when WHPX is enabled.
>=20
> How do you build QEMU? Which OS/compiler version, ./configure flags,
> etc...? (looking at adding your case in our build setup).

OK I could reproduce wiht the qemu:fedora Docker image and this
Android/MinGW commit:
https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/host/x86_=
64-w64-mingw32-4.8/+/1bde9c3b14f3a3b081ada6e32da9f2870671b46f

$ ./configure --python=3D/usr/bin/python3
--cross-prefix=3Dx86_64-w64-mingw32-
--target-list=3Dx86_64-softmmu,i386-softmmu --enable-hax --enable-whpx
--extra-cflags=3D"-Iandroid" --disable-werror

$ make x86_64-softmmu/all
[...]
  CC      x86_64-softmmu/target/i386/whpx-all.o
target/i386/whpx-all.c: In function 'whpx_accel_init':
target/i386/whpx-all.c:1378:25: error: dereferencing pointer to
incomplete type 'MachineState' {aka 'struct MachineState'}
     whpx->mem_quota =3D ms->ram_size;
                         ^~
make[1]: *** [rules.mak:69: target/i386/whpx-all.o] Error 1
  CC      x86_64-softmmu/trace/generated-helpers.o
make[1]: Target 'all' not remade because of errors.
make: *** [Makefile:471: x86_64-softmmu/all] Error 2

MachineState is indeed declared in "hw/boards.h".


