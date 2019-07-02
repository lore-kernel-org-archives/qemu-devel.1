Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11114C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:55:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC24520665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC24520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFV6-0006pS-7w
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41047)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hiFTR-0005gR-85
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:53:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hiFTP-0001La-Ao
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:53:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hiFTK-0001IP-G6; Tue, 02 Jul 2019 05:53:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7898E3086204;
 Tue,  2 Jul 2019 09:53:00 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC77B1001B14;
 Tue,  2 Jul 2019 09:52:52 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com,
 imammedo@redhat.com, David Hildenbrand <david@redhat.com>
References: <20190701190819.25388-1-eric.auger@redhat.com>
 <78aa3a5a-9d29-c29d-64e4-ca16a69f4de4@redhat.com>
 <6d1b73bc-9ffa-7879-feb6-31cd03f3b5d0@redhat.com>
 <a369ef11-bf4a-67e3-8068-241ab02f371f@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <41e8588d-3b6d-c281-0324-fb0af746fa25@redhat.com>
Date: Tue, 2 Jul 2019 11:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a369ef11-bf4a-67e3-8068-241ab02f371f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 02 Jul 2019 09:53:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Hi Philippe,
On 7/2/19 11:43 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/2/19 11:01 AM, Auger Eric wrote:
>> Hi Philippe,
>> On 7/2/19 10:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Hi Eric,
>>>
>>> On 7/1/19 9:08 PM, Eric Auger wrote:
>>>> PCDIMM hotplug addition updated the DSDT. Update the reference table=
.
>>>
>>> Can you point the commit sha1 please?
>>
>> this follows Peter's make check failure report sent yesterday and
>> follow-up discussion on IRC. The series is not yet upstream so I canno=
t
>> point to any SHA1 yet.
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg627971.html
>=20
> I hadn't review this series, so this patch was making no sense at all t=
o
> me, now it does.
>=20
> I think it has to be squashed with:
> "hw/arm/virt: Enable device memory cold/hot plug with ACPI boot"
> in the series you mentioned.
Yep sorry for that. I was trying to fix the issue quickly for unblocking
the series for 4.1.

Actually it looks really weird as the test is passing on some hosts
(Igor is currently experiencing it). At the beginning I was not able to
reproduce Peter's issue and eventually after many various tweaks in the
environment I was able to. I used the script to regenerate the DSDT and
this definitively fixes the issue for me. Now we are not sure this isn't
an issue in the test itself.

Thanks

Eric
>=20
> Regards,
>=20
> Phil.
>=20
>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> ---
>>>>  tests/data/acpi/virt/DSDT | Bin 18476 -> 18493 bytes
>>>>  1 file changed, 0 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/tests/data/acpi/virt/DSDT b/tests/data/acpi/virt/DSDT
>>>> index 20e85c7f89f645c69935c615c07084e221419960..1a5c3e5243c78eb25345=
fdf7ffa442afec3c5c28 100644
>>>> GIT binary patch
>>>> delta 172
>>>> zcmZ28fpPByMlP3Nmk?VI1_q{Y6S<_BIvO{s=3DeSSi^^mWRZt~=3Da(Tfjuig$N)iRX=
y-
>>>> z@O0sIbPn(|FfcS`;D`?ea)A;+mUB?BARiZZCmRDZqb36bLnT9WgKLnhI|B~`0|zG;
>>>> zOLQYQi0kYc?CPT+ViNBf7Q$Ho;v_5(n_Qj1$iNt*&kVB1*CW8$H`v*4fdEjLhl`1U
>>>> Ni>WOjJjjWw0RY`tDw+TQ
>>>>
>>>> delta 134
>>>> zcmdlxfpN_QMlP3Nmk=3DEf1_q{ziCof5?F}2%bKIpo*xdvC4LIUGJY9GlgM2*<49pA}
>>>> zIN}{$f+og`c`$P_2rw{ovN13+sxvS!RDxt&Jq4Ay6ndl?7@-g-A<n=3Dc$sh-0Ff)LR
>>>> Z11c2ZjdwLLW@rlt4|3vam^{&45den68LI#Q
>>>>

