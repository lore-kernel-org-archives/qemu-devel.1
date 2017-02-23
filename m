Received: from eggs.gnu.org ([2001:4830:134:3::10]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgpul-00061r-MY
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgpuj-0003f7-2S
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 04:42:19 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1487710908-26356-1-git-send-email-armbru@redhat.com>
	<1487710908-26356-5-git-send-email-armbru@redhat.com>
	<c8d4f4a7-9d99-9cf7-b5d2-8dfd6191bb18@redhat.com>
Date: Thu, 23 Feb 2017 10:41:28 +0100
In-Reply-To: <c8d4f4a7-9d99-9cf7-b5d2-8dfd6191bb18@redhat.com> (Eric Blake's
	message of "Wed, 22 Feb 2017 17:02:05 -0600")
Message-ID: <87zihdkzw7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 4/5] qapi: Factor
 qobject_input_get_autocast() out of methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 02/21/2017 03:01 PM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  qapi/qobject-input-visitor.c | 87 ++++++++++++++++++--------------------------
>>  1 file changed, 35 insertions(+), 52 deletions(-)
>> 
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> I guess you aren't squashing this into 3/5 because that one kept Dan as
> the original author?

Yes.
