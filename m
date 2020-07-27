Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802FFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4424E2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOjTqszJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4424E2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k005l-0005ff-GM
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0057-00053E-Lu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:10:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k0056-0001gb-4q
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595844603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTPwEubOxZywmvlMBCFMGeSbYSU7ynTc3fp1vWxHVk0=;
 b=gOjTqszJHcZEyl/qGXuGRDaiX0Ek7XhB57MnJKojvE2ocOuIyuAM/M2GZCoPFEmRDNPtAh
 /HyCFtEQVSkhFhU1q8+Ag9ca0rNKQFFgrBe/RjOc9RiLkFNZdhbH5dUzGsbzIBPYuaqMwB
 n29Dt/sXuhu/QO+tRuCCym7AdIyBi4k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106--BgT_Df5NEa884dniRb2fA-1; Mon, 27 Jul 2020 06:10:00 -0400
X-MC-Unique: -BgT_Df5NEa884dniRb2fA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA2D482BA4E;
 Mon, 27 Jul 2020 10:09:52 +0000 (UTC)
Received: from gondolin (ovpn-112-210.ams2.redhat.com [10.36.112.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3957712D7;
 Mon, 27 Jul 2020 10:09:33 +0000 (UTC)
Date: Mon, 27 Jul 2020 12:09:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFCv3 6/9] s390x/diag: subcode to query device memory
 region
Message-ID: <20200727120930.7b8803e4.cohuck@redhat.com>
In-Reply-To: <963e5931-117e-48cb-b829-d630abff9e42@redhat.com>
References: <20200724143750.59836-1-david@redhat.com>
 <20200724143750.59836-7-david@redhat.com>
 <20200727114819.3f816010.cohuck@redhat.com>
 <963e5931-117e-48cb-b829-d630abff9e42@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 11:52:30 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 27.07.20 11:48, Cornelia Huck wrote:
> > On Fri, 24 Jul 2020 16:37:47 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> A guest OS that is aware of memory devices (placed into the device
> >> memory region located in guest physical address space) has to know at least
> >> the end address of the device memory region during boot, for example, to
> >> prepare the kernel virtual address space accordingly (e.g., select page
> >> table hierarchy). The device memory region is located above the SCLP
> >> maximum storage increment.
> >>
> >> Let's provide a new diag500 subcode to query the location of the device
> >> memory region under QEMU/KVM. This way, esp. Linux who's wants to support
> >> virtio-based memory devices can query the location of this region and
> >> derive the maximum possible PFN.
> >>
> >> Let's use a specification exception in case no such memory region
> >> exists (e.g., maxmem wasn't specified, or on old QEMU machines). We'll
> >> unlock this with future patches that prepare and instanciate the device
> >> memory region.  
> > 
> > Specification exception on old machines seems reasonable. But maybe
> > newer machines can use a different return value for "no memory regions"?  
> 
> Hm, I don't see any benefit to distinguish the two cases of "no device
> memory region". Should the guest really care?

No idea, was just a random thought.

> 
> [...]
> > 
> > (...)
> >   
> >> diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
> >> index e6b958db41..1b179d7d99 100644
> >> --- a/hw/s390x/s390-hypercall.h
> >> +++ b/hw/s390x/s390-hypercall.h
> >> @@ -16,6 +16,7 @@
> >>  #define DIAG500_VIRTIO_RESET           1 /* legacy */
> >>  #define DIAG500_VIRTIO_SET_STATUS      2 /* legacy */
> >>  #define DIAG500_VIRTIO_CCW_NOTIFY      3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
> >> +#define DIAG500_DEVICE_MEMORY_REGION   4  
> > 
> > Regardless what we end up with, this needs to be specified
> > somewhere(tm).
> >   
> 
> Yeah, there, we should also document the existing subcodes. What would
> be the right place for this? The kernel feels somewhat wrong to me.

The still supported subcode 3 is properly specified in the virtio spec.
That's not a good place for that new one, though.

QEMU is probably a better place than the kernel to specify stuff,
although it's not really ideal, either. OTOH, do we ever expect other
hypervisors to implement this new subcode?

So maybe under doc/specs/?


