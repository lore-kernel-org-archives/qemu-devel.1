Received: from eggs.gnu.org ([209.51.188.92]:59232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glYP9-0006XK-DU
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1glYP8-0005pc-OZ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:10:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1glYP8-0005n1-C4
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:10:14 -0500
References: <20190117161640.5496-1-jusual@mail.ru>
	<20190117161640.5496-3-jusual@mail.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76792f5c-0174-58e3-7fb0-73790d9dded1@redhat.com>
Date: Mon, 21 Jan 2019 13:09:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190117161640.5496-3-jusual@mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] tests/microbit-test: Make test
 independent of global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>

On 2019-01-17 17:16, Julia Suvorova wrote:
> Using of global_qtest is not required here. Let's replace functions like
> readl() with the corresponding qtest_* counterparts.
> 
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  tests/microbit-test.c | 247 ++++++++++++++++++++++--------------------
>  1 file changed, 129 insertions(+), 118 deletions(-)

Great, thank you!

Acked-by: Thomas Huth <thuth@redhat.com>
