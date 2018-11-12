Received: from eggs.gnu.org ([2001:4830:134:3::10]:46166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gMGQU-0002QO-0N
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:55:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gMGNS-0005Yf-70
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:52:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gMGNQ-0005SR-Bw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:51:56 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-5-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <fad0f7da-8f3d-0ed2-4795-1145ff7a72d9@redhat.com>
Date: Mon, 12 Nov 2018 15:51:27 -0200
MIME-Version: 1.0
In-Reply-To: <20181109150710.31085-5-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>


On 11/09/2018 01:07 PM, Cleber Rosa wrote:
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

Hi Cleber!

I would leave "tests" to the description, then it becomes:
"Run unit, qapi-schema, qtest and decodetree tests"

Note: there isn't an entry for check-decodetree on the help. You may 
want to address it in this patch (or I can send in a separate patch).

Overall, this patch series looks good for me. I tested patches 1, 2 and 
4 on Fedora 29. So:

Tested-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

- Wainer

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
