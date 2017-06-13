Received: from eggs.gnu.org ([2001:4830:134:3::10]:41156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKjAt-0007lR-Sq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dKjAt-0001pA-5x
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:35:51 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34151)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dKjAs-0001ow-VD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:35:51 -0400
Received: by mail-wr0-x22a.google.com with SMTP id g76so131018327wrd.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 03:35:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1496739312-32304-1-git-send-email-clg@kaod.org>
References: <1496739312-32304-1-git-send-email-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 11:35:23 +0100
Message-ID: <CAFEAcA83mqkBv+=d9SH=zLRUu01ajTOXiQkZXtNbmvHw1HHLRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix timer enablement when a
 reload is not set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 09:55, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> When a timer is enabled before a reload value is set, the controller
> waits for a reload value to be set before starting decrementing. This
> fix tries to cover that case by changing the timer expiry only when
> a reload value is valid.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/timer/aspeed_timer.c | 37 +++++++++++++++++++++++++++++--------
>  1 file changed, 29 insertions(+), 8 deletions(-)

Applied to target-arm.next, thanks.

-- PMM
