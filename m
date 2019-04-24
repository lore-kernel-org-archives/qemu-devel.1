Received: from eggs.gnu.org ([209.51.188.92]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJHnP-0002I7-5A
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hJHen-0003jZ-K0
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:09:50 -0400
Received: from mail-eopbgr700107.outbound.protection.outlook.com
	([40.107.70.107]:4245
	helo=NAM04-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hJHYw-0005p0-Lt
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:03:48 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Wed, 24 Apr 2019 13:03:43 +0000
Message-ID: <BN6PR2201MB1251B9F471655E8E079E83E2C63C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for eXtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, "daniel.santos@pobox.com" <daniel.santos@pobox.com>, "lvivier@redhat.com" <lvivier@redhat.com>, "thuth@redhat.com" <thuth@redhat.com>, "philmd@redhat.com" <philmd@redhat.com>

> From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Subject: [PATCH v2 1/5] linux-user: Fix support for the SIOCATMARK and SI=
OCGPGRP ioctls for eXtensa
>
> Fix support for the SIOCATMARK and SIOCGPGRP ioctls for eXtensa by
> correcting corresponding macro definition.

Hello, Xtensa folks!

This patch was devised while looking at some MIPS scenarios, but, in fact,
it affects Xtensa platform only (found by inspecting relevant Linux kernel
headers).

Could someone form Xtensa Ack ot Not-Ack this patch?

Sincerely, Aleksandar=
