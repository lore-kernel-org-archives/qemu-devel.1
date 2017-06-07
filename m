Received: from eggs.gnu.org ([2001:4830:134:3::10]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXme-0007KD-UO
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXmb-0005xE-AC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:01:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXmb-0005wv-4q
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 06:01:45 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170607074632.13162-2-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 7 Jun 2017 11:46:28 +0400")
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-2-marcandre.lureau@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 07 Jun 2017 12:01:40 +0200
Message-ID: <87a85k3ym3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/5] coccinelle: replace code with ROUND_UP
 macro
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
> I used a the following coccinelle script:
>
> @@
> expression e1;
> @@
> - ((e1) + (3)) / (4) * (4)
> + ROUND_UP(e1,4)
>
> @@
> expression e1;
> expression e2;
> @@
> -(ROUND_UP(e1,e2))
> +ROUND_UP(e1,e2)
>
> I tried with various other values (4, 8, 16, 32), but got only the
> matches in this patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
