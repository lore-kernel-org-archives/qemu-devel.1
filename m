Received: from eggs.gnu.org ([2001:4830:134:3::10]:58143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVhz7-0004U3-UV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVhz3-0001d6-9Z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:37:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fVhz3-0001cV-4i
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 14:37:33 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77BAB7788C
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 18:37:32 +0000 (UTC)
References: <20180620153947.30834-1-dgilbert@redhat.com>
	<20180620153947.30834-5-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ea06b97e-efc7-090d-1b36-c0d17206e9d3@redhat.com>
Date: Wed, 20 Jun 2018 13:37:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180620153947.30834-5-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/7] qmp: Enable a few commands in
 preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, imammedo@redhat.com, peterx@redhat.com

On 06/20/2018 10:39 AM, Dr. David Alan Gilbert (git) wrote:
> From: Igor Mammedov <imammedo@redhat.com>
> 
> Commands query-chardev, query-version, query-name, query-uuid,
> query-iothreads, query-memdev are informational and do not depend on
> the machine being initialized.  Make them available in preconfig
> runstate to make the latter a little bit more useful.
> The generic qom commands don't depend on the machine being initialized
> either; so enabled qom-list, qom-get, qom-set, qom-list-types,
> qom-list-properties.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   qapi/char.json |  3 ++-
>   qapi/misc.json | 27 +++++++++++++++++----------
>   2 files changed, 19 insertions(+), 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
