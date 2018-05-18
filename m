Received: from eggs.gnu.org ([2001:4830:134:3::10]:57367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJgsB-000681-WF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:00:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJgs8-00018F-UH
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:00:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43804 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJgs8-00017x-Qf
	for qemu-devel@nongnu.org; Fri, 18 May 2018 11:00:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-4-danielhb@linux.ibm.com>
	<87vablgxhz.fsf@dusky.pond.sub.org>
	<a5065f6d-1c55-5a0d-9000-de8d920ef088@linux.ibm.com>
Date: Fri, 18 May 2018 17:00:42 +0200
In-Reply-To: <a5065f6d-1c55-5a0d-9000-de8d920ef088@linux.ibm.com> (Daniel
	Henrique Barboza's message of "Fri, 18 May 2018 09:52:23 -0300")
Message-ID: <87bmdddn51.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qmp.c: system_wakeup: runstate and
 wake-up support check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> On 05/18/2018 05:48 AM, Markus Armbruster wrote:
>> This affects both QMP and HMP.  Let's rephrase the title to
>>
>>      qmp hmp: Make system_wakeup check wake-up support and run state
>>
>> Can do that in my tree.
>
> I can rename the commit name, and handle the other suggestions you
> made below, in the respin I'll end up making due to the changes
> about to happen in patch 1. No problem.
>
> I've cited 'query-target' all over the patch series too. All these
> references
> will need to be changed with the new API of the flag (query-machines seems
> to be the favorite so far). It's easier to just resend everything
> up-to-date.

Makes my life easier :)

However, I'd recommend to give people a bit more time to chime in on the
proper home of wakeup-suspend-support before you respin.
