Received: from eggs.gnu.org ([2001:4830:134:3::10]:46715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilaS-0004gx-Vw
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cilaP-00022C-Td
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:29:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35164)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cilaP-000220-Oo
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:29:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF7E68553C
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 17:29:17 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-18-git-send-email-armbru@redhat.com>
	<915e35bf-bac6-43cd-29f2-176984971310@redhat.com>
Date: Tue, 28 Feb 2017 18:29:14 +0100
In-Reply-To: <915e35bf-bac6-43cd-29f2-176984971310@redhat.com> (Eric Blake's
	message of "Tue, 28 Feb 2017 08:56:56 -0600")
Message-ID: <87shmyql5h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 17/26] qapi: Drop unused non-strict
 qobject input visitor
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

> On 02/26/2017 03:43 PM, Markus Armbruster wrote:
>> The split between tests/test-qobject-input-visitor.c and
>> tests/test-qobject-input-strict.c now makes less sense than ever.  The
>> next commit will take care of that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>
> If I read Paolo's thread correctly, we were deferring his patches that
> relied on a non-strict visit until 2.10.  And we can re-add non-strict
> via a new constructor, rather than adding back a bool parameter to all
> existing callers, so it doesn't hurt too badly that we are doing this
> now for 2.9 (or a revert always works, if it is justified).

Yup.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>
>> @@ -276,7 +269,6 @@ static GenericList *qobject_input_next_list(Visitor *v, GenericList *tail,
>>      return tail->next;
>>  }
>>  
>> -
>>  static void qobject_input_start_alternate(Visitor *v, const char *name,
>>                                            GenericAlternate **obj, size_t size,
>>                                            bool promote_int, Error **errp)
>
> Spurious hunk?

Yes, will drop.

Thanks!
