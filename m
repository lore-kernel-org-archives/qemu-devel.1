Received: from eggs.gnu.org ([2001:4830:134:3::10]:39889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1dVDx2-0007cg-At
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vincenzo.romano@notorand.it>) id 1dVDx1-0004ib-CN
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:28:56 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:35366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vincenzo.romano@notorand.it>)
	id 1dVDx1-0004WY-16
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 05:28:55 -0400
Received: by mail-lf0-x22f.google.com with SMTP id b207so10887908lfg.2
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 02:28:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
References: <CAOE=1Z3ve+zQJbjqqfNA1iB_mNgFkoTTXRxyBikSiJ5_AZwpiA@mail.gmail.com>
From: Vincenzo Romano <vincenzo.romano@notorand.it>
Date: Wed, 12 Jul 2017 11:27:49 +0200
Message-ID: <CAHjZ2x6S8VZOts_d=vkH=HoT8YatEehP6z531QS+d9JmDEuRgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] How to stop `qemu-system-x86_64
 ...` instead of `kill -9`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

2017-07-12 11:24 GMT+02:00 Sam <batmanustc@gmail.com>:
> hi all,
>
> I'm running `qemu-system-x86_64 ...` to start a guest vm. Now I want to
> stop and destroy this vm, I found there is no `qemu-stop` related command,
> so I have to `kill -9` this process.
>
> How could I stop `qemu-system-x86_64` instead of `kill -9`? Use `virsh`
> command or something?
>
> Thank you~

I hate virsh/libvirt.
I use the qemu monitor commands via SSH.
See http://download.qemu.org/qemu-doc.html#pcsys_005fmonitor

-- 
Vincenzo Romano - NotOrAnd.IT
Information Technologies
--
NON QVIETIS MARIBVS NAVTA PERITVS
