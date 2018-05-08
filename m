Received: from eggs.gnu.org ([2001:4830:134:3::10]:33031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG359-00041L-9r
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fG353-0001vl-J5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:07 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fG353-0001vZ-DY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:55:01 -0400
Received: by mail-oi0-x241.google.com with SMTP id n65-v6so28395512oig.6
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 06:55:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508134831.GV5967@redhat.com>
References: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
	<20180508134831.GV5967@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 May 2018 14:54:39 +0100
Message-ID: <CAFEAcA_L3fy+MFh72=zX3pHtXP634Uhu0+G=nz-fMWaGC8muNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 8 May 2018 at 14:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote=
:
> This test has a couple of threads running, and passes &error_abort to
> the qio_channel_socket_readv() function. So I expect that one thread
> is closing the socket connection, and the other thread has not yet
> shutdown cleanly, so tries to readv on a dead socket triggering the
> error_abort.  IOW,  qio_channel_socket_readv is likely just the symptom
> of brokeness somewhere else in the test, not the cause.

That sounds familiar...didn't we have a thread about this a while back?

thanks
-- PMM
