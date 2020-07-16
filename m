Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC4DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83A720760
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDZJ9Pi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83A720760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvzgw-00064D-4k
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvzgJ-0005L5-6h
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:55:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42631
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvzgH-0001Fk-Bg
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594889752;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5EmgUT5RlturpJ88qr0WmFTiW4z8DIuoC9RTqK4X6HQ=;
 b=CDZJ9Pi4p4xgBoZv2RrKjnvtYk5IiEQbblseun2Ojhht4NeGOS8/fvq/2lgJc3gZAsna+x
 qE+TZAAHGlXun+HLnGzI4YI/jeRnKzvwfIRZpKdBkuLWuQUfiDnfOP/myg5stfHnDteEXZ
 8k0C0cSmcKtyLVaWPqbxStnyUynj4Ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-jGTqAdJVNZqkdusUmjUFYA-1; Thu, 16 Jul 2020 04:55:47 -0400
X-MC-Unique: jGTqAdJVNZqkdusUmjUFYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93662100961D;
 Thu, 16 Jul 2020 08:55:46 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41CFB710A0;
 Thu, 16 Jul 2020 08:55:42 +0000 (UTC)
Date: Thu, 16 Jul 2020 09:55:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 0/4] Add dtrace support on macOS
Message-ID: <20200716085539.GD227735@redhat.com>
References: <20200716081754.22422-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
In-Reply-To: <20200716081754.22422-1-r.bolshakov@yadro.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding Stefan as the trace maintainer.

On Thu, Jul 16, 2020 at 11:17:50AM +0300, Roman Bolshakov wrote:
> Hi,
> 
> This is a small series that enables dtrace tracing backend on macOS.
> Whether or not it should go to 5.1 is up to discretion of tracing
> maintainers.
> 
> Thanks,
> Roman
> 
> Roman Bolshakov (4):
>   scripts/tracetool: Fix dtrace generation for macOS
>   scripts/tracetool: Use void pointer for vcpu
>   build: Don't make object files for dtrace on macOS
>   net/colo: Match is-enabled probe to tracepoint
> 
>  Makefile.objs                 |  2 ++
>  net/colo-compare.c            | 12 +++++++-----
>  net/filter-rewriter.c         |  8 ++++++--
>  net/trace-events              |  2 --
>  scripts/tracetool/format/d.py |  9 ++++++++-
>  scripts/tracetool/vcpu.py     |  2 +-
>  6 files changed, 24 insertions(+), 11 deletions(-)
> 
> -- 
> 2.26.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


