Received: from eggs.gnu.org ([2001:4830:134:3::10]:36609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUm1-00067t-JD
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezUm0-0002yA-R7
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 18:02:57 -0400
References: <a80175c7-0d54-dc0b-5dbe-8bb05f51913b@redhat.com>
	<20180322135443.GJ32362@xz-mi>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e45efdc6-e43c-8af5-3a94-2f02fecc07e1@redhat.com>
Date: Fri, 23 Mar 2018 17:02:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180322135443.GJ32362@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] raw iotest regressions in 2.12.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, John Snow <jsnow@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>

On 03/22/2018 08:54 AM, Peter Xu wrote:
> On Wed, Mar 21, 2018 at 05:58:48PM -0400, John Snow wrote:
>> ./check -v -raw
>> Failures: 109 132 136 148 152 183
>>

>>
>> ./check -v raw
>> Failures: 055
>> Failed 5 of 5 tests
>>

>> Maybe these are known, but I wanted to consolidate them for rc0 for
>> something easy to search for. There are others for qcow2 which I'll post
>> in a bit...!

I think patches have been floating on list for the failures in 51, 185, 
and 186 under qcow2, which were failing independently of the OOB changes.

>>
>>
>> Thanks,
>> --js
> 
> CCing Max, Fam.
> 
> Now I think I know how to solve some of the tests already (109, 132,
> 148, 152, 183). While I am still working (or, not yet started to work)
> on some others (055, 136, 205).
> 
> 205 is interesting - it won't fail every time, but randomly:
> 

> 
> While I haven't started to look at 055, which is:

> 
> I'll continue and update tomorrow.  So if anyone has any idea on
> solving any of the problem, please feel free to shoot.
> 

Let me know how I can help, as well.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
