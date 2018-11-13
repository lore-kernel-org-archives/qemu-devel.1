Received: from eggs.gnu.org ([2001:4830:134:3::10]:43305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMSDH-0001gy-2i
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMSDC-0000X0-Nx
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:30:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMSDC-0000Vc-FJ
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 01:30:10 -0500
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-2-contrib@steffen-goertz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <58e1ef22-0501-2fbf-f0ad-d8852042f2a3@redhat.com>
Date: Tue, 13 Nov 2018 07:30:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181112214224.31560-2-contrib@steffen-goertz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/14] qtest: Add set_irq_in command to
 set IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-11-12 22:42, Steffen G=C3=B6rtz wrote:
> Adds a new qtest command "set_irq_in" which allows
> to set qemu gpio lines to a given level.
>=20
> Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363=
.html
> which never got merged.
>=20
> Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qtest.c          | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/libqtest.c | 10 ++++++++++
>  tests/libqtest.h | 13 +++++++++++++
>  3 files changed, 66 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>
