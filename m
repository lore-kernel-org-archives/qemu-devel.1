Received: from eggs.gnu.org ([2001:4830:134:3::10]:51480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKp6-0002Ff-D9
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVKp5-0002HB-Mx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dVKp5-0002Gl-H0
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:49:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499866456.git.alistair.francis@xilinx.com>
Date: Wed, 12 Jul 2017 18:49:08 +0200
In-Reply-To: <cover.1499866456.git.alistair.francis@xilinx.com> (Alistair
	Francis's message of "Wed, 12 Jul 2017 06:57:27 -0700")
Message-ID: <87vamxzjln.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 0/7] Implement a warning_report function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, philippe@mathieu-daude.net, Eduardo Habkost <ehabkost@redhat.com>

Alistair Francis <alistair.francis@xilinx.com> writes:

> QEMU currently has a standard method to report errors with
> error_repot(). This ensure a sane and standard format when printing
> errors. This series is attempting to extend this functionality for
> warnings and information as well.
>
> This patch renames error_print_loc() function to be more clear, but I
> didn't bother renaming the others. It seems silly to change
> error_printf() to error_warning_printf() and printf is already taken so
> I just left it as is.

I can take this through my tree once PATCH 4 got some R-by from PC
paintainers.  Whom you again neglected to cc; I just did that for you.
I'll be happy to touch up minor issues like the ones I pointed out for
v4.
