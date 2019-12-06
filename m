Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD0C2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:53:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979FC2075C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnJv17PZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEyq-00081x-8y
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1idESn-0005mm-1E
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1idESl-0007lp-Fv
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51742
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1idESl-0007i1-7R
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5HZHLsesUF3RBvUMYZS/Ng8o0IcHZw4J7J1QmgvKuA=;
 b=hnJv17PZZzvF0I2UaIlbW2k8nJh4psbPUqUG5Cl3cpkDZsEYGuVFtUbmqlnoLCG5KVzJ+G
 UmLrlf0EOSPBkDJvUk16WqwKhZKQpmTVB0ji0Qo2HcLmg7NuepT/8exPlmeEQu/ZSbAa3a
 8QDgaHxec1UglwiiiOrQFhli1IodrSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-ewz2r0prMKOC0JHgvdIjpQ-1; Fri, 06 Dec 2019 08:49:49 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEB99800EB9
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 13:49:48 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64B261001920;
 Fri,  6 Dec 2019 13:49:42 +0000 (UTC)
Date: Fri, 6 Dec 2019 14:49:40 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-5.0 8/8] acpi: cpuhp: spec: document procedure for
 enabling modern CPU hotplug
Message-ID: <20191206144940.091bef52@redhat.com>
In-Reply-To: <bb601078-db09-1915-1d12-350093887183@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-9-git-send-email-imammedo@redhat.com>
 <bb601078-db09-1915-1d12-350093887183@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: ewz2r0prMKOC0JHgvdIjpQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 15:07:53 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 12/04/19 18:05, Igor Mammedov wrote:
> > Describe how to enable and detect modern CPU hotplug interface.
> > Detection part is based on new CPHP_GET_CPU_ID_CMD command,
> > introduced by "acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command" patch.
> >
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  docs/specs/acpi_cpu_hotplug.txt | 22 ++++++++++++++++++++--
> >  1 file changed, 20 insertions(+), 2 deletions(-)  
> 
> Could we make this usecase / workflow independent of the new
> CPHP_GET_CPU_ID_CMD command please?
> 
> I'd like to suggest the following:
> 
> > diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> > index bb33144..667b264 100644
> > --- a/docs/specs/acpi_cpu_hotplug.txt
> > +++ b/docs/specs/acpi_cpu_hotplug.txt
> > @@ -15,14 +15,14 @@ CPU present bitmap for:
> >    PIIX-PM  (IO port 0xaf00-0xaf1f, 1-byte access)
> >    One bit per CPU. Bit position reflects corresponding CPU APIC ID. Read-only.
> >    The first DWORD in bitmap is used in write mode to switch from legacy
> > -  to new CPU hotplug interface, write 0 into it to do switch.
> > +  to modern CPU hotplug interface, write 0 into it to do switch.
> >  ---------------------------------------------------------------
> >  QEMU sets corresponding CPU bit on hot-add event and issues SCI
> >  with GPE.2 event set. CPU present map is read by ACPI BIOS GPE.2 handler
> >  to notify OS about CPU hot-add events. CPU hot-remove isn't supported.
> >
> >  =====================================
> > -ACPI CPU hotplug interface registers:
> > +Modern ACPI CPU hotplug interface registers:
> >  -------------------------------------
> >  Register block base address:
> >      ICH9-LPC IO port 0x0cd8
> > @@ -105,6 +105,24 @@ write access:
> >                other values: reserved
> >
> >      Typical usecases:
> > +        - (x86) Detecting and enabling modern CPU hotplug interface.  
> 
> (1) I think we can drop the (x86) restriction. (Because, we don't need
> to depend on APIC ID specifics; see below.)
I'd rather keep it x86 specific, as enabling interface and talking about
legacy bitmap applies only to x86 impl.
ARM one won't have any of it, it will just be enabled in a future QEMU
(probably even without version-ed machine type).
So could we just say usual "use firmware X.Y with QEMU Z to use CPU hotplug"
in that case?
Do we really need it to be arch agnostic?



