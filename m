Received: from eggs.gnu.org ([2001:4830:134:3::10]:48550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e78Uk-0002hO-0F
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e78Ug-0003Fk-On
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 19:20:25 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171024122045.30072-3-f4bug@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	24 Oct 2017 09:20:43 -0300")
References: <20171024122045.30072-1-f4bug@amsat.org>
	<20171024122045.30072-3-f4bug@amsat.org>
Reply-To: quintela@redhat.com
Date: Wed, 25 Oct 2017 01:20:13 +0200
Message-ID: <87a80gnnf6.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] tpm: add stubs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, "Richard W . M . Jones" <rjones@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Commit c37cacabf22 moved tpm_cleanup() in the main loop exit, however this
> function is not available when compiling with --disable-tpm.
>
> Provides necessary stubs to keep code clean of #ifdef'fery.
>
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-Id: <20171023102903.256AF7456A0@zero.eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
