Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D97C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C8E20760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIn9bshe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C8E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw2c1-0001ro-MF
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw2bQ-0001SF-3W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:03:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jw2bN-0004Ps-WE
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594900981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6p12cVFWhQjghokDVt/0nFHm0oacy9mwe1UtoYlgeac=;
 b=WIn9bshe0YXFZMBtWFFhSTX3nYWKoa14ImHgipsqzW+nKQIbMsFJF0piw8NxnZ93SJcEHS
 XFP6TLWnJiVN8K/ghRWyKlxwt29kNz3hQXlciHx2ihbkzDZfNn6PFTdD6zI4VRpmOIzOP3
 nd/zJdUx4SD7ep0rQ0HcjWFIr1u7Mqg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-evyd2DwJP_CIhmv7xQgKJA-1; Thu, 16 Jul 2020 08:02:54 -0400
X-MC-Unique: evyd2DwJP_CIhmv7xQgKJA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31AFF8C3E04;
 Thu, 16 Jul 2020 12:02:52 +0000 (UTC)
Received: from gondolin (ovpn-113-57.ams2.redhat.com [10.36.113.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 304DE72AF9;
 Thu, 16 Jul 2020 12:02:17 +0000 (UTC)
Date: Thu, 16 Jul 2020 14:02:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
Message-ID: <20200716140214.3fdc7590.cohuck@redhat.com>
In-Reply-To: <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <b1d68acf-881f-be0f-c1ac-d32b8bfc859d@linux.ibm.com>
 <20200715180409.451d217e.cohuck@redhat.com>
 <d59bd0a5-0660-0c22-09dd-018be6dfe74f@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Jul 2020 12:26:20 -0400
Collin Walling <walling@linux.ibm.com> wrote:

> On 7/15/20 12:04 PM, Cornelia Huck wrote:
> > On Wed, 15 Jul 2020 11:36:35 -0400
> > Collin Walling <walling@linux.ibm.com> wrote:
> >   
> >> Polite ping. Patches have been sitting on the list for a few weeks now,
> >> and it doesn't look like any further changes are requested (hopefully I
> >> didn't miss something).  
> > 
> > The only thing I had was (I think) the logging of the length you just
> > replied to. We can still tweak things like that later, of course.
> > 
> > As these patches depend on a headers sync, I could not yet queue them.
> > I can keep a preliminary version on a branch. I assume that the header
> > changes will go in during the next kernel merge window? (If I missed
> > something, apologies for that.)
> >   
> 
> Gotcha. Thanks for the update :)
> 
> There was an email on the KVM list a couple of days that made one change
> to the Linux header. Just changed the integer used for the DIAG cap,
> which should be reflected in QEMU as well.
> 
> https://www.spinics.net/lists/kvm/msg220548.html
> 
> Should I respin this patch series to include the new ack's and account
> for the header sync?

No need for that, my tooling picks up acks and the headers update needs
to be replaced with a sync against a proper Linux version anyway.

I've queued the patches on a local branch, and the only patch that did
not apply cleanly was the headers patch, which will get replaced later
anyway :) Just ping me when the kernel patches hit upstream, then I'll
do a header sync against the next -rc and queue the patches on
s390-next.


