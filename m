Received: from eggs.gnu.org ([2001:4830:134:3::10]:34704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyd7k-00065f-VI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyd7h-0007gx-TK
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:45:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyd7h-0007gp-ON
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:45:45 -0400
References: <20180321065506.21091-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e729a73e-b048-3f03-df3e-a67176ceca24@redhat.com>
Date: Wed, 21 Mar 2018 07:45:39 -0500
MIME-Version: 1.0
In-Reply-To: <20180321065506.21091-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] tests: trivial enhancements for OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

On 03/21/2018 01:55 AM, Peter Xu wrote:
> First two patches add OOB detection for current qapi-schema tests
> (which I missed in the OOB series but pointed out by Eric Blake).  The
> 3rd patch addressed one suggestion from Eric too here:
> 
> http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03177.html
> 
> I tried to batch the commands in a single string buffer but it's not
> that easy - because currently qtest_async_qmp() (and finally,
> qmp_fd_sendv()) does not really support multiple qobjects in a single
> command buffer.  Let's put that aside.  After all even calling
> qtest_async_qmp() many times would be really fast, since we are
> basically filling things to the write buffer very quickly (I believe
> that's much faster than the IO really flushed to the receiver side).
> 
> But, adding the "id" field and check that would be far easier, that's
> what I did in that last patch.
> 
> It's fine even for 2.12, but I'll let people decide.

I consider added testsuite coverage of a new feature to be a bug fix 
(the feature was incomplete if the testsuite doesn't prevent regressions 
in the feature) and safe for freeze (the testsuite changes don't impact 
the main binary, so they can't break anything), so I'm happy to queue 
this through my qapi tree for 2.12 once it is reviewed.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
