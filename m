Received: from eggs.gnu.org ([2001:4830:134:3::10]:48650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUYxy-0004FO-Ss
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUYxv-0000bE-NQ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dUYxv-0000aq-HJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:43:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1499453787.git.alistair.francis@xilinx.com>
	<a6c43be7d56dd7a7f4c0aa372ead1d9c6545d4e4.1499453788.git.alistair.francis@xilinx.com>
Date: Mon, 10 Jul 2017 15:43:02 +0200
In-Reply-To: <a6c43be7d56dd7a7f4c0aa372ead1d9c6545d4e4.1499453788.git.alistair.francis@xilinx.com>
	(Alistair Francis's message of "Fri, 7 Jul 2017 16:21:24 -0700")
Message-ID: <87lgnw1k7t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/8] Convert error_report*_err() to
 warn_report*_err()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, philippe@mathieu-daude.net, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, alistair23@gmail.com, Richard Henderson <rth@twiddle.net>

Alistair Francis <alistair.francis@xilinx.com> writes:

> Convert all uses of error_report*_err("Warning:"... to use
> warn_report*_err() instead. This helps standardise on a single
> method of printing warnings to the user.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
