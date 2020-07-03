Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE783C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:21:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E199208E4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THZfXH+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E199208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrORZ-000228-TV
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrO8q-00015h-Eo
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:02:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jrO8n-0008IM-U6
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593792136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QBCgCDInfFECHeq4DAuxkUBflOMbLuBSh4FmjCvUoKI=;
 b=THZfXH+/Iv1CFT5mib8msvPwGiE3a1i2U03SSDUOG/AiD3JMwg+0s36IsDlH1epTVrP5Ed
 WaKwJbPiGQitHLpRn/XBAQImomTrSOuERwlLSaJLcof+4w3ugeNZqa1aJMk0hjET+HI6zb
 FMNTUCz7IGIoQMldVAOoGBbZLpOjYXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-NtVNTqzKOrS_wevjcJmepw-1; Fri, 03 Jul 2020 12:02:14 -0400
X-MC-Unique: NtVNTqzKOrS_wevjcJmepw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CDEB186A206;
 Fri,  3 Jul 2020 16:02:12 +0000 (UTC)
Received: from work-vm (ovpn-114-207.ams2.redhat.com [10.36.114.207])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADC389CA0;
 Fri,  3 Jul 2020 16:02:10 +0000 (UTC)
Date: Fri, 3 Jul 2020 17:02:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: James Bottomley <jejb@linux.ibm.com>
Subject: Re: [PATCH v2] SEV: QMP support for Inject-Launch-Secret
Message-ID: <20200703160208.GG6641@work-vm>
References: <20200702194213.23272-1-tobin@linux.vnet.ibm.com>
 <20200703110929.GB6641@work-vm>
 <1593791654.3972.26.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1593791654.3972.26.camel@linux.ibm.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: thomas.lendacky@amd.com, brijesh.singh@amd.com, tobin@ibm.com,
 qemu-devel@nongnu.org, Tobin Feldman-Fitzthum <tobin@linux.vnet.ibm.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* James Bottomley (jejb@linux.ibm.com) wrote:
> On Fri, 2020-07-03 at 12:11 +0100, Dr. David Alan Gilbert wrote:
> > * Tobin Feldman-Fitzthum (tobin@linux.vnet.ibm.com) wrote:
> [...]
> > > +    input.trans_uaddr = (uint64_t)data;
> > > +    input.trans_len = data_sz;
> > > +
> > > +    input.guest_uaddr = (uint64_t)hva;
> > 
> > Thanks for changing these; although it fails a 32bit build (which is
> > probably mostly pointless for SEV, but it fails the build rather than
> > building it out). The easy fix here seems to be:
> >    (uint64_t)(uintptr_t)
> 
> That's a pointer width issue.  The recommended way to communicate to
> the compiler that we really want to cast a 32 bit pointer to a 64 bit
> value is actually to cast to unsigned long before casting to pointer,
> so
> 
> (uint64_t)(unsigned long)hva
> 
> Many other things work, of course, but if you follow the recommendation
> you (hopefully) don't trip future compiler warnings.

OK, fair enough
(Out of curiosity can you explain why unsigned long not uintptr_t?)

Dave

> James
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


