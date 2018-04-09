Received: from eggs.gnu.org ([2001:4830:134:3::10]:42367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5T2S-0005CA-8R
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:24:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5T2R-00066n-Ee
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:24:36 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:45642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5T2R-00066c-9n
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:24:35 -0400
Received: by mail-oi0-x233.google.com with SMTP id 71-v6so6922860oie.12
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 02:24:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409083154.GD18283@redhat.com>
References: <20180409082323.29575-1-peterx@redhat.com>
	<20180409083154.GD18283@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Apr 2018 10:24:14 +0100
Message-ID: <CAFEAcA-VS=b31Z=WZEO3sDLntA97px81ErVRZbHcSTxRe1YNEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: don't warn GTK if disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 9 April 2018 at 09:31, Daniel P. Berrang=C3=A9 <berrange@redhat.com> wro=
te:
> Feels to me that since we've deprecated 2.0, we could just *never* auto
> detect - just do     test -z "$gtkabi" && gtkabi=3D3.0
>
> Anyone who wants gtk2 should have to use an explicit --with-gtkabi=3D2.0

I think if we still work with gtk2 then we should go ahead and
warn-but-use it.

thanks
-- PMM
