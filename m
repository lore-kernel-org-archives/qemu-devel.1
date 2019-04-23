Received: from eggs.gnu.org ([209.51.188.92]:48350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyIe-0004OC-5Q
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIyEK-0003YA-9O
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hIyEK-0003XX-1h
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 12:25:12 -0400
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-2-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8cb7159d-8517-65f0-a117-81e03097f4f1@redhat.com>
Date: Tue, 23 Apr 2019 18:25:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190420100056.116305-2-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] tests: refactor fw_cfg_test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com, philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com
Cc: qemu-devel@nongnu.org, liq3ea@gmail.com

On 20/04/2019 12.00, Li Qiang wrote:
> Currently, fw_cfg_test uses one QTestState for every test case.
> This will add all command lines for every test case and
> this is unnecessary. This patch split the test cases and for
> every test case it uses his own QTestState. This patch does following
> things:
> 
> 1. Get rid of the global 'fw_cfg', this need add a uninit function
> 
> 2. Convert every test case in a separate QTestState
> 
> After this patch, we can add fw_cfg test case freely and will not
> have efect other test cases.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/fw_cfg-test.c   | 86 ++++++++++++++++++++++++++++++++++++++-----
>  tests/libqos/fw_cfg.c | 10 +++++
>  tests/libqos/fw_cfg.h |  7 ++++
>  3 files changed, 94 insertions(+), 9 deletions(-)

Sounds like a good idea.

Acked-by: Thomas Huth <thuth@redhat.com>
