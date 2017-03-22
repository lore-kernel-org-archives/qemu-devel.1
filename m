Received: from eggs.gnu.org ([2001:4830:134:3::10]:41851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cql8E-0000oM-2j
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cql8A-0001Jv-TU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 14:37:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490204908-26567-1-git-send-email-armbru@redhat.com>
	<1490204908-26567-18-git-send-email-armbru@redhat.com>
	<86365af6-9184-bf7d-8e42-66c120ff8ba3@redhat.com>
Date: Wed, 22 Mar 2017 19:37:08 +0100
In-Reply-To: <86365af6-9184-bf7d-8e42-66c120ff8ba3@redhat.com> (Eric Blake's
	message of "Wed, 22 Mar 2017 12:57:26 -0500")
Message-ID: <87lgrx6tuz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL v2 for-2.9 17/17] qapi: Fix QemuOpts visitor
 regression on unvisited input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/22/2017 12:48 PM, Markus Armbruster wrote:
>> From: Eric Blake <eblake@redhat.com>
>> 
>> An off-by-one in commit 15c2f669e meant that we were failing to
>> check for unparsed input in all QemuOpts visitors.  Recent testsuite
>> additions show that fixing the obvious bug with bogus fields will
>> also fix the case of an incomplete list visit; update the tests to
>> match the new behavior.
>> 
>> Simple testcase:
>> 
>> ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio -numa node,size=1g
>> 
>> failed to diagnose that 'size' is not a valid argument to -numa, and
>> now once again reports:
>> 
>> qemu-system-x86_64: -numa node,size=1g: Invalid parameter 'size'
>> 
>> See also https://bugzilla.redhat.com/show_bug.cgi?id=1434666
>> 
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> Tested-by: Laurent Vivier <lvivier@redhat.com>
>> Message-Id: <20170322144525.18964-4-eblake@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> [Fixup squashed in]
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Fixup squashed into the wrong patch. End result is the same, though, so
> not sure if it is worth a v3 pull request.

Rats...  thanks for paying attention!
