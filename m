Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdQI-0001HC-P7
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdQC-0004rH-RT
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:06:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZdQC-0004ou-EF
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:06:04 -0500
References: <20181217231700.24482-1-pbonzini@redhat.com>
	<CAFEAcA-=jLUHhcUeBMQtOU-tA6nKaNoBkf2eYqC6CA2TkG+6ZA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0c4f4079-40df-4d40-0c77-bc18eedaf538@redhat.com>
Date: Wed, 19 Dec 2018 16:05:58 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=jLUHhcUeBMQtOU-tA6nKaNoBkf2eYqC6CA2TkG+6ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19/12/18 15:33, Peter Maydell wrote:
> PS: can the colorization be disabled? Grepping logfiles for
> ERROR, FAIL, etc doesn't work in the presence of colour
> escape sequences...

Oh interesting that it didn't grep fine for you, it seemed to be okay her=
e.

I added it because "make -O" uses a pipe rather than tty, and causes
colors not to be applied.  I'm thinking of adding a --enable-color=3DFOO
instead, for now I'll disable it and send v2.

Paolo
