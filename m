Received: from eggs.gnu.org ([209.51.188.92]:60473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkuR-0006y4-VA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkuQ-0005VP-4x
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43479)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkuO-0005Rc-8n
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:21:13 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efead2d2-d1df-351a-8dde-e9e99aa432bf@redhat.com>
Date: Fri, 1 Mar 2019 10:21:08 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/7] tests: Rename UserDefNativeListUnion
 to UserDefListUnion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, quintela@redhat.com

On 3/1/19 9:40 AM, Markus Armbruster wrote:
> The lists in UserDefNativeListUnion aren't "native", they're lists of
> built-in types.  The next commit will add a list of a user-defined
> type.  Drop "Native", and adjust the tests using the type.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Looks mechanical, and makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
