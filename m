Received: from eggs.gnu.org ([2001:4830:134:3::10]:49534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5en-0000Ws-WE
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe5en-00006b-8g
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:31:18 -0400
Date: Fri, 13 Jul 2018 18:31:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713213108.GV31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-5-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-5-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 04/16] hw/arm/armv7: Fix crash when
 introspecting the "iotkit" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Fri, Jul 13, 2018 at 10:27:32AM +0200, Thomas Huth wrote:
> QEMU currently crashes when introspecting the "iotkit" device and
> runnint "info qtree" afterwards, e.g. when running QEMU like this:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'iotkit'}}" "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> 
> Use the new functions object_initialize_child() and sysbus_init_child_obj()
> to make sure that all objects get cleaned up correctly when the instances
> are destroyed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
