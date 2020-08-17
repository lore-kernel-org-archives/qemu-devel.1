Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E61C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD9620657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 17:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gys+cNeu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD9620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7ijG-0002N4-CY
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k7iiY-0001w2-MO
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:14:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k7iiX-0003xI-4Z
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 13:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597684479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHFQrdWQwn7g9qJIjYi6WbtVaKTRTDzB3mBpwSlvtEI=;
 b=Gys+cNeujlQkPaQjCzXNIvhUusaRoINyTnj+3AJT9hNV1S8+KDuYVlbvda4lWUWV8kmpTy
 +KBUok0SRYqzQbliHl+rqelgp9grnZUlYxw+efMiRx/pKhab1wa1X31pAjalnO9mvITwry
 IkxRpUj+t9plLIxFx1BBzNQkPvdrDGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-RhHhSmVnMLO7SEtcbUJFZA-1; Mon, 17 Aug 2020 13:14:38 -0400
X-MC-Unique: RhHhSmVnMLO7SEtcbUJFZA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313861005E6A
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 17:14:37 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE10D60BF3;
 Mon, 17 Aug 2020 17:14:36 +0000 (UTC)
Date: Mon, 17 Aug 2020 13:14:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 37/41] [automated] Use DECLARE_*CHECKER* when possible
 (--force mode)
Message-ID: <20200817171436.GJ1700540@habkost.net>
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-38-ehabkost@redhat.com>
 <20200817162938.GI4775@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200817162938.GI4775@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 17, 2020 at 05:29:38PM +0100, Daniel P. Berrangé wrote:
> On Thu, Aug 13, 2020 at 06:26:21PM -0400, Eduardo Habkost wrote:
> > Separate run of the script using the --force flag, for the cases
> > where the typedef wasn't found in the same header.
> 
> This scenario feels a little suspicious to me.
> 
> A bunch of these are caused because the typedef is put
> into qemu/typedefs.h.
> 
> Others simply look wrong.
> 
> I wonder if we're better off fixing all these exceptions
> so the typedef is in the expected place.

Yeah, it is a good idea to take a closer look on each of those
cases.  Many cases changed using --force had caused breakage, and
originated the fixes at the beginning of this series.

I will change the script to at least look at typedefs.h, so we
know which of those 59 cases are truly unsafe.  Maybe the list
that requires manual review will become much shorter.

-- 
Eduardo


