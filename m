Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0acc-00077u-Gk
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0acX-0006UG-R5
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:29:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0acX-0006Tl-MT
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 18:29:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E70C8D682
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 22:29:38 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c13d18f-b029-f2ce-c0e3-636c391aad97@redhat.com>
Date: Mon, 26 Mar 2018 17:29:34 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/8] Monitor: some oob related
 patches (fixes, new param, tests)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:38 AM, Peter Xu wrote:
> I suppose these are all good even for 2.12, so marked in subject.
> Tested with "make check" for all targets on x86_64, and iotest -raw.
> 
> Patch 1 fixes one OOB error message regression reported by Marc-Andre.
> 
> Patch 2 fixes one potential OOB problem when more than one clients are
> there, reported by Marc-Andre (too).
> 
> Patch 3 introduce "-mon x-oob=on" parameter to allow user to
> explicitly enable Out-Of-Band for a specific monitor.
> 
> Patch 4-6 are qapi-schema fixes and tests for Out-Of-Band.
> 
> Patch 7-8 add back the OOB test on the new parameter (with more
> enhancements).
> 
> Please review, thanks.
> 
> Peter Xu (8):
>    qmp: fix qmp_capabilities error regression
>    qmp: cleanup qmp queues properly
>    monitor: new parameter "x-oob"
>    qapi: restrict allow-oob value to be "true"
>    tests: let qapi-schema tests detect oob
>    tests: add oob-test for qapi-schema
>    tests: introduce qtest_init_with_qmp_format()
>    tests: qmp-test: add test for new "x-oob"

Queuing 1, 4-6 without further changes.  I'll repost a v2 of 2, 3, my 
rewrite of 7, and 8.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
