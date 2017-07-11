Received: from eggs.gnu.org ([2001:4830:134:3::10]:35864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV1Yu-0004q0-LT
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dV1Yr-0004kT-IW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dV1Yr-0004jo-Ci
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:15:09 -0400
Date: Tue, 11 Jul 2017 17:14:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170711201457.GB6020@localhost.localdomain>
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
	<20170711103011.32631-5-marcandre.lureau@redhat.com>
	<2acb6eb3-26e0-9a97-34d9-016fc9d1b2ec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2acb6eb3-26e0-9a97-34d9-016fc9d1b2ec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] dump: add vmcoreinfo ELF note
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, anderson@redhat.com, imammedo@redhat.com, Alistair Francis <alistair.francis@xilinx.com>

On Tue, Jul 11, 2017 at 10:04:43PM +0200, Laszlo Ersek wrote:
[...]
> > +    lines = g_strsplit((char *)vmci, "\n", -1);
> > +    for (i = 0; lines[i]; i++) {
> > +        if (g_str_has_prefix(lines[i], "NUMBER(phys_base)=")) {
> > +            if (qemu_strtou64(lines[i] + 18, NULL, 16,
> > +                              &phys_base) < 0) {
> > +                error_report("warning: Failed to read NUMBER(phys_base)=");
[...]
> > +        } else if (size < note_head_size || size > MAX_VMCOREINFO_SIZE) {
> > +            error_report("warning: vmcoreinfo size is invalid: %" PRIu32, size);
[...]
> > +                error_report("warning: Invalid vmcoreinfo header");

You will probably want to change this to warn_report() once
Alistair's series is merged.

-- 
Eduardo
