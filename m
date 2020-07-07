Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C6FC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A952065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 09:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGVgllsE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A952065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsk63-0001aW-EM
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48736)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsk5M-0000u9-2j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:40:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55077
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jsk5K-0004SW-0p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 05:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594114816;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zI5Z7RQP3rBg7MrBNUAelWh4881OkbBao63JmFMXZyE=;
 b=VGVgllsEeHt4CFpFhQcAI+3KKIwYfCN4JpzBaWF2cK8BfiZ3yCf5Ny1EiAdLpbuBTblu+Q
 CEVb/bXIECLo+Z63qQyTa1UeBiyW0JAq/sE/LuzpF5rRU9YhYKdRugTAT6992Lyzg5TzPZ
 gl2YNT35uek6A1icAf+PR/vzRpR3YXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-a-bEgep7NSejpAcb9zpGCw-1; Tue, 07 Jul 2020 05:40:14 -0400
X-MC-Unique: a-bEgep7NSejpAcb9zpGCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F893800D5C;
 Tue,  7 Jul 2020 09:40:13 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A409971674;
 Tue,  7 Jul 2020 09:40:09 +0000 (UTC)
Date: Tue, 7 Jul 2020 10:40:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
Message-ID: <20200707094006.GE2649462@redhat.com>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Laurent Vivier <lvivier@redhat.com>, ehabkost@redhat.com,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mark.cave-ayland@ilande.co.uk, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 David Gibson <dgibson@redhat.com>, pbonzini@redhat.com, philmd@redhat.com
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

I think the test case itself could be optimized. Currently it does
approx

   for each device type
      info qom-tree
      device_addr type,help
      info qom-tree

it compares the before/after qom-tree to look for stray objects or
to try to trigger crashes.

The info qom-tree calls could be pushed outside the loop

   info qom-tree
   for each device type
      device_addr type,help
   info qom-tree

Taking /x86_64/device/introspect/concrete/defaults/pc-q35-5.1 as a
example, this change is the difference between 20 seconds running and
3 seconds running.

Reverting Markus' change actually didn't make much difference, only
reducing the 20 seconds to 17 seconds.

The downside is that if there is a stray object/crash, it would not
immediately associate with the device type. I'm not sure that's a
real problem though. Especially if we are running this as pre-merge
CI we'll only need to look at the patch series to find the broken
device. If this is quick enough that we can run it as standard,
instead of only with -m slow, then its a net win I think.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


