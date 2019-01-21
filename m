Received: from eggs.gnu.org ([209.51.188.92]:33300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glchC-0000Ao-IU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carpeddiem@gmail.com>) id 1glcTH-0006m7-2f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:30:48 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carpeddiem@gmail.com>)
	id 1glcTF-0006hx-1s
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:30:45 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so15966624ita.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 08:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
	<20190118144724.66914-1-emaste@freebsd.org>
	<8def73c9-23e5-9f87-81d1-dda0c7e6f7d9@redhat.com>
	<242e057a-0c35-93b1-1249-93799cdf1196@redhat.com>
	<CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
In-Reply-To: <CAPyFy2BLuGCYx0-GUdy5w8HD0u3hkvH3DGmCV+9OKYjtkr6rew@mail.gmail.com>
From: Ed Maste <emaste@freebsd.org>
Date: Mon, 21 Jan 2019 11:30:23 -0500
Message-ID: <CAPyFy2DNJvE4GbXxtzFJe8bPiXQm+bOmp+D_zVSCtaJML18vzw@mail.gmail.com>
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

On Mon, 21 Jan 2019 at 10:16, Ed Maste <emaste@freebsd.org> wrote:
>
> To confirm, I have another build running now with
> echo "Running with hw.ncpu=$(sysctl -n hw.ncpu)"
> added.

Confirmed - https://cirrus-ci.com/build/5768962257190912:
Running with hw.ncpu=8

If there is some sort of hanging test issue I could try wrapping it in
timeout and outputting ps and other info upon failure.
