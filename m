Received: from eggs.gnu.org ([2001:4830:134:3::10]:60636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnR9N-0003j1-Jl
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnR9M-0004oh-QX
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:40:41 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:38658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnR9M-0004oO-KI
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:40:40 -0400
Received: by mail-wm0-x233.google.com with SMTP id t189so41666262wmt.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 07:40:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489415605-13105-1-git-send-email-clg@kaod.org>
References: <1489415605-13105-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 15:40:18 +0100
Message-ID: <CAFEAcA_Ov-c7r4cvJ4yjW7szzGnV1Qe=EJxjCaS4=6bJWEy50Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: replace hweight_long() with ctpopl()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13 March 2017 at 15:33, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> ctpopl() has a better implementation than hweight_long() and ui/vnc.c
> being the last user of hweight_long(), we can simply remove it.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
