Received: from eggs.gnu.org ([2001:4830:134:3::10]:42448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eS0gf-0002P3-Kz
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:15:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eS0gc-0001yJ-Ty
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:15:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eS0gc-0001xT-NW
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 08:14:58 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <a86b625a-de01-4b19-b9bc-b021c5736180.me@nagexiucai.com>
	<20171220091022.2b9add4b@redhat.com>
Date: Thu, 21 Dec 2017 14:14:51 +0100
In-Reply-To: <20171220091022.2b9add4b@redhat.com> (Luiz Capitulino's message
	of "Wed, 20 Dec 2017 09:10:22 -0500")
Message-ID: <87lghwxlx0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Hi, where can i get a latest full version of QAPI ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: =?utf-8?B?6YKj5Liq56eA5omN?= <me@nagexiucai.com>, qemu-devel <qemu-devel@nongnu.org>

Luiz Capitulino <lcapitulino@redhat.com> writes:

> On Wed, 20 Dec 2017 18:37:37 +0800
> "=E9=82=A3=E4=B8=AA=E7=A7=80=E6=89=8D" <me@nagexiucai.com> wrote:
>
>> Hi,
>> =C2=A0=C2=A0=C2=A0 Dear master.=C2=A0=C2=A0=C2=A0 Where can i get a late=
st full verson of QAPI ?=C2=A0=C2=A0=C2=A0 I wanna read some file in VMs by=
 qemu-quest-agent, since then, i found things below:
>> =C2=A0=C2=A0=C2=A0=C2=A0https://wiki.qemu.org/QMP=C2=A0=C2=A0=C2=A0=C2=
=A0https://wiki.qemu.org/Features/GuestAgent=C2=A0=C2=A0=C2=A0=C2=A0https:/=
/wiki.qemu.org/Features/QAPI=C2=A0=C2=A0=C2=A0=C2=A0https://wiki.qemu.org/F=
eatures/QAPI/Signals
>> =C2=A0=C2=A0=C2=A0=C2=A0and even:
>> =C2=A0=C2=A0=C2=A0=C2=A0http://shevek.github.io/qemu-java/docs/javadoc/=
=C2=A0=C2=A0=C2=A0=C2=A0However, those are all not a API manual like https:=
//developer.openstack.org/api-ref/application-container/ or https://dev.off=
ice.com/reference/add-ins/shared/asyncresult
>> =C2=A0=C2=A0=C2=A0=C2=A0Need help !=C2=A0=C2=A0=C2=A0=C2=A0Thanks for an=
y response !
>> Regards!
>> Boba little code labour in the world full of dust.
>
> Markus is a better person to ask.

The general guest agent protocol is documented in
docs/interop/qmp-spec.txt.

Guest agent commands are specified in qga/qapi-schema.json.  The build
process extracts documentation from it to docs/interop/qemu-ga-ref.*.
You can browse 2.11's at <http://qemu.weilnetz.de/doc/qemu-ga-ref.html>.

Hope this helps!
