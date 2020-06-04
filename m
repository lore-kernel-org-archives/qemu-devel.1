Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111F2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10F2206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBxA9oMs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10F2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgo97-00058H-4l
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgo8M-0004i0-1c
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48974
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgo8L-0002Q9-3l
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591270444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTJD/5S6sTH1G9/f+RtdhhC30e56I1/1Ew4Nt12YgB0=;
 b=BBxA9oMsAcdDyuRndzrPGvvnhA63fal1cr7h7yxccI5JuOV13iSMbeBrVoaBEYFHzQbg10
 ugDZ6RkCXAanBldqeEX+yITIKZurmPsq4+Uyru6dY2LgiPGSqZFHJZu5jTBne0jIC1YTTb
 sYiIcJHE8a8vzm5QiZAxtHBeEDdaPwk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-o8faFYORP5OKgOoRskNruw-1; Thu, 04 Jun 2020 07:33:57 -0400
X-MC-Unique: o8faFYORP5OKgOoRskNruw-1
Received: by mail-wr1-f71.google.com with SMTP id m14so2308812wrj.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LTJD/5S6sTH1G9/f+RtdhhC30e56I1/1Ew4Nt12YgB0=;
 b=NTzLuCKUkJzdKgcRtpVo90n/yGKD0R3H62LrnIWpCJasQ1ptY2M17ajt4PzhmkRXOA
 Bgr0xwdXEIYO3jALxZAIiarVAgzkVKhZTdQ77BZHjhZXEcAKOkRJ5Jr978t+ehM0n2zP
 frSF/PCTml6JIbR9M7MJHIuYX7bA6Ocmr95jXvPZulBZ2+IIk0ZEx+VjuTz8WiLmLtWR
 Ih17Jn1EQAWzzy/KmLt8txF2pn8xfxVAwM7vxEKDQj7rTQNk0shKuqZVfyrxYOpEe5r/
 Kgpn+KcsHsJBevv6d3hkOKndAOkNNKUd06ZUe8+vST0J4DBLvR08elk++x4tMjy3vVQX
 oKFQ==
X-Gm-Message-State: AOAM531sr2+KR8WbNuhTodX0hl3ACct6KfvXMEDrxOzav3o5V6MX7ywm
 b+OIW1RBaz2Ug6nXAZhcOoIqbzfz88veYDs5fiJk2aPGTGhrJQ+shFqSQQINChAp6njZivqJN0p
 oStim5h+lac3AfzQ=
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr3829194wrc.377.1591270436431; 
 Thu, 04 Jun 2020 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaeCodJ4O1azBWze1slKKT2PQ/jv0sTQZa6ahFdmQU3ENCP3ghzFJZcu1JtHdQY0SNpcc3mw==
X-Received: by 2002:a5d:6cce:: with SMTP id c14mr3829157wrc.377.1591270436222; 
 Thu, 04 Jun 2020 04:33:56 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id z2sm7307915wrs.87.2020.06.04.04.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:33:55 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:33:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v3 7/8] vhost-vdpa: introduce vhost-vdpa backend
Message-ID: <20200604073144-mutt-send-email-mst@kernel.org>
References: <20200529140620.28759-1-lulu@redhat.com>
 <20200529140620.28759-8-lulu@redhat.com>
 <CAJaqyWcTDDzgV_sHza80ZoRe8a=59zvszvmgLSFhxPht=_N82g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcTDDzgV_sHza80ZoRe8a=59zvszvmgLSFhxPht=_N82g@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:14:08
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
Cc: Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, hanand@xilinx.com, Rob Miller <rob.miller@broadcom.com>,
 saugatm@xilinx.com, Cindy Lu <lulu@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, hch@infradead.org, jgg@mellanox.com,
 mhabets@solarflare.com, shahafs@mellanox.com, kevin.tian@intel.com,
 parav@mellanox.com, Vitaly Mireyno <vmireyno@marvell.com>,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, Stefan Hajnoczi <stefanha@redhat.com>,
 zhihong.wang@intel.com, Tiwei Bie <tiwei.bie@intel.com>,
 Ariel Adam <aadam@redhat.com>, rdunlap@infradead.org,
 Maxime Coquelin <maxime.coquelin@redhat.com>, lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 12:39:34PM +0200, Eugenio Perez Martin wrote:
> > +static int vhost_vdpa_set_config(struct vhost_dev *dev, const uint8_t *data,
> > +                                   uint32_t offset, uint32_t size,
> > +                                   uint32_t flags)
> > +{
> > +    struct vhost_vdpa_config config;
> > +    int ret;
> > +    if ((size > VHOST_VDPA_MAX_CONFIG_SIZE) || (data == NULL)) {
> 
> VHOST_VDPA_MAX_CONFIG_SIZE is currently undefined.
> 
> If we want to maintain this as a stack allocation (as proposed in
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg701744.html) I
> think that the best option is to decide which is the maximum value buf
> can hold, and set it in vhost_vdpa_config.buf declaration.

That depends on device features. qemu has logic to figure out
config size based on that and set config_size accordingly.
Why not reuse it? Sending more should be ok and extra
data just ignored.

-- 
MST


