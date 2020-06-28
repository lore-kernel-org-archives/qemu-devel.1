Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B17C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB5220768
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 01:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TaQePKXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpMGy-00062b-6p
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 21:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpMGE-0005c2-65
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:37:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpMGC-0001kJ-Ga
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 21:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593308251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8hMocK+M7XFI8ekbVeJAF+qutZVxp0buX2uLgQl9OY=;
 b=TaQePKXbpqpYyyK9pUlsZ89wnQj9NxvxiY8tZzmpfWCT3y4A8LEUwOqvFhk4YzqRDYZKGZ
 f8sXWJGmnNYzrUr6boi5rzd9WwuC3e/y+PVJkAXbFV5nM7OJsaYKukZUmSPNbON/2iWaIF
 zfiLW468TNw5HgPZc2qyHOrDnmmkvhQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-AOSkP5miOUeat9SDVuNlPQ-1; Sat, 27 Jun 2020 21:37:27 -0400
X-MC-Unique: AOSkP5miOUeat9SDVuNlPQ-1
Received: by mail-pj1-f69.google.com with SMTP id d14so10344905pjw.5
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 18:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x8hMocK+M7XFI8ekbVeJAF+qutZVxp0buX2uLgQl9OY=;
 b=nm7pd05Q28GgqkCAyWS0w6DvXY/dNo/W3FpUglwtrfpXc6ZDjLoQuujzq1PcUKQ8oH
 r7mN7Hd3oCWo6ZFlCkqkYhcNNtpbJzKSdcz6zBD1f9spe23ruLBUnoTCS+HtRADbnqoP
 TAlrBEXOp/HQgCvG/SeaYM45BvkBrbbymN92Q03AoSxCczrdxyHwmAFhlmDhjA3+SUyd
 FkqHmzKgSPEfqbp9PbByXHnStwhXr2gjpICJfo43aoEnMVuc/s4FLuL49T+VaBCAdM05
 4Iv26J5ko0n5xWzidYy509iP3pQw1LMzLKpPrlI0ArJOYg7pUzkGg2Lmmb2VuSNbf1dD
 /sFA==
X-Gm-Message-State: AOAM5305kLSMSvNZH0k1bT9O8mPKGsGocD/SDW0vA7FFhVc7ER4Kaps8
 Wa4DxlUSjH1QqGJjzj+Fu8az63yp9s+wZdPMC7veIfByD/ZPfcYYCeIwy57zY/3k1pbC92I4ov3
 bmyBZMQZcdc5u6d74PGEDjirxx7Zkakk=
X-Received: by 2002:a62:7ccd:: with SMTP id x196mr8558059pfc.23.1593308246258; 
 Sat, 27 Jun 2020 18:37:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+fJruFgBrXT8IyMBFs+IucAdtKnP8atvXQgAuXMQtuUeDmP9/DWse39qkwlNorqPsjhSp97+gngBo2NX9GQo=
X-Received: by 2002:a62:7ccd:: with SMTP id x196mr8558024pfc.23.1593308246002; 
 Sat, 27 Jun 2020 18:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <877dvy45vr.fsf@dusky.pond.sub.org>
 <CACLfguWUoV7Ngt0U3Rdenvyp1s0PcWk2xsJirYGvHR3KSmZoeA@mail.gmail.com>
 <c8929663-27f2-93d6-e7b5-a3dc269fa7d2@redhat.com>
 <CACLfguW04Lz8jbe+HOPMk7V46A91USc7eo+XdP+3BX+OeOFzDA@mail.gmail.com>
 <87v9jf7nu8.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9jf7nu8.fsf@dusky.pond.sub.org>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 28 Jun 2020 09:37:15 +0800
Message-ID: <CACLfguVO_ZGWDM48HLi=XT3pfZF0aT9wqjyuUVnBvvgOp0DSHw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] vDPA support in qemu
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/27 21:37:31
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

On Thu, Jun 25, 2020 at 12:48 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>
> Cindy Lu <lulu@redhat.com> writes:
>
> > On Tue, Jun 23, 2020 at 5:43 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >>
> >> On 2020/6/23 =E4=B8=8B=E5=8D=885:16, Cindy Lu wrote:
> >> > On Tue, Jun 23, 2020 at 3:07 PM Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >> Cindy Lu <lulu@redhat.com> writes:
> >> >>
> >> >>> vDPA device is a device that uses a datapath which complies with t=
he
> >> >>> virtio specifications with vendor specific control path. vDPA devi=
ces
> >> >>> can be both physically located on the hardware or emulated by soft=
ware.
> >> >>> This RFC introduce the vDPA support in qemu
> >> >>> TODO
> >> >>> 1) vIOMMU support
> >> >>> 2) live migration support
> >> >> This gives me the foggiest of ideas on what vDPA is.  Could we use
> >> >> docs/interop/vhost-vdpa.rst?
> >> >>
> >> > Sure will add this
> >> >
> >> >
> >>
> >> Not sure it's the best place since vhost-vdpa is kernel specific.
> >>
> >> Maybe kernel docs (TBD) is a better place and we can refer it this fil=
e
> >> in the future.
> >>
> >> But it doesn't harm if you said something more here and refer the kern=
el
> >> commit here:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D4c8cf31885f69e86be0b5b9e6677a26797365e1d
> >>
> >> Thanks
> >>
> >>
> > Hi Markus,
> > I think I agree with Jason's opinion, kernel docs is a better place.
> > Maybe we can keep what it is now, and do this job in the future.
>
> I think a super-short description of vDPA here (one sentence?) together
> with a link to complete information would be helpful.  If the link's
> target doesn't yet exist, adding the link later is okay.
>
sure thanks Markus, will do


