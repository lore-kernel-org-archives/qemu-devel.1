Received: from eggs.gnu.org ([2001:4830:134:3::10]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gaM4M-0004f3-1H
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1gaM4I-0004wN-EG
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 09:46:29 -0500
References: <20181221134115.27973-1-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <185800dd-7eec-5553-ed19-f79c4d6c6cff@msgid.tls.msk.ru>
Date: Fri, 21 Dec 2018 17:46:12 +0300
MIME-Version: 1.0
In-Reply-To: <20181221134115.27973-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/usb: fix mistaken de-initialization of
 CCID state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-trivial@nongnu.org

21.12.2018 16:41, Daniel P. Berrang=C3=A9 wrote:
> In previous commit:
>=20
>    commit 7dea29e4af17fc1d27478de9f8ea38144deac54a
>    Author: Li Qiang <liq3ea@gmail.com>
>    Date:   Fri Oct 19 03:50:36 2018 -0700
[]

> --- a/hw/usb/ccid-card-emulated.c
> +++ b/hw/usb/ccid-card-emulated.c
> @@ -549,6 +549,8 @@ static void emulated_realize(CCIDCardState *base, E=
rror **errp)
>       qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apd=
u_thread,
>                          card, QEMU_THREAD_JOINABLE);
>  =20
> +    return;
> +
>   out2:
>       clean_event_notifier(card);
>   out1:

Lovely :)

Reviewed-By: Michael Tokarev <mjt@tls.msk.ru>

/mjt
