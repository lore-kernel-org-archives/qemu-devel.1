Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B7C48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 01:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E77216E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 01:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E77216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgJgl-00072W-Jn
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 21:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hgJgH-0006ba-3S
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 21:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hgJgG-0005dm-03
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 21:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52758)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hgJgF-0005cQ-Ns
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 21:58:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2F78308424C;
 Thu, 27 Jun 2019 01:58:28 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3FFB60856;
 Thu, 27 Jun 2019 01:58:23 +0000 (UTC)
To: Zhang Chen <chen.zhang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, 
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 qemu-dev <qemu-devel@nongnu.org>, Stefano Stabellini
 <sstabellini@kernel.org>, Paul Durrant <paul.durrant@citrix.com>
References: <20190609164433.5866-1-chen.zhang@intel.com>
 <20190609164433.5866-5-chen.zhang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e56908b7-3671-0ac8-6fbc-4d412a2755e6@redhat.com>
Date: Thu, 27 Jun 2019 09:58:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190609164433.5866-5-chen.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 27 Jun 2019 01:58:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH V2 4/5] COLO-compare: Add colo-compare
 remote notify support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/10 =E4=B8=8A=E5=8D=8812:44, Zhang Chen wrote:
> From: Zhang Chen <chen.zhang@intel.com>
>
> This patch make colo-compare can send message to remote COLO frame(Xen)=
 when occur checkpoint.
>
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>   net/colo-compare.c | 54 +++++++++++++++++++++++++++++++++++++--------=
-
>   1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/net/colo-compare.c b/net/colo-compare.c
> index 16285f4a96..516b651ecd 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -120,11 +120,6 @@ enum {
>       SECONDARY_IN,
>   };
>  =20
> -static void colo_compare_inconsistency_notify(void)
> -{
> -    notifier_list_notify(&colo_compare_notifiers,
> -                migrate_get_current());
> -}
>  =20
>   static int compare_chr_send(CompareState *s,
>                               const uint8_t *buf,
> @@ -132,6 +127,27 @@ static int compare_chr_send(CompareState *s,
>                               uint32_t vnet_hdr_len,
>                               bool notify_remote_frame);
>  =20
> +static void notify_remote_frame(CompareState *s)
> +{
> +    char msg[] =3D "DO_CHECKPOINT";
> +    int ret =3D 0;
> +
> +    ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, true);
> +    if (ret < 0) {
> +        error_report("Notify Xen COLO-frame failed");
> +    }
> +}
> +
> +static void colo_compare_inconsistency_notify(CompareState *s)
> +{
> +    if (s->notify_dev) {
> +        notify_remote_frame(s);
> +    } else {
> +        notifier_list_notify(&colo_compare_notifiers,
> +                             migrate_get_current());
> +    }
> +}
> +
>   static gint seq_sorter(Packet *a, Packet *b, gpointer data)
>   {
>       struct tcp_hdr *atcp, *btcp;
> @@ -435,7 +451,7 @@ sec:
>           qemu_hexdump((char *)spkt->data, stderr,
>                        "colo-compare spkt", spkt->size);
>  =20
> -        colo_compare_inconsistency_notify();
> +        colo_compare_inconsistency_notify(s);
>       }
>   }
>  =20
> @@ -577,7 +593,7 @@ void colo_compare_unregister_notifier(Notifier *not=
ify)
>   }
>  =20
>   static int colo_old_packet_check_one_conn(Connection *conn,
> -                                           void *user_data)
> +                                          CompareState *s)
>   {
>       GList *result =3D NULL;
>       int64_t check_time =3D REGULAR_PACKET_CHECK_MS;
> @@ -588,7 +604,7 @@ static int colo_old_packet_check_one_conn(Connectio=
n *conn,
>  =20
>       if (result) {
>           /* Do checkpoint will flush old packet */
> -        colo_compare_inconsistency_notify();
> +        colo_compare_inconsistency_notify(s);
>           return 0;
>       }
>  =20
> @@ -608,7 +624,7 @@ static void colo_old_packet_check(void *opaque)
>        * If we find one old packet, stop finding job and notify
>        * COLO frame do checkpoint.
>        */
> -    g_queue_find_custom(&s->conn_list, NULL,
> +    g_queue_find_custom(&s->conn_list, s,
>                           (GCompareFunc)colo_old_packet_check_one_conn)=
;
>   }
>  =20
> @@ -637,7 +653,8 @@ static void colo_compare_packet(CompareState *s, Co=
nnection *conn,
>                */
>               trace_colo_compare_main("packet different");
>               g_queue_push_head(&conn->primary_list, pkt);
> -            colo_compare_inconsistency_notify();
> +
> +            colo_compare_inconsistency_notify(s);
>               break;
>           }
>       }
> @@ -989,7 +1006,24 @@ static void compare_sec_rs_finalize(SocketReadSta=
te *sec_rs)
>  =20
>   static void compare_notify_rs_finalize(SocketReadState *notify_rs)
>   {
> +    CompareState *s =3D container_of(notify_rs, CompareState, notify_r=
s);
> +
>       /* Get Xen colo-frame's notify and handle the message */
> +    char *data =3D g_memdup(notify_rs->buf, notify_rs->packet_len);
> +    char msg[] =3D "COLO_COMPARE_GET_XEN_INIT";
> +    int ret;
> +
> +    if (!strcmp(data, "COLO_USERSPACE_PROXY_INIT")) {
> +        ret =3D compare_chr_send(s, (uint8_t *)msg, strlen(msg), 0, tr=
ue);
> +        if (ret < 0) {
> +            error_report("Notify Xen COLO-frame INIT failed");
> +        }
> +    }
> +
> +    if (!strcmp(data, "COLO_CHECKPOINT")) {
> +        /* colo-compare do checkpoint, flush pri packet and remove sec=
 packet */
> +        g_queue_foreach(&s->conn_list, colo_flush_packets, s);
> +    }
>   }


This protocol looks too simple, is this accepted by Xen?

Thanks


>  =20
>   /*

