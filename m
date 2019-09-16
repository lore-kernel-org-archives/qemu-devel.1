Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F8C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0B720678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0B720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nJo-0002aE-Oh
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9nJ7-0002Af-W5
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:28:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9nJ6-0008R5-7r
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33908)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9nJ5-0008Qp-Rl
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:28:28 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A809283F3C
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:28:26 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o16so4059433wru.10
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=su84Z6hmzpc7w8nvN+8CaKj9CdVf1E8dnnHZjR7Vk8U=;
 b=YZhG09BZyTWvyEYpFbLtLVMTZSCrUQG1mAmcaAmUNVWEK2GRTGZyTafTT5N5DGpShU
 G/vW0OwmHGz1/rFaDQj2IYedDOaamsRICDR4fCJSSBYRaoLlYfOOMVVFcWDVgq0NBp68
 zDqeiJcRNkFdagr2kqnblgakhP7NeALxaAtp35iPIgzok5OGqToEMdcjrKk0O7R7Zet1
 dAJm1hs1QFqy/Nr2N6gNEWS4uctl61awmczaajqNkvBA1+i5TlShnvLvKKZ7U2VHAYcl
 ONYPvTn6VX6Mogl6GCfrUDAwq2iO1P+BqIj+t0LjLUKgPxiZgdSrlnd+44+1T9DGYkRx
 eoSw==
X-Gm-Message-State: APjAAAXTbHmGZl8xloxUxmhV5c0DJULavIl2gZNgw4MEMK4eUmIJkDmk
 vNRqoW1p2hcbPkjQCfjM68OmbXcKk0ijmvhLRRISQUZM75R9rIctU7SpTGUbR+IUwDSkhoU0182
 kb363G015AgaYjFI=
X-Received: by 2002:a5d:428c:: with SMTP id k12mr19214380wrq.196.1568626105291; 
 Mon, 16 Sep 2019 02:28:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxD4ep20EwoAa0OmwBy/D2QD+wdZPEitc/x6YcwP5wUXXYn5/vk4wyXB5OdwvK0v0RkTZ1xFQ==
X-Received: by 2002:a5d:428c:: with SMTP id k12mr19214365wrq.196.1568626105101; 
 Mon, 16 Sep 2019 02:28:25 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g201sm14914762wmg.34.2019.09.16.02.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 02:28:24 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com>
Date: Mon, 16 Sep 2019 11:28:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190916004242.GF2104@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests/acceptance: Add tests for the
 PReP/40p machine
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,

On 9/16/19 2:42 AM, David Gibson wrote:
> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
>> Quick tests worth to avoid regressions with the 40p machine.
>> idea from the "Maintainers, please tell us how to boot your machines"
>> thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
>>
>> v2: Split Travis job, added Herv=E9 R-b tag
>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.htm=
l
>>
>> Regards,
>>
>> Phil.
>=20
> I'm guessing you're expecting these to go in via the testing tree, in
> which case
>=20
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Thanks, appreciated :)

> Or do you want me to take them via the ppc tree?

I think the 'testing tree' should focus on the CI/testing
infrastructure, while each subsystem maintainers should care about the
tests covering their subsystem (the testing tree maintainers might not
have the required knowledge to be sure a test is correctly implemented).

In this particular case I assume you don't have much knowledge of that
PPC machine, which is a hobbyist one, but since you are the PPC
maintainer, I'd rather see this going via your tree :)

Alex/Cleber/Eduardo, any comment on this position?

Thanks,

Phil.

>> Philippe Mathieu-Daud=E9 (6):
>>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/40=
p
>>   tests/acceptance: Test Open Firmware on the PReP/40p
>>   tests/acceptance: Test OpenBIOS on the PReP/40p
>>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
>>   .travis.yml: Let the avocado job run the 40p tests
>>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
>>
>>  .travis.yml                      |  18 +++-
>>  MAINTAINERS                      |   1 +
>>  tests/acceptance/ppc_prep_40p.py | 150 ++++++++++++++++++++++++++++++=
+
>>  3 files changed, 167 insertions(+), 2 deletions(-)
>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>>
>=20

