Received: from eggs.gnu.org ([2001:4830:134:3::10]:51962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnjhG-0002Qc-RK
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnjh7-0002R6-B8
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:01:10 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnjh7-0002Qw-4j
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:01:01 -0400
Received: by mail-wm0-x233.google.com with SMTP id 187so1530638wmn.1
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 04:01:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170901092407.GE31680@redhat.com>
References: <20170831122925.GJ17315@redhat.com>
	<CAFEAcA_pZn5evv_Z00EKevr1PrV+vNrs4bzEv9FaYLU_cisqyw@mail.gmail.com>
	<1504254677.10150.3.camel@redhat.com>
	<20170901092407.GE31680@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Sep 2017 12:00:39 +0100
Message-ID: <CAFEAcA_XBugpJj+t+ne92ZmBsKRHR+_Ztz00yCU24Lof4jEQPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] RFC: changing ROM bundling in tar dists for
 releases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 September 2017 at 10:24, Daniel P. Berrange <berrange@redhat.com> wrote:
> I've always wondered why we need to specialcase those modules at all.
> Personally I'd just remove them entirely and let people install the
> -dev packages on their distro just like they do for any other build
> prerequisite of QEMU.

Two uses: (1) we've tended to want newer versions of dtc than
distros actually had released (in fact right now we need a
pretty new dtc that not many distros have) and (2) for
hosts like OSX and Windows dependencies are not
a simple matter of "just install the distro's dev package".

thanks
-- PMM
