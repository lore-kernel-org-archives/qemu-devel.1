Received: from eggs.gnu.org ([2001:4830:134:3::10]:48611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvWye-0001yF-UE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvWye-00048S-6e
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:31:04 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvWyd-00047h-Ur
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 18:31:04 -0400
Received: by mail-wm0-x232.google.com with SMTP id x124so40090909wmf.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 15:31:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170405.072837.698655508316162287.ryo_on@yk.rim.or.jp>
References: <20170405.062259.994335017099386017.ryo_on@yk.rim.or.jp>
	<CAFEAcA83HujBVrbYgXdfJq5YXTqzX9rOSLeGPgdtxaG2TwsbNw@mail.gmail.com>
	<20170405.072837.698655508316162287.ryo_on@yk.rim.or.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 23:30:42 +0100
Message-ID: <CAFEAcA_TrA+hwNVTZ0_vb0dGBjcLi+xzkgZ5KNamBmiLsddVWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] How to provide build/CI environment for NetBSD host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryo ONODERA <ryo_on@yk.rim.or.jp>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4 April 2017 at 23:28, Ryo ONODERA <ryo_on@yk.rim.or.jp> wrote:
> I use qemu from master branch (with some modification) every weekend.
> However I had never run 'make check'.
> I will run 'make check'.

Hmm. ivshmem_server doesn't link for me, because
it uses shm_open() but doesn't link with -lrt.
So the build fails.

thanks
-- PMM
