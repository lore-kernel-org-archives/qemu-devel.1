Received: from eggs.gnu.org ([2001:4830:134:3::10]:43754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJmU5-0006gG-5x
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJmU4-00086x-8n
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:28:01 -0500
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113161446.2862-2-michael.nawrocki@gtri.gatech.edu>
	<CAFEAcA8FDoLRx+OCMwjUzYd-X3HX7Z77SUTmNbSB9YWYT77AcA@mail.gmail.com>
	<CAFEAcA-JwUm5+N-Km1fZjuPYA81sMCekguchJiV59BvqjnPJOA@mail.gmail.com>
	<b3a7006b-bf0d-f5f3-bf78-f18b38a014e7@gtri.gatech.edu>
	<eb039f59-f43b-88c7-324e-31a336a8d433@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1fbc3c84-b197-7da0-b70d-a95952e87860@redhat.com>
Date: Tue, 28 Nov 2017 14:27:51 -0600
MIME-Version: 1.0
In-Reply-To: <eb039f59-f43b-88c7-324e-31a336a8d433@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Switch AMD CFI flash to use new
 MMIO API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, Peter Maydell <peter.maydell@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On 11/28/2017 02:05 PM, Eric Blake wrote:

> Better yet, please fix the PFLASH_DEBUG code to avoid bitrot in the=20
> first place, by rewriting the bad pattern:
>=20

> into the good pattern:
>=20
> #ifdef PFLASH_DEBUG
> # define PFLASH_PRINT 1
> #else
> # define PFLASH_PRINT 0
> #endif
> #define DPRINTF(fmt, ...) \
> do { \
>  =C2=A0 if (PFLASH_PRINT) { \
>  =C2=A0=C2=A0=C2=A0 fprintf(stderr, "PFLASH: " fmt, ## __VA_ARGS__); \
>  =C2=A0 }; \

Serves me right for typing this without testing; the extra ; is spurious.

By the way, this is one of the Bite-Sized Tasks that never seems to get=20
finished...
https://wiki.qemu.org/BiteSizedTasks#Bitrot_prevention

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
