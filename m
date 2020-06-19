Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1429CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F9C20890
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 10:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cec+Jzu3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F9C20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmDul-0002UZ-5Z
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 06:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmDu9-0001RM-97
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:05:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jmDu7-0003C8-OH
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 06:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592561147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wOB/56I0E2vSbrY8/qvWcoDbR4ALjD0BWAr2SAMhSX0=;
 b=Cec+Jzu3sxfevBnW4pj+KWUMuboryYBlBbD4vtlOd82OoUXj2pEzYbS7qo4Sfqv0u0wpW4
 X2OrkOvjaYK6OOXn3UW9bGAqcGdkJj2AE03vaKFs7bZx5ji6LDEyIoDVhOKR7NLJlcKdgu
 w8C4k5pTXzrR98UOlAQnUoXiNavq6dY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-dDbRV7HOMrmyUQ04EQbE4A-1; Fri, 19 Jun 2020 06:05:45 -0400
X-MC-Unique: dDbRV7HOMrmyUQ04EQbE4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11436107ACCA;
 Fri, 19 Jun 2020 10:05:43 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 964B31002394;
 Fri, 19 Jun 2020 10:05:33 +0000 (UTC)
Date: Fri, 19 Jun 2020 12:05:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v3 0/9] Generalize memory encryption models
Message-ID: <20200619120530.256c36cb.cohuck@redhat.com>
In-Reply-To: <79890826-f67c-2228-e98d-25d2168be3da@redhat.com>
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <e045e202-cd56-4ddc-8c1d-a2fe5a799d32@redhat.com>
 <20200619114526.6a6f70c6.cohuck@redhat.com>
 <79890826-f67c-2228-e98d-25d2168be3da@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com, frankja@linux.ibm.com,
 kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, dgilbert@redhat.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 11:56:49 +0200
David Hildenbrand <david@redhat.com> wrote:

> >>> For now this series covers just AMD SEV and POWER PEF.  I'm hoping it
> >>> can be extended to cover the Intel and s390 mechanisms as well,
> >>> though.    
> >>
> >> The only approach on s390x to not glue command line properties to the
> >> cpu model would be to remove the CPU model feature and replace it by the
> >> command line parameter. But that would, of course, be an incompatible break.  
> > 
> > Yuck.
> > 
> > We still need to provide the cpu feature to the *guest* in any case, no?  
> 
> Yeah, but that could be wired up internally. Wouldn't consider it clean,
> though (I second the "overengineered" above).

Could an internally wired-up cpu feature be introspected? Also, what
happens if new cpu features are introduced that have a dependency on or
a conflict with this one?


