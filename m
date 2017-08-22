Received: from eggs.gnu.org ([2001:4830:134:3::10]:50766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk98m-00075j-OT
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dk98j-0008RE-Gw
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:22:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dk98j-0008R3-9n
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 09:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A924C04D92E
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 13:22:40 +0000 (UTC)
References: <20170821141008.19383-1-famz@redhat.com>
	<20170821141008.19383-2-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b67adc0f-5b1f-493e-b32e-48df4789b94b@redhat.com>
Date: Tue, 22 Aug 2017 15:22:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170821141008.19383-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] scsi: Refactor scsi sense
 interpreting code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 21/08/2017 16:10, Fam Zheng wrote:
> So that it can be reused outside of iscsi.c.
> 
> Also update MAINTAINERS to include the new files in SCSI section.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  MAINTAINERS         |  2 ++
>  block/iscsi.c       | 45 ++++-----------------------------------------
>  include/scsi/scsi.h | 19 +++++++++++++++++++
>  util/Makefile.objs  |  1 +
>  util/scsi.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 41 deletions(-)

I've now introduced a more comprehensive scsi/utils.c.  No need to do
anything, I'll pick your file when I rebase the multipath patches I've
just sent.

Paolo
