Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025EC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:57:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28000206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 09:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28000206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9nl3-0004h9-A2
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 05:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9njx-0003V4-5r
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9njv-0002vS-B9
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:56:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i9njv-0002v8-43
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 05:56:11 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 33B2937E88
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 09:56:10 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m14so4282671wru.17
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 02:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ka1NNKZ9FyRyl5DdCkNNqBxZCHj3VNnYXG0utcjVjkU=;
 b=CT4fOLOMp3tT64ncCiHsncxqR5cNEb1ypUJ6WFkC9evpyq2XW4vJqZvf0MJudVwcDQ
 949/k2fO4d9tMU2KEqMWyqcuMBwQC2/gRNJlbEzla3pnIB9xHRL3eF6OYY9R6hT1AMtt
 PSwMbc37fy/JFto3hbiu+QKy8Ruw+7/6NLor0MFc0oSn5FMYP+SwQhp+WBDGew464p5k
 YmpqbrSBR1inCTCYLpOQbej512s2XTwl0vdI6TRHTc4WmVGabhIf7weoubAFZKdgm0Ke
 QrHSdcPNpZtUV50upK6M/D6qGIZTjANBYY8qKpUCd5q13cge2VhyLmyvkWeJ4fiQsqdE
 t9dQ==
X-Gm-Message-State: APjAAAWQPqUziC7x2JBTYDOjgj6cdB9vLNyl5lEQKvUMEx+zC08DMdV2
 dtyEDI9rB+DfRtYtVU11NuSjhozaaGOQkgakADBgLin1xD8bKR9lBYw84GifT78kEs1HWCVhvlv
 d7eTcoo/GLnCfUV8=
X-Received: by 2002:a5d:6647:: with SMTP id f7mr49150740wrw.170.1568627768809; 
 Mon, 16 Sep 2019 02:56:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwi8PGh8Sc6+EQ4LN7O+fOBxnQvTqFVB1ARTvU95wiiIjo4TpUGc+0Q/epriREgOFIBJexJcQ==
X-Received: by 2002:a5d:6647:: with SMTP id f7mr49150719wrw.170.1568627768602; 
 Mon, 16 Sep 2019 02:56:08 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s9sm14067887wme.36.2019.09.16.02.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Sep 2019 02:56:08 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com> <87lfuo1sbp.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <02b9bc89-eee6-493d-3e3c-ae75b6c24657@redhat.com>
Date: Mon, 16 Sep 2019 11:56:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87lfuo1sbp.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
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
 Thomas Huth <huth@tuxfamily.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 11:52 AM, Alex Benn=C3=A9e wrote:
>=20
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>=20
>> Hi David,
>>
>> On 9/16/19 2:42 AM, David Gibson wrote:
>>> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>> Quick tests worth to avoid regressions with the 40p machine.
>>>> idea from the "Maintainers, please tell us how to boot your machines=
"
>>>> thread:
>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.html
>>>>
>>>> v2: Split Travis job, added Herv=C3=A9 R-b tag
>>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg05896.h=
tml
>>>>
>>>> Regards,
>>>>
>>>> Phil.
>>>
>>> I'm guessing you're expecting these to go in via the testing tree, in
>>> which case
>>>
>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Thanks, appreciated :)
>>
>>> Or do you want me to take them via the ppc tree?
>>
>> I think the 'testing tree' should focus on the CI/testing
>> infrastructure, while each subsystem maintainers should care about the
>> tests covering their subsystem (the testing tree maintainers might not
>> have the required knowledge to be sure a test is correctly implemented=
).
>>
>> In this particular case I assume you don't have much knowledge of that
>> PPC machine, which is a hobbyist one, but since you are the PPC
>> maintainer, I'd rather see this going via your tree :)
>>
>> Alex/Cleber/Eduardo, any comment on this position?
>=20
> Once we have a .travis.yml I'm happy with it can go in via another tree
> no problem. See other thread....

Good :)

David can take patches 1-5 (I tagged patch 6 as RFC but messed something
with git-publish and lost it when I sent this series).

Thanks!

>>>> Philippe Mathieu-Daud=C3=A9 (6):
>>>>   tests/acceptance: Add test that runs NetBSD 4.0 installer on PRep/=
40p
>>>>   tests/acceptance: Test Open Firmware on the PReP/40p
>>>>   tests/acceptance: Test OpenBIOS on the PReP/40p
>>>>   tests/acceptance: Test Sandalfoot initrd on the PReP/40p
>>>>   .travis.yml: Let the avocado job run the 40p tests
>>>>   .travis.yml: Split enterprise vs. hobbyist acceptance test job
>>>>
>>>>  .travis.yml                      |  18 +++-
>>>>  MAINTAINERS                      |   1 +
>>>>  tests/acceptance/ppc_prep_40p.py | 150 ++++++++++++++++++++++++++++=
+++
>>>>  3 files changed, 167 insertions(+), 2 deletions(-)
>>>>  create mode 100644 tests/acceptance/ppc_prep_40p.py
>>>>
>>>
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20

