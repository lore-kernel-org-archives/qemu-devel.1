Received: from eggs.gnu.org ([2001:4830:134:3::10]:38160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6Fg-0004Qg-BP
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj6Ff-0005fB-FI
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:10:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj6Ff-0005eb-8k
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 13:10:03 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-24-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3f617ed4-01b0-be63-21ab-27d1800f1566@redhat.com>
Date: Fri, 27 Jul 2018 12:10:02 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-24-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 23/23] libqtest: Rename qtest_FOOv() to
 qtest_vFOO() for consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Might be worth adding mention of WHAT it is consistent with (as Thomas 
pointed out on 2/23, we still have inconsistencies with 
object_new_with_propv and such)

> ---
>   tests/libqtest.c | 12 ++++++------
>   tests/libqtest.h |  4 ++--
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
