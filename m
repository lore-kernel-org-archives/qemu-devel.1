Received: from eggs.gnu.org ([2001:4830:134:3::10]:48159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVKau-0005IQ-Be
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dVKar-000330-9O
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dVKar-00032M-2o
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 12:34:29 -0400
References: <20170712105216.747-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24ba64bb-4536-462c-ce88-c8ad7b50158b@redhat.com>
Date: Wed, 12 Jul 2017 18:34:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170712105216.747-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/4] some gdbstub fixes for debug and
 vcont
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 12/07/2017 12:52, Alex Benn=C3=A9e wrote:
> Hi Paolo,
>=20
> I was going through my review queue and realised I had this hanging
> around with an outstanding comment. Basically the only change is to
> fix the bsd-user build by adding a field for the thread-id. It isn't
> populated but it never was and it looks like the gdbstub for threaded
> bsd-user programs has been broken forever.
>=20
> Given the range of different ways of getting a thread-id and the fact
> the bsd fork machinery looks like it needs updating anyway I'd left
> this for a future BSD maintainer to fix up properly.
>=20
> Are you happy to take this into your tree?

Yes, I will include it in my pull request.

Paolo
