Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564D0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B9E2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuC1SAW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B9E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpXH-0006eg-AS
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38466)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQpVU-0004t1-7I
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQpVT-00049p-PP
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50641
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQpVT-00048a-Ap
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587462473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=talIZWqrnsNT2OHum5lzcO2erqNaBJ8V0sM/482iDfs=;
 b=TuC1SAW+9fYBU4YhZtYdf4lMKOxalo3c8UlEd/oKghbXvkE3R1GqymZ7Yvi7K1orf7Hto3
 Jg/w9txx4VyBN0XwGXr0l6lNxKjpv1yN1lsrzPbtnudK9LSZA+7+/jsE7VAxDcSzKHebMG
 ZFREs9MH7yhI4kZ0HYxC2iUtNZ096vA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-EOL38F1cPNGInBlogwGZSg-1; Tue, 21 Apr 2020 05:47:49 -0400
X-MC-Unique: EOL38F1cPNGInBlogwGZSg-1
Received: by mail-pl1-f199.google.com with SMTP id w16so11095680plq.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=talIZWqrnsNT2OHum5lzcO2erqNaBJ8V0sM/482iDfs=;
 b=BDyt+Inz4xtsi2d343zvZoSKniusSgBriK2zMdt9C3oKKPheKTgypxgOsgL+W4by7k
 2ZO1FJfFefmhwFQEtPy1oyvpb4XDj1dKNC5ZDivj16phfLMz4uoQ06BH6IJBYS6b4X0O
 sMIrhSLsfaQF/6tJS/BVKGZE9ih+IvrKfTKS+KGfWBql4Wr58bwUMT0U6QT5rGOMU7OD
 qK/puNzFJXoYyGVpm0xuKjrCzGPtStGMrdsKKf5L8niuki5gu3SAas/0UiSVG4SwjVIF
 dY6bvIcleO9G+18j5pFVNyL3poNeXOTXfIRCx0c3qsj5CSoBYzbkoJ0TeiVrBJgEq6IU
 y08A==
X-Gm-Message-State: AGi0Pubb0lkgeOhJxrlo1An+8gsPNvNKDBbQqRoNHl+SNVSKT4x3uKGT
 GybePGyCK84eUgwhuULldXvcLAhjRZQLL1byQUoeoOq8IFDUlyAI2U/L8S3OjhdcN7V0Rv7LlUl
 ifQWZLGhf5ao5rb1TLJGcAzWwMtpGYXc=
X-Received: by 2002:a65:68c7:: with SMTP id k7mr21244365pgt.248.1587462468665; 
 Tue, 21 Apr 2020 02:47:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypK+qp0/Yijhy1axo85pWfpeuTqE8eXvna7UNpF289PSRDhPKhBk47cDVIseFQvHF1za9Ie56cl22jFFORVxgTY=
X-Received: by 2002:a65:68c7:: with SMTP id k7mr21244316pgt.248.1587462468332; 
 Tue, 21 Apr 2020 02:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200420093241.4238-1-lulu@redhat.com>
 <43587e34-b616-98bd-e2f0-20303d4af393@redhat.com>
In-Reply-To: <43587e34-b616-98bd-e2f0-20303d4af393@redhat.com>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 21 Apr 2020 17:47:37 +0800
Message-ID: <CACLfguU-6D79nZC0gfx5fPHzEa1umo2aP2k_hfv1s0ztLqi_Hg@mail.gmail.com>
Subject: Re: [RFC v1 0/4] vDPA support in qemu
To: Jason Wang <jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000084fccd05a3c9e897"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 01:28:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: cohuck@redhat.com, Michael Tsirkin <mst@redhat.com>, mhabets@solarflare.com,
 qemu-devel@nongnu.org, hanand@xilinx.com, rob.miller@broadcom.com,
 saugatm@xilinx.com, armbru@redhat.com, hch@infradead.org,
 Eugenio Perez Martin <eperezma@redhat.com>, jgg@mellanox.com,
 shahafs@mellanox.com, kevin.tian@intel.com, parav@mellanox.com,
 vmireyno@marvell.com, "Liang, Cunming" <cunming.liang@intel.com>,
 gdawar@xilinx.com, jiri@mellanox.com, xiao.w.wang@intel.com,
 stefanha@redhat.com, "Wang, Zhihong" <zhihong.wang@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 maxime.coquelin@redhat.com, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000084fccd05a3c9e897
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Jason, I will fix these problems and send new version soon

On Tue, Apr 21, 2020 at 12:05 PM Jason Wang <jasowang@redhat.com> wrote:

>
> On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:
> > vDPA device is a device that uses a datapath which complies with the
> > virtio specifications with vendor specific control path. vDPA devices
> > can be both physically located on the hardware or emulated by software.
> > This RFC introduce the vDPA support in qemu
>
>
> And please mention the TODO list. E.g:
>
> 1) vIOMMU support
> 2) software assisted live migration
>
> Thanks
>
>

--00000000000084fccd05a3c9e897
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks=C2=A0Jason, I will fix these problems and send=
 new version soon=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr=
" class=3D"gmail_attr">On Tue, Apr 21, 2020 at 12:05 PM Jason Wang &lt;<a h=
ref=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
On 2020/4/20 =E4=B8=8B=E5=8D=885:32, Cindy Lu wrote:<br>
&gt; vDPA device is a device that uses a datapath which complies with the<b=
r>
&gt; virtio specifications with vendor specific control path. vDPA devices<=
br>
&gt; can be both physically located on the hardware or emulated by software=
.<br>
&gt; This RFC introduce the vDPA support in qemu<br>
<br>
<br>
And please mention the TODO list. E.g:<br>
<br>
1) vIOMMU support<br>
2) software assisted live migration<br>
<br>
Thanks<br>
<br>
</blockquote></div></div>

--00000000000084fccd05a3c9e897--


