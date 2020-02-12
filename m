Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA7C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35DC120714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 09:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzcnhagT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35DC120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1o7h-0000y1-0i
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 04:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1o6x-0000PW-AK
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1o6v-000654-VZ
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:15:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1o6v-00063H-RO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 04:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581498908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWBcaYCnmul0MivQLsQCV063q1kIrzRox1sk7SxSSWE=;
 b=ZzcnhagT8e1gcH3DVjdu1vMfHP0hoIMDIfPsdZcWgctcKbrK4PpskAzrgy7fkXAT0mDPrb
 6uOMxTgF1BtfmPlSciZQlSQYntvyngkrefZA7i1NmnQ14cPAfU6z+A8kD7KtsSFU0XukRN
 hV8aAsIWjTAgojtNsFoZ17ScRw5qeJc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-b8s4NDyHP5WHlWFZP41utQ-1; Wed, 12 Feb 2020 04:15:06 -0500
Received: by mail-qt1-f198.google.com with SMTP id e37so853080qtk.7
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 01:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=emUnSXuU1gnGL6zBKl9lbYM4Of017ZRheWAF5EOYEWY=;
 b=V2ac1RQliVo7D7yKuBmPdYbu1vSRTjTcIueQBIO6vY0JvxyZwhdlIcwIY9BvwrnS0k
 eSXnM4aBWBKkSODxm/xaxRXpAV3IEVLRrQTPzNvH/mvTUmK6rHQvsp9enHOaqx0nNlt2
 HRvezxfpbBK4xcdPM4pZ+zczZ+mDm8B/XJGeh2szDqoDswW3O4jmQgUFDqwaIajRtbRk
 3qYgnRs7yZrIdF8YFaHuXlgDeGA4r1wDOxqLZhqU79h0iOmMJB7EaVHbLjked3z6Yagg
 Q8unCTV8IS9N2Cpc/DkE3AqOpd79OK6UrUhsbag+gzb3Eg+PL4k/z//QbNCohJN5GAsZ
 Kgvg==
X-Gm-Message-State: APjAAAWHme7ODV/Qu8BODh6zb/SB4BdMth37BIBetgrYVBlkxABhtoZN
 UzXqDcnYmiRl5/u77e6MExVpLzjO37my08K1LRbrnuHO4zqjen0adJ7SDwsMbySIFU7hmpbpO+9
 JBo4waR8o3qt6ok4=
X-Received: by 2002:a37:9d44:: with SMTP id g65mr9308945qke.15.1581498906464; 
 Wed, 12 Feb 2020 01:15:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlftBNRnpiBz+KvKNJz2frshDsvKQ2+OJG52e1nrZBO4xynJpwxurqShPM5E74UZozY6B2ag==
X-Received: by 2002:a37:9d44:: with SMTP id g65mr9308935qke.15.1581498906290; 
 Wed, 12 Feb 2020 01:15:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id h14sm84919qke.99.2020.02.12.01.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 01:15:05 -0800 (PST)
Date: Wed, 12 Feb 2020 04:15:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Message-ID: <20200212041317-mutt-send-email-mst@kernel.org>
References: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <20200211065319-mutt-send-email-mst@kernel.org>
 <c4a78a15-c889-df3f-3e1e-7df1a4d67838@redhat.com>
 <20200211070523-mutt-send-email-mst@kernel.org>
 <fdb19ef4-2003-6c6f-5c6f-c757a6320130@redhat.com>
 <20200211090003-mutt-send-email-mst@kernel.org>
 <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4557a5e8-74eb-f238-1579-b7b558cb2969@redhat.com>
X-MC-Unique: b8s4NDyHP5WHlWFZP41utQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, "Liu, Jing2" <jing2.liu@linux.intel.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 05:03:00PM +0800, Jason Wang wrote:
>=20
> On 2020/2/11 =E4=B8=8B=E5=8D=8810:00, Michael S. Tsirkin wrote:
> > > Yes, it can work but it may bring extra effort when you want to mask =
a
> > > vector which is was shared by a lot of queues.
> > >=20
> > > Thanks
> > >=20
> > masking should be per vq too.
> >=20
> > --=20
>=20
>=20
> Yes, but if the vector is shard by e.g 16 queues, then all those virtqueu=
es
> needs to be masked which is expensive.
>=20
> Thanks

I think that's ok - masking is rare. in fact if vectors can be
changed atomically I'm no longer sure they are needed,
maybe a destructive "disable" which can lose interrupts
is enough.

--=20
MST


