Received: from eggs.gnu.org ([2001:4830:134:3::10]:60122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIAA6-0003fe-Sk
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIAA3-0001Hf-Py
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIAA3-0001H9-KF
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 04:48:23 -0400
Message-ID: <1496738897.15129.7.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 06 Jun 2017 10:48:17 +0200
In-Reply-To: <87vao91sym.fsf@dusky.pond.sub.org>
References: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
	<87f8f3e0-754d-7de5-4c2a-4b0930adb7fe@redhat.com>
	<87vao91sym.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

  Hi,

> Any plan to replace properties defined as data by properties defined
> in
> code will be a hard sell with me.=C2=A0=C2=A0I think we should go back to=
 data
> unless the problem at hand *requires* code.

There *are* some cases which require code, specifically QOM properties
which are writable after realize as they typically need some code to
apply the changes.

But, yes, the majority of properties we have in tree doesn't need that
(realize callback will handle them) and qdev properties are a perfect
fit for those.

cheers,
  Gerd
