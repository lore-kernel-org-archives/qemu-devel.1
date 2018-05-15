Received: from eggs.gnu.org ([2001:4830:134:3::10]:60809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIcz1-0004WK-ED
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIcyx-0006Gh-FP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:39:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51082 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fIcyx-0006GI-BC
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:39:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA3327D843
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 16:39:22 +0000 (UTC)
References: <20180515091356.24106-1-peterx@redhat.com>
	<87mux16s9c.fsf@dusky.pond.sub.org> <20180515123827.GB9089@xz-mi>
	<87vaboud3h.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae9f3538-4271-16d4-5910-43473b9261e3@redhat.com>
Date: Tue, 15 May 2018 11:39:19 -0500
MIME-Version: 1.0
In-Reply-To: <87vaboud3h.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org

On 05/15/2018 10:56 AM, Markus Armbruster wrote:

>> One example I can think of is that we can keep some error environment
>> when the first error happens:
>>
>>    if (something_wrong_happened) {
>>       if (error_report_once("blablabla")) {
>>         /* only cache the first error */
>>         error_cmd = xxx;
>>         error_param = xxx;
>>         ...
>>       }
>>    }
> 
> I see.
> 
> Add a contract comment (suggest to start with the one next to
> error_report()), expand the tabs, replace the reserved identifiers
> (caught by patchew; you can use foo_ instead of __foo),

Actually, patchew doesn't flag use of leading __ (although maybe it 
should); it was complaining about the use of TAB instead of space.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
