Received: from eggs.gnu.org ([2001:4830:134:3::10]:55765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt4m-0002X4-MJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjt4j-0007Qg-KE
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:41:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cjt4j-0007Ol-EA
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:41:13 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A86E4E4C5
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:41:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-7-git-send-email-armbru@redhat.com>
	<6a0b8822-aa82-64e6-68f8-d0e63436ab76@redhat.com>
Date: Fri, 03 Mar 2017 20:41:10 +0100
In-Reply-To: <6a0b8822-aa82-64e6-68f8-d0e63436ab76@redhat.com> (Eric Blake's
	message of "Fri, 3 Mar 2017 12:29:13 -0600")
Message-ID: <87bmtijgh5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 06/28] qapi-introspect: Mangle --prefix
 argument properly for C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  scripts/qapi-introspect.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I'm guessing we haven't seen a use of a prefix that matters yet, but
> that an upcoming patch triggered a compilation failure without this fix.
>  Mentioning that in the commit message wouldn't hurt.

Done.  Thanks!


[...]
