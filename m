Received: from eggs.gnu.org ([2001:4830:134:3::10]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbKGp-0002ro-Sr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbKGm-0001Qb-R7
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:31:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fbKGm-0001PU-MN
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:31:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B81DE9002
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 06:31:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180705091402.26244-1-armbru@redhat.com>
	<20180705091402.26244-3-armbru@redhat.com>
	<d8ff142e-34f8-65c8-fa3e-2509a85fa06e@redhat.com>
Date: Fri, 06 Jul 2018 08:31:02 +0200
In-Reply-To: <d8ff142e-34f8-65c8-fa3e-2509a85fa06e@redhat.com> (Eric Blake's
	message of "Thu, 5 Jul 2018 11:39:02 -0500")
Message-ID: <87r2kg3mft.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] cli qmp: Mark --preconfig,
 exit-preconfig experimental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, pkrempa@redhat.com, ehabkost@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/05/2018 04:14 AM, Markus Armbruster wrote:
>> Committing to the current --preconfig / exit-preconfig interface
>> before it has seen any use is premature.  Mark both as experimental,
>> the former in documentation, the latter by renaming it to
>> x-exit-preconfig.
>>
>> See the previous commit for more detailed rationale.
>
> Should the CLI be spelled --x-preconfig?

Would be the first use of x- with option names.

Since you have to pair --preconfig with x-exit-preconfig, I figure
slapping x- onto the latter suffices.  But I'm not opposed to slapping
it onto the former as well.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> Other than the potential for a spelling change,
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks!
