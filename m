Received: from eggs.gnu.org ([2001:4830:134:3::10]:51761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3QF-00067a-Ca
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3QE-0001i7-MA
	for qemu-devel@nongnu.org; Wed, 16 May 2018 16:53:19 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-39-kwolf@redhat.com>
	<8b50aa3d-24eb-53cd-bc0b-14165ae73784@redhat.com>
	<20180516204649.GG4435@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d5039e0-29aa-a859-a186-a468a2ab7a51@redhat.com>
Date: Wed, 16 May 2018 15:53:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180516204649.GG4435@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 38/42] job: Add JOB_STATUS_CHANGE QMP event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

On 05/16/2018 03:46 PM, Kevin Wolf wrote:

>>> +{ 'event': 'JOB_STATUS_CHANGE',
>>> +  'data': { 'id': 'str',
>>> +            'status': 'JobStatus' } }
>>
>> Is it worth also trying to list the old state that the transition came from?
>> But that's new compared to what block jobs are currently doing, so if we
>> can't come up with a strong reason to add that, I'm okay.
> 
> If a management tool needs this information (I don't see why), it just
> needs to keep track of the last state it had seen, no?

And if you miss an event, the previous state is not preserved for any 
later query-job command.  Exposing something in a (possibly-missed) 
event that is not available elsewhere doesn't buy us much.  So I agree - 
there is no strong reason to advertise the previous state.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
