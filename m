Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6136EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECD8233A1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 09:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECD8233A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3H1V-0001kM-89
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 05:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3H0d-0001Ad-IM
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:46:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3H0Y-0005Su-S6
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:46:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3H0X-0005Rn-VW
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 05:46:22 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C88C155E0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:46:19 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j10so1812662wrb.16
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 02:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5kTrJLkapP5C/CWXunHQoT71JCaUar/HtXnHryMMDBU=;
 b=ejfclJu/ONwOhIdX45X5PRrnqVkSAW0Uyhs2Nx1V64MFQBDevgOhRt8qKnxT3kRKUo
 dMMnJbATrKas6PlalZSWlwAG6Cx/vNOWJVmhR2nLcMsOa1PPoM2j78T2Yv50d5aJHI2l
 e2i5r1HGTYvAonyffhF97mGzL7ZUP0g6uVfUcE7wknaLl6KPV2+KYh/7bkSDmDWl/KXJ
 2x8QmVNKA8VXMNFrGaaEQsitps5z1Kn2uMPczJhTQbLnY1+AES9LeTeGMgSefku45iyj
 4hmRIWiN2XiGbKR7o2tGgvWKEULyf1AwzRs8zcXgVdDV3RI8qwZ8KMcoRI6MvA/Z+wxM
 OBQw==
X-Gm-Message-State: APjAAAWBoQSbOf8MF+3pgQgCUO5X6v20UAYDmtOpoM1XI8nokSBj9Ji6
 zweu5GS4m0krlwl1pxdT2c5FZzM1+BC2Vc3qX8joGuothtaD4nWuJ/NCTAZd6c66hTBgJXA+CWt
 fJIQowToPlg0wSK8=
X-Received: by 2002:a5d:4a11:: with SMTP id m17mr52179wrq.40.1567071977531;
 Thu, 29 Aug 2019 02:46:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWHT5ZMd0V/oI14z65w1Jocw7XyZRvNJ3Z3pAXjtAhebJLtA5cj1yn8nR+d9xIqCD5tckpsg==
X-Received: by 2002:a5d:4a11:: with SMTP id m17mr52161wrq.40.1567071977288;
 Thu, 29 Aug 2019 02:46:17 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e6sm1650974wrw.35.2019.08.29.02.46.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 02:46:16 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
Date: Thu, 29 Aug 2019 11:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: ldoktor@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber, Luk=C3=A1=C5=A1,

On 8/29/19 11:24 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/29/19 5:27 AM, Cleber Rosa wrote:
>> On Thu, Aug 29, 2019 at 11:51:17AM +1000, David Gibson wrote:
[...]
>>> Fwiw, I also get an equally cryptic error that I haven't figured out
>>> the cause for on my 32-bit Fedora container environment:
>>>
>>>   VENV    /home/dwg/src/qemu/build/i386/tests/venv
>>>   PIP     /home/dwg/src/qemu/tests/requirements.txt
>>>   Failed building wheel for bcrypt
>>> Could not build wheels for bcrypt which use PEP 517 and cannot be ins=
talled directly
>>> You are using pip version 19.0.3, however version 19.2.3 is available=
.
>>> You should consider upgrading via the 'pip install --upgrade pip' com=
mand.
>>>
>>
>> This is certainly caused by pip not being able to install paramiko on
>> those systems.  I have dealt with paramiko (and its many dependencies)
>> before on the avocado remote runner plugin (which is not being used
>> here) and it was not fun.
>>
>> My personal goal was to rely on the ssh binary as an ssh client, which
>> should be more ubiquitous, and with that I added a simple wrapper to
>> Avocado:
>>
>>   https://avocado-framework.readthedocs.io/en/71.0/api/utils/avocado.u=
tils.html#module-avocado.utils.ssh
>=20
> I did not know this module.

class avocado.utils.ssh.Session(address, credentials)

  Parameters:=09

    credentials (tuple)
         username and path to a key for authentication purposes

The current test uses username + password.
Can we use this credentials with the Avocado module?
(The image used is prebuilt).

>> I guess we should consider changing the (few) tests that require
>> paramiko to use that module instead.
>=20
> Clean way to resolve this issue.

