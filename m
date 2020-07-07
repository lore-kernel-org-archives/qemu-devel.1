Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56908C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E6A2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XccgXrbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E6A2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjGN-0007Xr-3U
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsjFl-00077H-8u
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:47:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsjFi-0003J7-Uz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594111617;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4MYB3HeJnGZ6YZushfQwM6W4I0JwXWJTIgoYLedTMSI=;
 b=XccgXrbTF6kPpIXfLlobTrOJQhIb3wsut6wZFQn4sicUWxEgjHQTR5Na1xqaxupEZ6KxEi
 o62feaVoOdrhylvfL+FD9AFikgg5tRDoJA2sm6q8zL4a/CU7+yrVcOiQYisvAQmdOT6ZkL
 lb8WxL/pEB4cbw+Jyuv/EZ9TbzUo0Zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-nzGGsIKyNRCUFNCAkijulA-1; Tue, 07 Jul 2020 04:46:55 -0400
X-MC-Unique: nzGGsIKyNRCUFNCAkijulA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2F91B18BC2;
 Tue,  7 Jul 2020 08:46:54 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBF3B7922B;
 Tue,  7 Jul 2020 08:46:50 +0000 (UTC)
Date: Tue, 7 Jul 2020 09:46:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
Message-ID: <20200707084647.GB2649462@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, ehabkost@redhat.com, philmd@redhat.com,
 mark.cave-ayland@ilande.co.uk, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, pbonzini@redhat.com,
 David Gibson <dgibson@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 07, 2020 at 06:45:57AM +0200, Thomas Huth wrote:
> On 27/05/2020 10.47, Markus Armbruster wrote:
> > "info qom-tree" prints children in unstable order.  This is a pain
> > when diffing output for different versions to find change.  Print it
> > sorted.
> > 
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> 
>  Hi Markus,
> 
> this patch causes a slow down of the qtests which becomes quite massive
> when e.g. using the ppc64 and thourough testing. When I'm running
> 
> QTEST_QEMU_BINARY="ppc64-softmmu/qemu-system-ppc64" time \
> ./tests/qtest/device-introspect-test -m slow | tail -n 10
> 
> the test runs for ca. 6m40s here before the patch got applied, and for
> mor than 20 minutes after the patch got applied!
> 
> This causes our gitlab CI to constantly fail since the patch got merged,
> since the testing time now exceeds the 1h time limit:
> 
>  https://gitlab.com/qemu-project/qemu/-/pipelines/156767175
> 
> Sure, we can work around that problem in the CI (Alex has already a
> patch queued), but still, is there something you could do about this
> massive slowdown?

I think the answer is to stop using q_queue_insert_sorted(). The impl of
it looks like it is quadratic in complexity. Instead store the objects
in a plain array and then use qsort() at the end.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


