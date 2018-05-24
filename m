Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLutK-000409-3u
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fLutJ-00083K-9i
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:23:10 -0400
References: <20180518132114.4070-1-kwolf@redhat.com>
	<20180518132114.4070-36-kwolf@redhat.com>
	<6b0e43c5-f35b-5865-e423-ff6de432bb86@redhat.com>
	<20180524083624.GE4008@localhost.localdomain>
	<d58401b0-18e6-5815-b46f-67e941ade836@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b22b1f99-8205-b2ec-78e8-2b1f84bf754a@redhat.com>
Date: Thu, 24 May 2018 13:22:59 -0500
MIME-Version: 1.0
In-Reply-To: <d58401b0-18e6-5815-b46f-67e941ade836@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 35/40] job: Add JOB_STATUS_CHANGE QMP
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: jcody@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com

On 05/24/2018 12:36 PM, John Snow wrote:

>>> On 05/18/2018 09:21 AM, Kevin Wolf wrote:
>>>> This adds a QMP event that is emitted whenever a job transitions from
>>>> one status to another.
>>>>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

>>
>> The question that I was asking myself was just whether I'd literally
>> duplicate the existing events, just with s/BLOCK_JOB_/JOB_/, or whether
>> a single event with a status field can do. I think the latter is more
>> elegant (also because it can be implemented in a single place), even if
>> it is emitted a bit more often than strictly necessary.
>>
> 
> Code-wise I agree that this is more elegant; just wondering if the
> implications of the additional API guarantees were considered. This
> means we have to be a bit more careful about how we restructure the
> state machine in the future, I think.
> 
> It also makes the "NULL" state visible, which I didn't really intend...
> It's probably fine, just a little quirky.

Is it worth a special case to avoid emitting the event on transition to 
the NULL state?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
