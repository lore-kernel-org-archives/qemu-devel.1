Received: from eggs.gnu.org ([2001:4830:134:3::10]:39685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <snaipe@diacritic.io>) id 1cedYC-0004wX-7J
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <snaipe@diacritic.io>) id 1cedY8-0004M5-4Y
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:05:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170217005018.GA21716@lemon.lan>
References: <20170216085857.23501-1-snaipe@diacritic.io>
	<20170217005018.GA21716@lemon.lan>
From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>
Date: Fri, 17 Feb 2017 08:05:05 +0000
Message-ID: <CAK_MOSePd7740oW9X1M0U-ga3uOQZUm+P9v4sd95m+r0hBjQEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, snaipe@arista.com, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

2017-02-17 0:50 GMT+00:00 Fam Zheng <famz@redhat.com>:
> On Thu, 02/16 08:58, Franklin Snaipe Mathieu wrote:
>> +            p =3D lock_user_string(arg3)
>> +            if (!p) {
>
> Please compile test at least, even if it is a trivial patch.
>

Whoops, sorry, I forgot to re-compile after fixing the checkpatch issues.

--=20
Franklin "Snaipe" Mathieu
=F0=9F=9D=B0 https://diacritic.io
