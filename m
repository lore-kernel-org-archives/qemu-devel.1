Received: from eggs.gnu.org ([209.51.188.92]:52476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFDs-00024V-TM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjFDs-0003ij-05
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:17:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjFDr-0003iA-Qi
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:17:03 -0500
Date: Mon, 14 Jan 2019 22:16:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114221620-mutt-send-email-mst@kernel.org>
References: <cover.1546399191.git.yi.z.zhang@linux.intel.com>
	<863b9c951827a05978eddd241b62db4e48294a80.1546399191.git.yi.z.zhang@linux.intel.com>
	<20190114185036.GC28115@habkost.net>
	<20190114140223-mutt-send-email-mst@kernel.org>
	<20190115023914.GA67749@tiger-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115023914.GA67749@tiger-server>
Subject: Re: [Qemu-devel] [PATCH V8 2/5] util/mmap-alloc: switch
 qemu_ram_mmap() to 'flags' parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, xiaoguangrong.eric@gmail.com, stefanha@redhat.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, imammedo@redhat.com, dan.j.williams@intel.com, qemu-devel@nongnu.org

On Tue, Jan 15, 2019 at 10:39:14AM +0800, Yi Zhang wrote:
> > It's needed for this series but yes, this ifdefery belongs in
> > a more central header. Maybe qemu/osdep.h
> > And it needs documentation and be a separate patch.
> Agree, Thank Michael's explanation, better to doing this in a separate
> patch series.

Separate patch, does not have to be a separate series.
