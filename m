Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eno2z-00014m-AY
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eno2y-00051t-EP
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:12:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49630 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eno2y-00051Y-9j
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 11:12:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F37B37C6BB
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 16:12:07 +0000 (UTC)
References: <1519031728-9850-1-git-send-email-thuth@redhat.com>
	<1519031728-9850-5-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5eb7474f-328f-3429-1cb4-bc6c191f02f5@redhat.com>
Date: Mon, 19 Feb 2018 17:12:05 +0100
MIME-Version: 1.0
In-Reply-To: <1519031728-9850-5-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 4/8] net: Make net_client_init() static
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 19/02/2018 10:15, Thomas Huth wrote:
> The function is only used within net.c, so there's no need that
> this is a global function.
> 
> While we're at it, also remove the unused prototype compute_mcast_idx()
> (the function has been removed in commit d9caeb09b107e91122d10ba4a08a).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/net/net.h | 2 --
>  net/net.c         | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index bdd4d9f..cd1708c 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -204,7 +204,6 @@ extern const char *host_net_devices[];
>  extern const char *legacy_tftp_prefix;
>  extern const char *legacy_bootp_filename;
>  
> -int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp);
>  int net_client_parse(QemuOptsList *opts_list, const char *str);
>  int net_init_clients(Error **errp);
>  void net_check_clients(void);
> @@ -228,7 +227,6 @@ void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd);
>  #define POLYNOMIAL_LE 0xedb88320
>  uint32_t net_crc32(const uint8_t *p, int len);
>  uint32_t net_crc32_le(const uint8_t *p, int len);
> -unsigned compute_mcast_idx(const uint8_t *ep);
>  
>  #define vmstate_offset_macaddr(_state, _field)                       \
>      vmstate_offset_array(_state, _field.a, uint8_t,                \
> diff --git a/net/net.c b/net/net.c
> index 08049d9..bb63d82 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -1119,7 +1119,7 @@ static void show_netdevs(void)
>      }
>  }
>  
> -int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
> +static int net_client_init(QemuOpts *opts, bool is_netdev, Error **errp)
>  {
>      void *object = NULL;
>      Error *err = NULL;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
