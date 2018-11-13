Received: from eggs.gnu.org ([2001:4830:134:3::10]:32803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMVA1-0005Wc-Fo
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:39:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gMV9x-0005Qo-9n
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:39:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gMV9v-0005PR-Bq
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 04:38:59 -0500
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-2-contrib@steffen-goertz.de>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5f097f63-6a53-d468-1071-3956a7aa9c04@redhat.com>
Date: Tue, 13 Nov 2018 10:38:54 +0100
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 12/11/2018 22:42, Steffen G=C3=B6rtz wrote:
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
>=20

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
