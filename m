Received: from eggs.gnu.org ([2001:4830:134:3::10]:48463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwXpn-0007hd-3G
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwXpj-0005cs-V5
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwXpj-0005bm-Ot
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:10:19 -0400
Date: Mon, 25 Sep 2017 15:09:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170925180957.GE3030@localhost.localdomain>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
	<CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On Mon, Sep 25, 2017 at 07:05:26PM +0100, Peter Maydell wrote:
> On 25 September 2017 at 18:59, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > Finding the full list of devices that can be instantiated
> > internally at hotplug-time sounds tricky.
> 
> If we just diff "list of devices marked hotplug before this patch"
> against "list of devices marked hotplug after this patch" how
> big is the list? Can we just eyeball it to see what needs
> to be specialcased?

I was working on a query-device-type QMP command some time ago.
I will rebase the work in progress and use it to build those
lists.

-- 
Eduardo
