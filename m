Received: from eggs.gnu.org ([2001:4830:134:3::10]:50033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYptw-0007B5-IR
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:04:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cYptt-0004uH-FK
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:04:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cYptt-0004u4-6v
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 03:04:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v117suWg080589
	for <qemu-devel@nongnu.org>; Wed, 1 Feb 2017 03:04:19 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28ba36ua61-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Feb 2017 03:04:18 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 1 Feb 2017 03:04:17 -0500
References: <20170130145025.26475-1-david@redhat.com>
	<89891b01-8d50-98ac-c26c-2a769b22b400@weilnetz.de>
	<CAFEAcA86o3ohxZj0qqHKSxqxmo1mCtwKPa_j78xdO2izynEopA@mail.gmail.com>
	<2d18251c-395e-641e-30d1-e44d7be9c012@weilnetz.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 1 Feb 2017 09:04:10 +0100
MIME-Version: 1.0
In-Reply-To: <2d18251c-395e-641e-30d1-e44d7be9c012@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <c0e1d939-774c-485b-b9b5-1e3631309358@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x: use "qemu" cpu model in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Riku Voipio <riku.voipio@iki.fi>, pkg-qemu-devel@lists.alioth.debian.org, qemu-stable <qemu-stable@nongnu.org>

On 01/30/2017 04:23 PM, Stefan Weil wrote:
> Am 30.01.2017 um 16:11 schrieb Peter Maydell:
>> On 30 January 2017 at 15:09, Stefan Weil <sw@weilnetz.de> wrote:
>>> Am 30.01.2017 um 15:50 schrieb David Hildenbrand:
>>>> "any" does not exist, therefore resulting in a misleading error message.
>>>>
>>>> Reported-by: Stefan Weil <sw@weilnetz.de>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  linux-user/main.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/linux-user/main.c b/linux-user/main.c
>>>> index 3004958..e588f58 100644
>>>> --- a/linux-user/main.c
>>>> +++ b/linux-user/main.c
>>>> @@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
>>>>  # endif
>>>>  #elif defined TARGET_SH4
>>>>          cpu_model = TYPE_SH7785_CPU;
>>>> +#elif defined TARGET_S390X
>>>> +        cpu_model = "qemu";
>>>>  #else
>>>>          cpu_model = "any";
>>>>  #endif
>>>
>>> Thanks.
>>>
>>> Reviewed-by: Stefan Weil <sw@weilnetz.de>
>>>
>>> This fix is also needed for Debian's QEMU user emulation.
>> Does it merit a cc: qemu-stable ?
>>
>> thanks
>> -- PMM
> 
> Yes, of course. Thanks for the reminder - I added that list now as cc.

Added to the kvm/s390 tree (since this tree introduced the regression)
