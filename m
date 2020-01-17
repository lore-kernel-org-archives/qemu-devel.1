Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8629AC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5593420728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etDOn2xL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5593420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRoR-0006SR-2h
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isRn7-000530-0Q
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isRn5-0001hF-QR
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:36:00 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45500
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isRn5-0001gT-MS
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579268158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Th/SkgwkFWkEs4o4ayRq7xGuMNJxo3Vi/QWVO57M8A8=;
 b=etDOn2xLI+6kwVdGVOz7/lesSMMgWbsxkGR1V6YirLXrT0s4/AX4PRmA7AGPXMMXVJUu1z
 48C1F0oHEj3hajruVyRJ6LtsaNG7dfv9qEn0llAMjx+WqG3aocTSZ7/f0qmX/VwDavarAm
 aPR6rNr7IEo41Tt/ZycVU47IzMltbt0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-E2XUFgX0OWy4s-TN7-b2Sg-1; Fri, 17 Jan 2020 08:35:52 -0500
Received: by mail-wr1-f70.google.com with SMTP id o6so10490223wrp.8
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:35:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J3qPvvKTD+YPX2lVjkTcF2R+XThWz6YykrWtOGVU8BE=;
 b=OP+GuJCnLlDN2sDeKc7yvzCIxDJ6P67IrG766IqGMVdKXd0Q7MLL0DEcfEMCdhFYUW
 9zfdh3BDegcpxdomyTwOqVcfB2QNXGad+ooKB3Q3pq08/2IXiVQAEj5+s7xRdMgiAdr8
 BJYfeAJ2Xz7gyUxDBTfeXt2H+50ayCK9SjFP7Y7i++0wWWJ3/8z+j1BNYEaiBa2aSfOF
 pD7Fik/+L7Jf3Y2BZ5neSiQ0lPPchaZO6/vHQNo53S9u519FRf7k8HU1KEa/hzrive7y
 XAiB3a3l22kOm55u73m0Eak/jadnNlau2zG4Afug97dD0ozVrZn40FpiUKJeG6nTHhkX
 zkBw==
X-Gm-Message-State: APjAAAVtJ3lrZsImagkyaWy8x2NMHjoLPfo1su2eU+lQLCFFHexJlPfT
 mzx+mSirEYohpMjCTKtJl1nGnijprP09zpjQGR/mOezWhSkD8AGbAv4qGEBlRkyifAnFxAWgO2a
 p8AoP6pVJou+KqE0=
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr4790770wmn.155.1579268151321; 
 Fri, 17 Jan 2020 05:35:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvjZE/wJN4/TDkp88TPDAbE4nvEGFcQvM5Pxus6GCdAdiQZZgUzpTPzgJLtP82jzvIznQEJQ==
X-Received: by 2002:a05:600c:2c2:: with SMTP id
 2mr4790758wmn.155.1579268151125; 
 Fri, 17 Jan 2020 05:35:51 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id u14sm33451221wrm.51.2020.01.17.05.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:35:50 -0800 (PST)
Subject: Re: [PATCH 103/104] virtiofsd: add --thread-pool-size=NUM option
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-104-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <dcac828c-b100-014e-fd77-808262a56777@redhat.com>
Date: Fri, 17 Jan 2020 14:35:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-104-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: E2XUFgX0OWy4s-TN7-b2Sg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 5:39 PM, Dr. David Alan Gilbert (git) wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> Add an option to control the size of the thread pool.  Requests are now
> processed in parallel by default.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   tools/virtiofsd/fuse_i.h        | 1 +
>   tools/virtiofsd/fuse_lowlevel.c | 7 ++++++-
>   tools/virtiofsd/fuse_virtio.c   | 5 +++--
>   3 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
> index 8a4a05b319..4da6a242ba 100644
> --- a/tools/virtiofsd/fuse_i.h
> +++ b/tools/virtiofsd/fuse_i.h
> @@ -72,6 +72,7 @@ struct fuse_session {
>       int   vu_listen_fd;
>       int   vu_socketfd;
>       struct fv_VuDev *virtio_dev;
> +    int thread_pool_size;
>   };
>  =20
>   struct fuse_chan {
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowle=
vel.c
> index 9f01c05e3e..09a7b23726 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -27,6 +27,7 @@
>   #include <sys/file.h>
>   #include <unistd.h>
>  =20
> +#define THREAD_POOL_SIZE 64
>  =20
>   #define OFFSET_MAX 0x7fffffffffffffffLL
>  =20
> @@ -2523,6 +2524,7 @@ static const struct fuse_opt fuse_ll_opts[] =3D {
>       LL_OPTION("--socket-path=3D%s", vu_socket_path, 0),
>       LL_OPTION("vhost_user_socket=3D%s", vu_socket_path, 0),
>       LL_OPTION("--fd=3D%d", vu_listen_fd, 0),
> +    LL_OPTION("--thread-pool-size=3D%d", thread_pool_size, 0),
>       FUSE_OPT_END
>   };
>  =20
> @@ -2544,7 +2546,9 @@ void fuse_lowlevel_help(void)
>           "    --socket-path=3DPATH         path for the vhost-user socke=
t\n"
>           "    -o vhost_user_socket=3DPATH  path for the vhost-user socke=
t\n"
>           "    --fd=3DFDNUM                 fd number of vhost-user socke=
t\n"
> -        "    -o auto_unmount            auto unmount on process terminat=
ion\n");
> +        "    -o auto_unmount            auto unmount on process terminat=
ion\n"
> +        "    --thread-pool-size=3DNUM     thread pool size limit (defaul=
t %d)\n",
> +        THREAD_POOL_SIZE);
>   }
>  =20
>   void fuse_session_destroy(struct fuse_session *se)
> @@ -2598,6 +2602,7 @@ struct fuse_session *fuse_session_new(struct fuse_a=
rgs *args,
>       }
>       se->fd =3D -1;
>       se->vu_listen_fd =3D -1;
> +    se->thread_pool_size =3D THREAD_POOL_SIZE;
>       se->conn.max_write =3D UINT_MAX;
>       se->conn.max_readahead =3D UINT_MAX;
>  =20
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.=
c
> index b696ac3135..7bc6ff2f19 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -570,10 +570,11 @@ static void *fv_queue_thread(void *opaque)
>       struct fv_QueueInfo *qi =3D opaque;
>       struct VuDev *dev =3D &qi->virtio_dev->dev;
>       struct VuVirtq *q =3D vu_get_queue(dev, qi->qidx);
> +    struct fuse_session *se =3D qi->virtio_dev->se;
>       GThreadPool *pool;
>  =20
> -    pool =3D g_thread_pool_new(fv_queue_worker, qi, 1 /* TODO max_thread=
s */,
> -                             TRUE, NULL);
> +    pool =3D g_thread_pool_new(fv_queue_worker, qi, se->thread_pool_size=
, TRUE,
> +                             NULL);
>       if (!pool) {
>           fuse_log(FUSE_LOG_ERR, "%s: g_thread_pool_new failed\n", __func=
__);
>           return NULL;
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


