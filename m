Received: from eggs.gnu.org ([2001:4830:134:3::10]:49137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnvyQ-00033p-RM
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnvyL-0005Yt-Tk
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:07:42 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnvyL-0005Yd-PI
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 20:07:37 -0400
Received: by mail-qk0-x244.google.com with SMTP id l65so1212314qkc.3
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 17:07:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-27-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8e442540-5f6e-bb7a-2b85-0f805884a6bc@amsat.org>
Date: Fri, 1 Sep 2017 21:07:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-27-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 26/29] fw_cfg-test: Drop dependence on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

On 09/01/2017 03:03 PM, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  It turns out that with the
> recent changes to libqos, fw_cfg-test was not even using
> global_qtest any more.  Avoid a pointless strdup while at it.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/fw_cfg-test.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 47596c57a1..3a8dc7a2cd 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -102,14 +102,11 @@ static void test_fw_cfg_boot_menu(void)
>   int main(int argc, char **argv)
>   {
>       QTestState *s;
> -    char *cmdline;
>       int ret;
> 
>       g_test_init(&argc, &argv, NULL);
> 
> -    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
> -    s = qtest_start(cmdline);
> -    g_free(cmdline);
> +    s = qtest_init("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8");
> 
>       fw_cfg = pc_fw_cfg_init(s);
> 
