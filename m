Received: from eggs.gnu.org ([2001:4830:134:3::10]:47511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHRdh-0008UJ-1F
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHRdc-0004iV-0n
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHRdb-0004dH-LS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 06:52:43 -0400
References: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
	<1540873732-3503-3-git-send-email-liq3ea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8554a03c-4409-c7f5-bd9e-613d03779e73@redhat.com>
Date: Tue, 30 Oct 2018 11:52:31 +0100
MIME-Version: 1.0
In-Reply-To: <1540873732-3503-3-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: fw_cfg: add reboot_timeout
 test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, thuth@redhat.com, lvivier@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org

On 30/10/2018 05:28, Li Qiang wrote:
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  tests/fw_cfg-test.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 1c5103fe1c..aeabd17ec0 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -99,6 +99,15 @@ static void test_fw_cfg_boot_menu(void)
>      g_assert_cmpint(qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_MENU), ==, boot_menu);
>  }
>  
> +static void test_fw_cfg_reboot_timeout(void)
> +{
> +    uint32_t reboot_timeout;
> +
> +    qfw_cfg_get_file(fw_cfg, "etc/boot-fail-wait",
> +                     &reboot_timeout, sizeof(reboot_timeout));
> +    g_assert_cmpint(reboot_timeout, <=, 65535);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      QTestState *s;
> @@ -125,6 +134,7 @@ int main(int argc, char **argv)
>      qtest_add_func("fw_cfg/max_cpus", test_fw_cfg_max_cpus);
>      qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>      qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> +    qtest_add_func("fw_cfg/reboot_timeout", test_fw_cfg_reboot_timeout);
>  
>      ret = g_test_run();

This test is not doing much; you could add "-boot reboot-timeout=15" and
check the value.

Paolo
