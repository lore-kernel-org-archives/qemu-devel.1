Received: from eggs.gnu.org ([2001:4830:134:3::10]:34517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9jK-0006F2-3X
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9jE-00061P-Kj
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:30 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk9jE-00060q-Gt
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 10:00:24 -0400
Received: by mail-qt0-x241.google.com with SMTP id 57so7368210qtu.0
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 07:00:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-29-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c484139-4462-9f61-b004-90f9be33c22b@amsat.org>
Date: Tue, 22 Aug 2017 11:00:19 -0300
MIME-Version: 1.0
In-Reply-To: <20170822132255.23945-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 28/54] qapi: do not define enumeration
 value explicitely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 08/22/2017 10:22 AM, Marc-André Lureau wrote:
> The C standard has the initial value at 0 and the subsequent values
> incremented by 1. No need to set this explicitely.
> 
> This will prevent from artificial "gaps" when compiling out some enum
> values and having unnecessarily large MAX values & enums arrays.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   scripts/qapi.py | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 52099332f1..9d075440d3 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1979,14 +1979,11 @@ typedef enum %(c_name)s {
>   ''',
>                   c_name=c_name(name))
>   
> -    i = 0
>       for value in enum_values:
>           ret += mcgen('''
> -    %(c_enum)s = %(i)d,
> +    %(c_enum)s,
>   ''',
> -                     c_enum=c_enum_const(name, value, prefix),
> -                     i=i)
> -        i += 1
> +                     c_enum=c_enum_const(name, value, prefix))
>   
>       ret += mcgen('''
>   } %(c_name)s;
> 
