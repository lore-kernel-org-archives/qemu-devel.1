Received: from eggs.gnu.org ([2001:4830:134:3::10]:55096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dpXLU-0006Fx-GB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1dpXLO-0000ty-J5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 06:14:08 -0400
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<809da3cc-4051-cb39-7f6a-2355013d3f9a@redhat.com>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <4cbf1e77-a32e-ec81-2eeb-31f3a596ae83@huawei.com>
Date: Wed, 6 Sep 2017 12:12:41 +0200
MIME-Version: 1.0
In-Reply-To: <809da3cc-4051-cb39-7f6a-2355013d3f9a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, "kwolf@redhat.com" <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

On 9/5/2017 11:19 PM, Eric Blake wrote:
> On 09/04/2017 11:07 AM, Pradeep Jagadeesh wrote:
>> These patches provide the qmp interface, to query the io throttle
>> status of the all fsdev devices that are present in a vm.
>> also, it provides an interface to set the io throttle parameters of a
>> fsdev to a required value. some of the patches also remove the duplicate
>> code that was present in block and fsdev files.
>>
>> Pradeep Jagadeesh (6):
>>   throttle: factor out duplicate code
>>   qmp: Create IOThrottle structure
>>   throttle: move out function to reuse the code
>>   hmp: create a throttle initialization function for code reusability
>>   fsdev: QMP interface for throttling
>>   fsdev: hmp interface for throttling
>
> I know you're already up to v10, but your code changes conflict with
> Manos throttling work, which has now landed on Kevin's branch:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01051.html
>
> T: git git://repo.or.cz/qemu/kevin.git block
>
> How hard is it for you to post a rebased v11 on top of Manos' work?
>
Hmm, I will try. No idea, how long its gonna take.

-Pradeep
