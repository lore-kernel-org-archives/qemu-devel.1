Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D49BC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680832068E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUF+ndp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680832068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChp1-0004Uu-KJ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kChoT-0003zd-6L
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kChoR-0001qZ-F1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598872642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U+tzIHWH3abqeO2VjnMotvrhqX/vEMaRGXYuVm/4znY=;
 b=LUF+ndp4MtAHWIVaUaPAdOqIXbMGLOJvODx0Zz7nbwuc3rsvtoYyx1qVGvGlDwHo5jRRV0
 YjU+O/ownyR52sMjJb/ZeZVdWKaMBlVjn3UY+nFyP6gswyXLNm7Vn5U+mH+mhEWNOVz9SV
 cf8rrSizbfebksu2NlDxn9H1mMcTF5Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-WNjRpGq3NjyK_yRCODbtSg-1; Mon, 31 Aug 2020 07:16:15 -0400
X-MC-Unique: WNjRpGq3NjyK_yRCODbtSg-1
Received: by mail-pl1-f200.google.com with SMTP id bd4so2422183plb.17
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 04:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U+tzIHWH3abqeO2VjnMotvrhqX/vEMaRGXYuVm/4znY=;
 b=dBxEb5fBoXp/qHvH1VH/F+u+LaQgE7+Xteaj+F2RxcqycjV+PEZN+cD4GngzRJXyWI
 fjYPPdlkdv/Hi5NdmTG9SDRoYZIg5dji/t9hyq18nA1oordL7dkEeoJifhGHRUZnAr3o
 7uLM6tVg0HJmHhxncM5QQDYc6zYIexOk9GiFXMJRF+FVgo/B0AGMw34Aqs/Scmrvw351
 Ht1jir71YWd19d8A58p4ps9WshEKRZfBnePmKzO1w9f61NL4b3XHG1xI5eRCl13FQlR5
 LqIRPZcwWsf+zYzR/DITIsCpQA0t9IOCEyzHc2iubC3AL5Ejn/6WvXyu+fX+zfs1PT1u
 qjrg==
X-Gm-Message-State: AOAM5300KmGInxWSFcHMFV6GHDPCrPbBJ6A00PyHwQ3XYxr1hRew4Ioc
 mP1hQ5k9688SkmZN4aBqY4LTyHPHfTMAjwcQB8Y+YG4zWu3FI4XFj6K5tKWA88UrlHaWlEtDoM+
 c0rANvilGKEl+82isPrPqm6T98Q7ltLs=
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr717610pls.98.1598872574815; 
 Mon, 31 Aug 2020 04:16:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1sS6RLfg0pSaSgm7ALy0LZCwtTjLEy90mlFdC6UN4TN+fGfb22Q3FTsavEULJ0OESSIA24nRRHsCBgrX2DBY=
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr717595pls.98.1598872574529; 
 Mon, 31 Aug 2020 04:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200831082737.10983-1-jasowang@redhat.com>
 <20200831082737.10983-10-jasowang@redhat.com>
In-Reply-To: <20200831082737.10983-10-jasowang@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 31 Aug 2020 19:16:03 +0800
Message-ID: <CACLfguWu6fu3_PkfcTLZriTk=BqWk4a+=myfH+cFpQuHLu0koQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] vhost-vdpa: allow pre-opend file descriptor
To: Jason Wang <jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:02:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 31 Aug 2020 at 16:30, Jason Wang <jasowang@redhat.com> wrote:
>
> This patch allows to initialize vhost-vdpa network backend with pre
> opened vhost-vdpa file descriptor. This is useful for running
> unprivileged qemu through libvirt.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  net/vhost-vdpa.c | 24 +++++++++++++++++++-----
>  qapi/net.json    |  5 ++++-
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9a6f0b63d3..f6385cd264 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -206,20 +206,34 @@ int net_init_vhost_vdpa(const Netdev *netdev, const char *name,
>                            (char *)name, errp)) {
>          return -1;
>      }
> -    if (!opts->has_vhostdev) {
> -        error_setg(errp, "vhost-vdpa requires vhostdev to be set");
> +    if (!(opts->has_vhostdev ^ opts->has_fd)) {
> +        error_setg(errp, "Vhost-vdpa requires either vhostdev or fd to be set");
>          return -1;
>      }
>
>      assert(name);
>
>      nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, TYPE_VHOST_VDPA, name);
> -    snprintf(nc->info_str, sizeof(nc->info_str), "vhostdev=%s", opts->vhostdev);
> +    if (opts->has_vhostdev) {
> +        snprintf(nc->info_str, sizeof(nc->info_str),
> +                 "vhostdev=%s", opts->vhostdev);
> +        vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR);
> +        if (vdpa_device_fd == -1) {
> +            error_setg(errp, "Fail to open vhost-vdpa device %s",
> +                       opts->vhostdev);
> +            return -errno;
> +        }
> +    } else {
> +        snprintf(nc->info_str, sizeof(nc->info_str), "fd=%s", opts->fd);
> +        vdpa_device_fd = monitor_fd_param(cur_mon, opts->fd, errp);
> +        if (vdpa_device_fd == -1) {
> +            return -1;
> +        }
> +    }
>
>      s = DO_UPCAST(VhostVDPAState, nc, nc);
> -    vdpa_device_fd = qemu_open(opts->vhostdev, O_RDWR);
>      if (vdpa_device_fd == -1) {
> -        error_setg(errp, "Fail to open vhost-vdpa device %s", opts->vhostdev);
> +
>          return -errno;
>      }
>      s->vhost_vdpa.device_fd = vdpa_device_fd;
> diff --git a/qapi/net.json b/qapi/net.json
> index a2a94fad3e..5ad60c3045 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -442,12 +442,15 @@
>  # @queues: number of queues to be created for multiqueue vhost-vdpa
>  #          (default: 1)
>  #
> +# @fd: file descriptor of an already opened vhost-vdpa (since 5.2)
> +#
>  # Since: 5.1
>  ##
>  { 'struct': 'NetdevVhostVDPAOptions',
>    'data': {
>      '*vhostdev':     'str',
> -    '*queues':       'int' } }
> +    '*queues':       'int',
> +    '*fd':           'str' } }
>
>  ##
>  # @NetClientDriver:
> --
> 2.20.1
>
I think the latest  code supported this part.
you can pass a pre open file descriptor to it via the add-fd QMP
command to /dev/fdset/NNN, and then pass the string
"/dev/fdset/NNN" as vhostdev.  so we don't need a special fd parameter here.

Thanks
Cindy


