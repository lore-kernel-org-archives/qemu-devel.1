Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT4UE-0004ZB-OL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dT4UE-0005Hj-04
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:58:18 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dT4UD-0005H9-Pq
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 06:58:17 -0400
Received: by mail-wr0-x232.google.com with SMTP id 77so23857829wrb.1
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 03:58:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170706104940.GJ3988@redhat.com>
References: <1499237876.3041.4.camel@linux.intel.com>
	<20170705110431.GE22008@redhat.com>
	<20170705114411.GE29382@lemon.lan>
	<c1f43fc3-7db8-50af-ee8c-331895721bd6@redhat.com>
	<20170705122200.GH29382@lemon.lan> <20170706104940.GJ3988@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2017 11:57:56 +0100
Message-ID: <CAFEAcA97GY+8PGxfL3_EajvBKrb_8wMfkWvEmm6US9nOPc3hsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] change x86 default machine type to Q35?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>, Thomas Huth <thuth@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 July 2017 at 11:49, Daniel P. Berrange <berrange@redhat.com> wrote:
> eg if we killed the default, currently QEMU would say something like
>
>    qemu-system-x86_64: No machine specified, and there is no default
>    Use -machine help to list supported machines

Incidentally I really should get round to figuring out how to make
command lines like
 qemu-system-arm -device help
 qemu-system-arm -cpu help
work without the user having to specify "-M virt" too to avoid the
"no default machine" error taking precedence over the help output...

thanks
-- PMM
