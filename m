Received: from eggs.gnu.org ([2001:4830:134:3::10]:58521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3vx-00085x-5I
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJ3vw-00067u-F3
	for qemu-devel@nongnu.org; Wed, 16 May 2018 17:26:05 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
	<ecc2431e-ee7d-13b7-319e-e69d499330f8@redhat.com>
	<20180516205626.GI4435@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4307be7a-31ec-4903-89ed-21db52bc1f97@redhat.com>
Date: Wed, 16 May 2018 16:25:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180516205626.GI4435@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/42] job: Add reference counting
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

On 05/16/2018 03:56 PM, Kevin Wolf wrote:

>>> +
>>> +void job_unref(Job *job)
>>> +{
>>> +    if (--job->refcnt == 0) {
>>
>> Should this be free()-like and allow an incoming job == NULL as a no-op?
> 
> This behaves like block_job_unref() always behavec, and I don't see a
> single caller having a NULL check before calling job_unref(), so is it
> worth it?

Only if it makes it easier to clean up a partially-constructed object 
(which is the most likely case of wanting to pass in NULL)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
