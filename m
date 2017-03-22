Received: from eggs.gnu.org ([2001:4830:134:3::10]:41078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqdMB-00080r-FE
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cqdM8-00040S-Sw
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cqdM8-00040A-MU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 06:19:04 -0400
References: <87bmstu19t.fsf@dusky.pond.sub.org>
	<1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <da2bfbb8-c000-eaff-826f-904582f6e98a@redhat.com>
Date: Wed, 22 Mar 2017 11:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <1f744cad-f67b-92d3-b4e4-32f8b05c643c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Minimum RAM size for PC machines?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, seabios@seabios.org, =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

On 22.03.2017 11:03, Thomas Huth wrote:
> On 22.03.2017 10:08, Markus Armbruster wrote:
> [...]
>> Are we now ready to accept a simple & stupid patch that actually helps
>> users, say letting boards that care declare minimum and maximum RAM
>> size?  And make PC reject RAM size less than 1MiB, even though "someon=
e"
>> might conceivably have firmware that works with less?
>=20
> I'd say enforce a minimum RAM size on the normal "pc" and "q35" machine=
,
> but still allow smaller sizes on the "isapc" machine. So if "someone"
> comes around and claims to have a legacy firmware that wants less memor=
y
> than 1MiB, just point them to the isapc machine.
> Just my 0.02 =E2=82=AC.
>=20
>  Thomas

Or maybe simply warn the user that things may go wrong instead of
enforcing it.

--=20

Thanks,

David
