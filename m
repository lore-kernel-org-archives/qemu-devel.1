Received: from eggs.gnu.org ([2001:4830:134:3::10]:39318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMtX-0008JU-Ih
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elMtT-0001Bz-Mq
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:48:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1elMtT-0001BM-Hm
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 17:48:15 -0500
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-30-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5aab1c5f-352d-e74d-9aba-d68154523dde@redhat.com>
Date: Mon, 12 Feb 2018 16:48:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 29/29] qapi: Don't create useless
 directory qapi-generated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com

On 02/11/2018 03:36 AM, Markus Armbruster wrote:
> We used to generate first test and later QGA QAPI code into
> qapi-generated/.  Commit b93b63f574 moved the test code to tests/.
> Commit 54c2e50205 moved the QGA code to qga/qapi-generated/.  The
> directory has been unused since.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   .gitignore | 1 -
>   Makefile   | 1 -
>   configure  | 1 -
>   3 files changed, 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
