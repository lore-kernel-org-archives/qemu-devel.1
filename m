Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36816C43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8181422265
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SwO/qV8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8181422265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQshC-0005Su-Gh
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsgY-0004os-B7
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsgW-0001D1-9b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602251025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cwnQEjlcpryndssPY3m0VwV4oJGOOo5Ad6sgkM9RsWk=;
 b=SwO/qV8OM78h2iFNOpAJueSe6THZ/96qC3IIO56nnUcbS6XyLq6E4VU/EmJkgMB2kTNhUD
 MYMPE9Dy5UOpQHw6AsyW8B1Nkz/dwjTDe76rfi4To5j207Tir/3Z+Y5cJIjwbnQqg3ZoRf
 4i9xmKj/AQVslhzICdkacc92yQEcFXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-1kWu33TlNf2-Hpnj0d9PEA-1; Fri, 09 Oct 2020 09:43:44 -0400
X-MC-Unique: 1kWu33TlNf2-Hpnj0d9PEA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1196A8DA151;
 Fri,  9 Oct 2020 13:43:43 +0000 (UTC)
Received: from redhat.com (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EFC35C1BB;
 Fri,  9 Oct 2020 13:43:40 +0000 (UTC)
Date: Fri, 9 Oct 2020 14:43:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH 1/5] Fixing Lesser GPL version number [1/5]
Message-ID: <20201009134337.GC25901@redhat.com>
References: <20201009063734.2627-1-chetan4windows@gmail.com>
 <9f236758-8039-0a16-df3a-b49b7e24168d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <9f236758-8039-0a16-df3a-b49b7e24168d@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 08:07:52AM -0500, Eric Blake wrote:

> > There is no "version 2" of the "Lesser" General Public License. It is
> > either "GPL version 2.0" or "Lesser GPL version 2.1". This patch replaces all
> > occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" in comment section.
> 
> I'm not a copyright lawyer; there may be legal ramifications for doing
> this on files where you are not the copyright owner, although to me it
> looks like an obvious correction of intent, so I'm okay with the idea.

Yes, we've done exactly this same cleanup for various files before,
and considered it acceptable since it is matching the intent.


> Thus, maybe something like:
> 
> backends: Fix LGPL version number
> disas: Fix LGPL version number
> target: Fix LGPL version number
> 
> and so on.  There may be a smarter division of the work based on which
> maintainer(s) will have to ack various patches; breaking the series into
> more than 5 chunks may be easier, although it then requires more topic
> lines.  Or, if it truly is automated, doing it all in one shot may be
> best after all.

I'm happy to queue 80% of this patch, and a patch of patch 2, since
they cover files in subsystems I maintain and the typos are largely
my fault :-)



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


