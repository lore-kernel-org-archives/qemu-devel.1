Received: from eggs.gnu.org ([2001:4830:134:3::10]:60607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuST-0007Bu-7Z
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuSO-0006PT-57
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:41 -0500
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:40139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePuSO-0006P9-0O
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:11:36 -0500
Received: by mail-qk0-x232.google.com with SMTP id b123so11398448qkg.7
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 10:11:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-12-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <765d8d60-8812-b418-4bc9-5d382f5eb7bd@amsat.org>
Date: Fri, 15 Dec 2017 15:11:32 -0300
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 11/13] tests: fix qmp-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

On 12/15/2017 12:06 PM, Marc-André Lureau wrote:
> Direct leak of 913 byte(s) in 43 object(s) allocated from:
>     #0 0x55880a15df60 in __interceptor_malloc (/home/elmarco/src/qq/build/tests/qmp-test+0x110f60)
>     #1 0x7f3f20fd098f in _IO_vasprintf (/lib64/libc.so.6+0x8098f)
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/qmp-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qmp-test.c b/tests/qmp-test.c
> index c5a5c10b41..36feb2204b 100644
> --- a/tests/qmp-test.c
> +++ b/tests/qmp-test.c
> @@ -271,7 +271,7 @@ static void add_query_tests(QmpSchema *schema)
>  {
>      SchemaInfoList *tail;
>      SchemaInfo *si, *arg_type, *ret_type;
> -    const char *test_name;
> +    char *test_name;
>  
>      /* Test the query-like commands */
>      for (tail = schema->list; tail; tail = tail->next) {
> @@ -297,6 +297,7 @@ static void add_query_tests(QmpSchema *schema)
>  
>          test_name = g_strdup_printf("qmp/%s", si->name);
>          qtest_add_data_func(test_name, si->name, test_query);
> +        g_free(test_name);
>      }
>  }
>  
> 
