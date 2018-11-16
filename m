Received: from eggs.gnu.org ([2001:4830:134:3::10]:39952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfeg-0003sn-Sd
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:03:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNfeX-0007nH-8G
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:03:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNfeX-0007mF-2I
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:03:25 -0500
References: <cover.1542301855.git.xiezhide@huawei.com>
	<37e2a76b4020a5f9e48fe3b7c36d8e4bfb111569.1542301855.git.xiezhide@huawei.com>
	<df1afb51-f027-d5f8-d5e2-b9869cf104f7@redhat.com>
	<A02D6AA901860840B46E751C5E9E38B43CC975D8@DGGEML532-MBX.china.huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2c4e7d2-b39f-1d82-f382-4aab96c9ee2a@redhat.com>
Date: Fri, 16 Nov 2018 09:03:20 -0600
MIME-Version: 1.0
In-Reply-To: <A02D6AA901860840B46E751C5E9E38B43CC975D8@DGGEML532-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] fsdev-throttle-qmp: move struct
 ThrottleLimits to new file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiezhide <xiezhide@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "groug@kaod.org" <groug@kaod.org>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, "armbru@redhat.com" <armbru@redhat.com>, "berto@igalia.com" <berto@igalia.com>, zengcanfu 00215970 <zengcanfu@huawei.com>, Jinxuefeng <jinxuefeng@huawei.com>, "Chenhui (Felix, Euler)" <chenhui.rtos@huawei.com>

On 11/16/18 2:21 AM, xiezhide wrote:
> 

Here's a couple of meta observations:


> 
>>
>> Signed-off-by: xiezhide <xiezhide@huawei.com>

Your sign-off line ...[1]

>> -    if (arg->has_bps_total) {
>> -        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps_total;
>> +    if (arg->has_bps) {
>> +        cfg->buckets[THROTTLE_BPS_TOTAL].avg = arg->bps;
> 
> Otherwise, the churn from renaming members (part 1) makes it hard to see if the code was properly moved into a new file.
> 
> Split this patch to three patches in v5

Your mailer's quoting style makes it very hard to read your replies. 
You are including both a line that I originally wrote and your reply 
with no difference in quoting levels between the two, which makes it 
look like you are writing both the question and the answer.  It is MUCH 
easier to read mails where quoted material is prefixed by some form of 
quoting (and '>' is probably the easiest form).

> 
> Thanks
> Kidd

[1] ...does not match your informal signature.  That's not necessarily a 
problem, but the project does prefer that Signed-off-by lines use a 
preferred legal name rather than merely a nickname or username.  It is 
acceptable for a sign off to include multiple variations of your name 
(I've seen people use UTF-8 characters to represent their name natively, 
followed by a Latinized transcription of the name they use in English), 
as well as signatures that use just a UTF-8 form or just a Latinized 
form; at the same time, I won't reject your patch as written, because if 
you look hard enough in git history, you'll find other commit authors 
that got away with a username or nickname.  If you prefer to be 
addressed by 'Kidd' when speaking in English, then including that as 
part of your S-o-b lines will help other reviewers know the best name to 
use for mentioning you by name.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
