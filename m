Received: from eggs.gnu.org ([209.51.188.92]:33084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwJC7-0001qP-5b
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gwJ5N-0002Mr-Tb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gwJ5N-0002Ma-Lj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 23:02:17 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
Date: Wed, 20 Feb 2019 05:02:14 +0100
In-Reply-To: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>
	(Aleksandar Markovic's message of "Tue, 19 Feb 2019 20:15:04 +0100")
Message-ID: <87y36bjeex.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: qemu-devel@nongnu.org, natalia.fursova@ispras.ru, arikalo@wavecomp.com, mdroth@linux.vnet.ibm.com, dovgaluk@ispras.ru, amarkovic@wavecomp.com, marcandre.lureau@redhat.com, philmd@redhat.com, aurelien@aurel32.net

Aleksandar Markovic <aleksandar.markovic@rt-rk.com> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This patch enables QMP-based querying of the available CPU types for
> MIPS and MIPS64 platforms.
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Almost identical to the ARM code.  Factoring out the common core doesn't
seem worth the bother for just two copies.  Perhaps if we grow more
copies.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
