Received: from eggs.gnu.org ([2001:4830:134:3::10]:48452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxkW-0000cJ-NC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxkT-0005um-Jk
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:35:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1500158641-23033-1-git-send-email-peng.hao2@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <953bc962-9929-c933-e0df-678a7e6a4c60@amsat.org>
Date: Mon, 17 Jul 2017 01:35:05 -0300
MIME-Version: 1.0
In-Reply-To: <1500158641-23033-1-git-send-email-peng.hao2@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qga-win32: remove a redundancy code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>, mdroth@linux.vnet.ibm.com, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

Cc'ing qemu-trivial

On 07/15/2017 07:44 PM, Peng Hao wrote:
> In the first line of run_agent,it has set ga_state = s,don't need
> set ga_state = s again behind.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   qga/main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qga/main.c b/qga/main.c
> index 405c129..dcd6104 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1314,7 +1314,7 @@ static int run_agent(GAState *s, GAConfig *config, int socket_activation)
>       ga_command_state_init(s, s->command_state);
>       ga_command_state_init_all(s->command_state);
>       json_message_parser_init(&s->parser, process_event);
> -    ga_state = s;
> +
>   #ifndef _WIN32
>       if (!register_signal_handlers()) {
>           g_critical("failed to register signal handlers");
> 
