Received: from eggs.gnu.org ([2001:4830:134:3::10]:54349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe60Q-0005Y3-AK
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fe60P-0002PT-KI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 17:53:38 -0400
Date: Fri, 13 Jul 2018 18:53:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180713215329.GZ31657@localhost.localdomain>
References: <1531470464-21522-1-git-send-email-thuth@redhat.com>
	<1531470464-21522-9-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531470464-21522-9-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/16] hw/arm/msf2-soc: Fix
 introspection problem with the "msf2-soc" device
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

On Fri, Jul 13, 2018 at 10:27:36AM +0200, Thomas Huth wrote:
> Valgrind currently reports a problem when running QEMU like this:
> 
> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>  "'arguments':{'typename':'msf2-soc'}}" \
>  "{'execute': 'human-monitor-command', " \
>  "'arguments': {'command-line': 'info qtree'}}" | \
>  valgrind -q aarch64-softmmu/qemu-system-aarch64 -M none,accel=qtest -qmp stdio
> [...]
> ==23097== Invalid read of size 8
> ==23097==    at 0x6192AA: qdev_print (qdev-monitor.c:686)
> ==23097==    by 0x6192AA: qbus_print (qdev-monitor.c:719)
> [...]
> 
> Use the new sysbus_init_child_obj() function to make sure that the child
> objects are cleaned up correctly when the parent gets destroyed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
