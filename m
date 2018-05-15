Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fISWz-0008SS-11
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fISWt-0005lK-PP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:29:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fISWt-0005l1-LB
	for qemu-devel@nongnu.org; Tue, 15 May 2018 01:29:43 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
	<eebc1ad7-2191-d9cc-81fd-5fefa9e3b1c8@linux.vnet.ibm.com>
	<87tvsfxkuq.fsf@dusky.pond.sub.org>
	<87efie1v65.fsf@dusky.pond.sub.org>
	<ab7b28df-747b-0294-2c8f-2b7617a8915e@linux.ibm.com>
Date: Tue, 15 May 2018 07:29:41 +0200
In-Reply-To: <ab7b28df-747b-0294-2c8f-2b7617a8915e@linux.ibm.com> (Daniel
	Henrique Barboza's message of "Mon, 14 May 2018 18:03:14 -0300")
Message-ID: <87vabplc56.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qmp: 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, dgilbert@redhat.com

Daniel Henrique Barboza <danielhb@linux.ibm.com> writes:

> On 05/14/2018 05:46 AM, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:
>>>
>>>> Ping
>>> Michael, you reviewed v4 (at least in part), can you have a look?
>> Have these patches fallen through the cracks?
>>
> Should I re-send it? Not sure if this is applicable in the current
> code base anymore.

git-am isn't happy on current master.  The conflicts look simple enough
for a maintainer to resolve, but that's yet another hurdle.  Best to
respin, I think (assuming you still want the patches to go in).
