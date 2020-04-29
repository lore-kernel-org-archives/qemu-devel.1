Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F0C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A703720757
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 06:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWoFtJa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A703720757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTg1J-0006JF-Sq
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 02:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTfwg-0006d9-NZ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jTfwf-00033S-Hi
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32208
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jTfwf-00033A-3Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 02:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588140703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwldEiI0ZwLDLmWUgP1MXicIGX0GdoVJ5V5QMz1Z668=;
 b=MWoFtJa33qY7ugNNhYt0YaSifEMVvtBGxP33Mdgkq1O0e+esNZcHw9G5NlxVABloL6YjdJ
 3cpDlaVVHgbQfb8iVR/yUdlbkxszI4J0Pe8RnWvCSUuuUYzEZYML3mtzXwGu6nvEWlBpjF
 51glVb/cVeiSlXN0eWs+z8q1iDJiM+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-LlLx03WvO4CDg-s_UNKLHQ-1; Wed, 29 Apr 2020 02:11:37 -0400
X-MC-Unique: LlLx03WvO4CDg-s_UNKLHQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC4F107ACF2;
 Wed, 29 Apr 2020 06:11:36 +0000 (UTC)
Received: from gondolin (ovpn-112-87.ams2.redhat.com [10.36.112.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 051835D76A;
 Wed, 29 Apr 2020 06:11:31 +0000 (UTC)
Date: Wed, 29 Apr 2020 08:11:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 0/2] virt: Set tpm-tis-device ppi property to off by
 default
Message-ID: <20200429081129.18e9760a.cohuck@redhat.com>
In-Reply-To: <0257ca1e-2323-e437-4e19-d8a4dfa6d792@linux.ibm.com>
References: <20200427143145.16251-1-eric.auger@redhat.com>
 <20200428123826.1ec68e6c.cohuck@redhat.com>
 <0257ca1e-2323-e437-4e19-d8a4dfa6d792@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 16:13:05 -0400
Stefan Berger <stefanb@linux.ibm.com> wrote:

> On 4/28/20 6:38 AM, Cornelia Huck wrote:
> > On Mon, 27 Apr 2020 16:31:43 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >  
> >> Instead of using a compat in the mach-virt machine to force
> >> PPI off for all virt machines (PPI not supported by the
> >> tpm-tis-device device), let's simply change the default value
> >> in the sysbus device.
> >>
> >> Best Regards
> >>
> >> Eric
> >>
> >> Eric Auger (2):
> >>    tpm: tpm-tis-device: set PPI to false by default
> >>    hw/arm/virt: Remove the compat forcing tpm-tis-device PPI to off
> >>
> >>   hw/arm/virt.c           | 5 -----
> >>   hw/tpm/tpm_tis_sysbus.c | 2 +-
> >>   2 files changed, 1 insertion(+), 6 deletions(-)
> >>  
> > I think we can apply the compat machines patch on top of these two
> > patches.
> >
> > Q: Who will queue this and the machine types patch? It feels a bit
> > weird taking arm patches through the s390 tree :)
> >  
> I can queue them and would send the PR soon. I am also fine with someone 
> else doing it.

Would be great if you could queue these together with
https://patchew.org/QEMU/20200424090314.544-1-cohuck@redhat.com/
(hopefully should still apply cleanly, let me know if a respin is
needed).


