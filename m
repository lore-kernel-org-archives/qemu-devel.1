Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB30-0000su-6B
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB2w-0002XG-Tw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB2w-0002X9-OT
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:28:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 633D8406E1D6
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:28:02 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-27-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad99b7b4-d8e2-7d08-972f-5a99567fde54@redhat.com>
Date: Mon, 2 Jul 2018 21:28:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-27-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 26/32] qmp: Simplify monitor_qmp_respond()
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
> monitor_qmp_respond() takes both a response object and an error
> object.  If an error object is non-null, the response object must be
> null, and the response is built from the error object.
> 
> Of the two callers, one always passes a null response object, and one
> a null error object.  Move building the response object from the error
> object to the latter, and drop the error object parameter.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 26 ++++++++++----------------
>   1 file changed, 10 insertions(+), 16 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
