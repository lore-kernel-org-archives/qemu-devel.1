Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97ACCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:40:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A592070B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJGjSuP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A592070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVIM-0005fi-Ju
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1iLVHB-00059t-VW
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1iLVHA-0004aO-Ec
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:38:53 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38885)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1iLVHA-0004Ze-9s
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:38:52 -0400
Received: by mail-oi1-x241.google.com with SMTP id d140so1438258oib.5
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 09:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=xdR+CMp/C6VknEYgw1Fg47DgYvYw16ZWxNpsuktZ1i4=;
 b=MJGjSuP0tINWkAATN4KNAUyuFmGGqWSZ+e7owoyhN6vZptvT2QC/614mcvywqy0jiK
 QrOrwmOFw/a8HbKbF8c2X1rbEc1BE95oTdyweEYJj/pgdkfDGxmY4vz3UiM+OnOFAoz+
 yPRUFBa6O9sXJmjetfj7OfUEah2P+Te0mJYdV4TF6/a3ldrLDeCnaG1o0uiO/3A05TTz
 kqMCPR1po3ggomhjYmJCq/DjD6W2Dvz/AnnJS5L87qCQ1GzT1gtKRVw1cYvQjFIyjCRn
 py7bV5WIgwz+WJI8+f6zrHl4guz0WyWnny53oHHjUoJd46RDMKoderhh06pshx7kCMpM
 G2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=xdR+CMp/C6VknEYgw1Fg47DgYvYw16ZWxNpsuktZ1i4=;
 b=KzBUCTA38d7cNhwPL0se0T0d9mrtgzmFD8IOPeqb6iS0j0rL9Jazy8UJMZ9vUPwbgu
 NwlC+wXmdRglmkpZ+dbO26Ab3AJRAnqQYYQs7lCD/Euk7pPxyj2J/kpANAb5a3zRtYg1
 Ikafy2bPfYjzQMHS9JlJR3VDU8iepNtjP0YW8fxpCTCf6ZegE4r3nxWHlzWpqGuAfEvo
 K/+WRYvFiau8XTixfNhSsyAnkdVSI7Gln4YFMnOZzy26G+uNWR9hatBSzF08Y8l3rdml
 sU3fgIgBKyH4G54cXTzvN137q2UStPY/IhD/qA7kyr1pfBdcZGYy+i1ReubPwX5VjGDL
 DA1Q==
X-Gm-Message-State: APjAAAU5j9XYzNNEP0+/ehAOPTUVWnmWL8NF8YN5m5FAh5Vpx2yv74Ws
 a7VY8YOrI3NlKirzKvyS5+w=
X-Google-Smtp-Source: APXvYqx7OhmKHcrOtA9OMn9VQ3c4UWPYwACZXLM+K0uo/XEu+WksLIZ+yG8IVi55pSI2EyzzxFxbAA==
X-Received: by 2002:aca:5148:: with SMTP id f69mr8935354oib.172.1571416730612; 
 Fri, 18 Oct 2019 09:38:50 -0700 (PDT)
Received: from localhost ([172.58.110.169])
 by smtp.gmail.com with ESMTPSA id y18sm1610970oto.2.2019.10.18.09.38.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 18 Oct 2019 09:38:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20191018094352.GC2990@work-vm>
References: <20191017205953.13122-1-cheloha@linux.vnet.ibm.com>
 <20191017205953.13122-3-cheloha@linux.vnet.ibm.com>
 <20191018081625.GA2990@work-vm>
 <351dca8e-e77c-c450-845b-d78ba621156a@redhat.com>
 <20191018094352.GC2990@work-vm>
Message-ID: <157141671749.15348.15966144834012002565@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/2] migration: savevm_state_handler_insert:
 constant-time element insertion
Date: Fri, 18 Oct 2019 11:38:37 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: david@gibson.dropbear.id.au, Scott Cheloha <cheloha@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Dr. David Alan Gilbert (2019-10-18 04:43:52)
> * Laurent Vivier (lvivier@redhat.com) wrote:
> > On 18/10/2019 10:16, Dr. David Alan Gilbert wrote:
> > > * Scott Cheloha (cheloha@linux.vnet.ibm.com) wrote:
> > >> savevm_state's SaveStateEntry TAILQ is a priority queue.  Priority
> > >> sorting is maintained by searching from head to tail for a suitable
> > >> insertion spot.  Insertion is thus an O(n) operation.
> > >>
> > >> If we instead keep track of the head of each priority's subqueue
> > >> within that larger queue we can reduce this operation to O(1) time.
> > >>
> > >> savevm_state_handler_remove() becomes slightly more complex to
> > >> accomodate these gains: we need to replace the head of a priority's
> > >> subqueue when removing it.
> > >>
> > >> With O(1) insertion, booting VMs with many SaveStateEntry objects is
> > >> more plausible.  For example, a ppc64 VM with maxmem=3D8T has 40000 =
such
> > >> objects to insert.
> > > =

> > > Separate from reviewing this patch, I'd like to understand why you've
> > > got 40000 objects.  This feels very very wrong and is likely to cause
> > > problems to random other bits of qemu as well.
> > =

> > I think the 40000 objects are the "dr-connectors" that are used to plug
> > peripherals (memory, pci card, cpus, ...).
> =

> Yes, Scott confirmed that in the reply to the previous version.
> IMHO nothing in qemu is designed to deal with that many devices/objects
> - I'm sure that something other than the migration code is going to get u=
pset.

The device/object management aspect seems to handle things *mostly* okay, at
least ever since QOM child properties started being tracked by a hash table
instead of a linked list. It's worth noting that that change (b604a854) was
done to better handle IRQ pins for ARM guests with lots of CPUs. I think it=
 is
inevitable that certain machine types/configurations will call for large
numbers of objects and I think it is fair to improve things to allow for th=
is
sort of scalability.

But I agree it shouldn't be abused, and you're right that there are some
problem areas that arise. Trying to outline them:

 a) introspection commands like 'info qom-tree' become pretty unwieldly,
    and with large enough numbers of objects might even break things (QMP
    response size limits maybe?)
 b) various related lists like reset handlers, vmstate/savevm handlers might
    grow quite large

I think we could work around a) with maybe flagging certain
"internally-only" objects as 'hidden'. Introspection routines could then
filter these out, and routines like qom-set/qom-get could return report
something similar to EACCESS so they are never used/useful to management
tools.

In cases like b) we can optimize things where it makes sense like with
Scott's patch here. In most cases these lists need to be walked one way
or another, whether it's done internally by the object or through common
interfaces provided by QEMU. It's really just the O(n^2) type handling
where relying on common interfaces becomes drastically less efficient,
but I think we should avoid implementing things in that way anyway, or
improve them as needed.

> =

> Is perhaps the structure wrong somewhere - should there be a single DRC
> device that knows about all DRCs?

That's an interesting proposition, I think it's worth exploring further,
but from a high level:

 - each SpaprDrc has migration state, and some sub-classes SpaprDrc (e.g.
   SpaprDrcPhysical) have additional migration state. These are sent
   as-needed as separate VMState entries in the migration stream.
   Moving to a single DRC means we're either sending them as an flat
   array or a sparse list, which would put just as much load on the
   migration code (at least, with Scott's changes in place). It would
   also be difficult to do all this in a way which maintains migration
   compatibility with older machine types.
 - other aspects of modeling these as QOM objects, such as look-ups,
   reset-handling, and memory allocations, wouldn't be dramatically
   improved upon by handling it all internally within the object

AFAICT the biggest issue with modeling the DRCs as individual objects
is actually how we deal with introspection, and we should try to
improve. What do you think of the alternative suggestion above of
marking certain objects as 'hidden' from various introspection
interfaces?

> =

> Dave
> =

> =

> > https://github.com/qemu/qemu/blob/master/hw/ppc/spapr_drc.c
> > =

> > They are part of SPAPR specification.
> > =

> > https://raw.githubusercontent.com/qemu/qemu/master/docs/specs/ppc-spapr=
-hotplug.txt
> > =

> > CC Michael Roth
> > =

> > Thanks,
> > Laurent
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20

