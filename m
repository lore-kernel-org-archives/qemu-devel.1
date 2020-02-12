Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAF3C2BA83
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857B820714
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRTPusGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857B820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1tSY-0006Zh-MZ
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 09:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j1tRy-00066v-Uq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j1tRv-00077l-CV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:57:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43776
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j1tRu-00076r-Ta
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 09:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581519429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4SugdQsmL0TmO67dyyVZaD8V5q+XGb95Bl7LLxss9M=;
 b=gRTPusGZ2z+em/h7+aT7SMZ+qOuxC9HQbU0Jfbn50IuYVF2wPJevUYlPRAGJxArly14Jvg
 wJe+06HC/R/Ibh9v4hEMbes3mh+JXJJtoQYjJ6+CX3V3hgM7B7qg1+IbkM2fa4ejJ7y4Wd
 YkyduGqXrvNqunL/+SrZc0MigVHIR3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-2rmHmCOTOv2L_iwB3VwT7A-1; Wed, 12 Feb 2020 09:57:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACF59800D41;
 Wed, 12 Feb 2020 14:57:06 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A53CA5DA83;
 Wed, 12 Feb 2020 14:57:02 +0000 (UTC)
Date: Wed, 12 Feb 2020 15:57:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] docs: rstfy vfio-ap documentation
Message-ID: <20200212155700.3d0a879e.cohuck@redhat.com>
In-Reply-To: <20200207163218.207a931f.cohuck@redhat.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-3-cohuck@redhat.com>
 <CAFEAcA9wM4r=OfLnREQOQAcqOEdSr3=bHsjoO9mvn4VogMhQLw@mail.gmail.com>
 <20200207163218.207a931f.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 2rmHmCOTOv2L_iwB3VwT7A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 16:32:18 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 7 Feb 2020 12:43:03 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> > On Tue, 28 Jan 2020 at 19:39, Cornelia Huck <cohuck@redhat.com> wrote:  
> > >
> > > Move to system/, as this is mostly about configuring vfio-ap.
> > >
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>    

> > > -   Example 1: Valid configuration:
> > > -   ------------------------------
> > > -   Guest1: adapters 1,2  domains 5,6
> > > -   Guest2: adapter  1,2  domain 7
> > > +Example 1: Valid configuration
> > > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > +Guest1: adapters 1,2  domains 5,6
> > > +Guest2: adapter  1,2  domain 7    
> > 
> > These don't render correctly -- rST thinks the "Example 1..." line
> > is a subsection heading because of the underlining, and then renders
> > the next two lines as runon-text:
> > "Guest1: adapters 1,2 domains 5,6 Guest2: adapter 1,2 domain 7"
> > 
> > Depending on what you want, you could try one of:
> >  * use a literal block (which gets you fixed-width font, preserved
> >    whitespace and linebreaks)
> >  * use a bulleted list
> >  * use one of rST's table formats  
> 
> Hm... I think this is supposed to be:
> - header ("Example 1: ...")
> - config
> - explanation why this is a valid config
> 
> Maybe a table? Tony, any preferences?
> 
> > 
> > (is it deliberate that line 1 is "adapters" and line 2 is "adapter" ?)  
> 
> I don't think so.
> 
> >   
> > > -   This is valid because both guests have a unique set of APQNs: Guest1 has
> > > -   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
> > > +This is valid because both guests have a unique set of APQNs: Guest1 has
> > > +APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).

This section now looks like this:

Example 1: Valid configuration                                                  
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                                                  
                                                                                
+----------+--------+--------+                                                  
|          | Guest1 | Guest2 |                                                  
+==========+========+========+                                                  
| adapters |  1, 2  |  1, 2  |                                                  
+----------+--------+--------+                                                  
| domains  |  5, 6  |  7     |                                                  
+----------+--------+--------+                                                  
                                                                                
This is valid because both guests have a unique set of APQNs:                   
                                                                                
* Guest1 has APQNs (1,5), (1,6), (2,5) and (2,6);                               
* Guest2 has APQNs (1,7) and (2,7).

Seems more readable to me, also in the rendered html. (Not sure if
switching rows/columns would be better.)


