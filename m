Received: from eggs.gnu.org ([2001:4830:134:3::10]:47228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwXlN-0006FA-Sy
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwXlM-0003Kg-Rz
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:05:49 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:51195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwXlM-0003KK-6R
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:05:48 -0400
Received: by mail-wr0-x22b.google.com with SMTP id w12so9260006wrc.7
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:05:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170925175944.GD3030@localhost.localdomain>
References: <1506071794-4373-1-git-send-email-thuth@redhat.com>
	<20170925135316.74fed6da.cohuck@redhat.com>
	<20170925133153.GZ3030@localhost.localdomain>
	<20170925154647.357047b9@nial.brq.redhat.com>
	<20170925143439.GA3030@localhost.localdomain>
	<f078939d-4ae0-0ae8-4030-3df0ed66299a@redhat.com>
	<CAFEAcA-kmSkjhM0f+Ti7nY1_AuDm1pPcYHNGn50fes20YvOeBg@mail.gmail.com>
	<59e890ab-45e4-fe8a-a8de-3c441de19080@redhat.com>
	<20170925175944.GD3030@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Sep 2017 19:05:26 +0100
Message-ID: <CAFEAcA_3SpWNm0FCviD5fXOFmxF1jGAwYgD_cZgwUMMAMn4BOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, David Hildenbrand <david@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Amit Shah <amit@kernel.org>

On 25 September 2017 at 18:59, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Finding the full list of devices that can be instantiated
> internally at hotplug-time sounds tricky.

If we just diff "list of devices marked hotplug before this patch"
against "list of devices marked hotplug after this patch" how
big is the list? Can we just eyeball it to see what needs
to be specialcased?

thanks
-- PMM
