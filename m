Received: from eggs.gnu.org ([2001:4830:134:3::10]:43487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv3S-0007ok-8U
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:18:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gMv3O-00051G-Vd
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:18:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gMv3O-00050D-PM
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:17:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id i73-v6so10143340wmd.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:17:58 -0800 (PST)
References: <20181114123643.24091-1-marcandre.lureau@redhat.com>
	<20181114123643.24091-38-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dd833079-31b0-cf4d-e6d4-f9524383c920@redhat.com>
Date: Wed, 14 Nov 2018 14:17:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181114123643.24091-38-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.2 37/41] slirp: replace ARRAY_SIZE
 with G_N_ELEMENTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

On 14/11/18 13:36, Marc-André Lureau wrote:
> Do not require QEMU macro.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   slirp/ncsi.c | 2 +-
>   slirp/tftp.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/slirp/ncsi.c b/slirp/ncsi.c
> index 10decfb5ef..8594382270 100644
> --- a/slirp/ncsi.c
> +++ b/slirp/ncsi.c
> @@ -128,7 +128,7 @@ void ncsi_input(Slirp *slirp, const uint8_t *pkt, int pkt_len)
>       memset(reh->h_source, 0xff, ETH_ALEN);
>       reh->h_proto = htons(ETH_P_NCSI);
>   
> -    for (i = 0; i < ARRAY_SIZE(ncsi_rsp_handlers); i++) {
> +    for (i = 0; i < G_N_ELEMENTS(ncsi_rsp_handlers); i++) {
>           if (ncsi_rsp_handlers[i].type == nh->type + 0x80) {
>               handler = &ncsi_rsp_handlers[i];
>               break;
> diff --git a/slirp/tftp.c b/slirp/tftp.c
> index dddb614b8a..ef8d0352b4 100644
> --- a/slirp/tftp.c
> +++ b/slirp/tftp.c
> @@ -360,7 +360,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sockaddr_storage *srcsas,
>         return;
>     }
>   
> -  while (k < pktlen && nb_options < ARRAY_SIZE(option_name)) {
> +  while (k < pktlen && nb_options < G_N_ELEMENTS(option_name)) {
>         const char *key, *value;
>   
>         key = &tp->x.tp_buf[k];
> @@ -404,7 +404,7 @@ static void tftp_handle_rrq(Slirp *slirp, struct sockaddr_storage *srcsas,
>     }
>   
>     if (nb_options > 0) {
> -      assert(nb_options <= ARRAY_SIZE(option_name));
> +      assert(nb_options <= G_N_ELEMENTS(option_name));
>         tftp_send_oack(spt, option_name, option_value, nb_options, tp);
>         return;
>     }
> 
