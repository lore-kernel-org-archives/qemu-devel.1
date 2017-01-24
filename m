Received: from eggs.gnu.org ([2001:4830:134:3::10]:42091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVzXZ-0000BN-Sw
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cVzXY-0007fA-JQ
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:45:33 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:34017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cVzXY-0007er-F1
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:45:32 -0500
Received: by mail-vk0-x232.google.com with SMTP id r136so110057708vke.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 03:45:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484751701-2646-1-git-send-email-clg@kaod.org>
References: <1484751701-2646-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 11:45:11 +0000
Message-ID: <CAFEAcA9Ata6d-zECUvrMeq8OPG2QYn_ek8g1TC4U1ZG4i=NsUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] aspeed/smc: handle dummy bytes when
 doing fast reads in command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Marcin Krzeminski <mar.krzeminski@gmail.com>

On 18 January 2017 at 15:01, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> When doing fast read, a certain amount of dummy bytes should be sent
> before the read. This number is configurable in the controler CE0
> Control Register and needs to be modeled using fake transfers to the
> flash module.
>
> This only supports command mode. User mode requires more work and a
> possible extension of the m25p80 device model.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>



Applied to target-arm.next, thanks.

-- PMM
