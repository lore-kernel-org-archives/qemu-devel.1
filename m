Received: from eggs.gnu.org ([2001:4830:134:3::10]:45677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5iL-0002PA-W2
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:46:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5iH-0002vw-SC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:46:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa5iE-0002rZ-Fo
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C805340122CB
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 20:46:17 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-2-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <66a4fd1d-1ea4-e0a9-6b09-f2b3e899f637@redhat.com>
Date: Mon, 2 Jul 2018 15:46:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/32] qmp: Say "out-of-band" instead of
 "Out-Of-Band"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:21 AM, Markus Armbruster wrote:
> Affects documentation and a few error messages.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   docs/devel/qapi-code-gen.txt            |  2 +-
>   docs/interop/qmp-spec.txt               |  2 +-
>   monitor.c                               | 14 +++++++-------
>   qapi/misc.json                          |  2 +-
>   tests/qapi-schema/qapi-schema-test.json |  2 +-
>   tests/qmp-test.c                        |  2 +-
>   6 files changed, 12 insertions(+), 12 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
