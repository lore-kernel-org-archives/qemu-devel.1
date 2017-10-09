Received: from eggs.gnu.org ([2001:4830:134:3::10]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e1aeK-0004Zz-IY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1e1aeG-0002ZA-Hr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:11:24 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:62494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1e1aeG-0002Xl-7y
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:11:20 -0400
References: <20171009151926.1708-1-alex.bennee@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <96ec6b84-4437-74ce-7ce1-f844fa150fc3@vivier.eu>
Date: Mon, 9 Oct 2017 18:11:09 +0200
MIME-Version: 1.0
In-Reply-To: <20171009151926.1708-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] linux-user/main: support dfilter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

Le 09/10/2017 à 17:19, Alex Bennée a écrit :
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 829f974662..5072aa855b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -3854,6 +3854,11 @@ static void handle_arg_log(const char *arg)
>      qemu_set_log(mask);
>  }
>  
> +static void handle_arg_dfilter(const char *arg)
> +{
> +    qemu_set_dfilter_ranges(arg, NULL);
> +}
> +
>  static void handle_arg_log_filename(const char *arg)
>  {
>      qemu_set_log_filename(arg, &error_fatal);
> @@ -4054,6 +4059,8 @@ static const struct qemu_argument arg_table[] = {
>      {"d",          "QEMU_LOG",         true,  handle_arg_log,
>       "item[,...]", "enable logging of specified items "
>       "(use '-d help' for a list of items)"},
> +    {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
> +     "range[,...]","filter logging based on address range"},
>      {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
>       "logfile",     "write logs to 'logfile' (default stderr)"},
>      {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
> 

It's really an interesting feature, I think it will be very useful to
debug linux-user QEMU.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
