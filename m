Received: from eggs.gnu.org ([2001:4830:134:3::10]:45730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eDQuu-00075v-AW
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 03:13:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eDQut-0007mq-5N
	for qemu-devel@nongnu.org; Sat, 11 Nov 2017 03:13:28 -0500
Date: Sat, 11 Nov 2017 13:43:14 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <7441e865-c6d7-7fbf-3175-63ebdf7291e7@amsat.org>
Message-ID: <nycvar.YSQ.7.76.1711111341320.32164@wniryva>
References: <20171109115814.28232-1-ppandit@redhat.com>
	<7441e865-c6d7-7fbf-3175-63ebdf7291e7@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] highbank: validate register
 offset before access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Moguofang <moguofang@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robh@kernel.org>

  Hello Philippe,

+-- On Fri, 10 Nov 2017, Philippe Mathieu-Daud=C3=A9 wrote --+
| I'd report that:
|=20
|            qemu_log_mask(LOG_UNIMP, ...
|=20
| Cc'ing Shawn & Rob since this might also be a LOG_GUEST_ERROR.
|=20
| Mixed declarations (interleaving statements and declarations within
| blocks) are generally not allowed; declarations should be at the
| beginning of blocks.

Done. Sent a revised patch v1.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
