Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ED3C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8659A21897
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8659A21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYV7-0002qN-LW
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAYUO-0002Id-2O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:51:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAYUL-000596-NG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAYUL-00058V-G6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:51:13 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45EBC59465
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:51:12 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t11so2260839wrq.19
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5RHujtnNTF6LFQw37y3JTMK3iw/5QRxzRcJJ3fJq7wI=;
 b=ktBGPW8gMH/Ajzn74PMv8GlvNBqpOccP3ssZ3191VnkQHQTUwFNUdV/JWya3iTCLWS
 luYDjOlY35lQnlB0Oq29KXYQeavBnBXSQmyalZTVJUM+q1jlpFvM2MBU4vJWJ/78TdPN
 d2ybFuUc03XkpG+S7RP4Blzl1QYm61A0cf8mW3rLMex/hC6R9EBVwE3K/bWxTLvnp6Ae
 w/0J+A0NFkdA0vJ2BOND+Ljuwx59KZ/yet7helzf7iFda5jZMn6l78kNmI/uzaC2nuuj
 2oFs29/IieNT1ZLEXkjwj8PjwVq6zd/QmwDHTUHNwiep4QKcOXhM3dgXEgHLvDCNOS6H
 kUxQ==
X-Gm-Message-State: APjAAAUBo+Jn8/X1/sp+dEcPJoxTTBhyUswoVIAIawwWJdcLhly0MVf0
 q+TvkNCUL5vFzLnMVv85ooxuMNzJVgl9eYgyNF7u8c4xt+P3Vg49TTgP4uliVuybBfJcDyRVxme
 ++qep7OKLJMa9qLU=
X-Received: by 2002:a7b:c013:: with SMTP id c19mr2387310wmb.34.1568807471057; 
 Wed, 18 Sep 2019 04:51:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy/Z5n7B3iRIrFHDapRt6qcAaByzfiEFBJ1kYdUe2aKQH3zi+sde1nisao9/a4p3/tTWAtgxw==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr2387291wmb.34.1568807470858; 
 Wed, 18 Sep 2019 04:51:10 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id c6sm6459137wrm.71.2019.09.18.04.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:51:10 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190915211940.30427-1-f4bug@amsat.org>
 <20190916004242.GF2104@umbus.fritz.box>
 <331a9dc2-d79c-3f29-d818-3df74222425b@redhat.com> <87lfuo1sbp.fsf@linaro.org>
 <02b9bc89-eee6-493d-3e3c-ae75b6c24657@redhat.com>
 <20190917021952.GB8842@umbus.fritz.box>
 <20190917114006.GA2440@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d81d9abc-c2b3-ea67-313d-570eef4e41a3@redhat.com>
Date: Wed, 18 Sep 2019 13:51:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190917114006.GA2440@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 0/6] tests/acceptance: Add
 tests for the PReP/40p machine
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
 qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/19 1:40 PM, David Gibson wrote:
> On Tue, Sep 17, 2019 at 12:19:52PM +1000, David Gibson wrote:
>> On Mon, Sep 16, 2019 at 11:56:06AM +0200, Philippe Mathieu-Daud=E9 wro=
te:
>>> On 9/16/19 11:52 AM, Alex Benn=E9e wrote:
>>>>
>>>> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>>>>
>>>>> Hi David,
>>>>>
>>>>> On 9/16/19 2:42 AM, David Gibson wrote:
>>>>>> On Sun, Sep 15, 2019 at 11:19:34PM +0200, Philippe Mathieu-Daud=E9=
 wrote:
>>>>>>> Quick tests worth to avoid regressions with the 40p machine.
>>>>>>> idea from the "Maintainers, please tell us how to boot your machi=
nes"
>>>>>>> thread:
>>>>>>> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04177.ht=
ml
>>>>>>>
>>>>>>> v2: Split Travis job, added Herv=E9 R-b tag
>>>>>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg0589=
6.html
>>>>>>>
>>>>>>> Regards,
>>>>>>>
>>>>>>> Phil.
>>>>>>
>>>>>> I'm guessing you're expecting these to go in via the testing tree,=
 in
>>>>>> which case
>>>>>>
>>>>>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>>>>
>>>>> Thanks, appreciated :)
>>>>>
>>>>>> Or do you want me to take them via the ppc tree?
>>>>>
>>>>> I think the 'testing tree' should focus on the CI/testing
>>>>> infrastructure, while each subsystem maintainers should care about =
the
>>>>> tests covering their subsystem (the testing tree maintainers might =
not
>>>>> have the required knowledge to be sure a test is correctly implemen=
ted).
>>>>>
>>>>> In this particular case I assume you don't have much knowledge of t=
hat
>>>>> PPC machine, which is a hobbyist one, but since you are the PPC
>>>>> maintainer, I'd rather see this going via your tree :)
>>>>>
>>>>> Alex/Cleber/Eduardo, any comment on this position?
>>>>
>>>> Once we have a .travis.yml I'm happy with it can go in via another t=
ree
>>>> no problem. See other thread....
>>>
>>> Good :)
>>>
>>> David can take patches 1-5 (I tagged patch 6 as RFC but messed someth=
ing
>>> with git-publish and lost it when I sent this series).
>>
>> Ok, I've taken patches 1-5 into my ppc-for-4.2 tree.
>=20
> Hrm.  Judging by both the continued comments on this thread, and the
> fact it breaks the travis build, seems like this series needs a little
> more work.  I've pulled it out of ppc-for-4.2 again, and I'll wait for
> the next spin.

OK, sorry :|

