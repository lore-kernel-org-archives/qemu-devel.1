Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDF1C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:36:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD3ED2225E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmWsfG3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD3ED2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZXC9-0006iw-Ir
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 05:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZXBB-0005tl-FZ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:35:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27016)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZXB8-0006OO-Nm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 05:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604313309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJWI+AehPUDEnWpfA416YDr42UqW/df4IkVyTwqf06E=;
 b=YmWsfG3eU7XnXU0/y4Lhi/5ixsJGLQ048XI62RcgYKuYfzh1qLkLhZLaPHUQa2j95bf22I
 PdeYqhu9fJdBvwifOhYJ0FzuKyEvvQds9mDZtuYKhTOv0Epk86JcVQ5O8svtLUViacWMFU
 RahkntOuM/CRekJcTJs92xiMuHWTVJM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-RPxJsgw3O-KB4YM9ncl2Tg-1; Mon, 02 Nov 2020 05:35:07 -0500
X-MC-Unique: RPxJsgw3O-KB4YM9ncl2Tg-1
Received: by mail-wm1-f71.google.com with SMTP id t21so1723555wmt.8
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 02:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=jJWI+AehPUDEnWpfA416YDr42UqW/df4IkVyTwqf06E=;
 b=GG0EHvge/0TXHYPJFV8KiD2FjAa/pCo40E2N2nD4bbfeNJFPE+rnDjBmQs5STc8q/y
 jhx4v9l3NS9l4sfzwI2jjW23/wLHP+S6ahFhQPy8X6SGM1VGGW4W9sr5MxrDTon/MMO4
 lN1S/Q7p/yPXUsjRFmngg12M3PjGv95Q6B6PpQOZX4woZKISFgvn8KE4jRLeG6TyZX8z
 E5a42He5Qh2xRAvUWv639vr2zB7L7qTRgM102IQMP2/nYHuyZej5XshKBi01VynrxAFC
 pOSkiGyZQfcemYCVPFsTHOykSM3+oePscLXA2aMPLr/l1zRKttcuRENnCOwIJht0g3UQ
 T6RQ==
X-Gm-Message-State: AOAM533/S8FTqtitH48wyyQQSds7tfvVT/ROd0RT2Y65/VhJQb7irjR7
 PkrVNVXIpENeA58y7eRc4LzvaLoSj81+Tz1yrPcTFy/wMQXR+4y6qtYz09q0gBg5Heftd+Jm7nV
 f7WFWAew5zvIOS+0=
X-Received: by 2002:a1c:3502:: with SMTP id c2mr11679829wma.79.1604313306449; 
 Mon, 02 Nov 2020 02:35:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyL8TB0awLU70BUFMMxE2cT5jE+LUGMDTR5m+w5R6jgheOkhCN6MvZgfoa5gjyVx9EGwsfSJw==
X-Received: by 2002:a1c:3502:: with SMTP id c2mr11679786wma.79.1604313306257; 
 Mon, 02 Nov 2020 02:35:06 -0800 (PST)
Received: from redhat.com (bzq-79-182-97-190.red.bezeqint.net. [79.182.97.190])
 by smtp.gmail.com with ESMTPSA id y2sm21976969wrh.0.2020.11.02.02.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 02:35:05 -0800 (PST)
Date: Mon, 2 Nov 2020 05:34:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201102053142-mutt-send-email-mst@kernel.org>
References: <20201029083130.0617a28f@w520.home>
 <b85405de-d525-bf59-826c-737fa7bbdfef@redhat.com>
 <20201029094603.15382476@w520.home>
 <d4f7df42-7b02-6505-c2c7-245bf813b513@redhat.com>
 <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <0cabda60-f10d-fb74-f3eb-d21be7db7334@redhat.com>
 <20201102102754.GB42093@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201102102754.GB42093@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/02 01:33:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 John G Johnson <john.g.johnson@oracle.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Yan Vugenfirer <yan@daynix.com>,
 Jag Raman <jag.raman@oracle.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 02, 2020 at 10:27:54AM +0000, Stefan Hajnoczi wrote:
> On Mon, Nov 02, 2020 at 11:00:12AM +0800, Jason Wang wrote:
> > 
> > On 2020/10/30 下午7:13, Stefan Hajnoczi wrote:
> > > > I still don't get why it must be opaque.
> > > If the device state format needs to be in the VMM then each device
> > > needs explicit enablement in each VMM (QEMU, cloud-hypervisor, etc).
> > > 
> > > Let's invert the question: why does the VMM need to understand the
> > > device state of a_passthrough_  device?
> > 
> > 
> > It's not a 100% passthrough device if you want to support live migration.
> > E.g the device state save and restore is not under the control of drivers in
> > the guest.
> 
> VFIO devices are already not pure passthrough (even without mdev) since
> the PCI bus is emulated and device-specific quirks may be implemented.

So since it's not a pure passthrough anyway, let's try to
introduce some standards even if we can not always enforce
them.

> Adding device state save/load does not change anything here.

It's as good a time as any to try to standardize things and
not just let each driver do whatever it wants. In particular
if you consider things like cross version support it's
a hard problem where vendors are sure to get it wrong without
guidance.

-- 
MST


