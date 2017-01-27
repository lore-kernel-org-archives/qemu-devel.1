Received: from eggs.gnu.org ([2001:4830:134:3::10]:56867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXCNo-0001hY-Eh
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cXCNn-0007kI-IP
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 14:40:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485444454-30749-1-git-send-email-armbru@redhat.com>
	<1485444454-30749-4-git-send-email-armbru@redhat.com>
Date: Fri, 27 Jan 2017 20:40:20 +0100
In-Reply-To: <1485444454-30749-4-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Thu, 26 Jan 2017 16:27:34 +0100")
Message-ID: <87efzo5m1n.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/i386: Deprecate -drive if=scsi with
 PC machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> The PC machines (pc-q35-* pc-i440fx-* pc-* isapc xenfv) automatically
> create lsi53c895a SCSI HBAs and SCSI devices to honor -drive if=scsi.
> For giggles, try -drive if=scsi,bus=25,media=cdrom --- this makes QEMU
> create 25 of them.
>
> lsi53c895a is thoroughly obsolete (PCI Ultra2 SCSI, ca. 2000), and
> currently has no maintainer in QEMU.  megasas is a better choice,
> except with old OSes that lack drivers.  virtio-scsi is a much better
> choice when you have a driver, but only (newish) Linux comes with one
> in the box.  There is no good default that works for all guests.
>
> Encourage users to pick a non-obsolete SCSI HBA that works for them by
> deprecating -drive if=scsi.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Missing: update doc (qemu-options.hx), and possibly qemu-iotests/051.
Will fix.
