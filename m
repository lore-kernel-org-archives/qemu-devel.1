Received: from eggs.gnu.org ([2001:4830:134:3::10]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC5o-00070A-6Z
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:51:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAC5k-0000Da-N6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:51:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAC5k-000094-F6
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:51:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so5160241wru.8
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:51:44 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f1fcec57-e7a6-378f-3d8e-88d4976634c0@redhat.com>
Date: Wed, 10 Oct 2018 12:51:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-7-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] Acceptance Tests: add variants
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

Hi Cleber,

On 10/10/2018 01:26, Cleber Rosa wrote:
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

Can you provide here the command you used to generate this JSON?

Thanks,

Phil.

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/variants/arch.json | 92 +++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 tests/acceptance/variants/arch.json
> 
> diff --git a/tests/acceptance/variants/arch.json b/tests/acceptance/variants/arch.json
> new file mode 100644
> index 0000000000..64ff6ad278
> --- /dev/null
> +++ b/tests/acceptance/variants/arch.json
> @@ -0,0 +1,92 @@
> +[
> +    {
> +        "paths": [
> +            "/run/*"
> +        ],
> +        "variant": [
> +            [
> +                "/run/aarch64",
> +                [
> +                    [
> +                        "/run/aarch64",
> +                        "arch",
> +                        "aarch64"
> +                    ]
> +                ]
> +            ]
> +        ],
> +        "variant_id": "aarch64"
> +    },
> +    {
> +        "paths": [
> +            "/run/*"
> +        ],
> +        "variant": [
> +            [
> +                "/run/ppc",
> +                [
> +                    [
> +                        "/run/ppc",
> +                        "arch",
> +                        "ppc"
> +                    ]
> +                ]
> +            ]
> +        ],
> +        "variant_id": "ppc"
> +    },
> +    {
> +        "paths": [
> +            "/run/*"
> +        ],
> +        "variant": [
> +            [
> +                "/run/ppc64",
> +                [
> +                    [
> +                        "/run/ppc64",
> +                        "arch",
> +                        "ppc64"
> +                    ]
> +                ]
> +            ]
> +        ],
> +        "variant_id": "ppc64"
> +    },
> +    {
> +        "paths": [
> +            "/run/*"
> +        ],
> +        "variant": [
> +            [
> +                "/run/s390x",
> +                [
> +                    [
> +                        "/run/s390x",
> +                        "arch",
> +                        "s390x"
> +                    ]
> +                ]
> +            ]
> +        ],
> +        "variant_id": "s390x"
> +    },
> +    {
> +        "paths": [
> +            "/run/*"
> +        ],
> +        "variant": [
> +            [
> +                "/run/x86_64",
> +                [
> +                    [
> +                        "/run/x86_64",
> +                        "arch",
> +                        "x86_64"
> +                    ]
> +                ]
> +            ]
> +        ],
> +        "variant_id": "x86_64"
> +    }
> +]
> 
