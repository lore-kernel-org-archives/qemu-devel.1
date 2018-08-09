Received: from eggs.gnu.org ([2001:4830:134:3::10]:41837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnofh-0002bR-4S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnofd-0000ar-6w
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:24:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnofd-0000Zy-2L
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 13:24:21 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-15-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <65e0558e-f798-201b-9c71-48f51a35a128@redhat.com>
Date: Thu, 9 Aug 2018 12:24:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-15-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/56] check-qjson qmp-test: Cover control
 characters more thoroughly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> RFC 7159 requires control characters in strings to be escaped.
> Demonstrate the JSON parser accepts U+0001 .. U+001F unescaped.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 36 ++++++++++++++++++++++++++++++------
>   tests/qmp-test.c    | 14 ++++++++++++++
>   2 files changed, 44 insertions(+), 6 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

Accepting it on input (as an extension to the RFC, similar to our \' 
extension) sounds reasonable, but producing it on output is wrong.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
