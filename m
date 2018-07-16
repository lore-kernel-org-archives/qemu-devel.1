Received: from eggs.gnu.org ([2001:4830:134:3::10]:48174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAiJ-0002iz-LP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ffAiI-0005Yq-Nb
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:07:23 -0400
Date: Mon, 16 Jul 2018 18:07:15 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180716210715.GT31657@localhost.localdomain>
References: <1531745974-17187-1-git-send-email-thuth@redhat.com>
	<1531745974-17187-16-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531745974-17187-16-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 15/17] hw/arm/stm32f205_soc: Fix
 introspection problem with 'stm32f205-soc' device
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

On Mon, Jul 16, 2018 at 02:59:32PM +0200, Thomas Huth wrote:
> Valgrind complains:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'stm32f205-soc'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> [...]
> ==28531== Invalid read of size 8
> ==28531==    at 0x6185BA: qdev_print (qdev-monitor.c:686)
> ==28531==    by 0x6185BA: qbus_print (qdev-monitor.c:719)
> ==28531==    by 0x452B38: handle_hmp_command (monitor.c:3446)
> [...]
> 
> Fix it with the new sysbus_init_child_obj() function.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
