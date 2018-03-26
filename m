Received: from eggs.gnu.org ([2001:4830:134:3::10]:53853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Uzs-0008IU-Eq
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Uzn-00061q-RK
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:29:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Uzn-00061a-NB
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 12:29:19 -0400
References: <1522047629-27658-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA8-2uHpdPYHbKj3fTyPd4DEXHm2CF-xVGcg5nJfzF8RDQ@mail.gmail.com>
	<9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <46ff0b91-41de-e65e-85c8-ab1b7a94efcd@redhat.com>
Date: Mon, 26 Mar 2018 11:29:10 -0500
MIME-Version: 1.0
In-Reply-To: <9b924dcf-d5bb-d1d9-a570-5fffd6a8db92@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 03/26/2018 09:23 AM, Eric Blake wrote:

>>> Julia Suvorova via Qemu-devel (1):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 net/vde: print error on vde_open=
() failure
>>
>> Applied, thanks.
>=20
> We'll want a followup patch to .mailmap to make the git log attribution=
=20
> look nicer.=C2=A0 We currently have the following patches all attribute=
d to=20
> the same email address; I have no idea if .mailmap can correctly sort=20
> between them:

Looks like it can, if we use the four-argument form.  Quoting=20
'git-shortlog --help':

            Proper Name <proper@email.xx> Commit Name <commit@email.xx>

        which allows mailmap to replace both the name and the email of a=20
commit
        matching both the specified commit name and email address.

>=20
> $ git shortlog origin --author=3Dqemu-devel | grep '^[^ ]'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
