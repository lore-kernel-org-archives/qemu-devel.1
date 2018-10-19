Received: from eggs.gnu.org ([2001:4830:134:3::10]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDPlP-0004GN-8b
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDPlL-00023o-LP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:04:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gDPlL-0001xx-9s
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 04:04:03 -0400
Date: Fri, 19 Oct 2018 10:04:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181019080400.lu46ohp4qmpp4otr@sirius.home.kraxel.org>
References: <20181015032642.16411-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015032642.16411-1-maozhongyi@cmss.chinamobile.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] use object link instead of qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Mon, Oct 15, 2018 at 11:26:39AM +0800, Mao Zhongyi wrote:
> According to qdev-properties.h, properties of pointer type
> should be avoid, so convert qdev property to link, Whilst we
> are here, also update some hardcoded strings with already
> defineded macros.

Patch series breaks "make check".

cheers,
  Gerd
