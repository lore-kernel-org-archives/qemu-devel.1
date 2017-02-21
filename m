Received: from eggs.gnu.org ([2001:4830:134:3::10]:44302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWH-00063f-8X
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWE-0005hZ-6C
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:29 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWE-0005hT-2P
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:26 -0500
Received: by mail-qt0-x241.google.com with SMTP id b16so14886729qte.2
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:42:25 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-15-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3951110e-f03b-9f4e-bf14-e3ba37e101bd@amsat.org>
Date: Tue, 21 Feb 2017 13:42:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-15-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/30] tests: fix ipmi-bt-test leak
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
>  tests/ipmi-bt-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/ipmi-bt-test.c b/tests/ipmi-bt-test.c
> index e84dd6889b..7e21a9bbcb 100644
> --- a/tests/ipmi-bt-test.c
> +++ b/tests/ipmi-bt-test.c
> @@ -420,6 +420,7 @@ int main(int argc, char **argv)
>            " -device ipmi-bmc-extern,chardev=ipmi0,id=bmc0"
>            " -device isa-ipmi-bt,bmc=bmc0", emu_port);
>      qtest_start(cmdline);
> +    g_free(cmdline);
>      qtest_irq_intercept_in(global_qtest, "ioapic");
>      qtest_add_func("/ipmi/extern/connect", test_connect);
>      qtest_add_func("/ipmi/extern/bt_base", test_bt_base);
>
