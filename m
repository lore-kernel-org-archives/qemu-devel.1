Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E91C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BD92064A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eacKIg4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BD92064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSzkL-00087j-Ix
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSzie-0006ez-7d
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jSzid-0000IE-Oi
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jSzid-0000Hl-BG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587978386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXsvdutah6t9CH5x8BGSgdvoKtSOCPu4HQcKovAZ6iI=;
 b=eacKIg4CPo+s+8o0E9G2KbrQfeoDBR1R7h1+8P+p5xFn28QGlB1kcP5jPEQmHNJDjPa8VS
 D5cN+9CDmzapRtXzKuBI6l3+rLxXnhdKbzORTYd4KpPlkMideQuYctP7ZPtIZQVxfcYYjd
 vdV2NmySuneOSrGRogWtul0XH71xfaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-A53jBI3fM6-2e5paFePLOA-1; Mon, 27 Apr 2020 05:06:22 -0400
X-MC-Unique: A53jBI3fM6-2e5paFePLOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E67E8800688;
 Mon, 27 Apr 2020 09:06:20 +0000 (UTC)
Received: from gondolin (ovpn-112-184.ams2.redhat.com [10.36.112.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FABC5C1D6;
 Mon, 27 Apr 2020 09:06:12 +0000 (UTC)
Date: Mon, 27 Apr 2020 11:06:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH] hw: add compat machines for 5.1
Message-ID: <20200427110609.36ecaac6.cohuck@redhat.com>
In-Reply-To: <548cd0de-17d3-204d-7df1-4c8fdccad83c@redhat.com>
References: <20200424090314.544-1-cohuck@redhat.com>
 <548cd0de-17d3-204d-7df1-4c8fdccad83c@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 23:32:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Apr 2020 09:43:33 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Connie,
> 
> On 4/24/20 11:03 AM, Cornelia Huck wrote:
> > Add 5.1 machine types for arm/i440fx/q35/s390x/spapr.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > Still keeping the default cpu model version on x86 at v1.
> > 
> > I'll queue this to my s390-next branch, as I'm planning to send a pull
> > req as soon as 5.0 is out; if someone else wants to queue this, we'll
> > figure it out :)
> > 
> > ---
> >  hw/arm/virt.c              |  9 ++++++++-
> >  hw/core/machine.c          |  3 +++
> >  hw/i386/pc.c               |  3 +++
> >  hw/i386/pc_piix.c          | 14 +++++++++++++-
> >  hw/i386/pc_q35.c           | 13 ++++++++++++-
> >  hw/ppc/spapr.c             | 15 +++++++++++++--
> >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> >  include/hw/boards.h        |  3 +++
> >  include/hw/i386/pc.h       |  3 +++
> >  9 files changed, 71 insertions(+), 6 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 7dc96abf72cf..5e84c09402dd 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2309,15 +2309,22 @@ static void machvirt_machine_init(void)
> >  }
> >  type_init(machvirt_machine_init);
> >  
> > +static void virt_machine_5_1_options(MachineClass *mc)
> > +{
> > +}
> > +DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> > +
> >  static void virt_machine_5_0_options(MachineClass *mc)
> >  {
> >      static GlobalProperty compat[] = {
> >          { TYPE_TPM_TIS_SYSBUS, "ppi", "false" },
> >      };
> >  
> > +    virt_machine_5_1_options(mc);
> > +    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
> >      compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));  
> As spotted by patchew we need { TYPE_TPM_TIS_SYSBUS, "ppi", "false" } to
> be applied for all machine types 5_0 onwards as our tpm-tis-device does
> not support PPI. So I guess we need to move compat[] declaration outside
> of virt_machine_5_0_options and call
> "compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));"
> for each  virt_machine_5_*_options? Or is a misuse of compats?

Ah, that was the error (I could not really make sense of it).

So, if I understand it correctly, ppi needs to be disabled for all virt
machines. I think the correct way to do this would be to add the
"compat" prop in virt_machine_class_init() (even if it is not strictly
compat, as it always needs to be disabled). It can be removed there and
added to a compat machine should support be added in the future.

Or does anyone have a better idea?


