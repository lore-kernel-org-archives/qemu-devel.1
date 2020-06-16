Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFD0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F6C2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djQAlW+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F6C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7Lb-0004ae-Jr
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jl7Kz-0004BD-MQ
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:52:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56471
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jl7Kx-0001Md-FY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=94mJEZyppg/p1yB+39jT977blw1KsN32vXBJqxPY0Nw=;
 b=djQAlW+awbHB/kfeU40EROD33j/fP1TdZ429zI7kX7KZhRIYqBrPymbuTAPy502sg78gt3
 FjJwOsdJnHJm65oBsdxmbi6QSpX1Y2Gv4Ad0NRVrbLE71+1MARljq3eC7bqEyXDv18vSDM
 nOvJj9J6qFB9lo2XEAeclQZVL54hgFA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-6Zd8ZqtvPbW1KVzJm3Ekcw-1; Tue, 16 Jun 2020 04:52:49 -0400
X-MC-Unique: 6Zd8ZqtvPbW1KVzJm3Ekcw-1
Received: by mail-pj1-f71.google.com with SMTP id ga20so1795181pjb.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 01:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=94mJEZyppg/p1yB+39jT977blw1KsN32vXBJqxPY0Nw=;
 b=Veh+ROzbaD4QBAbOtgM1BF2pssw1mvdt0a3KQf1E9S5mZD916fsGUGAb4TB1Ff/lug
 pVGiNdQrnzuqlOUcytUtEV5FGwTsn/bUEFOwyQ0KbE5pLtgM8iq3fvKzHkdPooVmyMOm
 uCNU5+8N7ZgileUisQvPgVT9+ho45EBWdWxIG6Aj9OdX94eeb9LaxjtPhwu44zZd2ryz
 qNgkw7pveLbidHUiSgOk8K5i/N6a676W06mPNI/CZEbi56s0UlDyHeS0Udvc1ObouAmh
 TLO+Y/97TRlUepYXrmHVP9Q7cKwQv+fWOm6T+2BZ1DvI4oohUwdGFb/yW6ti10P46IsU
 bbPw==
X-Gm-Message-State: AOAM531vF0v49UmFG5krSjlBHxLUXfKSFB+xHexSWi8nL+AXAa/0qFZu
 jPzqCteciy1IOg3R2bRbkgWhoowAm+GCRVFByqaTodpl+sylkfHd34Q6aMM5ddK10/VCby2cA/W
 cBVKG0OxuSDSFakZQdjrVxZgNvHNo4NA=
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr1221694plb.12.1592297568676; 
 Tue, 16 Jun 2020 01:52:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO+MiFMkefmz1PZeyl8SkvyCSbErpdw7z3CN6DWncoMjZ17FAFi7SLOEJvqh6An0gwQrU7Tzc+U5EQWRP385M=
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr1221668plb.12.1592297568417; 
 Tue, 16 Jun 2020 01:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <202b7a79-8d27-cdd8-7c72-5016b53c538d@redhat.com>
 <b9590e77-c77e-80e5-18a9-e46094b00f21@redhat.com>
In-Reply-To: <b9590e77-c77e-80e5-18a9-e46094b00f21@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 16 Jun 2020 16:52:37 +0800
Message-ID: <CACLfguV3NvGTkZec=fy910oz-31AF5Lb0CW6G=962sU1ugyjqQ@mail.gmail.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
To: Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
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
 mhabets@solarflare.com, qemu-devel@nongnu.org,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Jason Wang <jasowang@redhat.com>, Shahaf Shuler <shahafs@mellanox.com>,
 kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 hanand@xilinx.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 10:44 PM Laurent Vivier <lvivier@redhat.com> wrote:
>
> On 08/06/2020 22:14, Eric Blake wrote:
> > On 5/29/20 9:06 AM, Cindy Lu wrote:
> >> From: Tiwei Bie <tiwei.bie@intel.com>
> >
> > The original author is Tiwei Bie...
> >
> >>
> >> Currently we have 2 types of vhost backends in QEMU: vhost kernel and
> >> vhost-user. The above patch provides a generic device for vDPA purpose,
> >> this vDPA device exposes to user space a non-vendor-specific
> >> configuration
> >> interface for setting up a vhost HW accelerator, this patch set
> >> introduces
> >> a third vhost backend called vhost-vdpa based on the vDPA interface.
> >>
> >> Vhost-vdpa usage:
> >>
> >>    qemu-system-x86_64 -cpu host -enable-kvm \
> >>      ......
> >>    -netdev type=vhost-vdpa,vhostdev=/dev/vhost-vdpa-id,id=vhost-vdpa0 \
> >>    -device virtio-net-pci,netdev=vhost-vdpa0,page-per-vq=on \
> >>
> >> Co-Authored-By: Lingshan zhu <lingshan.zhu@intel.com>
> >> Signed-off-by: Cindy Lu <lulu@redhat.com>
> >> ---
> >
> > ...but there is no S-o-b here.  Also, Co-Authored-By is an unusual tag;
> > it's just as easy to spell it Signed-off-by even for co-authors.
> >
>
> Normally the tag to use in this case is "Co-developed-by".
>
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
>
> "A Co-Developed-by: states that the patch was also created by another
> developer along with the original author. This is useful at times when
> multiple people work on a single patch. Note, this person also needs to
> have a Signed-off-by: line in the patch as well."
>
> Thanks,
> Laurent
>
Thanks Laurent,I will fix this


