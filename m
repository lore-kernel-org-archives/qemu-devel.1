Received: from eggs.gnu.org ([2001:4830:134:3::10]:38509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsbxp-0007RT-Ck
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:50:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fsbxo-0004gV-Mv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 18:50:57 -0400
References: <20180817190457.8292-1-jsnow@redhat.com>
	<20180817190457.8292-3-jsnow@redhat.com>
	<332129bf-2c69-8ad2-ca0c-c95322639f7c@redhat.com>
	<c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <92b5c1a6-1434-3ef6-50a8-aa77cf1e6167@redhat.com>
Date: Wed, 22 Aug 2018 18:50:49 -0400
MIME-Version: 1.0
In-Reply-To: <c63c5a3b-9168-a502-453f-3ccabc2ff747@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] jobs: canonize Error object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, jtc@redhat.com



On 08/22/2018 06:59 AM, Max Reitz wrote:
> On 2018-08-21 02:10, John Snow wrote:
>>
>>
>> On 08/17/2018 03:04 PM, John Snow wrote:
>>> +            error_setg_errno(&job->err, -job->ret, "job failed");
>>
>> Kevin specifically asked for me to change this, and I lost it in the
>> shuffle. I'll send a v3 now, since there are enough nits to warrant it,
>> and I think I want to adjust a few things to set up the "part II"
>> portion of this changeset a little more nicely.
> 
> But error_setg_errno() uses either strerror() or
> g_win32_error_message(), depending on the host OS.  I prefer that over a
> blind strerror(), to be honest.
> 

uhh, does it...?

it looks like error_setg_errno is always error_setg_errno_internal,
which always uses strerror... am I misreading?

> In general, it might make sense to introduce a qemu_strerror() (which
> g_strdup()s strerror() on Linux, I presume, so it's compatible with
> Win32); or to allow passing a NULL format to error_setg_errno() so you
> only get the error string.
> 
> Max
> 
