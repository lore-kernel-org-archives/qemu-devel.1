Received: from eggs.gnu.org ([2001:4830:134:3::10]:34380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1XI-0007D8-0z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dG1XE-0004uN-TU
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:11:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dG1XE-0004u9-NW
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:11:28 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170526054013.299-1-n54@gmx.com>
	<20170530062022.5841-1-n54@gmx.com>
	<58d04e43-1caa-f623-44fe-749dd351fad9@redhat.com>
	<42633e66-7ef4-c4ef-18d3-d2be588b816c@gmx.com>
	<6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com>
Date: Wed, 31 May 2017 13:11:25 +0200
In-Reply-To: <6ee03c9d-3c42-4f73-1ca9-313f50be63df@redhat.com> (Eric Blake's
	message of "Tue, 30 May 2017 09:05:05 -0500")
Message-ID: <87k24xcmci.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, marcandre.lureau@gmail.com, f4bug@amsat.org

Eric Blake <eblake@redhat.com> writes:

> On 05/30/2017 08:11 AM, Kamil Rytarowski wrote:
>
>>>
>>> Is this a v2 patch? If so, it's best to repost it as a new top-level
>>> thread rather than buried in reply to your v1 patch.  Also, be sure to
>>> include v2 in the subject line ('git send-email -v2' works wonders for
>>> that).
>>>
>
>> 
>> I reworked it, fixed title and it's more like v3.
>> 
>
>> Do I still need to resend it?
>> 
>
> A human maintainer can often (eventually) figure out what's going on if
> you don't, but resending is easier if you want to ensure the automated
> patch tools don't lose things.

Yes.

However, ivshmem doesn't have a maintainer.  Since the patch is really
simple, the easiest path forward could be sending a v3 with
cc: qemu-trivial@nongnu.org.
