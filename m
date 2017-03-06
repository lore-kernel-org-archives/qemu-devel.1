Received: from eggs.gnu.org ([2001:4830:134:3::10]:58827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpF9-0001Z8-TU
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckpF6-0003QP-Pl
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:47:49 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckpF6-0003Nw-JT
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 04:47:48 -0500
Received: by mail-wm0-x22d.google.com with SMTP id n11so59055640wma.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 01:47:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d5475df8-290b-07d4-d177-979d78850615@redhat.com>
References: <cover.1488504063.git.balaton@eik.bme.hu>
	<cc6a20fc4a2748f24920c03ce64ae34af0f61799.1488504063.git.balaton@eik.bme.hu>
	<d5475df8-290b-07d4-d177-979d78850615@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 09:47:24 +0000
Message-ID: <CAFEAcA90FRxghG0ZdH7H9y2bDk2U9XO1TUJgx0MN+N=7LzO5pQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 13/13] ppc: Add SM501 device in config
 for ppc and ppcemb targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 6 March 2017 at 07:00, Thomas Huth <thuth@redhat.com> wrote:
> Note: In case you respin the series, you might want to add this
> CONFIG_SM501 to ppc64-softmmu.mak, too, since it is a superset of the
> 32-bit config (i.e. it can also emulate the 32-bit embedded chips).

Yes, definitely do this please.
(Missed this because ARM's 64-bit default config includes the
32-bit one rather than duplicating its contents.)


thanks
-- PMM
