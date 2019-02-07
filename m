Received: from eggs.gnu.org ([209.51.188.92]:34760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1groFL-0001Ws-8M
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:18:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1groFK-0007G0-FD
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:17:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1groFK-0007FC-9D
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:17:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id z5so894563wmf.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:17:58 -0800 (PST)
References: <20190207180012.27303-1-crosa@redhat.com>
	<20190207180012.27303-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <688cc2db-bb65-b8ff-3a48-483e35cae17c@redhat.com>
Date: Thu, 7 Feb 2019 19:17:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190207180012.27303-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] Acceptance tests: depend on qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Samuel Ortiz <sameo@linux.intel.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

FWIW, Cc'ing qemu-img maintainers.

On 2/7/19 7:00 PM, Cleber Rosa wrote:
> Tests using the avocado.utils.vmimage library make use of qemu-img,
> and because it makes sense to use the version matching the rest of the
> source code, let's make sure it gets built.
> 
> Its selection, instead of a possible qemu-img binary installed system
> wide, is already dealt with by the change that adds the build dir to
> the PATH during the test execution.
> 
> This is based on the same work for qemu-iotests, and suggested by its
> author:
> 
>   - https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00951.html
> 
> CC: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b39e989f72..9a2fb94f4a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1111,7 +1111,7 @@ $(TESTS_RESULTS_DIR):
>  
>  check-venv: $(TESTS_VENV_DIR)
>  
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) qemu-img$(EXESUF)
>  	$(call quiet-command, \
>              $(TESTS_VENV_DIR)/bin/python -m avocado \
>              --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
> 
