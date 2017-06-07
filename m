Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXnv-0000X1-9U
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXns-0006R3-64
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:03:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXns-0006Qp-0Y
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:03:04 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170607074632.13162-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 11:46:31 +0400")
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-5-marcandre.lureau@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 12:02:58 +0200
Message-ID: <8760g83yjx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] Replace g_malloc()+memcpy() with
 g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> I found these pattern via grepping the source tree. I don't have a
> coccinelle script for it!
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
