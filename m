Received: from eggs.gnu.org ([2001:4830:134:3::10]:37109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimkE-0001wT-N4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dimk9-000099-OY
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:15:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dimk9-00007X-He
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:15:41 -0400
Date: Fri, 18 Aug 2017 16:15:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170818191534.GE3108@localhost.localdomain>
References: <20170818190943.23858-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170818190943.23858-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] numa: Move
 numa_legacy_auto_assign_ram to pc-i440fx-2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Fri, Aug 18, 2017 at 04:09:43PM -0300, Eduardo Habkost wrote:
> The 'm->numa_auto_assign_ram = numa_legacy_auto_assign_ram;' line
> was supposed to be in pc_i440fx_2_9_machine_options() (see commit
> 3bfe5716 "numa: equally distribute memory on nodes"), but the
> merge commit adb354dd ("Merge remote-tracking branch
> 'mst/tags/for_upstream' into staging") moved it to the
> pc_i440fx_2_10_machine_options().
> 
> Move the line back to pc_i440fx_2_9_machine_options().
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I just re-read the schedule wiki page and noticed 2017-08-22 is
"release _or_ tag -rc4".  Does this mean including this patch
would slip the schedule for 1 week?

In that case, I don't think this patch should block the release
and cause a schedule slip.  We can simply change the NUMA RAM
assignment algorithm in pc-2.11 and keep the old one in pc-2.10.

-- 
Eduardo
