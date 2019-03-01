Received: from eggs.gnu.org ([209.51.188.92]:51865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzmPd-0007p0-Fs
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:57:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzmPc-0002a8-G9
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 12:57:33 -0500
References: <1551456970-463-1-git-send-email-thuth@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <74a6796e-1242-69dd-a74d-74525955f100@redhat.com>
Date: Fri, 1 Mar 2019 12:57:19 -0500
MIME-Version: 1.0
In-Reply-To: <1551456970-463-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: Remove (mostly) useless
 architecture checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>



On 3/1/19 11:16 AM, Thomas Huth wrote:
> These checks at the beginning of some of the tests are mostly useless:
> We only run the tests on x86 anyway, and g_test_message() does not
> print anything unless you call g_test_init() first.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/fdc-test.c      | 7 -------
>  tests/ide-test.c      | 7 -------
>  tests/ipmi-bt-test.c  | 7 -------
>  tests/ipmi-kcs-test.c | 7 -------
>  4 files changed, 28 deletions(-)
> 
> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
> index 88f1abf..31cd329 100644
> --- a/tests/fdc-test.c
> +++ b/tests/fdc-test.c
> @@ -548,16 +548,9 @@ static void fuzz_registers(void)
>  
>  int main(int argc, char **argv)
>  {
> -    const char *arch = qtest_get_arch();
>      int fd;
>      int ret;
>  
> -    /* Check architecture */
> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> -        g_test_message("Skipping test for non-x86\n");
> -        return 0;
> -    }
> -
>      /* Create a temporary raw image */
>      fd = mkstemp(test_image);
>      g_assert(fd >= 0);
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index f0280e6..300d64e 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -1009,16 +1009,9 @@ static void test_cdrom_dma(void)
>  
>  int main(int argc, char **argv)
>  {
> -    const char *arch = qtest_get_arch();
>      int fd;
>      int ret;
>  
> -    /* Check architecture */
> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> -        g_test_message("Skipping test for non-x86\n");
> -        return 0;
> -    }
> -
>      /* Create temporary blkdebug instructions */
>      fd = mkstemp(debug_path);
>      g_assert(fd >= 0);
> diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
> index f4a81b5..fc4c83b 100644
> --- a/tests/ipmi-bt-test.c
> +++ b/tests/ipmi-bt-test.c
> @@ -400,15 +400,8 @@ static void open_socket(void)
>  
>  int main(int argc, char **argv)
>  {
> -    const char *arch = qtest_get_arch();
>      int ret;
>  
> -    /* Check architecture */
> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> -        g_test_message("Skipping test for non-x86\n");
> -        return 0;
> -    }
> -
>      open_socket();
>  
>      /* Run the tests */
> diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
> index 178ffc1..a2354c1 100644
> --- a/tests/ipmi-kcs-test.c
> +++ b/tests/ipmi-kcs-test.c
> @@ -263,16 +263,9 @@ static void test_enable_irq(void)
>  
>  int main(int argc, char **argv)
>  {
> -    const char *arch = qtest_get_arch();
>      char *cmdline;
>      int ret;
>  
> -    /* Check architecture */
> -    if (strcmp(arch, "i386") && strcmp(arch, "x86_64")) {
> -        g_test_message("Skipping test for non-x86\n");
> -        return 0;
> -    }
> -
>      /* Run the tests */
>      g_test_init(&argc, &argv, NULL);
>  
> 

Hm, if you insist. I have no strong feelings... Do we plan to split
tests out by architecture eventually? Clearly x86 only tests don't
really need to each individually check the arch, but I'm not sure what
the vision is.

Either way, since I have no horse in the race:

Acked-by: John Snow <jsnow@redhat.com>
