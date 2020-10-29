Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_PH_BODY_ACCOUNTS_PRE autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EABDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91482087E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSeZeNzU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91482087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY95x-0004vd-MJ
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kY8yC-0001yf-DJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kY8y9-0006pz-V4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603981917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hjs/4gU0vgPWp16yGCLxWyrnNq57vsBbrFdCTR2YCpE=;
 b=jSeZeNzUrnLrSz0C3z5Kc1zisllDD869OTq618+/z6IQYxCRvfSv9tUvu9OlrwrhlHm3PG
 8MXqG7geE8Y+2h/sgrzEFOTFXKAY12YiCSu6WHbhWV2JMx/JQAV/7ZpT3El+Qh3VOvrb04
 YnEIuoohUfccGJaEjyuRrDmER0P/k6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-CDBpr4e1PYaWyCbyIfR-Rw-1; Thu, 29 Oct 2020 10:31:56 -0400
X-MC-Unique: CDBpr4e1PYaWyCbyIfR-Rw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F574393B7;
 Thu, 29 Oct 2020 14:31:53 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DFD576642;
 Thu, 29 Oct 2020 14:31:33 +0000 (UTC)
Date: Thu, 29 Oct 2020 08:31:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: Out-of-Process Device Emulation session at KVM Forum 2020
Message-ID: <20201029083130.0617a28f@w520.home>
In-Reply-To: <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
References: <20201027151400.GA138065@stefanha-x1.localdomain>
 <CAJSP0QWrmNN1Ci-M-4WDFZBOGHyeZvF71utg0w2ajCbOLtynJw@mail.gmail.com>
 <c4e5b631-1607-a0ec-ee88-6c5a9493e3de@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001 autolearn=ham autolearn_force=no
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
 "mst@redhat.com" <mtsirkin@redhat.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Yan Vugenfirer <yan@daynix.com>, Jag Raman <jag.raman@oracle.com>,
 Anup Patel <anup@brainfault.org>,
 Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Halil Pasic <pasic@linux.vnet.ibm.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Christophe de Dinechin <dinechin@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, fam <fam@euphon.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 21:02:05 +0800
Jason Wang <jasowang@redhat.com> wrote:

> On 2020/10/29 =E4=B8=8B=E5=8D=888:08, Stefan Hajnoczi wrote:
> > Here are notes from the session:
> >
> > protocol stability:
> >      * vhost-user already exists for existing third-party applications
> >      * vfio-user is more general but will take more time to develop
> >      * libvfio-user can be provided to allow device implementations
> >
> > management:
> >      * Should QEMU launch device emulation processes?
> >          * Nicer user experience
> >          * Technical blockers: forking, hotplug, security is hard once
> > QEMU has started running
> >          * Probably requires a new process model with a long-running
> > QEMU management process proxying QMP requests to the emulator process
> >
> > migration:
> >      * dbus-vmstate
> >      * VFIO live migration ioctls
> >          * Source device can continue if migration fails
> >          * Opaque blobs are transferred to destination, destination can
> > fail migration if it decides the blobs are incompatible =20
>=20
>=20
> I'm not sure this can work:
>=20
> 1) Reading something that is opaque to userspace is probably a hint of=20
> bad uAPI design
> 2) Did qemu even try to migrate opaque blobs before? It's probably a bad=
=20
> design of migration protocol as well.
>=20
> It looks to me have a migration driver in qemu that can clearly define=20
> each byte in the migration stream is a better approach.

Any time during the previous two years of development might have been a
more appropriate time to express your doubts.

Note that we're not talking about vDPA devices here, we're talking
about arbitrary devices with arbitrary state.  Some degree of migration
support for assigned devices can be implemented in QEMU, Alex Graf
proved this several years ago with i40evf.  Years later, we don't have
any vendors proposing device specific migration code for QEMU.

Clearly we're also trying to account for proprietary devices where even
for suspend/resume support, proprietary drivers may be required for
manipulating that internal state.  When we move device emulation
outside of QEMU, whether in kernel or to other userspace processes,
does it still make sense to require code in QEMU to support
interpretation of that device for migration purposes?  That seems
counter to the actual goal of out-of-process devices and clearly hasn't
work for us so far.  Thanks,

Alex


