Received: from eggs.gnu.org ([209.51.188.92]:39643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghywS-0004s2-Ex
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghywQ-0006Oj-El
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:41:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57361)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghywP-0006NX-BR
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:41:50 -0500
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
	<87sgxzusb7.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
Date: Fri, 11 Jan 2019 16:41:41 +0100
MIME-Version: 1.0
In-Reply-To: <87sgxzusb7.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] tests: replace rem = sleep(time) with
 g_timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org, ehabkost@redhat.com

On 11/01/19 16:28, Alex Benn=C3=A9e wrote:
>> Why not g_usleep?  It already does a while loop around nanosleep (whic=
h
>> returns the remaining time in the wait, like select but unlike sleep a=
nd
>> poll).
> Yeah I'm testing that now. However I have managed to trigger:
>=20
>   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D 0=
): (35584 =3D=3D 0)

I think that's a good old SIGSEGV (0x8B00).

Paolo
