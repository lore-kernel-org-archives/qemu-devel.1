Received: from eggs.gnu.org ([2001:4830:134:3::10]:41647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Stt-0007XA-16
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8Stp-0003Qs-SX
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:24:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8Stn-0003FC-Ux
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:24:20 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so4103273wmd.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 09:24:18 -0700 (PDT)
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d81c7840-efd9-336c-9538-b032d6c54bdb@redhat.com>
Date: Fri, 5 Oct 2018 18:24:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181004151429.7232-7-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Hi Cleber,

On 04/10/2018 17:14, Cleber Rosa wrote:
> One of the Avocado features relevant to virtualization testing is the
> ability to reuse tests in different scenarios, known as variants.
> This adds a JSON based variants file, that can be used to run most
> tests in a number of different architectures.  It can be run with:
> 
>    $ avocado run \
>      --json-variants-load=tests/acceptance/variants/arch.json \
>      --filter-by-tags='-x86_64' -- tests/acceptance/
> 
> Currently this covers 5 architectures, resulting in the execution
> of 25 different combinations.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/variants/arch.json | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 tests/acceptance/variants/arch.json
> 
> diff --git a/tests/acceptance/variants/arch.json b/tests/acceptance/variants/arch.json
> new file mode 100644
> index 0000000000..a7a2570553
> --- /dev/null
> +++ b/tests/acceptance/variants/arch.json
> @@ -0,0 +1 @@
> +[{"paths":["/run/*"],"variant":[["/run/aarch64",[["/run/aarch64", "arch", "aarch64"]]]],"variant_id": "aarch64"},{"paths":["/run/*"],"variant":[["/run/ppc",[["/run/ppc", "arch", "ppc"]]]],"variant_id": "ppc"},{"paths":["/run/*"],"variant":[["/run/ppc64",[["/run/ppc64", "arch", "ppc64"]]]],"variant_id": "ppc64"},{"paths":["/run/*"],"variant":[["/run/s390x",[["/run/s390x", "arch", "s390x"]]]],"variant_id": "s390x"},{"paths":["/run/*"],"variant":[["/run/x86_64",[["/run/x86_64", "arch", "x86_64"]]]],"variant_id": "x86_64"}]
> 

Is this generated? (thinking about the other archs supported).

You should use some linter ;)
