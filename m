Received: from eggs.gnu.org ([2001:4830:134:3::10]:60571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVdP-0003rL-0I
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVdM-0002Jx-7k
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:02:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYVdM-0002J0-2g
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:02:44 -0400
References: <20180628110254.6725-1-berrange@redhat.com>
	<20180628110254.6725-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4be1ffd-3bd4-f8f8-c283-b59993971ca3@redhat.com>
Date: Thu, 28 Jun 2018 07:02:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180628110254.6725-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/2] Delete AF_UNIX socket after close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Pavel Balaev <mail@void.so>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>Pavel Balaev <mail@void.so>

On 06/28/2018 06:02 AM, Daniel P. Berrang=C3=A9 wrote:
> From: Pavel Balaev <mail@void.so>
>=20
> This is a second attempt at sending this patch:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04697.html

I'm not stopping the pull request, but this particular commit message is=20
not very useful. A year from now, looking through 'git log' will tell us=20
nothing about the "why" for this patch (the subject line only covers the=20
"what").  And at that time, no one will care how many failed attempts=20
went through the list, but only what actually got committed.  Better=20
would have been just directly using the message from that mail:

>> Since version 2.12.0 AF_UNIX socket created for QMP exchange is not
>> deleted on instance shutdown.
>>=20
>> This is due to the fact that function qio_channel_socket_finalize() is
>> called after qio_channel_socket_close().

As a hint for future patches, mentioning that a post is a second version=20
and replaces an earlier post to the list is best done after the --- line=20
(where it is still readable on list as an aid to reviewers, but dropped=20
by the maintainer using 'git am' as unnecessary fluff for the git log).=20
More patch submission tips at: https://wiki.qemu.org/Contribute/SubmitAPa=
tch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
