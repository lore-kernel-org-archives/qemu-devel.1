Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C1EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5A3220738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WukTej5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5A3220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnf44-0008CA-4F
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf3D-0007K8-2f
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnf3B-0000JI-3E
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G0JtMBSyZmuUN8J2iOpy6fMstb5yOu3NxHTcO+zTWTA=;
 b=WukTej5QOfrGGWBgka+jqYPBhOOeh+BNJS7YjZTcYxWZ6E6In8FAcAL4vg29UCUqqOGkSX
 d0/XG29PLJsNE8RiklxZszNWjOt6dvoILLUeIneKiyaErAWavmH9zaVM+hvT9TD905AC6R
 zdL7hCa3wVQi4LiS+9pEYKuCbsnjfDk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ai4DLuP6MliKLr_uoEo7-g-1; Tue, 23 Jun 2020 05:17:02 -0400
X-MC-Unique: ai4DLuP6MliKLr_uoEo7-g-1
Received: by mail-pf1-f198.google.com with SMTP id p1so6512720pff.17
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G0JtMBSyZmuUN8J2iOpy6fMstb5yOu3NxHTcO+zTWTA=;
 b=aURnyhTRBmBtgX3kRuPBKEaVb/gogGHzHzcjUnN/4IGCUUbyeoDDRrtzbU1H6d3Z1w
 DtK/MzujpCLXKe/Xu71hFv6bybtGtSJ/vd6F2UJTf3r1oX87xn3SusqMDCPDKzkpjvkW
 9U4zYt5ZJyFVATaAeLiTJBZ/ouED3nFi8dLHhQ0BjTgLx0cO/EfVPnBj4KSQTI/uanc+
 hlQf0KEI0I16EaqGxAIn15zPe2ZvuqbtAH5ViWKp9InshaTulICDAm93GfbavdKEXhXA
 GsvfrUGi1SPnSQ7ABZ5FK6YDoEKz+Z2VTuTuIzp35LpdiSclcDJe+zzIzveXU1Vmdo8x
 PCwg==
X-Gm-Message-State: AOAM531BB/q9yHVWdNNOHoI0Hb5UBkM1TRa2NZvh8RjjJL/ZRUKcv05J
 EeFu8I5PJwtj6GGbSthHSJS7hkEUUyQLBjnsK6sgxJ4y8BA600VNh9TgCXwc9ZDDlihhbBghknb
 DnREA/XlTmT22ykfK6dsXXfHjx4McsJM=
X-Received: by 2002:a65:67d9:: with SMTP id b25mr16687847pgs.311.1592903821308; 
 Tue, 23 Jun 2020 02:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLBq8ceNfzTFuCe8JF/J58ANl76Mi+Gl0hoom5F2w4juNMyn8FkWnYmBfKZOn/PMcR8auMuz0Rr+LAR5DgUTI=
X-Received: by 2002:a65:67d9:: with SMTP id b25mr16687817pgs.311.1592903821080; 
 Tue, 23 Jun 2020 02:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <877dvy45vr.fsf@dusky.pond.sub.org>
In-Reply-To: <877dvy45vr.fsf@dusky.pond.sub.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 23 Jun 2020 17:16:50 +0800
Message-ID: <CACLfguWUoV7Ngt0U3Rdenvyp1s0PcWk2xsJirYGvHR3KSmZoeA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] vDPA support in qemu
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: rdunlap@infradead.org, Michael Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, hanand@xilinx.com, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 3:07 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Cindy Lu <lulu@redhat.com> writes:
>
> > vDPA device is a device that uses a datapath which complies with the
> > virtio specifications with vendor specific control path. vDPA devices
> > can be both physically located on the hardware or emulated by software.
> > This RFC introduce the vDPA support in qemu
> > TODO
> > 1) vIOMMU support
> > 2) live migration support
>
> This gives me the foggiest of ideas on what vDPA is.  Could we use
> docs/interop/vhost-vdpa.rst?
>
Sure will add this


