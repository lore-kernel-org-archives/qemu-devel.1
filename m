Received: from eggs.gnu.org ([2001:4830:134:3::10]:41418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faARz-0003XO-7t
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faARw-000547-3K
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:49:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37536 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faARv-00053j-VJ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 21:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DEE087A87
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 01:49:47 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-12-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8cfd539c-240b-da9b-24f0-10e2990fef32@redhat.com>
Date: Mon, 2 Jul 2018 20:49:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/32] qmp qemu-ga: Fix qemu-ga not to
 accept "control"
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
> Commit cf869d53172 "qmp: support out-of-band (oob) execution"
> accidentally made qemu-ga accept and ignore "control".  Fix that.
> 
> Out-of-band execution in a monitor that doesn't support it now fails
> with
> 
>      {"error": {"class": "GenericError", "desc": "QMP input member 'control' is unexpected"}}
> 
> instead of
> 
>      {"error": {"class": "GenericError", "desc": "Please enable out-of-band first for the session during capabilities negotiation"}}
> 
> The old description is suboptimal when out-of-band cannot not be
> enabled, or the command doesn't support out-of-band execution.
> 
> The new description is a bit unspecific, but it'll do.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
