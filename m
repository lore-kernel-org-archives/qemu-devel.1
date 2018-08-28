Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fug0T-0006xC-2X
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fufxD-0007xw-7P
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:30:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33740 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fufxD-0007xe-1w
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:30:51 -0400
References: <20180827213943.33524-1-eblake@redhat.com>
	<20180827213943.33524-3-eblake@redhat.com>
	<87k1oaoew1.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fef4c95f-8a40-7349-6885-4346d53c6968@redhat.com>
Date: Tue, 28 Aug 2018 10:30:49 -0500
MIME-Version: 1.0
In-Reply-To: <87k1oaoew1.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qapi: Add comments to aid debugging
 generated introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

On 08/28/2018 07:27 AM, Markus Armbruster wrote:

>> ---
>> v2: rebase on conditional code additions, drop patch to remove -u,
>> update documentation to match

My update wasn't very accurate, as you discovered :)

> 
> Let's rebase onto my "[PATCH 0/2] qapi: A whitespace touch-up, and a doc
> update".  The appended fixup needs to be squashed in then.  Happy to do
> that in my tree.

Yes, that makes the most sense.  Go ahead!

> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 
> 
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index a4091a7d78..f9990808de 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -1430,7 +1430,7 @@ Example:
>               { "name", QLIT_QSTR("MY_EVENT"), },
>               {}
>           })),
> -        /* "0" = q_empty */
> +        /* "0" = q_obj_my-command-arg */
>           QLIT_QDICT(((QLitDictEntry[]) {
>               { "members", QLIT_QLIST(((QLitObject[]) {
>                   QLIT_QDICT(((QLitDictEntry[]) {
> @@ -1444,6 +1444,7 @@ Example:
>               { "name", QLIT_QSTR("0"), },
>               {}
>           })),
> +        /* "1" = UserDefOne */
>           QLIT_QDICT(((QLitDictEntry[]) {
>               { "members", QLIT_QLIST(((QLitObject[]) {
>                   QLIT_QDICT(((QLitDictEntry[]) {
> @@ -1463,6 +1464,7 @@ Example:
>               { "name", QLIT_QSTR("1"), },
>               {}
>           })),
> +        /* "2" = q_empty */
>           QLIT_QDICT(((QLitDictEntry[]) {
>               { "members", QLIT_QLIST(((QLitObject[]) {
>                   {}
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
