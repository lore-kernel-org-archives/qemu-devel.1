Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C24C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E46A7206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E46A7206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFLj-0007Q6-Su
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39060)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiFKP-0006iO-5O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiFKN-0006WO-Ui
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:43:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiFKN-0006W0-MR
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:43:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so212706wma.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 02:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JXNqboG/6khsCf+27ofnoCFp0LemwWTZeTG2yyfqZro=;
 b=tagjJgNO7dIsnbBb/lzdVxFwRFmu/+Rc9u4D/MtP6FVYZDayse6Y2TZ7dlVKpK6N3x
 h8pZqkttoz8VQTZ6jjVub6wEWtACvx1O+oB25RyCqOylgi8YHrOOMHKs6kyRqhjaGXUj
 zE5HeDa13AQoF8efyw1NrRUdln6WsTnPSZRBh5r7h7ULJGNhM3ZXrTuAUHMpG6zPgvqP
 M6hroTv4W+DM0kv8Q7mUZMsEGFZnyCqqOZoric+EeYFVD3jNqFg5dKZFrmmyVKjo/K8L
 dAUFdnmY+WajFnGGeYjoFJ3gO51/GhjiEYdRld42HU1gVfftLfI8CFzckHRG6AVAiWyN
 Qhiw==
X-Gm-Message-State: APjAAAXRlOu3GyEnxnPKerueeNpTu3NyAbhdNnwQImJQM18e4Tf2d52c
 QxsB48Y55pzSzppsir+sJCBusg==
X-Google-Smtp-Source: APXvYqwp05wxxLhMUzNGfjFElYTyaH6g+lzYK3OmSi3oZ59yyH8o32iMQECp4VawaX7IdH8zBkUP4A==
X-Received: by 2002:a1c:dc46:: with SMTP id t67mr2550268wmg.159.1562060634519; 
 Tue, 02 Jul 2019 02:43:54 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h8sm1837548wmf.12.2019.07.02.02.43.53
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Jul 2019 02:43:53 -0700 (PDT)
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com,
 David Hildenbrand <david@redhat.com>
References: <20190701190819.25388-1-eric.auger@redhat.com>
 <78aa3a5a-9d29-c29d-64e4-ca16a69f4de4@redhat.com>
 <6d1b73bc-9ffa-7879-feb6-31cd03f3b5d0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a369ef11-bf4a-67e3-8068-241ab02f371f@redhat.com>
Date: Tue, 2 Jul 2019 11:43:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <6d1b73bc-9ffa-7879-feb6-31cd03f3b5d0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] tests: Update DSDT ACPI table for arm/virt
 board with PCDIMM related changes
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

On 7/2/19 11:01 AM, Auger Eric wrote:
> Hi Philippe,
> On 7/2/19 10:56 AM, Philippe Mathieu-Daudé wrote:
>> Hi Eric,
>>
>> On 7/1/19 9:08 PM, Eric Auger wrote:
>>> PCDIMM hotplug addition updated the DSDT. Update the reference table.
>>
>> Can you point the commit sha1 please?
> 
> this follows Peter's make check failure report sent yesterday and
> follow-up discussion on IRC. The series is not yet upstream so I cannot
> point to any SHA1 yet.
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg627971.html

I hadn't review this series, so this patch was making no sense at all to
me, now it does.

I think it has to be squashed with:
"hw/arm/virt: Enable device memory cold/hot plug with ACPI boot"
in the series you mentioned.

Regards,

Phil.

>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> ---
>>>  tests/data/acpi/virt/DSDT | Bin 18476 -> 18493 bytes
>>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
>>> index 20e85c7f89f645c69935c615c07084e221419960..1a5c3e5243c78eb25345fdf7ffa442afec3c5c28 100644
>>> GIT binary patch
>>> delta 172
>>> zcmZ28fpPByMlP3Nmk?VI1_q{Y6S<_BIvO{s=eSSi^^mWRZt~=a(Tfjuig$N)iRXy-
>>> z@O0sIbPn(|FfcS`;D`?ea)A;+mUB?BARiZZCmRDZqb36bLnT9WgKLnhI|B~`0|zG;
>>> zOLQYQi0kYc?CPT+ViNBf7Q$Ho;v_5(n_Qj1$iNt*&kVB1*CW8$H`v*4fdEjLhl`1U
>>> Ni>WOjJjjWw0RY`tDw+TQ
>>>
>>> delta 134
>>> zcmdlxfpN_QMlP3Nmk=Ef1_q{ziCof5?F}2%bKIpo*xdvC4LIUGJY9GlgM2*<49pA}
>>> zIN}{$f+og`c`$P_2rw{ovN13+sxvS!RDxt&Jq4Ay6ndl?7@-g-A<n=c$sh-0Ff)LR
>>> Z11c2ZjdwLLW@rlt4|3vam^{&45den68LI#Q
>>>

