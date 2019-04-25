Received: from eggs.gnu.org ([209.51.188.92]:37447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJcpU-0004Oa-13
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hJcpT-0003mb-2J
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:46:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hJcpS-0003gP-Q5
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:46:14 -0400
Date: Thu, 25 Apr 2019 13:46:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425134601.29769330@redhat.com>
In-Reply-To: <20190425133250.69ec66dc@redhat.com>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-13-git-send-email-imammedo@redhat.com>
	<20190425082050.GF24829@richard>
	<20190425133250.69ec66dc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] tests: acpi: refactor
 rebuild-expected-aml.sh to dump ACPI tables for a specified list of targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Thu, 25 Apr 2019 13:32:50 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 25 Apr 2019 16:20:50 +0800
> Wei Yang <richardw.yang@linux.intel.com> wrote:
> 
> > On Thu, Apr 25, 2019 at 07:34:48AM +0200, Igor Mammedov wrote:  
> > >Make initial list contain aarch64 and  x86_64 targets.    
> > 
> > so i386 is taken out?
we use the same blobs for both i386 and x86_64 targets so it was sort of duplication.
But someone who intends to update reference blobs, surely can build x86_64 and aarch64
targets to achieve their goal.
