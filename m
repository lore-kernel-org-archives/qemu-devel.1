Received: from eggs.gnu.org ([2001:4830:134:3::10]:44075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqmA-0005Ju-FX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqm9-0007la-NC
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59272 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fXqm9-0007lN-IX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D71E7788C
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:25:05 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-3-pbonzini@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <39b929a9-bc78-c754-475e-7aee552ecaae@redhat.com>
Date: Tue, 26 Jun 2018 18:25:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] pr-helper: fix assertion failure on
 failed multipath PERSISTENT RESERVE IN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/26/2018 05:40 PM, Paolo Bonzini wrote:
> The response size is expected to be zero if the SCSI status is not
> "GOOD", but nothing was resetting it.
> 
> This can be reproduced simply by "sg_persist -s /dev/sdb" where /dev/sdb
> in the guest is a scsi-block device corresponding to a multipath device
> on the host.
> 
> Before:
> 
>   PR in (Read full status): Aborted command
> 
> and on the host:
> 
>   prh_write_response: Assertion `resp->sz == 0' failed.
> 
> After:
> 
>   PR in (Read full status): bad field in cdb or parameter list
>   (perhaps unsupported service action)
> 
> Reported-by: Jiri Belka <jbelka@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/qemu-pr-helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal
