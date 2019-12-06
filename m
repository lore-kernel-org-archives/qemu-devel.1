Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E56C2D0C1
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D502464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QE1zltt8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D502464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEOq-0001Zr-Dh
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1idEJY-0004u1-KI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:10:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1idEJV-0003Ml-8P
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:10:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1idEJS-0003EL-Rd
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eFTttXa6T1gTIeH9tIncgCW1S/5vgxrVFxsVqYBspI=;
 b=QE1zltt83NhpF5TX48BRsTZRJsp+IwI7C44Y19uIXt7MHnrKeSM/JuB7C+htkQDp/Emnvh
 YQIeaJ1SjgLZ/Yopub+YJQq8lNWsYhK/KXMbKy5phwje5YRyH2mFJFZNdX0iC9TbQ51RpU
 CZRL8t3oTS3G6RaY6DO1eEMpPddXStk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-1BSTVJCQMgaf7540BRKLww-1; Fri, 06 Dec 2019 06:09:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D41F8017DF
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 11:09:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E26C5C1C3;
 Fri,  6 Dec 2019 11:09:39 +0000 (UTC)
Date: Fri, 6 Dec 2019 12:09:36 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-5.0 4/8] acpi: cpuhp: spec: fix 'Command data'
 description
Message-ID: <20191206120936.5d7ad8e8@redhat.com>
In-Reply-To: <680b7776-044b-59e8-2ee9-f9e1751c5577@redhat.com>
References: <1575479147-6641-1-git-send-email-imammedo@redhat.com>
 <1575479147-6641-5-git-send-email-imammedo@redhat.com>
 <680b7776-044b-59e8-2ee9-f9e1751c5577@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 1BSTVJCQMgaf7540BRKLww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: pbonzini@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 5 Dec 2019 13:17:22 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 12/04/19 18:05, Igor Mammedov wrote:
> > Correct returned value description in case 'Command field' == 0x0,
> > it's in not PXM but CPU selector value with pending event  
> 
> (1) s/in not/not/
> 
> > 
> > In addition describe 0 blanket value in case of not supported
> > 'Command field' value.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  docs/specs/acpi_cpu_hotplug.txt | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
> > index 4e65286..19c508f 100644
> > --- a/docs/specs/acpi_cpu_hotplug.txt
> > +++ b/docs/specs/acpi_cpu_hotplug.txt
> > @@ -56,9 +56,8 @@ read access:
> >             3-7: reserved and should be ignored by OSPM
> >      [0x5-0x7] reserved
> >      [0x8] Command data: (DWORD access)
> > -          in case of error or unsupported command reads is 0xFFFFFFFF
> > -          current 'Command field' value:
> > -              0: returns PXM value corresponding to device
> > +          contains 0 unless last stored in 'Command field' value is one of:
> > +              0: contains 'CPU selector' value of a CPU with pending event[s]  
> 
> (2) I think we can improve the word order:
> 
>   last stored in 'Command field' value
> ->  
>   value last stored in 'Command field'
> 
> >  
> >  write access:
> >      offset:
> > @@ -81,9 +80,9 @@ write access:
> >            value:
> >              0: selects a CPU device with inserting/removing events and
> >                 following reads from 'Command data' register return
> > -               selected CPU (CPU selector value). If no CPU with events
> > -               found, the current CPU selector doesn't change and
> > -               corresponding insert/remove event flags are not set.
> > +               selected CPU ('CPU selector' value).
> > +               If no CPU with events found, the current 'CPU selector' doesn't
> > +               change and corresponding insert/remove event flags are not set.  
> 
> (3) AFAICT this is only a -- useful! -- re-wrapping.
Not sure what you are trying to say here ...

> But, since we are
> modifying this section anyway, can we replace "flags are not set" with
> "flags are left unchanged" or "flags are not modified"?
sure


> "set" is ambiguous with bit fields: it can mean "rewritten", and it can
> mean "set to 1".
> 
> >              1: following writes to 'Command data' register set OST event
> >                 register in QEMU
> >              2: following writes to 'Command data' register set OST status
> >   
> 
> Anyway, these are all superficial comments. Pick up whatever you agree
> with. Either way:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks!
> Laszlo


