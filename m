Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76185C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C10B21841
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 16:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C10B21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDtb3-0006Zr-Dj
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 12:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDrTt-0003cW-GM
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDrTp-0008Ju-Vd
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48492)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDrTp-0008JS-Lb
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 10:44:21 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A22A7CBB1
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 14:44:20 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j3so1132930wrn.7
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 07:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2q+9SXfolCGkpiu01Kpc50RZfUmkJV77qGm65Z4aLrw=;
 b=g8K6LbGDQeQo+4x3n1JHVPr4oVxLUISXA69pMO8PCnKRmxRAfthxm/JG3wCuNK5JWh
 I7aD8kmE2vh8tRgz4tXIdk0cF7HQq/BJB+AKauezLdKC2MRYmlqZ5a58/onH6MEdBYYz
 uXpuVd01P8uX666I3nowq9iZLdjtZEr0HdIY5G1sIuma0m2Tob+scA9dWiQ1jppjTCH1
 HCeG34wEAg053VGjsEQWnXDKIQcJf2ev88aGoNJDq+NdI5SryjSdf5gW2cPsbF85F0YN
 v5HTTt0Zd6boDXpgF7RY5jwehx5GPD6yQisPz9E78F5rlJck3SE8J2iv3HqFyjVB0ucg
 sheg==
X-Gm-Message-State: APjAAAXkMRnBXgeIUOQGTqG9VeFycmJaipU20OsKSYCUrXHbSowpwsYQ
 wSmhZ5LHYzSTMWXEo4WPgt4w1DexpNBZF304LaKv4QeKVV9bmorWG3oEJYlPJjv1UcflhlVdkBJ
 Jn1m2AKJq1yx2ohM=
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr8031925wme.92.1569595458433; 
 Fri, 27 Sep 2019 07:44:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxbZp8HmBA51sBwb3b89xFrk0CkTIdezJrIhZyhIvEU53PPyiWJhUaBYgDbSXXS1qzPc15bvg==
X-Received: by 2002:a1c:a90b:: with SMTP id s11mr8031894wme.92.1569595458242; 
 Fri, 27 Sep 2019 07:44:18 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b184sm6552821wmg.47.2019.09.27.07.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Sep 2019 07:44:17 -0700 (PDT)
Subject: Re: [PATCH 14/19] python/qemu/machine: Allow to use other serial
 consoles than default
To: Peter Maydell <peter.maydell@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Cleber Rosa <crosa@redhat.com>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-15-f4bug@amsat.org>
 <CADYoBw11iiK=+O-mGYS5Xp85zVhezOXXXr-wKV_xCg07ZYuzVw@mail.gmail.com>
 <20190927132602.GA19931@roeck-us.net>
 <CAFEAcA8KcJzCNU1iLjiteEKhLsw9jeDyyqXurv0fuvSmLAEF0A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <00b49d9e-0860-161f-a4d4-41fbe7bb2124@redhat.com>
Date: Fri, 27 Sep 2019 16:44:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8KcJzCNU1iLjiteEKhLsw9jeDyyqXurv0fuvSmLAEF0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
Cc: bzt <bztemail@gmail.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cheng Xiang <ext-cheng.xiang@here.com>,
 Pekka Enberg <penberg@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 3:36 PM, Peter Maydell wrote:
> On Fri, 27 Sep 2019 at 14:26, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Fri, Sep 27, 2019 at 02:54:10PM +0200, bzt wrote:
>>> Hi,
>>>
>>> On 9/26/19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>>>> Currently we are limited to use the first serial console available.
>>>
>>> I'm not so sure. Right now it works like this:
>>>
>>> qemu -serial stdio
>>> Connects the VM's UART0 (PL011) serial console to the host terminal
>>>
>>> qemu -serial null -serial stdio
>>> Connects the VM's UART1 (AUX) serial console to the host terminal
>>>
>>> I think this is simple and good, please don't remove this option. If
>>> your commit does not influence these cli args, I'm not against it.
>>>
>> Agreed. I am using that mechanism (raspi3 uses the second console,
>> not pl011) in my scripts. Please don't take it away.
>=20
> This patch is changing our python infrastructure that invokes
> QEMU, not QEMU itself. What Philippe's message means is
> "currently our code for running QEMU as part of tests like
> this is limited to using the first serial console; this doesn't
> work for raspi because we want to use the second (aux) console;
> so make the test infrastructure able to handle machines like this."

Exactly, thanks Peter for clarifying.

I'll try to come with a clearer commit description.

Regards,

Phil.

