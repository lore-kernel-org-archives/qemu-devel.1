Received: from eggs.gnu.org ([2001:4830:134:3::10]:58928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEofH-0004Zn-UA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 00:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gEofD-00008L-Ro
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 00:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gEofB-00005G-St
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 00:51:31 -0400
Date: Tue, 23 Oct 2018 10:21:13 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <31102692-e821-9fb2-c5fa-a6fd021e4c23@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1810231019220.24301@xnncv>
References: <20181022181035.20104-1-ppandit@redhat.com>
	<31102692-e821-9fb2-c5fa-a6fd021e4c23@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>

+-- On Tue, 23 Oct 2018, Philippe Mathieu-Daud=C3=A9 wrote --+
| > From: Prasad J Pandit <pjp@fedoraproject.org>
| >=20
| > Update v1: use ARRAY_SIZE macro
| >    -> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04826.=
html
| >=20
| > -        qemu_set_irq(s->handler[bit], (level >> bit) & 1);
| > +        if (bit < ARRAY_SIZE(s->handler)) {
| > +            qemu_set_irq(s->handler[bit], (level >> bit) & 1);
|=20
|            } else {
|                	qemu_log_mask(LOG_GUEST_ERROR, ...
|=20
| With that:
| Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thank you Philippe and Li.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
