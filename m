Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHvh9-0002wI-Cu
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHvh8-0000H3-Jl
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:49:19 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:35153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHvh8-0000Gl-DV
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:49:18 -0500
Received: by mail-ua0-x231.google.com with SMTP id 12so43470217uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 08:49:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480441323-31417-1-git-send-email-clg@kaod.org>
References: <1480441323-31417-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 16:48:57 +0000
Message-ID: <CAFEAcA9SVh-pUS+mnPWBYgWR9is49ysh9O_y35K-x2iyDwhfNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/4] FTGMAC100 model for the Aspeed SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Dmitry Fleytman <dmitry@daynix.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 29 November 2016 at 17:41, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The Aspeed SoCs AST2400 and AST2500 have two FTGMAC100 ethernet
> controllers. This serie proposes a model for this device and a way to
> customize the bit definitions which are slightly different from the
> Faraday definitions.
>
> The last patch adds a fake NC-SI (Network Controller Sideband
> Interface) backend to pretend a NIC is being managed.

Could you explain in a bit more detail why the patchset is
marked "RFC" and what parts you want comments on? (An RFC
patchset that doesn't say this kind of thing in the cover letter
is dangerously close to being a "please ignore me" request :-))

thanks
-- PMM
