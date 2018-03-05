Received: from eggs.gnu.org ([2001:4830:134:3::10]:44438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1estjM-0000hp-5i
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1estjL-0007Po-BZ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:16:56 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1estjL-0007PZ-5L
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 12:16:55 -0500
Received: by mail-oi0-x22c.google.com with SMTP id e9so5976028oii.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 09:16:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520266949-29817-1-git-send-email-thuth@redhat.com>
References: <1520266949-29817-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 17:16:33 +0000
Message-ID: <CAFEAcA8OZOCG-nhdWrw3D_KJ4OC5R87asV8-e4Ydpez1gUf1fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm: Use more CONFIG switches for
 the object files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 5 March 2018 at 16:22, Thomas Huth <thuth@redhat.com> wrote:
> A lot of ARM object files are linked into the executable unconditionally,
> even though we have corresponding CONFIG switches like CONFIG_PXA2XX or
> CONFIG_OMAP. We should make sure to use these switches in the Makefile so
> that the users can disable certain unwanted boards and devices more easily.
> While we're at it, also add some new switches for the boards that do not
> have a CONFIG option yet.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Fixed the miscategorization of the boards in v1
>  - Add separate config switches for the boards that did not have a
>    config switch yet.

You could argue that the 'virt' board ought to have a CONFIG_VIRT
I suppose, but personally I think our config setup is an unmaintained
mess anyway that really just boils down to "enable everything", so
I don't care very much.

Applied, thanks.

-- PMM
