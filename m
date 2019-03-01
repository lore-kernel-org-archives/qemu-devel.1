Received: from eggs.gnu.org ([209.51.188.92]:50900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkMy-0004uY-Eh
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzkMv-0004V8-3E
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gzkMq-0004Hj-F2
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 10:46:33 -0500
References: <20190301154051.23317-1-armbru@redhat.com>
	<20190301154051.23317-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d49a056a-cf2b-639a-8134-551b7ba8acb4@redhat.com>
Date: Fri, 1 Mar 2019 09:46:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190301154051.23317-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] tests/qapi-schema: Cover conditional
 arrays
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
> Commit 967c885108f neglected to cover arrays of conditional types.  Do
> that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/qapi-schema/qapi-schema-test.json | 2 +-
>  tests/qapi-schema/qapi-schema-test.out  | 4 +++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
