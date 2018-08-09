Received: from eggs.gnu.org ([2001:4830:134:3::10]:49469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnivj-0006Ve-TZ
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnivf-0000DB-Qe
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:16:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59824 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnivf-0000Ct-Je
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 07:16:31 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-7-e.emanuelegiuseppe@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b25fe07a-6368-95bf-f283-ba931d888997@redhat.com>
Date: Thu, 9 Aug 2018 13:16:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180806143412.27722-7-e.emanuelegiuseppe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/34] tests/qgraph: sdhci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
> Convert tests/sdhci-test in first qgraph test node, sdhci-test. This test
> consumes an sdhci interface and checks that its function return the
> expected values.
> 
> Note that this test does not allocate any sdhci structure, it's all done by the
> qtest walking graph mechanism
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> ---
>  tests/Makefile.include |   9 +-
>  tests/sdhci-test.c     | 222 ++++++++++++-----------------------------
>  2 files changed, 68 insertions(+), 163 deletions(-)
...
> +
> +libqos_init(sdhci_test);

"libqos_init(register_sdhci_tests)"?

Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks,
Laurent
