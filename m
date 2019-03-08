Received: from eggs.gnu.org ([209.51.188.92]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2HoQ-0008Qw-KM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:53:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h2HoP-0004z8-Pd
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:53:30 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:33339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h2HoP-0004yF-IN
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:53:29 -0500
Received: by mail-ot1-x331.google.com with SMTP id q24so17782487otk.0
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 07:53:29 -0800 (PST)
MIME-Version: 1.0
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
	<CAFEAcA9_shDqjpqF-k9mvR1N6DY7HmXMPiOpkSFcnGpyC3W7tQ@mail.gmail.com>
	<12a1fc59-da10-174b-6544-3af075da8057@redhat.com>
In-Reply-To: <12a1fc59-da10-174b-6544-3af075da8057@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Mar 2019 15:53:17 +0000
Message-ID: <CAFEAcA9kYUAP2fhKRn0GTvx4gXGMyimxeWSD8x6ZNd9HS+0ksQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 21 Feb 2019 at 14:55, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi,
> On 2/21/19 3:26 PM, Peter Maydell wrote:
> > On Thu, 21 Feb 2019 at 14:20, Auger Eric <eric.auger@redhat.com> wrote:
> >> [a regression using aarch64 KVM]
> >Can you provide the QEMU_EFI.fd ?
> I am using upstream EDK2 (https://github.com/tianocore/edk2) compiled in
> debug mode

I don't really want to mess about building EDK2. Could you just
provide the blob that demonstrates the bug, please?

thanks
-- PMM
