Received: from eggs.gnu.org ([2001:4830:134:3::10]:50294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyZ0-0002cP-Cg
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFyYv-0004DL-Oq
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16291)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFyYt-0003zn-IU
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 05:37:49 -0400
Date: Fri, 26 Oct 2018 15:07:34 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA-Mp_ovLRzHFpUCTmd6r-bmGZ2-V3OHSxo+5Mg+zw2=aA@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810261507060.8270@xnncv>
References: <20181022181035.20104-1-ppandit@redhat.com>
	<CAFEAcA-6djmjK_x_n5z7cnicdgu+eeJF3QJw4iaCOMDLPkEJ7w@mail.gmail.com>
	<nycvar.YSQ.7.76.1810252239320.26372@xnncv>
	<CAFEAcA-Mp_ovLRzHFpUCTmd6r-bmGZ2-V3OHSxo+5Mg+zw2=aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>

+-- On Fri, 26 Oct 2018, Peter Maydell wrote --+
| > ===
| > diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
| > index ec2627374d..dd8c4b1f2e 100644
| > --- a/hw/arm/strongarm.c
| > +++ b/hw/arm/strongarm.c
| > @@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr
| > offset,
| >
| >      switch (offset) {
| >      case GPDR:        /* GPIO Pin-Direction registers */
| > -        s->dir = value;
| > +        s->dir = value & 0x3fffff;
| >          strongarm_gpio_handler_update(s);
| >          break;
| >
| >      case GPSR:        /* GPIO Pin-Output Set registers */
| > -        s->olevel |= value;
| > +        s->olevel |= value & 0x3fffff;
| >          strongarm_gpio_handler_update(s);
| >          break;
| > ===
| >
| > does this seem okay?
| 
| Yes, that's what I had in mind.

Cool, patch sent.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
