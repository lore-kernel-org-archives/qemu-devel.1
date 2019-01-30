Received: from eggs.gnu.org ([209.51.188.92]:47767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokXl-0004Kl-LH
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokXe-0002e8-M3
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:44:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokXe-0002du-8Y
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:44:14 -0500
Date: Wed, 30 Jan 2019 08:44:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190130074407.33ta4xuk7cvgtayj@sirius.home.kraxel.org>
References: <20190129150029.29829-1-philmd@redhat.com>
	<20190129150029.29829-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190129150029.29829-2-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] hw/lm32: Move LM32 specific
 hardware out of common-obj list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Michael Walle <michael@walle.cc>, Fam Zheng <fam@euphon.net>, Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Brad Smith <brad@comstyle.com>

On Tue, Jan 29, 2019 at 04:00:25PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The LM32 specific hardware is only used by the LM32 target,
> it is pointless to compile those objects in other targets.

I think the idea was to only move the critical object files from
common-obj to obj (i.e. tmu2 only, or the two files in hw/display/).

cheers,
  Gerd
