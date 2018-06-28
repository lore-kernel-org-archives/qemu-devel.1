Received: from eggs.gnu.org ([2001:4830:134:3::10]:33926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXL1-0007zm-1q
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:51:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXL0-0005XM-6i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:51:55 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXL0-0005WU-0m
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:51:54 -0400
Received: by mail-oi0-x244.google.com with SMTP id f79-v6so5225896oib.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 06:51:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180625165749.3910-1-f4bug@amsat.org>
References: <20180625165749.3910-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 14:51:32 +0100
Message-ID: <CAFEAcA-gdAOohovhu1iF1fXGjqU_KiuEs0Q6WYRE7=BOBwr+gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/3] qapi/error: converts
 error_setg(&error_fatal) to error_report() + exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 25 June 2018 at 17:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi,
>
> This series converts error_setg(&error_fatal) to error_report() + exit() =
as
> suggested by the "qapi/error.h" documentation.
>
> This reduce Coverity and Clang static analyzer positive falses.
>
> See http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07585.html=
:
>
>     On 07/24/2017 04:52 PM, Eric Blake wrote:
>     That's a shame.  Rather, we should patch this file (and others) to av=
oid
>     all the inconsistent uses of error_setg(&error_*), to comply with the
>     error.h documentation.
>

Applied to target-arm.next, thanks. (Not all arm code, but mostly
close enough that that seems the easiest way to deal with it.)

thanks
-- PMM
