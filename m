Received: from eggs.gnu.org ([209.51.188.92]:44464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGOFK-0000IB-Co
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hGOFH-00059G-Mt
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hGOFF-0004yI-CE
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:35:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id m10so17612093otp.2
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190415154503.6758-1-berrange@redhat.com>
In-Reply-To: <20190415154503.6758-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2019 14:35:04 +0100
Message-ID: <CAFEAcA-YpG71aGtTVMafShGyd9uM599Uy_8S3vvvnPzfiKMqnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] usb-mtp: fix ObjectInfo request
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>, Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>

On Mon, 15 Apr 2019 at 16:45, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Two previous attempts to fix this due to GCC 9 highlighting
> unaligned data access. My attempt:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07763.html
>
> And a previous one:
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07923.html
>   https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg00162.html
>
> There are a number of bugs in the USB MTP usb_mtp_write_metadata
> method handling the filename character set conversion.
>
> The 2nd patch in this series is a security flaw fix since the
> code was not correctly validating guest provided data length.

Given that we don't seem to be confident in this fix just now,
and this is a read-only buffer overrun in a not-commonly-used
feature that only happens if you explicitly enable write support,
my current thought is that we should not try to put this into 4.0
(but instead treat it as we would a security issue that had
occurred after we released 4.0).

Opinions? Maybe we should just apply patch 2/3 for 4.0 ?

thanks
-- PMM
