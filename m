Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2E5C388F9
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 21:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFA620729
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 21:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0u3Nv4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFA620729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYym7-0002vh-2Y
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 17:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYykU-000212-Sr
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 17:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kYykR-0000uw-2y
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 17:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604180955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2E0g2bWI1WmK5uNP5c1EfX+zaEDTTrktojsTZ6g15g0=;
 b=c0u3Nv4tqunqgGsVbT6D721XuVeC74n6aJxxCUsnPaXqAR97CBq9riC6Hq3J1adZCON6Nf
 eUWzgl8pa5pyKgDnFrAHKGNOn4EiYV8KPgD6GPyb50PcRaM/nuql37KwB2EPwg7eTIOZKW
 cA46pBO0uvXdkLYy+J82eqHVP1lyXiM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-91dtIVWtOmy_wlAF2hqUKQ-1; Sat, 31 Oct 2020 17:49:13 -0400
X-MC-Unique: 91dtIVWtOmy_wlAF2hqUKQ-1
Received: by mail-wr1-f70.google.com with SMTP id j15so4443105wrd.16
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 14:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2E0g2bWI1WmK5uNP5c1EfX+zaEDTTrktojsTZ6g15g0=;
 b=SXXxON2ZkQ/zeyZLZ0lMAmEoRXWapwZwf0kCDcX5FO1fXFlEfrW4Nmws9vbI7JZsQM
 T5rOMz/JBpgiMzOyEuWz2XeOGVS39WQou2gYt6R1In9Y4MrOr46a1sKbmhAwRwqahCxW
 WrG+gOUoShSszMIvcrLFtIWcqY65JLFJB4qRWTdQEFDbLidTCcZJMau+fZyHrBNBbWVx
 fs1UmjTOTL/Q27DNV1gl3AW9RA5v45/8u3wU/h/BKWfVfc5RLimMZMf5q3v+S7A4yLVq
 eu/Q+oVDe0YhviK6V3G2h5C03I5oVWS/pffXLgFvF18Mgt49pvzKWNblv8QX5d4TAsMg
 Lggw==
X-Gm-Message-State: AOAM533evzbyKtL2F/83AstFHm0djWw/y9eyFMBzGHrOGvygD0Ke+Z4p
 8eGzjMPxM4VdKO3Qaoa/hqr/NAYZMEL4eNLiP/0TYNgFJGjU1VWhlWiyAX7kyzUH+Sudby9s1qO
 6uJZlQT7u4rHbZaY=
X-Received: by 2002:adf:f687:: with SMTP id v7mr11909896wrp.179.1604180952132; 
 Sat, 31 Oct 2020 14:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4oM2XfvZyP6em4GNztYKFjxPVRLbjnmVDqjOWu+0cW2mdmCJIukHlWiYFF8RLm/AOBrewyw==
X-Received: by 2002:adf:f687:: with SMTP id v7mr11909858wrp.179.1604180951897; 
 Sat, 31 Oct 2020 14:49:11 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id x7sm13374114wrt.78.2020.10.31.14.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2020 14:49:10 -0700 (PDT)
Date: Sat, 31 Oct 2020 17:49:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201031174726-mutt-send-email-mst@kernel.org>
References: <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
 <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 17:49:15
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
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 John G Johnson <john.g.johnson@oracle.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 30, 2020 at 11:13:59AM +0000, Stefan Hajnoczi wrote:
> > > 3. The device can save/load opaque blobs. This is the initial VFIO
> > > approach.
> >
> >
> > I still don't get why it must be opaque.
> 
> If the device state format needs to be in the VMM then each device
> needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).

And QEMU cares why exactly?

> Let's invert the question: why does the VMM need to understand the
> device state of a _passthrough_ device?

To support cross version migration and compatibility checks.
This problem is harder than it appears, I don't think vendors
will do a good job of it without any guidance and standards.

-- 
MST


