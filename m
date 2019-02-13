Received: from eggs.gnu.org ([209.51.188.92]:55049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtwep-0007v5-8Q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gtwei-00033z-Ox
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:41:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gtweg-0002xh-T2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:40:59 -0500
References: <20190211163829.10297-1-pbonzini@redhat.com>
	<87imxppe68.fsf@dusky.pond.sub.org>
	<8f8ef754-0003-77e2-0fd1-e10f3ab2e3e5@redhat.com>
	<87d0nwjfna.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <12679a0f-7780-bc26-3f45-b99f52e131f1@redhat.com>
Date: Wed, 13 Feb 2019 16:40:48 +0100
MIME-Version: 1.0
In-Reply-To: <87d0nwjfna.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Kconfig: add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: peter.maydell@linaro.org, thuth@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 13/02/19 08:45, Markus Armbruster wrote:
> * If it doesn't, "default" / "imply" supply the value if condition is
>   met
>=20
> * What about contradictions between "default" / "imply"?

We would avoid those by forbidding "default n", then "imply" would also
be just another "default y".  I'm quite sold on only having "default y"
lines (which then are easily ORed among themselves and with "imply" lines=
).

Paolo
