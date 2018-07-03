Received: from eggs.gnu.org ([2001:4830:134:3::10]:60567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB4O-0001eH-FX
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB4L-00033p-7q
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:29:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB4L-00033i-28
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4E04406E1D6
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:29:28 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-29-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d5667115-d500-1c7f-7cd2-e179fb9c166b@redhat.com>
Date: Mon, 2 Jul 2018 21:29:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-29-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 28/32] qmp: Switch timestamp_put() to
 qdict_from_jsonf_nofail()
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

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> There's just one use of qobject_from_jsonf() to parse a JSON object
> left: timestamp_put().  Switch it to qdict_from_jsonf_nofail().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/qmp-event.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
