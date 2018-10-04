Received: from eggs.gnu.org ([2001:4830:134:3::10]:57732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g86nU-0003Mg-M7
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g86nS-0000Fm-Nf
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:48:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g86nR-0000Dk-3m
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:48:17 -0400
References: <20181004151429.7232-1-crosa@redhat.com>
	<20181004151429.7232-7-crosa@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e5506347-f4d3-0669-150b-4ac6d5642a43@redhat.com>
Date: Thu, 4 Oct 2018 18:48:07 +0200
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
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On 10/04/18 17:14, Cleber Rosa wrote:
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

(Side comment: you can parse json? :) That's awesome. Then I *am*
tempted to suggest that Philippe's work parse the firmware metadata
format, in the long run.)

Laszlo
