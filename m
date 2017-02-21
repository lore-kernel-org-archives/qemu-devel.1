Received: from eggs.gnu.org ([2001:4830:134:3::10]:44518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWl-0006Yv-08
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWh-0005oB-TS
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:59 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cgDWh-0005o6-PG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:42:55 -0500
Received: by mail-qt0-x242.google.com with SMTP id x35so7635272qtc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 08:42:55 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-19-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8651fcbd-9f36-0fc4-0024-15ca8f93789d@amsat.org>
Date: Tue, 21 Feb 2017 13:42:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 18/30] tests: fix e1000-test leak
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
>  tests/e1000-test.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tests/e1000-test.c b/tests/e1000-test.c
> index 59cab68a60..0c5fcdcc44 100644
> --- a/tests/e1000-test.c
> +++ b/tests/e1000-test.c
> @@ -44,6 +44,7 @@ int main(int argc, char **argv)
>
>          path = g_strdup_printf("e1000/%s", models[i]);
>          qtest_add_data_func(path, models[i], test_device);
> +        g_free(path);
>      }
>
>      return g_test_run();
>
