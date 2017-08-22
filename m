Received: from eggs.gnu.org ([2001:4830:134:3::10]:42508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkBfe-0005zj-8r
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkBfd-0000kY-HF
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 12:04:50 -0400
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-9-pbonzini@redhat.com>
	<CAJ+F1C+CpgwqgMP262gg+UNqM_8WUXsTCKtTzTTsSrZt5Srzxw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d506d1cf-ae97-6554-b3fc-1a2ef3ab24ca@redhat.com>
Date: Tue, 22 Aug 2017 18:04:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+CpgwqgMP262gg+UNqM_8WUXsTCKtTzTTsSrZt5Srzxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] scsi: build qemu-pr-helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

On 22/08/2017 16:34, Marc-Andr=C3=A9 Lureau wrote:
> Could this be handled by udisk? It seems at first the problem is not
> specific to qemu.

Yes, possibly.  In practice, everybody else who uses persistent
reservations seems to run as root. :)

>> +static void usage(const char *name)
>> +{
>> +    (printf) (
> Why '(printf)' ? I noticed qemu-nbd use this too.
>=20

It lets you use #ifdef inside the argument list.

>>
>> +        /* Stash one file descriptor per request.  */
>> +        if (nfds) {
>> +            for (i =3D 0; i < nfds; i++) {
>> +                if (client->fd =3D=3D -1) {
>> +                    client->fd =3D fds[i++];
>> +                } else {
>> +                    close(fds[i]);
>=20
> Isn't this a condition to close the client?

Yes, though I still have to go through the descriptors and close them.

Paolo
