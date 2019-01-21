Received: from eggs.gnu.org ([209.51.188.92]:43163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glbJt-0004o7-OS
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glbJs-0001At-Nr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:17:01 -0500
Received: from mail-io1-f51.google.com ([209.85.166.51]:37030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1glbJs-0001AP-JB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:17:00 -0500
Received: by mail-io1-f51.google.com with SMTP id g8so16659597iok.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
In-Reply-To: <242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
From: Ed Maste <emaste@freebsd.org>
Date: Mon, 21 Jan 2019 10:16:46 -0500
Message-ID: <CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 21 Jan 2019 at 05:18, Thomas Huth <thuth@redhat.com> wrote:
>
> Actually, scratch that Tested-by: My build timed out after 1 hour:
>
>  https://cirrus-ci.com/task/5113243459649536

Interesting. My build reports successful completion after a bit under
1/2 hr: https://cirrus-ci.com/build/5717787416723456

I notice that both your failing result and my successful result have
as the last test:

PASS 57 test-hmp /aarch64/hmp/none+2MB

so I wonder if yours actually finished in 1/2 hr, but then waited for
1/2 hr on something that got stuck?

> Are you also sure that you can run with 8 CPUs here? ... I somehow doubt
> that, otherwise the build should not take more than 1 h, I think.

To confirm, I have another build running now with
echo "Running with hw.ncpu=$(sysctl -n hw.ncpu)"
added.
