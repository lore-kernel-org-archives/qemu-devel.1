Received: from eggs.gnu.org ([209.51.188.92]:48980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3LNV-0003bY-Hl
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3LHp-0003nU-Mr
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:48:14 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3LHp-0003mk-Ac
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:48:13 -0400
Received: by mail-ot1-x343.google.com with SMTP id c18so3927269otl.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180103214925.16677-1-f4bug@amsat.org>
	<20180103214925.16677-2-f4bug@amsat.org>
	<ed8793ce-cc5f-a506-2bdc-a39e9fc79cc7@amsat.org>
	<07100472-e75f-88c7-6740-21a56e225f80@redhat.com>
	<20190311134306.GJ8899@habkost.net>
In-Reply-To: <20190311134306.GJ8899@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 13:48:00 +0000
Message-ID: <CAFEAcA-yBu1SyhmfYKjXtA2BSHJrPnz_n-SrNwcdpG-isLbzWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair@alistair23.me>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Mon, 11 Mar 2019 at 13:43, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Mon, Mar 11, 2019 at 12:49:50PM +0100, Thomas Huth wrote:
> > On 08/03/2019 17.11, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi Markus,
> > >
> > > [Asking again from the correct series thread]
> > >
> > > On 1/3/18 10:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > >> Use Base64 to serialize the binary blobs in JSON.
> > >> So far at most 512 bytes will be transfered, which result
> > >> in a 684 bytes payload.
> > >> Since this command is intented for qtesting, it is acceptable.
> > >
> > > Any comment regarding QMP for this patch?
> >
> > Is this useful for anybody else than qtest? If not, I think this should
> > rather go into the qtest protocol instead, since QMP is our "public"
> > protocol.
>
> Extending qtest requires writing parsers by hand.  Do we really
> want to go that route and start extending the qtest protocol more
> often?

Perhaps we could have qtest-only QMP commands that only get
recognized if qtest_enabled() ?

thanks
-- PMM
