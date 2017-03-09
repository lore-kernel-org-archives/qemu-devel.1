Received: from eggs.gnu.org ([2001:4830:134:3::10]:51017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm1lP-0001oG-67
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:22:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm1lM-0008PM-1E
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:22:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm1lL-0008Nr-Rj
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:22:03 -0500
References: <20170303131113.25898-1-pbonzini@redhat.com>
	<8737emid07.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0a70ecd0-6340-d97e-a185-dc7cf06d958b@redhat.com>
Date: Thu, 9 Mar 2017 18:22:01 +0100
MIME-Version: 1.0
In-Reply-To: <8737emid07.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] tcg: fix icount super slowdown
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



On 09/03/2017 18:19, Alex Benn=C3=A9e wrote:
>=20
> Hmm your subject line was:
>=20
>   Subject: [PATCH 0/6] tcg: fix icount super slowdown
>=20
> But:
>=20
>> Paolo Bonzini (5):
>>   qemu-timer: fix off-by-one
>>   qemu-timer: do not include sysemu/cpus.h from util/qemu-timer.h
>>   cpus: define QEMUTimerListNotifyCB for QEMU system emulation
>>   main-loop: remove now unnecessary optimization
>>   icount: process QEMU_CLOCK_VIRTUAL timers in vCPU thread
> Did the tooling missing something or is this just a git-format-patch bu=
rp?

Patch 1 was the nios2 fix that I ended up posting as a separate thread.

Paolo
