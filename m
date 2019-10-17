Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8054ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE842089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE842089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8bf-0000uU-Io
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iL7tw-0001Km-Df
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iL7tv-0005Zk-0P
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iL7tu-0005Zb-K3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:41:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B78F38980E9;
 Thu, 17 Oct 2019 15:41:17 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8415C60872;
 Thu, 17 Oct 2019 15:41:08 +0000 (UTC)
Date: Thu, 17 Oct 2019 17:41:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 1/3] acpi: cpuhp: fix 'Command data' description is spec
Message-ID: <20191017174106.5b2c59d0@redhat.com>
In-Reply-To: <406bde43-fcb5-0043-eabf-69cc494736b4@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-2-imammedo@redhat.com>
 <406bde43-fcb5-0043-eabf-69cc494736b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Thu, 17 Oct 2019 15:41:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Oct 2019 14:33:19 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 10/09/19 15:22, Igor Mammedov wrote:
> > QEMU returns 0, in case of erro or invalid value in 'Command field',
> > make spec match reality, i.e.  
> 
> Unfinished thought?
yep, I'll fix it up.

[...]
> > index ee219c8358..ac5903b2b1 100644
> > --- a/docs/specs/acpi_cpu_hotplug.txt
> > +++ b/docs/specs/acpi_cpu_hotplug.txt
> > @@ -44,9 +44,10 @@ read access:
> >             3-7: reserved and should be ignored by OSPM
> >      [0x5-0x7] reserved
> >      [0x8] Command data: (DWORD access)  
> 
> since we're fixing this dword field description, can you spell out the
> endianness too?
Since it's ACPI oriented interface (i.e. guest AML LE access implied),
I'd prefer to spell it out once in spec so it would cover all integer
fields vs doing it per filed. (less chance to make mistake later)


> (I think endianness is relevant here, because patch#2 suggests selectors
> can be looped over. So selectors are actual integers, not just 32-bit
> opaque blobs.)
> 
> > -          in case of error or unsupported command reads is 0xFFFFFFFF
> > +          in case of error or unsupported command reads is 0x0
> >            current 'Command field' value:
> > -              0: returns PXM value corresponding to device
> > +              0: returns CPU selector value corresponding to a CPU with
> > +                 pending event.
> >  
> >  write access:
> >      offset:
> >   
> 
> Thanks!
> Laszlo
> 


