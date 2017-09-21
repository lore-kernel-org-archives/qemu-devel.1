Received: from eggs.gnu.org ([2001:4830:134:3::10]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=430e4adce=anthony.perard@citrix.com>)
	id 1dv3Nf-0004jB-Po
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=430e4adce=anthony.perard@citrix.com>)
	id 1dv3Nd-0003ru-5a
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:27:11 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:6765)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=430e4adce=anthony.perard@citrix.com>)
	id 1dv3Nc-0003lw-Ui
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 11:27:09 -0400
Date: Thu, 21 Sep 2017 16:27:03 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170921152703.GD1859@perard.uk.xensource.com>
References: <1505811353-29151-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1505811353-29151-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH] qdev: Mark devices as non-hotpluggable
 by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Tue, Sep 19, 2017 at 10:55:53AM +0200, Thomas Huth wrote:
> Historically we've marked all devices as hotpluggable by default. However,
> most devices are not hotpluggable, and you also need a HotplugHandler to
> support these devices. So if the user tries to "device_add" or "device_del"
> such a non-hotpluggable device during runtime, either nothing really usable
> happens, or QEMU even crashes/aborts unexpectedly (see for example commit
> 84ebd3e8c7d4fe955b - "Mark diag288 watchdog as non-hotpluggable").
> So let's change this dangerous default behaviour and mark the devices as
> non-hotpluggable by default. Certain parent devices classes which are known
> as hotpluggable (e.g. PCI, USB, etc.) are marked with "hotpluggable = true",
> so that devices that are derived from these classes continue to work as
> expected.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Hi,

xen-backend is needed to be hotpluggable, otherwise I have this error
message:
qemu-system-i386: Initialization of device xen-backend failed: Device 'xen-backend' does not support hotplugging

Also, when I try to add more cpus:
QMP command: { "execute": "cpu-add", "id": 2, "arguments": { "id": 2 } }
error message: Device 'qemu32-i386-cpu' does not support hotplugging


I've tested all I could think of that would involve hotplug.

Thanks,

-- 
Anthony PERARD
