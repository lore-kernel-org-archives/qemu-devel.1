Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFDDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:14:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3332074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gzm0qDW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3332074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0um-0000mQ-6I
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw0u2-0008MM-1n
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:14:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21579
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw0ty-0004GA-UN
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594894445;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VUCvkjhmxPn8ZhtnLvER6uqHi1mhpDecDkd5ghYV5GM=;
 b=Gzm0qDW1avilJOZ1/mTuGCPTGJPj9vvSs+A5jnLzAyB47Bq1cCX3Fxeb+0l6ZFkrwJbgoz
 LNxBQ5L0oNXzEH7ttt3BwvuNosmo4FibJ9A7+hES44k37oG83CplFNn2V94OFchmTrICOv
 YdRMilNQyOnc3mDbeZSeRuAZU5/P+JA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-YSghPMuYOK2xxc24A4qPgw-1; Thu, 16 Jul 2020 06:09:48 -0400
X-MC-Unique: YSghPMuYOK2xxc24A4qPgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5666E1888AAA;
 Thu, 16 Jul 2020 10:09:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 150A060E3E;
 Thu, 16 Jul 2020 10:09:38 +0000 (UTC)
Date: Thu, 16 Jul 2020 11:09:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716100936.GL227735@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <20200716085656.GA7813@work-vm>
 <nycvar.YSQ.7.78.906.2007161503230.950384@xnncv>
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.78.906.2007161503230.950384@xnncv>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 03:14:51PM +0530, P J P wrote:
> +-- On Thu, 16 Jul 2020, Dr. David Alan Gilbert wrote --+
> | > +	C: CVE/Security/Trust Quotient
> | > +	   H:High - Feature (or code) is meant to be safe and used by untrusted
> | > +	            guests. So any potential security issue must be processed with
> | > +	            due care and be considered as a CVE issue.
> | > +	   L:Low  - Feature (or code) is not meant to be safe OR is experimental
> | > +	            OR is used in trusted environments only OR is not well
> | > +	            maintained. So any potential security issue can be processed
> | > +	            and fixed as regular non-security bug. No need for a CVE.
> | 
> | That's a lot of OR's and it causes problems;
> | ....
> 
>   Yes, I started with the MAINTAINERS file thinking at least some segregation 
> would be a step forward than nothing.
>  
> | >  QMP
> | >  M: Markus Armbruster <armbru@redhat.com>
> | >  S: Supported
> | > +C: Low
> | >  F: monitor/monitor-internal.h
> | >  F: monitor/qmp*
> | >  F: monitor/misc.c
> | 
> | QMP is critical to many uses, so you wouldn't want to exclude it from a secure build;
> | any security issue with it (e.g. misparsing an argument) would be very
> | serious and would need to be looked at;
> 
>    No, High OR Low was not for excluding it from any build. It was merely an 
> indication to a user to decide whether an issue should be treated as a CVE one 
> or can be fixed as regular bug.
> 
> | but QMP is expected to be talking to another trusted endpoint.
> 
>   True; I set it to Low as QMP interface access is mostly given to privileged 
> trusted users.

It needs to consider that the classification will eventually be used to decide
what features are enabled at build time. If QMP is marked as "low" and someone
does a build "only high", then QMP won't get compiled, and thus QEMU will be
useless for mgmt apps.

Also bear in the mind the documented security classification is that approx
anything relevant for use with KVM based deployment is to be considered part
of the trusted code set, and anything that only makes sense for use with TCG
is part of the untrusted code set.

This implies that much general purpose common infrastructure in QEMU is
going to be part of the trusted code set. So that automatically includes
QMP.

NB, the build time classification won't be perfect, but that's largely
because we don't have sufficient granularity in what we build. For
example, although we only care about QMP, IIUC, we can't turn off HMP
at build time.  So we might consider HMP to be "low", despite the fact
that it is impossible to disable when building "only high features".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


