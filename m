Received: from eggs.gnu.org ([2001:4830:134:3::10]:47167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcUM-0006no-Cu
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcUH-0003XK-FQ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:22:34 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcUH-0003X3-Ak
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:22:29 -0400
Received: by mail-qt0-x244.google.com with SMTP id m13-v6so24208359qth.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:22:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712111221.20326-1-armbru@redhat.com>
	<20180712111221.20326-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e010f7e-38e0-2680-abfb-30ce9357f7e2@amsat.org>
Date: Thu, 12 Jul 2018 11:22:19 -0300
MIME-Version: 1.0
In-Reply-To: <20180712111221.20326-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 03/20] libqtest: Clean up how we read
 device_del messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 07/12/2018 08:12 AM, Markus Armbruster wrote:
> qtest_qmp_device_del() still uses the qmp("") hack to receive a
> message, even though we have qmp_receive() since commit 66e0c7b187e.
> Put it to use.
> 
> Bonus: gets rid of empty format strings.  A step towards compile-time
> format string checking without triggering -Wformat-zero-length.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/libqtest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/libqtest.c b/tests/libqtest.c
> index 9cb4096639..071d7eb7b1 100644
> --- a/tests/libqtest.c
> +++ b/tests/libqtest.c
> @@ -1090,7 +1090,7 @@ void qtest_qmp_device_del(const char *id)
>      g_assert(response1);
>      g_assert(!qdict_haskey(response1, "error"));
>  
> -    response2 = qmp("");
> +    response2 = qmp_receive();
>      g_assert(response2);
>      g_assert(!qdict_haskey(response2, "error"));
>  
> 
