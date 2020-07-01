Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5919720781
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3KphS0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5919720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqfU2-000360-HO
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 12:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfOT-00043I-Ew
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:15:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60837
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqfOO-0006rE-5R
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 12:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593620123;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYgbFBsOYt/YNe+vsPDEOrv/IwhWQRnpjZUO17nVabA=;
 b=J3KphS0dhPbat2Yvdr7z1l3o2ZdL7ENKIYhP8tuUkjQFDcd2yPB+loTgv7r5gSgVJNc0d+
 xnec3DKAnFRe8EU9tPQKDQUYgLVkRvYRR7IWipRZJhUtrVCpoZOrNG+dzY61UTsYsL+BFH
 WCJQy830XewHtwg4bIZvY7qspgUzssk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Ca59u2IIM5iuSzyE9vW2wg-1; Wed, 01 Jul 2020 12:15:21 -0400
X-MC-Unique: Ca59u2IIM5iuSzyE9vW2wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D79A186A222;
 Wed,  1 Jul 2020 16:15:20 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6575260CD1;
 Wed,  1 Jul 2020 16:15:04 +0000 (UTC)
Date: Wed, 1 Jul 2020 17:15:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200701161501.GJ1427561@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
 <20200701160906.GT126613@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200701160906.GT126613@stefanha-x1.localdomain>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Christophe de Dinechin <dinechin@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 05:09:06PM +0100, Stefan Hajnoczi wrote:
> On Tue, Jun 30, 2020 at 01:41:36PM +0100, Daniel P. Berrangé wrote:
> > On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wrote:
> > IMHO the whole point of having the pluggable trace backend impls, is
> > precisely that we don't have to add multiple different calls in the
> > code. A single trace_qemu_mutex_unlock() is supposed to work with
> > any backend.
> 
> I think an exception is okay when the other trace backends do not offer
> equivalent functionality.
> 
> Who knows if anyone other than Christophe will use this functionality,
> but it doesn't cost much to allow it.

This patch is just an example though, suggesting this kind of usage is
expected to done in other current trace probe locations. The trace wrapper
has most of the information required already including a format string,
so I'd think it could be wired up to the generator so we don't add extra
record() statements through the codebase. At most it should require an
extra annotation in the trace-events file to take the extra parameter
for grouping, and other trace backends can ignore that.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


