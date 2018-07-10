Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczaj-000190-GI
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczai-0001wE-NR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:50:33 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fczai-0001w2-IT
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 16:50:32 -0400
Received: by mail-qt0-x243.google.com with SMTP id a5-v6so5065511qtp.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 13:50:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180709152117.21585-1-alex.bennee@linaro.org>
	<20180709152117.21585-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dd497613-d307-1178-1e40-dd8afe26be73@amsat.org>
Date: Tue, 10 Jul 2018 17:50:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180709152117.21585-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 01/10] tests/.gitignore: don't
 ignore docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 07/09/2018 12:21 PM, Alex Bennée wrote:
> This was being a little over enthusiastic hiding files.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/.gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 08e2df1ce1..72c18aaab0 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -9,6 +9,7 @@ qht-bench
>  rcutorture
>  test-*
>  !test-*.c
> +!docker/test-*
>  test-qapi-commands.[ch]
>  test-qapi-events.[ch]
>  test-qapi-types.[ch]
> 
