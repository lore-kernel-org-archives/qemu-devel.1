Received: from eggs.gnu.org ([2001:4830:134:3::10]:47918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFmb-0006Sp-Bc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpFmW-0003nK-QD
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:28:57 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpFmW-0003my-I8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 11:28:52 -0400
Received: by mail-wm0-x231.google.com with SMTP id 187so20795078wmn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 08:28:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b6c65736-a095-e546-7798-d9028321f579@redhat.com>
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
	<d91a4033-a76a-9adc-aaa0-ded8468a337b@redhat.com>
	<CAFEAcA8-pX+QoqSwNzL9vvRqwByoazOzB2970a2K5Zg8CXKL+A@mail.gmail.com>
	<87vakx399z.fsf@dusky.pond.sub.org>
	<b6c65736-a095-e546-7798-d9028321f579@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 16:28:30 +0100
Message-ID: <CAFEAcA9njOtjVCgn=qeg3tw5Qv3i6x=WbkOgJQ_4FU4j3aMfKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 5 September 2017 at 08:36, Thomas Huth <thuth@redhat.com> wrote:
> OTOH, AIX support is really very, very like broken since years

It turns out there's an AIX box in the gcc compile farm, so just
out of curiosity I had a look.

(1) we don't recognize the cpu so you have to pass --cpu=ppc64
(2) we unconditionally pass -m64 for ppc64, which the AIX gcc
doesn't recognize, so you have to hack configure to avoid that
(3) after all that, AIX gcc doesn't have a working __thread for TLS

So yes, definitively broken and likely has been for years.

thanks
-- PMM
