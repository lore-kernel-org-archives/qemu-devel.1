Received: from eggs.gnu.org ([2001:4830:134:3::10]:35754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW4BY-0001P0-GM
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dW4BT-0005R2-J5
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dW4BT-0005QX-CY
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 13:15:19 -0400
Date: Fri, 14 Jul 2017 14:15:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170714171514.GK6020@localhost.localdomain>
References: <1500025208-14827-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500025208-14827-3-git-send-email-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500025208-14827-3-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCHv9 2/3] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, somlo@cmu.edu, mst@redhat.com, pbonzini@redhat.com, rjones@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org

On Fri, Jul 14, 2017 at 10:40:07AM +0100, Mark Cave-Ayland wrote:
> When looking to instantiate a TYPE_FW_CFG_MEM or TYPE_FW_CFG_IO device to be
> able to wire it up differently, it is much more convenient for the caller to
> instantiate the device and have the fw_cfg default files already preloaded
> during realize.
> 
> Move fw_cfg_init1() to the end of both the fw_cfg_mem_realize() and
> fw_cfg_io_realize() functions so it no longer needs to be called manually
> when instantiating the device, and also rename it to fw_cfg_common_realize()
> which better describes its new purpose.
> 
> Since it is now the responsibility of the machine to wire up the fw_cfg device
> it is necessary to introduce a object_property_add_child() call into
> fw_cfg_init_io() and fw_cfg_init_mem() to link the fw_cfg device to the root
> machine object as before.
> 
> Finally with the previous change to fw_cfg_find() we can now remove the
> assert() preventing multiple fw_cfg devices being instantiated and replace
> them with a simple call to fw_cfg_find() at realize time instead. This allows
> us to remove FW_CFG_NAME and FW_CFG_PATH since they are no longer required.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
