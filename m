Received: from eggs.gnu.org ([209.51.188.92]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghy27-0001Kz-3S
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghy25-0000Ig-TQ
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:43:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghy25-0000HH-Jt
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 09:43:37 -0500
References: <20190111143815.26107-1-alex.bennee@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
Date: Fri, 11 Jan 2019 15:43:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190111143815.26107-1-alex.bennee@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, ehabkost@redhat.com

On 11/01/19 15:38, Alex Benn=C3=A9e wrote:
> Relying on sleep to always return having slept isn't safe as a signal
> may have occurred. If signals are constantly incoming the program will
> never reach it's termination condition. This is believed to be the
> mechanism causing time outs for qht-test in Travis.
>=20
> Instead we use a g_timer to determine if the duration of the test has
> passed and sleep for a second at a time. This may bias benchmark
> results for short runs.

Why not g_usleep?  It already does a while loop around nanosleep (which
returns the remaining time in the wait, like select but unlike sleep and
poll).

Thanks,

Paolo
