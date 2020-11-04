Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE23C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48EA52080D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSK/+sIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48EA52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDT1-0004hl-4L
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaDRm-0004IT-PO
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:43:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaDRl-0006Dk-07
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604475787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeW5QF1ogV0au6pSJpSicNer5lVbwZRbBeNdEdrVLd4=;
 b=LSK/+sITBZSJsBYGqRQSFZw3anR2OOR0CC4mE7e5RgwyotwyRUGuaVNbMotkVZnkv1on3j
 +9rIFmbosuOMA3NpL23OO2oqpKbflZ5z0NWKMh1eTLtRhiOEDpNs5Qyo7XgQqPH5h4tIen
 7WFXBEHpJKD0wwekjaXqzL2krCgDehU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-v7JpW10FOnW-BKIGCyc8rg-1; Wed, 04 Nov 2020 02:43:03 -0500
X-MC-Unique: v7JpW10FOnW-BKIGCyc8rg-1
Received: by mail-wm1-f72.google.com with SMTP id u207so877194wmu.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 23:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YeW5QF1ogV0au6pSJpSicNer5lVbwZRbBeNdEdrVLd4=;
 b=H3hn1Ll0nnjludRLLV3zzv/WxLLSR+y0g2J7dW7XDdOMlipp14wj3ZNjSYWKoCGohF
 TtA3wOMePh0ZMHcKmnDbp+IojDhjSsaAIsJgv+4KU2kpJxlhFd5aNczXLMTh/5yzDbf1
 laTL1VweoOtqSBmlrvHEKY4019Jx2a9K+x9vjsIrey6EUEwiH94pzfvcRF+uory762yj
 6DLo3T5/yFzKSq3Niiclbb/ieuhhsH2lDNp6tvUC5I3SDRAHZiC6nDdRSfvbGKNunC3V
 VUdQHf8lNczOr6xFiCpwpLyiNgLCQjZInWknkhjCfoNA446c8A4pSVy2gYNhLLaOrjRz
 wOwg==
X-Gm-Message-State: AOAM533U/yLNHq5FpPXSK1iFytY7piN80jBZYsDKHrqWiu3KEJ0cua/L
 KXxUEp9q8rqJV/5kcTOgtpDB1b6nGVyLTwPT2MBEHNAiYbsc/mg6mFse+GvywDfOfMt4C+6u5Ci
 uJTBtacyDJtNamcw=
X-Received: by 2002:adf:f142:: with SMTP id y2mr29986469wro.160.1604475782247; 
 Tue, 03 Nov 2020 23:43:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyb/6/gZzTWIoZiyVqbgu4gYM2f2Yip4uhShCL056MsMeAEZ+ugyn0HO3q12b0GHnycHoTiQ==
X-Received: by 2002:adf:f142:: with SMTP id y2mr29986430wro.160.1604475782015; 
 Tue, 03 Nov 2020 23:43:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id u6sm1146290wmj.40.2020.11.03.23.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 23:43:01 -0800 (PST)
Date: Wed, 4 Nov 2020 02:42:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201104024052-mutt-send-email-mst@kernel.org>
References: <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <95432b0c-919f-3868-b3f5-fc45a1eef721@redhat.com>
 <CAJSP0QX_=dbDB2k7H-6D19ns1_HuM2P5ZMtUrFN9H7WU8aDXCg@mail.gmail.com>
 <1cf6b664-63cc-7b57-0a2c-4d4f979d4950@redhat.com>
 <20201102101308.GA42093@stefanha-x1.localdomain>
 <c007455d-b9fc-32d5-a58c-fd8d17794996@redhat.com>
 <CAJSP0QXJd-BK60t+efhAt2d6mj9+kgieiyfKm=DSC1z+fDCesA@mail.gmail.com>
 <20201104065052.hrc2entvg7bkodb6@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20201104065052.hrc2entvg7bkodb6@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
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

On Wed, Nov 04, 2020 at 07:50:52AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > I think not. Obviously each firmware should have its own ABI no matter
> > > whether its public or proprietary. For proprietary firmware, it should
> > > be understood by the proprietary userspace counterpart.
> > 
> > Userspace does not necessarily need to interpret the contents. The
> > vendor can ship a binary blob and the driver loads the file onto the
> > device without interpreting it.
> 
> Exactly.  Neither userspace nor kernel look at the blob, except maybe
> some headers with version, size, checksum etc.  Only the device does
> something with the actual content.
> 
> Doing the same make sense for migration device state.  The kernel driver
> saves and restores the device state.  Userspace doesn't need to look at
> it.  Again, with an exception for some header fields.
> 
> So requiring userspace being able to interpret the migration data
> (except header) for all devices looks rather pointless to me.

If nothing else we need a good place where vendors can publish this
data.

> Speaking of headers: Defining a common header format makes sense.
> For standard devices (virtio, nvme, ...) it makes sense to try define
> a standard, cross-vendor migration data format.
> For vendor-specific devices (gpus for example) I absolutely don't see
> the point.
> 
> take care,
>   Gerd


