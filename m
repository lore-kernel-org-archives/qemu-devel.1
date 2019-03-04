Received: from eggs.gnu.org ([209.51.188.92]:55537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0mp8-0005n3-36
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:36:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0mp7-0006Db-5a
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:36:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0mp6-0006Bw-Vp
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:36:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so3907960wmc.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 04:36:00 -0800 (PST)
References: <20181218113717.29130-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <68d432c9-4cd2-acc0-57d7-209aebc62e82@redhat.com>
Date: Mon, 4 Mar 2019 13:35:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181218113717.29130-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tests: Move qdict-test-data.txt to
 tests/data/qobject/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Cc'ing qemu-trivial@

On 12/18/18 12:37 PM, Philippe Mathieu-Daudé wrote:
> Move qdict-test-data.txt to the tests/data/qobject/ subdirectory,
> and remove the unnecessary symlinking.
> (See 4b2ff65a1f3 for similar test-data cleanup).
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS                                         | 1 +
>  configure                                           | 2 +-
>  tests/check-qdict.c                                 | 2 +-
>  qdict-test-data.txt => tests/data/qobject/qdict.txt | 0
>  4 files changed, 3 insertions(+), 2 deletions(-)
>  rename qdict-test-data.txt => tests/data/qobject/qdict.txt (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83c127f0d6..269427c3f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1891,6 +1891,7 @@ F: tests/check-qnum.c
>  F: tests/check-qjson.c
>  F: tests/check-qlist.c
>  F: tests/check-qstring.c
> +F: tests/data/qobject/qdict.txt
>  T: git https://repo.or.cz/qemu/armbru.git qapi-next
>  
>  QEMU Guest Agent
> diff --git a/configure b/configure
> index 224d3071ac..8022f4b999 100755
> --- a/configure
> +++ b/configure
> @@ -7534,7 +7534,7 @@ DIRS="$DIRS tests/fp"
>  DIRS="$DIRS docs docs/interop fsdev scsi"
>  DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>  DIRS="$DIRS roms/seabios roms/vgabios"
> -LINKS="Makefile tests/tcg/Makefile qdict-test-data.txt"
> +LINKS="Makefile tests/tcg/Makefile"
>  LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
>  LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
>  LINKS="$LINKS tests/fp/Makefile"
> diff --git a/tests/check-qdict.c b/tests/check-qdict.c
> index a1e8305066..b5efa859b0 100644
> --- a/tests/check-qdict.c
> +++ b/tests/check-qdict.c
> @@ -291,7 +291,7 @@ static void qdict_stress_test(void)
>      FILE *test_file;
>      QDict *qdict;
>      QString *value;
> -    const char *test_file_path = "qdict-test-data.txt";
> +    const char *test_file_path = "tests/data/qobject/qdict.txt";
>  
>      test_file = fopen(test_file_path, "r");
>      g_assert(test_file != NULL);
> diff --git a/qdict-test-data.txt b/tests/data/qobject/qdict.txt
> similarity index 100%
> rename from qdict-test-data.txt
> rename to tests/data/qobject/qdict.txt
> 
