Received: from eggs.gnu.org ([2001:4830:134:3::10]:60741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fwnuJ-0000vD-K1
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fwnuI-0007nP-Q4
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:24:39 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:43854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fwnuH-0007lW-DE
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:24:37 -0400
Received: by mail-oi0-x22f.google.com with SMTP id b15-v6so616833oib.10
	for <qemu-devel@nongnu.org>; Mon, 03 Sep 2018 05:24:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180903115926.GB14377@redhat.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
	<20180830142708.14311-2-sameeh@daynix.com>
	<20180903115926.GB14377@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Sep 2018 13:24:16 +0100
Message-ID: <CAFEAcA8HATZQqawAX3=OPmas6uzp0UAciK7QXo=uuRbCfvUjaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 1/6] Add bpf support to qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 September 2018 at 12:59, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:

>>  ##########################################
>> +# check for usable bpf system call
>> +if test "$bpf" =3D "yes"; then
>
> if test "x$bpf" !=3D "xno"; then

We don't use the leading-x thingy elsewhere in configure,
why is this condition special?
(We can assume we don't have a broken shell, and we
know that $bpf won't be a string starting with a hyphen.)

thanks
-- PMM
