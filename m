Received: from eggs.gnu.org ([2001:4830:134:3::10]:51207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgB1w-0006if-Mo
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cgB1r-0006Tv-0j
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:03:00 -0500
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:33385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cgB1q-0006T8-Q1
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:02:54 -0500
Received: by mail-wr0-x22f.google.com with SMTP id 97so4044837wrb.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 06:02:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487681108-14452-1-git-send-email-eric.auger@redhat.com>
References: <1487681108-14452-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Feb 2017 14:02:32 +0000
Message-ID: <CAFEAcA_MYmGBwPtVXFvywjp5DQ-R+opo2nvVJbHfASwdY9Do-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/virt: Add a user option to
 disallow ITS instantiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>

On 21 February 2017 at 12:45, Eric Auger <eric.auger@redhat.com> wrote:
> In 2.9 ITS will block save/restore and migration use cases. As such,
> let's introduce a user option that allows to turn its instantiation
> off, along with GICv3. With the "its" option turned false, migration
> will be possible, obviously at the expense of MSI support (with GICv3).
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>



Applied to target-arm.next, thanks.

-- PMM
