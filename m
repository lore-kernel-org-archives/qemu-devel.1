Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF26C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 01:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A60F20659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 01:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMERdg1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A60F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfZT6-0005Kv-By
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 21:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jfZSI-0004u2-Me
 for qemu-devel@nongnu.org; Sun, 31 May 2020 21:41:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jfZSF-00040U-QG
 for qemu-devel@nongnu.org; Sun, 31 May 2020 21:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590975689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WTsLmFcPCMhiAd/4KJIMCK/ZKScFwwPm/Q2nFQc01o=;
 b=VMERdg1ITWabtpT6ug4EezdZ2cDOcy0GvWO9AnCafHptECxuxGsI6txaschkD3qRBZuoLF
 6U2RJC2mB2lm8cbxxwbw7uvAnWl4gdNiPABAPI+LDsmteNFRztuDBwPRjsnnnvuMN7e539
 DRzstay9kUy5KE8w5Y4d+nN3hCT3TuM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-gTyj32nqMa-pfVTjAQ0biQ-1; Sun, 31 May 2020 21:41:21 -0400
X-MC-Unique: gTyj32nqMa-pfVTjAQ0biQ-1
Received: by mail-pj1-f72.google.com with SMTP id k30so5406784pje.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 18:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/WTsLmFcPCMhiAd/4KJIMCK/ZKScFwwPm/Q2nFQc01o=;
 b=gIlPvyOMmF6NHTvlaK+RLz8WWnPtGL4gZI3JICe6WAdjTH01e9vms0ZGCis+/DBwte
 2h5tAzy9JdK9Xb8trQ0mjUP05bk1/aKdIq4Ps6BEizzZaY2Zr1cYS5A0/lbioRnCY0s3
 vsXbDgsdYissJeIkfkDozjPhQIlPrbnwdirLOQ6Neq/z3Za2UWDNFhRZNXgUadsSsGHC
 FdfamPoy9/vgiqz11Oa1RZi+XZ9l3EfSQ4tzovUSgcJnDdLmfXN65K0sDox8mlbGOBep
 Yh+4R05LSXmgt+uIyzSTv9OOx4GHMdIZrk8+5HvvKd93D++UHUr3Yvu4qXNx9XBf49Uc
 xDeg==
X-Gm-Message-State: AOAM530SLGY5+gBCOn/Dc/TD/eGfxF28yp0gTuT/oqUGbVszPtoMVfqe
 +fuSkiN5IKdMuCH8dtOVwnOqvpAgrS868YBmExywoT0XemWX+ktC/zLQm2vx8Ya7iOxLPiq/J6c
 auKKBDCSdLsdOv04zSFTYczq88Tt2I/M=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr17898485pls.341.1590975680679; 
 Sun, 31 May 2020 18:41:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwo5I70bcLWqWOy4yrv4vHPggK3trsTaS9mBL+Gu9D888Ka8GtPzfIEWwtTOlvo6NnpSB9CsIE+8fGWtEwPPxU=
X-Received: by 2002:a17:902:bb86:: with SMTP id
 m6mr17898456pls.341.1590975680395; 
 Sun, 31 May 2020 18:41:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-9-lulu@redhat.com>
 <5595226b-dd22-9dc8-fa82-cdabb7a7df52@redhat.com>
In-Reply-To: <5595226b-dd22-9dc8-fa82-cdabb7a7df52@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 1 Jun 2020 09:41:09 +0800
Message-ID: <CACLfguVWxo86A2daXip5hJqoJpYLGfNmUjBubB76S1u498zpEg@mail.gmail.com>
Subject: Re: [RFC v3 8/8] vhost-vdpa: introduce vhost-vdpa net client
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 21:41:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, hanand@xilinx.com,
 rob.miller@broadcom.com, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 mhabets@solarflare.com, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 10:23 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/29/20 9:06 AM, Cindy Lu wrote:
> > From: Tiwei Bie <tiwei.bie@intel.com>
> >
> > This patch set introduces a new net client type: vhost-vdpa.
> > vhost-vdpa net client will set up a vDPA device which is specified
> > by a "vhostdev" parameter.
> >
> > Co-authored-by: Lingshan Zhu <lingshan.zhu@intel.com>
> > Signed-off-by: Cindy Lu <lulu@redhat.com>
> > ---
>
> > +static int net_vhost_vdpa_init(NetClientState *peer, const char *device,
> > +                               const char *name, const char *vhostdev,
> > +                               bool has_fd, char *fd)
> > +{
>
> fd is usually an int, not a string.
>
will fix this
> > +    NetClientState *nc = NULL;
> > +    VhostVDPAState *s;
> > +    int vdpa_device_fd = -1;
> > +    Error *err = NULL;
> > +    int ret = 0;
> > +    assert(name);
> > +
> > +    nc = qemu_new_net_client(&net_vhost_vdpa_info, peer, device, name);
> > +    snprintf(nc->info_str, sizeof(nc->info_str), "vhost-vdpa");
> > +    nc->queue_index = 0;
> > +
> > +    s = DO_UPCAST(VhostVDPAState, nc, nc);
> > +
> > +    if (has_fd) {
> > +        vdpa_device_fd = monitor_fd_param(cur_mon, fd, &err);
> > +    } else{
> > +        vdpa_device_fd = open(vhostdev, O_RDWR);
> > +    }
>
> Oh, you're trying to use the old way for passing in fds.  The preferred
> way is to use qemu_open(), at which point you can pass in fds via the
> add-fd QMP command, and then pass the string "/dev/fdset/NNN" as
> vhostdev.  Then you don't need a special fd parameter here.
>
Thanks Eric, I will try this.

> > +++ b/qapi/net.json
> > @@ -428,6 +428,27 @@
> >       '*vhostforce':    'bool',
> >       '*queues':        'int' } }
> >
> > +##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
> > +#
> > +# @vhostdev: name of a vdpa dev path in sysfs
> > +#            (default path:/dev/vhost-vdpa-$ID)
> > +#
> > +# @fd: file descriptor of an already opened vdpa device
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1)
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
> > +    '*fd':           'str',
> > +    '*queues':       'int' } }
>
> Instead of having vhostdev and fd both be optional (but where the user
> has to specify exactly one of them), you should only have vhostdev be
> mandatory, and rely on the /dev/fdset/NNN string as a way to get
> vhostdev to point to a previously-passed fd.
>
will fix this
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


