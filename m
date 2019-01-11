Received: from eggs.gnu.org ([209.51.188.92]:46267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghzIz-0002gR-GC
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ghzIy-0003uI-7o
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ghzIv-0003r7-W6
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 11:05:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id y139so2863344wmc.5
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 08:05:05 -0800 (PST)
References: <20190111143815.26107-1-alex.bennee@linaro.org>
	<89afa3af-940d-7f3b-ee7c-25027bfd18f5@redhat.com>
	<87sgxzusb7.fsf@linaro.org>
	<3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3b4aa1f9-c18a-e2d7-abdd-f688bed9f4a1@redhat.com>
Date: Fri, 11 Jan 2019 16:05:02 +0000
Message-ID: <87r2djuqmp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, cota@braap.org, ehabkost@redhat.com


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 11/01/19 16:28, Alex Benn=C3=A9e wrote:
>>> Why not g_usleep?  It already does a while loop around nanosleep (which
>>> returns the remaining time in the wait, like select but unlike sleep and
>>> poll).
>> Yeah I'm testing that now. However I have managed to trigger:
>>
>>   ERROR:tests/test-qht-par.c:20:test_qht: assertion failed (rc =3D=3D 0)=
: (35584 =3D=3D 0)
>
> I think that's a good old SIGSEGV (0x8B00).

Hmmm, but I haven't been able to trigger it running it directly:

  retry.py -n 30 -c -- ./tests/qht-bench 1>/dev/null 2>&1 -R -S0.1 -D10000 =
-N1 -n 4 -u 20 -d 1

Could this be some sort of weird interaction caused by using system()?

--
Alex Benn=C3=A9e
