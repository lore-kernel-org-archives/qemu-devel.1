Received: from eggs.gnu.org ([2001:4830:134:3::10]:44038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDVM-00051Z-QR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDVJ-0005WP-NF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:41:32 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDVJ-0005WJ-KF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:41:29 -0500
Received: by mail-qk0-x241.google.com with SMTP id x71so10012144qkb.0
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:41:29 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-14-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3fb86334-dd87-a7d1-ea7f-00d6ccb15b65@amsat.org>
Date: Tue, 21 Feb 2017 13:41:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/30] tests: fix ipmi-kcs-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 02/21/2017 11:14 AM, Marc-André Lureau wrote:
> Spotted by ASAN.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/ipmi-kcs-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/ipmi-kcs-test.c b/tests/ipmi-kcs-test.c
> index 9cf0b34a33..178ffc1797 100644
> --- a/tests/ipmi-kcs-test.c
> +++ b/tests/ipmi-kcs-test.c
> @@ -279,6 +279,7 @@ int main(int argc, char **argv)
>      cmdline = g_strdup_printf("-device ipmi-bmc-sim,id=bmc0"
>                                " -device isa-ipmi-kcs,bmc=bmc0");
>      qtest_start(cmdline);
> +    g_free(cmdline);
>      qtest_irq_intercept_in(global_qtest, "ioapic");
>      qtest_add_func("/ipmi/local/kcs_base", test_kcs_base);
>      qtest_add_func("/ipmi/local/kcs_abort", test_kcs_abort);
>
