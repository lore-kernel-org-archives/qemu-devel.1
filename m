Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85517C28CC5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 02:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545D3279DD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 02:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545D3279DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cn.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXcoV-0004gF-2r
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 22:35:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1hXcmr-0003j4-4s
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1hXcmp-0007OP-5p
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:33:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48332
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1hXcml-0007Hv-Dy
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 22:33:21 -0400
X-IronPort-AV: E=Sophos;i="5.60,545,1549900800"; d="scan'208,217";a="65669217"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
	by heian.cn.fujitsu.com with ESMTP; 03 Jun 2019 10:33:12 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
	by cn.fujitsu.com (Postfix) with ESMTP id 7BD1C4CDB937;
	Mon,  3 Jun 2019 10:33:07 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
	G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP
	Server id 14.3.439.0; Mon, 3 Jun 2019 10:33:14 +0800
To: Zhang Chen <chen.zhang@intel.com>, "Dr. David Alan Gilbert"
	<dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
	<zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
References: <20190602034239.23225-1-chen.zhang@intel.com>
	<20190602034239.23225-5-chen.zhang@intel.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Organization: fnst-ulinux
Message-ID: <23a2b7f5-a3b9-aee0-38c3-abe0fc00eca2@cn.fujitsu.com>
Date: Mon, 3 Jun 2019 10:33:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190602034239.23225-5-chen.zhang@intel.com>
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-yoursite-MailScanner-ID: 7BD1C4CDB937.A3F42
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 183.91.158.132
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 4/6] COLO-compare: Add colo-compare remote
 notify support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

how about do switch inside colo_compare_inconsistency_notify(), like:

colo_compare_inconsistency_notify(CompareState *s)
{
	if (s->remote_notify)
		remote_notify
	else
		local_notity
}

Thanks
Zhijian

On 6/2/19 11:42 AM, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch make colo-compare can send message to remote COLO frame(Xen) when occur checkpoint.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c | 51 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 46 insertions(+), 5 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 16285f4a96..19075c7a66 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -251,6 +251,17 @@ static void colo_release_primary_pkt(CompareState *s, Packet *pkt)
>       packet_destroy(pkt, NULL);
>   }
>   
> +static void notify_remote_frame(CompareState *s)
> +{
> +    char msg[] = "DO_CHECKPOINT";
> +    int ret = 0;
> +
> +    ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +    if (ret < 0) {
> +        error_report("Notify Xen COLO-frame failed");
> +    }
> +}
> +
>   /*
>    * The IP packets sent by primary and secondary
>    * will be compared in here
> @@ -435,7 +446,11 @@ sec:
>           qemu_hexdump((char *)spkt->data, stderr,
>                        "colo-compare spkt", spkt->size);
>   
> -        colo_compare_inconsistency_notify();
> +        if (s->notify_dev) {
> +            notify_remote_frame(s);
> +        } else {
> +            colo_compare_inconsistency_notify();
> +        }
>       }
>   }
>   
> @@ -577,7 +592,7 @@ void colo_compare_unregister_notifier(Notifier *notify)
>   }
>   
>   static int colo_old_packet_check_one_conn(Connection *conn,
> -                                           void *user_data)
> +                                          CompareState *s)
>   {
>       GList *result = NULL;
>       int64_t check_time = REGULAR_PACKET_CHECK_MS;
> @@ -588,7 +603,11 @@ static int colo_old_packet_check_one_conn(Connection *conn,
>   
>       if (result) {
>           /* Do checkpoint will flush old packet */
> -        colo_compare_inconsistency_notify();
> +        if (s->notify_dev) {
> +            notify_remote_frame(s);
> +        } else {
> +            colo_compare_inconsistency_notify();
> +        }
>           return 0;
>       }
>   
> @@ -608,7 +627,7 @@ static void colo_old_packet_check(void *opaque)
>        * If we find one old packet, stop finding job and notify
>        * COLO frame do checkpoint.
>        */
> -    g_queue_find_custom(&s->conn_list, NULL,
> +    g_queue_find_custom(&s->conn_list, s,
>                           (GCompareFunc)colo_old_packet_check_one_conn);
>   }
>   
> @@ -637,7 +656,12 @@ static void colo_compare_packet(CompareState *s, Connection *conn,
>                */
>               trace_colo_compare_main("packet different");
>               g_queue_push_head(&conn->primary_list, pkt);
> -            colo_compare_inconsistency_notify();
> +
> +            if (s->notify_dev) {
> +                notify_remote_frame(s);
> +            } else {
> +                colo_compare_inconsistency_notify();
> +            }
>               break;
>           }
>       }
> @@ -989,7 +1013,24 @@ static void compare_sec_rs_finalize(SocketReadState *sec_rs)
>   
>   static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>   {
> +    CompareState *s = container_of(notify_rs, CompareState, notify_rs);
> +
>       /* Get Xen colo-frame's notify and handle the message */
> +    char *data = g_memdup(notify_rs->buf, notify_rs->packet_len);
> +    char msg[] = "COLO_COMPARE_GET_XEN_INIT";
> +    int ret;
> +
> +    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +        ret = compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +        if (ret < 0) {
> +            error_report("Notify Xen COLO-frame INIT failed");
> +        }
> +    }
> +
> +    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +        /* colo-compare do checkpoint, flush pri packet and remove sec packet */
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    }
>   }
>   
>   /*


