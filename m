Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39018C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:33:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022C920838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpJHyuAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022C920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05d3-00087q-7j
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1j05cS-0007hF-9j
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1j05cQ-0007ZP-4g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1j05cQ-0007Yj-1C
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581089553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbKmirCKxBQdYoc2AXVNIl2ztg0w7yP3GX4N6InYoWs=;
 b=OpJHyuArSZxYsqsiQn3BkbSsx5xtZnQb4rzOV4AVRcvMJ80K3DG9W/MaZ/hZQ3Wr9HRVze
 XQ30agAVhcXPBeXBrocu+8rbWMG1c6RfgxfLdvwIsIwkfR4wnuaLpNU7lrA+edAO+Lt8rN
 NOw3QU6db1QjQRp2/mxStNzxs5k5ntU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-SMPaxjtQO1CQoM0Fj5PI0w-1; Fri, 07 Feb 2020 10:32:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 624CF8048F8;
 Fri,  7 Feb 2020 15:32:23 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0721185785;
 Fri,  7 Feb 2020 15:32:20 +0000 (UTC)
Date: Fri, 7 Feb 2020 16:32:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: Re: [PATCH RFC 2/2] docs: rstfy vfio-ap documentation
Message-ID: <20200207163218.207a931f.cohuck@redhat.com>
In-Reply-To: <CAFEAcA9wM4r=OfLnREQOQAcqOEdSr3=bHsjoO9mvn4VogMhQLw@mail.gmail.com>
References: <20200128180142.15132-1-cohuck@redhat.com>
 <20200128180142.15132-3-cohuck@redhat.com>
 <CAFEAcA9wM4r=OfLnREQOQAcqOEdSr3=bHsjoO9mvn4VogMhQLw@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: SMPaxjtQO1CQoM0Fj5PI0w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Feb 2020 12:43:03 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 28 Jan 2020 at 19:39, Cornelia Huck <cohuck@redhat.com> wrote:
> >
> > Move to system/, as this is mostly about configuring vfio-ap.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> > diff --git a/docs/vfio-ap.txt b/docs/system/vfio-ap.rst
> > similarity index 56%
> > rename from docs/vfio-ap.txt
> > rename to docs/system/vfio-ap.rst
> > index b1eb2deeaf2f..c8c5728e0aaa 100644
> > --- a/docs/vfio-ap.txt
> > +++ b/docs/system/vfio-ap.rst
> > @@ -1,17 +1,17 @@
> >  Adjunct Processor (AP) Device
> >  =============================
> >
> > -Contents:
> > -=========
> > -* Introduction
> > -* AP Architectural Overview
> > -* Start Interpretive Execution (SIE) Instruction
> > -* AP Matrix Configuration on Linux Host
> > -* Starting a Linux Guest Configured with an AP Matrix
> > -* Example: Configure AP Matrices for Three Linux Guests  
> > -> -Introduction:  
> > -============
> > +Contents
> > +--------
> > +* `Introduction`_
> > +* `AP Architectural Overview`_
> > +* `Start Interpretive Execution (SIE) Instruction`_
> > +* `AP Matrix Configuration on Linux Host`_
> > +* `Starting a Linux Guest Configured with an AP Matrix`_
> > +* `Example: Configure AP Matrices for Three Linux Guests`_
> > +  
> 
> You don't need to manually write out a table of contents. You
> can just have one line
> 
> .. contents::
> 
> and Sphinx will produce an autogenerated table of contents
> (including a 'Contents' title) for you.
> 
> https://docutils.sourceforge.io/docs/ref/rst/directives.html#table-of-contents
> 
> An example where we already use this is
> docs/interop/live-block-operations.rst:
> https://www.qemu.org/docs/master/interop/live-block-operations.html

Oh, nice, will do. (Not sure how useful this was in the text document,
anyway.)

> 
> 
> > +Introduction
> > +------------  
> 
> rST doesn't require it, but I'd recommend a blank line below
> the ---- line; I think it makes the source more readable.
> 
> >  The IBM Adjunct Processor (AP) Cryptographic Facility is comprised
> >  of three AP instructions and from 1 to 256 PCIe cryptographic adapter cards.
> >  These AP devices provide cryptographic functions to all CPUs assigned to a
> > @@ -21,8 +21,8 @@ On s390x, AP adapter cards are exposed via the AP bus. This document
> >  describes how those cards may be made available to KVM guests using the
> >  VFIO mediated device framework.
> >
> > -AP Architectural Overview:
> > -=========================
> > +AP Architectural Overview
> > +-------------------------
> >  In order understand the terminology used in the rest of this document, let's
> >  start with some definitions:
> >
> > @@ -75,7 +75,7 @@ start with some definitions:
> >    must be one of the control domains.
> >
> >  Start Interpretive Execution (SIE) Instruction
> > -==============================================
> > +----------------------------------------------
> >  A KVM guest is started by executing the Start Interpretive Execution (SIE)
> >  instruction. The SIE state description is a control block that contains the
> >  state information for a KVM guest and is supplied as input to the SIE
> > @@ -114,246 +114,254 @@ The APQNs can provide secure key functionality - i.e., a private key is stored
> >  on the adapter card for each of its domains - so each APQN must be assigned to
> >  at most one guest or the linux host.
> >
> > -   Example 1: Valid configuration:
> > -   ------------------------------
> > -   Guest1: adapters 1,2  domains 5,6
> > -   Guest2: adapter  1,2  domain 7
> > +Example 1: Valid configuration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Guest1: adapters 1,2  domains 5,6
> > +Guest2: adapter  1,2  domain 7  
> 
> These don't render correctly -- rST thinks the "Example 1..." line
> is a subsection heading because of the underlining, and then renders
> the next two lines as runon-text:
> "Guest1: adapters 1,2 domains 5,6 Guest2: adapter 1,2 domain 7"
> 
> Depending on what you want, you could try one of:
>  * use a literal block (which gets you fixed-width font, preserved
>    whitespace and linebreaks)
>  * use a bulleted list
>  * use one of rST's table formats

Hm... I think this is supposed to be:
- header ("Example 1: ...")
- config
- explanation why this is a valid config

Maybe a table? Tony, any preferences?

> 
> (is it deliberate that line 1 is "adapters" and line 2 is "adapter" ?)

I don't think so.

> 
> > -   This is valid because both guests have a unique set of APQNs: Guest1 has
> > -   APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
> > +This is valid because both guests have a unique set of APQNs: Guest1 has
> > +APQNs (1,5), (1,6), (2,5) and (2,6); Guest2 has APQNs (1,7) and (2,7).
> >
> > -   Example 2: Valid configuration:
> > -   ------------------------------
> > -   Guest1: adapters 1,2 domains 5,6
> > -   Guest2: adapters 3,4 domains 5,6
> > +Example 2: Valid configuration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Guest1: adapters 1,2 domains 5,6
> > +Guest2: adapters 3,4 domains 5,6
> >
> > -   This is also valid because both guests have a unique set of APQNs:
> > -      Guest1 has APQNs (1,5), (1,6), (2,5), (2,6);
> > -      Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)
> > +This is also valid because both guests have a unique set of APQNs:
> > +   Guest1 has APQNs (1,5), (1,6), (2,5), (2,6);
> > +   Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)  
> 
> This is differently rendered from the equivalent text in example 1,
> because of the indent -- rST treats the 2 indented lines as a block
> quote, and indents them in the output, but flows the text into
> one long line.
> 
> I think personally I'd opt to render like this:
> 
> This is also valid because both guests have a unique set of APQNs:
> 
> * Guest1 has APQNs (1,5), (1,6), (2,5), (2,6)
> * Guest2 has APQNs (3,5), (3,6), (4,5), (4,6)
> 
> (ie a bulleted list); but anyway consistency between the examples
> would be good.

Nod. The indentation in the document was a bit inconsistent, it just
did not matter before.

> 
> >
> > -   Example 3: Invalid configuration:
> > -   --------------------------------
> > -   Guest1: adapters 1,2  domains 5,6
> > -   Guest2: adapter  1    domains 6,7
> > +Example 3: Invalid configuration
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +Guest1: adapters 1,2  domains 5,6
> > +Guest2: adapter  1    domains 6,7
> >
> > -   This is an invalid configuration because both guests have access to
> > -   APQN (1,6).
> > +This is an invalid configuration because both guests have access to
> > +APQN (1,6).  
> 
> > -      * Individual bits in the mask can be switched on and off by specifying
> > -        each bit number to be switched in a comma separated list. Each bit
> > -        number string must be prepended with a ('+') or minus ('-') to indicate
> > -        the corresponding bit is to be switched on ('+') or off ('-'). Some
> > -        valid values are:
> > +    * Individual bits in the mask can be switched on and off by specifying
> > +      each bit number to be switched in a comma separated list. Each bit
> > +      number string must be prepended with a ('+') or minus ('-') to indicate
> > +      the corresponding bit is to be switched on ('+') or off ('-'). Some
> > +      valid values are::
> >
> >             "+0"    switches bit 0 on
> >             "-13"   switches bit 13 off
> >             "+0x41" switches bit 65 on
> >             "-0xff" switches bit 255 off  
> 
> Maybe use a definition list here rather than a literal block?
> 
>       valid values are:
> 
>       ``+0``
>           switches bit 0 on
>       ``-13``
>           switches bit 13 off
> 
> etc. The literal block is fine if you think it looks better though.

Not sure if a definition list for something that is basically a list of
examples makes sense. Will check how it renders.

> 
> 
> >
> >  assign_adapter  
> 
> Since these are filenames, you can enclose them in ``  `` and they'll
> render as fixed-width text, which I think makes them stand out a
> bit better in the HTML. I'm pretty sure this works even in the
> term part of a definition list.

That's probably a good idea, will check.

> 
> Not in this diff, but should the 'No APQN...' para in the assign_domain
> docs really be a 2nd para of the preceding bullet point rather than either
> its own bullet point or a paragraph outside the bulleted list ?

Will also check, I mostly converted this document via a whack-a-mole
approach.

> 
> (ditto for assign_domain)
> 
> 
> > @@ -486,20 +494,22 @@ facilities:
> >     The AP facilities feature indicates that AP facilities are installed on the
> >     guest. This feature will be exposed for use only if the AP facilities
> >     are installed on the host system. The feature is s390-specific and is
> > -   represented as a parameter of the -cpu option on the QEMU command line:
> > +   represented as a parameter of the -cpu option on the QEMU command line::
> >
> >        qemu-system-s390x -cpu $model,ap=on|off
> >
> > -      Where:
> > +   Where:
> >
> > -         $model is the CPU model defined for the guest (defaults to the model of
> > -                the host system if not specified).
> > +      $model  
> 
> Formatting $model and ap=on|off with `` `` would look nicer I think
> (ditto below)

Yep, I'll check if there is anything else that should be fixed-width.

> 
> thanks
> -- PMM
> 

Thanks for looking!


