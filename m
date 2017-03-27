Received: from eggs.gnu.org ([2001:4830:134:3::10]:54761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVt9-00036j-Qu
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVt5-0004Vr-TY
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:44:55 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1csVt5-0004Vc-Ph
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 10:44:51 -0400
Received: by mail-qk0-x243.google.com with SMTP id f11so5206980qkb.2
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:44:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170327084612.8998-1-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <04473219-8704-ee0d-da64-ef927e5eb017@amsat.org>
Date: Mon, 27 Mar 2017 11:44:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170327084612.8998-1-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] slirp: fix compilation errors with DEBUG
 set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org

On 03/27/2017 05:46 AM, Laurent Vivier wrote:
> slirp/slirp.c: In function 'get_dns_addr_resolv_conf':
> slirp/slirp.c:202:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>                  char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
>                              ^~~~~~~~~
> slirp/slirp.c:204:25: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>                      res = "(string conversion error)";
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  slirp/slirp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/slirp/slirp.c b/slirp/slirp.c
> index 60539de..5a94b06 100644
> --- a/slirp/slirp.c
> +++ b/slirp/slirp.c
> @@ -198,7 +198,7 @@ static int get_dns_addr_resolv_conf(int af, void *pdns_addr, void *cached_addr,
>  #ifdef DEBUG
>              else {
>                  char s[INET6_ADDRSTRLEN];
> -                char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
> +                const char *res = inet_ntop(af, tmp_addr, s, sizeof(s));
>                  if (!res) {
>                      res = "(string conversion error)";
>                  }
>
