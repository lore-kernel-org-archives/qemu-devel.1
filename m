Received: from eggs.gnu.org ([2001:4830:134:3::10]:35999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwmUm-0002ij-EJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dwmUj-0004IJ-Fh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:49:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dwmUj-0004I0-9B
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 05:49:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 258082C973A
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 09:49:36 +0000 (UTC)
Date: Tue, 26 Sep 2017 11:49:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170926114934.77229a68@nial.brq.redhat.com>
In-Reply-To: <20170926112425.3341fea0.cohuck@redhat.com>
References: <1505998749-269631-1-git-send-email-imammedo@redhat.com>
	<20170926112425.3341fea0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x: use generic cpu_model parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 26 Sep 2017 11:24:25 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 21 Sep 2017 14:59:08 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > define default CPU type in generic way in machine class_init  
> 
> s/define/Define/
> 
> > and let common machine code to handle cpu_model parsing.  
> 
> s/to handle/handle/
> 
> (fixed that up)
> 
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > ---
> > CC: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  target/s390x/cpu.h         |  6 ++++--
> >  hw/s390x/s390-virtio-ccw.c | 28 +++-------------------------
> >  target/s390x/cpu_models.c  | 11 -----------
> >  target/s390x/kvm.c         |  3 +++
> >  4 files changed, 10 insertions(+), 38 deletions(-)  
> 
> Thanks, applied.
one patch off my queue,

Thanks!
