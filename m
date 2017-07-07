Received: from eggs.gnu.org ([2001:4830:134:3::10]:56420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTUaH-0003X9-19
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dTUaD-0007LG-Vo
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dTUaD-0007L3-PN
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 10:50:13 -0400
Date: Fri, 7 Jul 2017 11:50:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170707145001.GY12152@localhost.localdomain>
References: <1498745240-30658-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1498745240-30658-6-git-send-email-mark.cave-ayland@ilande.co.uk>
	<20170703113940.0e0415a2@nial.brq.redhat.com>
	<0efc917e-16d3-f01b-6fd8-a3bb71580bf4@ilande.co.uk>
	<20170707133320.2e0d741d@nial.brq.redhat.com>
	<1b4f1872-2ea2-8c10-593f-e2adf013b234@ilande.co.uk>
	<20170707164453.4ba325fd@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170707164453.4ba325fd@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCHv7 5/6] fw_cfg: move qdev_init_nofail() from
 fw_cfg_init1() to callers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org, mst@redhat.com, somlo@cmu.edu, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, lersek@redhat.com

On Fri, Jul 07, 2017 at 04:44:53PM +0200, Igor Mammedov wrote:
[...]
> > 3) Since these checks are done at realize time, we can provide nice
> > friendly messages back to the developer to tell them what needs to be fixed
> error_set(error_abort, ...) should work nice for fwcfg usecase,
> you get error message and a stack trace in core file pointing to a place
> of the error.

error_setg(&error_abort, ...) is explicitly discouraged by
error_setg() documentation.

-- 
Eduardo
