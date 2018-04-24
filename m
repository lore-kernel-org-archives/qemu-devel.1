Received: from eggs.gnu.org ([2001:4830:134:3::10]:47220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAzoV-0007Fh-MG
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fAzoS-0006uo-Dd
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fAzoS-0006ty-9r
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:25:00 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
	<20180419150145.24795-2-marcandre.lureau@redhat.com>
	<d573d5eb-e8a2-c6e3-82b7-ba712c001aba@redhat.com>
	<CAJ+F1C+X9vAi2xx5Z7yoi_65o_C9SxfE_HNrV9BDBd81Y1wxwg@mail.gmail.com>
	<87po2ohk68.fsf@dusky.pond.sub.org>
	<CAFEAcA-ynm85eJ9Q7F8mtYNNiUBY+BQQcCdEg_eAdfmVTD4GRw@mail.gmail.com>
Date: Tue, 24 Apr 2018 17:24:56 +0200
In-Reply-To: <CAFEAcA-ynm85eJ9Q7F8mtYNNiUBY+BQQcCdEg_eAdfmVTD4GRw@mail.gmail.com>
	(Peter Maydell's message of "Tue, 24 Apr 2018 13:34:27 +0100")
Message-ID: <877eowhbjr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/5] qobject: ensure base is at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 24 April 2018 at 13:18, Markus Armbruster <armbru@redhat.com> wrote:
>> We define hundreds of QOM types without ever bothering to check the
>> super type comes first.  We don't even bother to clearly document it has
>> to come first.
>
> If you don't put the super type first then the first time you
> do MyParent *p =3D MY_PARENT(me); then the QOM cast will assert
> on you, so you'll figure it out pretty quickly...

Same for QObject & friends, where qobject_to() asserts.

Marc-Andr=C3=A9's argument for adding more checks was the possibility of
someone doing MyParent *p =3D (MyParent *)me without running into
MY_PARENT(me).
