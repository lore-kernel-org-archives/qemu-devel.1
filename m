Received: from eggs.gnu.org ([2001:4830:134:3::10]:60628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjVBk-0001Fw-Cg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:10:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjVBj-0004oI-EM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:10:52 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjVBj-0004nr-7a
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 13:10:51 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so142328366wmd.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 10:10:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170302174026.GI11445@redhat.com>
References: <a8300848-9e60-7d62-d8bd-c0084691abbb@ilande.co.uk>
	<20170302174026.GI11445@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 18:10:29 +0000
Message-ID: <CAFEAcA9WO4f9PuN=f1T61WjTsA8Veq4vERuucQfg-ZRAN0uT8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] git master build failure in 9pfs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>

On 2 March 2017 at 17:40, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Mar 02, 2017 at 05:28:24PM +0000, Mark Cave-Ayland wrote:
>> Build platform is Debian Wheezy on an x86_64 host.
>
> IIUC, O_PATH was introduced in glibc 2.14 and Wheezy only has 2.13.
>
> So unless we want to make this 9pfs code a configurable option, this
> means Debian Wheezy is no longer a supportable platform for QEMU.

I suspect some of our other supported host OSes still have
glibc 2.13 as well.

I think we should make this a configure check (assuming O_PATH
is a hard requirement for 9p now). We already only build 9pfs if
we're on a Linux host and have the libcap and libattr libraries available.

thanks
-- PMM
