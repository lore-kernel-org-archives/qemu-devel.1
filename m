Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534B8C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ED35208CA
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 07:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsHIB9vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ED35208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXJkq-0001bL-76
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 03:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJkA-00012d-Lv
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:17:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55078
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jXJk8-0002q2-IB
 for qemu-devel@nongnu.org; Sat, 09 May 2020 03:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589008670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKGrutE1fSOSwfMZH+hFv8f7HYvCDppPe2uHQNgNA9k=;
 b=SsHIB9vrDjJll69ANsvd6bHvEuf7XJqBMKQVWJTX39FwAOnYCcfPMF7tVFri3SWcAs4pzp
 jK5QoGB5tuwGdHWxamRtUNY1GHAIUuqnKna+GukURj4LyNlhndBaXwFripyMarCa6ArNvR
 74rJ788HtYyBp5L4bgceCPvY544AXXc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-xieu5U3WPOKZCt-VuhM0lQ-1; Sat, 09 May 2020 03:17:42 -0400
X-MC-Unique: xieu5U3WPOKZCt-VuhM0lQ-1
Received: by mail-pl1-f198.google.com with SMTP id j23so3431759pll.16
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 00:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hKGrutE1fSOSwfMZH+hFv8f7HYvCDppPe2uHQNgNA9k=;
 b=SaPNLz2EsT0pW9hMqidFHhzolm27s72X9jvz4h/UHjLXZX2oGXgWote5fbP+dFcOgS
 3w9CBXfw7X5iQsnHfzhloNu61iya9LIzqVhxHtU/TgCiu/eybg7ikyA1StD5yp/wUZK8
 0p6YwBYYmUBAMk5MRE/wHni3wW45iNcfVCPPXj4VCsbOqyJ20adNSn3Ds/wQBBTL0/bP
 q1tnakxOgB27T/Hby20TgYKfgTzzAtqOTdzTfvzrFnk4wvWZOhBbpiZZGYvRceJuEiBj
 slPIeVHTWpXCGnSxnJZDIyVj++w6QNyhXG5PSay9//MbiZ4hyuwRwWXmlmI1veUKc8tf
 YlAw==
X-Gm-Message-State: AGi0Pub41JWZmAoEQqhJsJJ24ukQ0mnCi3PxNTM1rgEjaWfBTsFtAS6D
 n2IwsrH+23tqlLc2cNVDqidLVKrCS8WfLNOAxmPCrkYJFXtLxM3NXzq8f+N7/fRekU7h7711Ida
 p5clkch+Bslc4Uyc5c4i4PJ+dmHkncAA=
X-Received: by 2002:aa7:962c:: with SMTP id r12mr6934253pfg.232.1589008661636; 
 Sat, 09 May 2020 00:17:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNL4Vvt3madx8FnUCR8z1mdu5tAAZwapqHH7/gLlpR/0ETa3/YpC7MOgjNRYAAd7CMmgYaCW7I9Mc1/pnzfsk=
X-Received: by 2002:aa7:962c:: with SMTP id r12mr6934209pfg.232.1589008661201; 
 Sat, 09 May 2020 00:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200508163218.22592-1-lulu@redhat.com>
 <20200508163218.22592-5-lulu@redhat.com>
 <b6b2b85d-2216-c207-0161-472a0c2635c4@redhat.com>
In-Reply-To: <b6b2b85d-2216-c207-0161-472a0c2635c4@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sat, 9 May 2020 15:17:30 +0800
Message-ID: <CACLfguVha-xanCnhR56x2f=+bEyaRbwu_cLwzMih9ofTw+tk1A@mail.gmail.com>
Subject: Re: [RFC v2 4/9] vhost-vdpa: introduce vhost-vdpa net client
To: Eric Blake <eblake@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 02:50:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 mhabets@solarflare.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, vmireyno@marvell.com, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 9, 2020 at 12:42 AM Eric Blake <eblake@redhat.com> wrote:
>
> On 5/8/20 11:32 AM, Cindy Lu wrote:
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
> Just looking at UI:
>
>
> > +++ b/qapi/net.json
> > @@ -441,6 +441,23 @@
> >       '*queues':        'int' } }
> >
> >   ##
> > +# @NetdevVhostVDPAOptions:
> > +#
> > +# Vhost-vdpa network backend
> > +#
> > +# @vhostdev: name of a vdpa dev path in sysfs
> > +#
> > +# @queues: number of queues to be created for multiqueue vhost-vdpa
> > +#          (default: 1) (Since 5.1)
>
> No need to mark a 'since' tag on a member introduced at the same time as
> the overall struct itself.
>
Will fix this
> > +#
> > +# Since: 5.1
> > +##
> > +{ 'struct': 'NetdevVhostVDPAOptions',
> > +  'data': {
> > +    '*vhostdev':     'str',
>
> What does this default to if omitted?
>
> > +    '*fd':           'str',
>
> Not documented above.
>
> > +    '*queues':       'int' } }
> > +##
>
> Missing blank line separator.
>
Thanks Eric, Will fix  these all
> >   # @NetClientDriver:
> >   #
> >   # Available netdev drivers.
> > @@ -451,7 +468,7 @@
> >   ##
> >   { 'enum': 'NetClientDriver',
> >     'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
> > -            'bridge', 'hubport', 'netmap', 'vhost-user' ] }
> > +            'bridge', 'hubport', 'netmap', 'vhost-user', 'vhost-vdpa' ] }
>
> Missing a line above that 'vhost-vdpa' is new to 5.1.
>
>
Will fix this
> > @@ -2749,6 +2756,18 @@ qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,sha
> >        -device virtio-net-pci,netdev=net0
> >   @end example
> >
> > +@item -netdev vhost-vdpa,vhostdev=/path/to/dev
> > +Establish a vhost-vdpa netdev, backed by a vhostdev. The chardev should
> > +be a unix domain socket backed one. The vhost-vdpa uses a specifically defined
> > +protocol to pass vhost ioctl replacement messages to an application on the other
> > +end of the socket.
> > +Example:
> > +@example
> > +qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,share=on \
> > +     -numa node,memdev=mem \
> > +     -netdev type=vhost-vdpa,id=net0,vhostdev=/path/to/dev \
> > +     -device virtio-net-pci,netdev=net0
> > +@end example
> >   @item -netdev hubport,id=@var{id},hubid=@var{hubid}[,netdev=@var{nd}]
> >
> >   Create a hub port on the emulated hub with ID @var{hubid}.
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>


