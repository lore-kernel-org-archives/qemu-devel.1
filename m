Received: from eggs.gnu.org ([2001:4830:134:3::10]:47122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gLCW5-0002wO-8O
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:32:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gLCVr-0003qa-8L
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:32:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gLCVq-0003nn-Dq
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:32:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so4441037wmb.0
	for <qemu-devel@nongnu.org>; Fri, 09 Nov 2018 11:32:10 -0800 (PST)
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-5-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b844b59a-fc49-5f14-c22d-1ec4ee283c1a@redhat.com>
Date: Fri, 9 Nov 2018 20:32:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181109150710.31085-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/4] check-help: visual and content
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Caio Carrara <ccarrara@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

On 9/11/18 16:07, Cleber Rosa wrote:
> The "check" target is not a target that will run all other tests
> listed, so in order to be accurate it's necessary to list those that
> will run.  The same is true for "check-clean".
> 
> Then, to give a better visual impression of the differences in the
> various targets, let's add empty lines.
> 
> Finally, a small (and hopeful) grammar fix from a non-native speaker.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   tests/Makefile.include | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c0a341c923..552faf9bbe 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -3,7 +3,8 @@
>   check-help:
>   	@echo "Regression testing targets:"
>   	@echo
> -	@echo " $(MAKE) check                Run all tests"
> +	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
> +	@echo
>   	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
>   	@echo " $(MAKE) check-qtest          Run qtest tests"
>   	@echo " $(MAKE) check-unit           Run qobject tests"
> @@ -12,12 +13,13 @@ check-help:
>   	@echo " $(MAKE) check-block          Run block tests"
>   	@echo " $(MAKE) check-tcg            Run TCG tests"
>   	@echo " $(MAKE) check-acceptance     Run all acceptance (functional) tests"
> +	@echo
>   	@echo " $(MAKE) check-report.html    Generates an HTML test report"
>   	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
> -	@echo " $(MAKE) check-clean          Clean the tests"
> +	@echo " $(MAKE) check-clean          Clean the tests and related data"
>   	@echo
>   	@echo "Please note that HTML reports do not regenerate if the unit tests"
> -	@echo "has not changed."
> +	@echo "have not changed."
>   	@echo
>   	@echo "The variable SPEED can be set to control the gtester speed setting."
>   	@echo "Default options are -k and (for $(MAKE) V=1) --verbose; they can be"
> 
