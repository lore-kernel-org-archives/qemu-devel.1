Received: from eggs.gnu.org ([2001:4830:134:3::10]:42961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePPTz-00054W-4X
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ePPTv-0005Po-Ut
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:07:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ePPTv-0005Oq-OD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 04:07:07 -0500
Date: Thu, 14 Dec 2017 10:06:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171213232025.24503-2-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

Am 14.12.2017 um 00:20 hat Philippe Mathieu-Daud=E9 geschrieben:
> Use Base64 to serialize the binary blobs in JSON.
> So far at most 512 bytes will be transfered, which result
> in a 684 bytes payload.
> Since this command is intented for qtesting, this is acceptable.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Doing this kind of thing over QMP doesn't look right to me. qtests
should access hardware the same way as real guests access the hardware
(i.e. MMIO and I/O ports).

But if for some reason the QMP maintainers were to think that this is
acceptable in QMP, I'd argue it should at least get an x-debug- prefix
to avoid making it a stable API that management tools may rely on.

Kevin
