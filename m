Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE4C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC712222B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 06:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C71l6B3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC712222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaCeq-0003TP-IQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 01:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaCdk-00032B-Pz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:51:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaCdi-0002nj-Iv
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 01:51:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604472685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fXP88vP5/sPDu8+yOvpevfUaErJi7jKQfn/zEKAkM2E=;
 b=C71l6B3gFi8rk3n8H0ZAaPhzUEne3q4gXGw023DPbdyOdAdy5MRmuVUTPUoO8/qo7DLdSn
 kaS9z3JDtsiN2GdQ86pK9N1VzM0yXskgxMYx7BSwhWU+eInQUtTib+McUnY29/fV1T0xc6
 nAS+W7XVnKY1ZwBdkjQ38Bwzitnng9U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-kSD58KttNhiEqGiI_pe7oQ-1; Wed, 04 Nov 2020 01:51:23 -0500
X-MC-Unique: kSD58KttNhiEqGiI_pe7oQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60172835B77;
 Wed,  4 Nov 2020 06:51:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 550F221E84;
 Wed,  4 Nov 2020 06:50:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5B55616E31; Wed,  4 Nov 2020 07:50:52 +0100 (CET)
Date: Wed, 4 Nov 2020 07:50:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201104065052.hrc2entvg7bkodb6@sirius.home.kraxel.org>
References: <20201029210407.33d6f008@x1.home>
 <CAJSP0QVto+xFEnWv-aj=-0mZ72SzfeAvg4q0RCoLGK-N7C-WEw@mail.gmail.com>
 <04179584-3324-994e-d793-04be18d2dab2@redhat.com>
 <CAJSP0QXQmFgtSsJL1B3eMUr8teQc3cvvEFvr7LvnFkJPcE3ZpA@mail.gmail.com>
 <95432b0c-919f-3868-b3f5-fc45a1eef721@redhat.com>
 <CAJSP0QX_=dbDB2k7H-6D19ns1_HuM2P5ZMtUrFN9H7WU8aDXCg@mail.gmail.com>
 <1cf6b664-63cc-7b57-0a2c-4d4f979d4950@redhat.com>
 <20201102101308.GA42093@stefanha-x1.localdomain>
 <c007455d-b9fc-32d5-a58c-fd8d17794996@redhat.com>
 <CAJSP0QXJd-BK60t+efhAt2d6mj9+kgieiyfKm=DSC1z+fDCesA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXJd-BK60t+efhAt2d6mj9+kgieiyfKm=DSC1z+fDCesA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
 John G Johnson <john.g.johnson@oracle.com>,
 "mst@redhat.com" <mtsirkin@redhat.com>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > I think not. Obviously each firmware should have its own ABI no matter
> > whether its public or proprietary. For proprietary firmware, it should
> > be understood by the proprietary userspace counterpart.
> 
> Userspace does not necessarily need to interpret the contents. The
> vendor can ship a binary blob and the driver loads the file onto the
> device without interpreting it.

Exactly.  Neither userspace nor kernel look at the blob, except maybe
some headers with version, size, checksum etc.  Only the device does
something with the actual content.

Doing the same make sense for migration device state.  The kernel driver
saves and restores the device state.  Userspace doesn't need to look at
it.  Again, with an exception for some header fields.

So requiring userspace being able to interpret the migration data
(except header) for all devices looks rather pointless to me.

Speaking of headers: Defining a common header format makes sense.
For standard devices (virtio, nvme, ...) it makes sense to try define
a standard, cross-vendor migration data format.
For vendor-specific devices (gpus for example) I absolutely don't see
the point.

take care,
  Gerd


