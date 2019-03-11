Received: from eggs.gnu.org ([209.51.188.92]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3LNv-0003bY-NK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1h3LCz-0001l5-SH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1h3LCz-0001kq-LF
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:43:13 -0400
Date: Mon, 11 Mar 2019 10:43:06 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190311134306.GJ8899@habkost.net>
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<ed8793ce-cc5f-a506-2bdc-a39e9fc79cc7@amsat.org>
	<07100472-e75f-88c7-6740-21a56e225f80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <07100472-e75f-88c7-6740-21a56e225f80@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] sdbus: add a QMP command to access
 a SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Edgar Iglesias <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Mon, Mar 11, 2019 at 12:49:50PM +0100, Thomas Huth wrote:
> On 08/03/2019 17.11, Philippe Mathieu-Daud=E9 wrote:
> > Hi Markus,
> >=20
> > [Asking again from the correct series thread]
> >=20
> > On 1/3/18 10:49 PM, Philippe Mathieu-Daud=E9 wrote:
> >> Use Base64 to serialize the binary blobs in JSON.
> >> So far at most 512 bytes will be transfered, which result
> >> in a 684 bytes payload.
> >> Since this command is intented for qtesting, it is acceptable.
> >=20
> > Any comment regarding QMP for this patch?
>=20
> Is this useful for anybody else than qtest? If not, I think this should
> rather go into the qtest protocol instead, since QMP is our "public"
> protocol.

Extending qtest requires writing parsers by hand.  Do we really
want to go that route and start extending the qtest protocol more
often?

I also plan to add new debugging-only QMP commands for testing
CPU code, and I'm not looking forward to writing my own parser
inside qtest_process_command().

--=20
Eduardo
