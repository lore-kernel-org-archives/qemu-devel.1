Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 08:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BFD820771
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 08:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F81TaO7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFD820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpSXm-0002Lf-QK
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 04:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpSX4-0001ur-22
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 04:19:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jpSX2-0003rc-5A
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 04:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593332359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFIWrpFRnlY8+OazB9ZVdlEN6ivECRMxyetkkjxpK9E=;
 b=F81TaO7es/l5cTWJ7R8ocrqVJuVgSBUGMlqj5rhK1YrZ/yuz88LZbKlakL9oaBjXi1x8uA
 0Aw7MLVWii8gIzhx4a241ERx6Do2Fik2jX3mi4+BEc7e6duyy+a0UhjldRqYvAgcTr5+tw
 0Hu8V1sSuQWxE1woDEGjOPG0yUzpv9I=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-nzL7qou_MGmw8cORROchVQ-1; Sun, 28 Jun 2020 04:19:15 -0400
X-MC-Unique: nzL7qou_MGmw8cORROchVQ-1
Received: by mail-pl1-f199.google.com with SMTP id b5so8280802pls.17
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 01:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EFIWrpFRnlY8+OazB9ZVdlEN6ivECRMxyetkkjxpK9E=;
 b=RSUWIyCsOzc+BTPMGg0CH9VY0HGJP5NArkjS9XNzQ/It1Wvu13NfDO1tw2IDHFd80K
 JhKduQkvMnu/tVofqrmebv2QCfcRuuyUpb4z2gi4dts8Y0dNsHsR6JTGNwtWAND74IBh
 dfvtS8K9pmQDseIyvYvFAigRwgQ5hlr/pnhURDu+trBXKejtXeqUAOe3RkPiaOcnod2K
 EdkOLP46eCCTXAOnwVdr0CBWY/c7LQIcBmyGE79VM/A+kFI3BOmx4boiRs6PtwYExYxn
 F+r2lQI9GptD4tWliFCTnHf+Qh+bn5m3Y0CINOZd+xW6j4Bp8e54Tp2Q6L+z10aikhFk
 Amvw==
X-Gm-Message-State: AOAM532d1ADFG+2ozIWS2V0jKb7ATZpMyCp1tvpUN+140Tju1knJM9yD
 n7muVLd9SPyjg7RAMV/0JNYdemo0qaMgCgudsid/CgnC9/NH/Pt5jSXhZfQ47einmle4vbrd8Qk
 l2B3yo5ahC6JQSwJMNxEMIfbN0aPaRhE=
X-Received: by 2002:a17:902:b692:: with SMTP id
 c18mr8105577pls.274.1593332354590; 
 Sun, 28 Jun 2020 01:19:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7chScDx2r3Q5aAti1+vzpA/MmhWTktGOLEtosWO5tA9UIDAtW/C7oduy4YsYC7P0zPmRcI42qDVGITR208NU=
X-Received: by 2002:a17:902:b692:: with SMTP id
 c18mr8105545pls.274.1593332354338; 
 Sun, 28 Jun 2020 01:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200622153756.19189-1-lulu@redhat.com>
 <2b8a5cd5-1306-6760-59aa-f0312868ee11@redhat.com>
In-Reply-To: <2b8a5cd5-1306-6760-59aa-f0312868ee11@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Sun, 28 Jun 2020 16:19:03 +0800
Message-ID: <CACLfguWC_rznRp20X1WpoJACP9Thk0OvAjA-m75+eGmnsJ6rkw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] vDPA support in qemu
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 03:07:30
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
Cc: Cornelia Huck <cohuck@redhat.com>, Michael Tsirkin <mst@redhat.com>,
 mhabets@solarflare.com, qemu-devel@nongnu.org, hanand@xilinx.com,
 Rob Miller <rob.miller@broadcom.com>, saugatm@xilinx.com,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 Shahaf Shuler <shahafs@mellanox.com>, kevin.tian@intel.com, parav@mellanox.com,
 Vitaly Mireyno <vmireyno@marvell.com>, "Liang,
 Cunming" <cunming.liang@intel.com>, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>, "Wang,
 Zhihong" <zhihong.wang@intel.com>, Ariel Adam <aadam@redhat.com>,
 rdunlap@infradead.org, Maxime Coquelin <maxime.coquelin@redhat.com>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 28, 2020 at 3:07 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2020/6/22 =E4=B8=8B=E5=8D=8811:37, Cindy Lu wrote:
> > vDPA device is a device that uses a datapath which complies with the
> > virtio specifications with vendor specific control path. vDPA devices
> > can be both physically located on the hardware or emulated by software.
> > This RFC introduce the vDPA support in qemu
> > TODO
> > 1) vIOMMU support
> > 2) live migration support
>
>
> Jut notice that the config interrupt [1] looks missed in this series.
>
> Please add them in next version.
>
> Thanks
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D776f395004d829bbbf18c159ed9beb517a208c71
>
sure will add this part


