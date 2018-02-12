Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGj6-0007os-0k
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:13:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elGj2-0005Sb-EN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:13:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60130 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elGj2-0005SD-A9
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 11:13:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B71283155
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 16:13:04 +0000 (UTC)
References: <20180211004013.10784-1-eblake@redhat.com>
	<87h8qnj1wl.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97ed0d16-0c25-ed1d-9660-8bf4afad7e52@redhat.com>
Date: Mon, 12 Feb 2018 10:13:02 -0600
MIME-Version: 1.0
In-Reply-To: <87h8qnj1wl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] QAPI file renames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/11/2018 03:44 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
>> This has been mentioned on list before as a possible improvement,
>> so I went ahead and did some renames to figure out how it would
>> look.  Patch 1 is something I hit on the way while debugging
>> patch 2 and 3; patch 2 is rather non-controversial, and patch 3
>> may or may not be worth doing (but if we do it, it is going
>> to cause a lot of rebase churn to anyone editing files in the
>> meantime, although git rename detection will probably get things
>> right more often than not).
> 
> Conflicts with my "[PATCH v2 00/29] Modularize generated QAPI code".
> Your series is much smaller.  Would you mind rebasing it?

Of course, yours definitely goes in first.  And let me know if I need to 
take care of some pull requests, based on your current situation.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
