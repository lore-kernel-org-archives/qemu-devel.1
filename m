Received: from eggs.gnu.org ([2001:4830:134:3::10]:51987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRdpg-0005kc-R3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRdpc-0000UX-QC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:55:20 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRdpc-0000Sz-Jr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:55:16 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so21734605qtm.13
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-11-marcandre.lureau@redhat.com>
	<20181127134154.GM18284@habkost.net>
In-Reply-To: <20181127134154.GM18284@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 17:55:02 +0400
Message-ID: <CAMxuvazzMc-6kREx2tpd7fz3KNAbc29JSLM5pATBpgnnrwsnAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 10/28] qom: make interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, minyard <minyard@acm.org>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, hpoussin@reactos.org, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, stefanb@linux.ibm.com

On Tue, Nov 27, 2018 at 5:42 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> On Tue, Nov 27, 2018 at 01:27:43PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Interfaces don't have instance, let's make the interface type really
> > abstract to avoid confusion.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> What about updating the documentation at qom/object.h with
> examples?

I don't like code example in documentation, they tend to bit rot
(hint: rustdoc :). Instead, we can point out
tests/check-qom-interface.c?

>
> --
> Eduardo
