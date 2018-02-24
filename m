Received: from eggs.gnu.org ([2001:4830:134:3::10]:43388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph2K-00082q-AK
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:07:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eph2J-0001Dm-AE
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 16:07:16 -0500
References: <20180224154033.29559-1-mreitz@redhat.com>
	<20180224154033.29559-6-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b4c93a5b-5957-9611-15d5-5cff1585356f@redhat.com>
Date: Sat, 24 Feb 2018 15:07:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180224154033.29559-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] qapi: Make more of qobject_to()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 02/24/2018 09:40 AM, Max Reitz wrote:
> This patch reworks some places which use either qobject_type() checks
> plus qobject_to(), where the latter alone is sufficient, or NULL checks
> plus qobject_type() checks where we can simply do a qobject_to() != NULL
> check.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   qapi/qobject-input-visitor.c |  4 ++--
>   qobject/json-parser.c        | 13 +++++++------
>   qobject/qdict.c              | 20 +++++++++++---------
>   3 files changed, 20 insertions(+), 17 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
