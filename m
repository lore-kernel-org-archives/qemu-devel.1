Received: from eggs.gnu.org ([209.51.188.92]:47174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hBOpu-0006Ix-RY
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hBOpt-00060g-UM
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:12:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hBOpt-000600-NI
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:12:41 -0400
Date: Tue, 2 Apr 2019 16:12:36 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190402191236.GD22884@habkost.net>
References: <20190131071658.29120-1-tao3.xu@intel.com>
	<20190131071658.29120-5-tao3.xu@intel.com>
	<20190206111124.73c99f4e@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206111124.73c99f4e@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH v3 4/8] Extend the command-line to provide
 memory latency and bandwidth information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Tao Xu <tao3.xu@intel.com>, xiaoguangrong.eric@gmail.com, mst@redhat.com, jingqi.liu@intel.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com, danmei.wei@intel.com, rth@twiddle.net, karl.heubaum@oracle.com

On Wed, Feb 06, 2019 at 11:11:24AM +0100, Igor Mammedov wrote:
> On Thu, 31 Jan 2019 15:16:54 +0800
> Tao Xu <tao3.xu@intel.com> wrote:
> 
> > From: Liu Jingqi <jingqi.liu@intel.com>
> > 
> > Add -numa hmat-lb option to provide System Locality Latency and
> > Bandwidth Information. These memory attributes help to build
> > System Locality Latency and Bandwidth Information Structure(s)
> > in ACPI Heterogeneous Memory Attribute Table (HMAT).
> Maybe instead of adding/using more globals since the rest of numa.c was
> written so, it's time to introduce NumaMachine type which inherits
> form base Machine and extends it with numa extensions.

I don't think inheritance is the right solution here.  We have
multiple features that are not available in all machines and:
SMP, ACPI, CPU hotplug, memory hotplug, etc.  We don't have
separate machine subclasses for each of these features.

Why would NUMA deserve having its own class in the machine type
hierarchy?

> 
> You don't have to refactor all old numa code for that (just the parts
> you use in HMAT) and later we could gradually refactor the rest of
> numa handling.
> 
> 
-- 
Eduardo
