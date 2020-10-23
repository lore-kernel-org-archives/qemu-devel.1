Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E4C5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:48:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70277223EA
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HydRZpwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70277223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW0Ey-0005Xk-7m
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kW0DD-0003oe-En
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30060)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kW0DA-0003dm-9Z
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 12:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603471597;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uUnfGCKnBHMkdIXbnISrBnd7Xk8ywFMLS2MPxMe8qko=;
 b=HydRZpwtIJMb8yXzAazFC33bUzwt6e8KZlEzss0h9jVwFjUJul/UAlKrgTuiu2KOMFd4wi
 OQu8G78oPpxmCuWC8+WnkVfoHSsn+EZk8/EEoI7w06yS6ON74KhJzTf9lDmtJp2t7Pcj7h
 e3maci1VyhwRjBytI77VCvVTkkRZ/70=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-UQLPZnRaOkG61qkGCZGhGQ-1; Fri, 23 Oct 2020 12:46:32 -0400
X-MC-Unique: UQLPZnRaOkG61qkGCZGhGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F9FDEDBCB
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 16:46:27 +0000 (UTC)
Received: from redhat.com (ovpn-113-189.ams2.redhat.com [10.36.113.189])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F8C76650;
 Fri, 23 Oct 2020 16:46:02 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:46:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [qemu-web PATCH 5/7] Simplify and restructure the page footer
Message-ID: <20201023164600.GC463062@redhat.com>
References: <20201023152957.488974-1-berrange@redhat.com>
 <20201023152957.488974-6-berrange@redhat.com>
 <54f37d84-a66e-bbfa-b410-2dba44d88ac9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <54f37d84-a66e-bbfa-b410-2dba44d88ac9@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 05:46:49PM +0200, Paolo Bonzini wrote:
> On 23/10/20 17:29, Daniel P. Berrangé wrote:
> > +	<div id="external-links">
> >  		<ul class="style">
> > -			<li><a href="{{ relative_root }}/">Home</a></li>
> > -			<li><a href="{{ relative_root }}/download">Download</a></li>
> > -			<li><a href="{{ relative_root }}/conservancy/">Conservancy / Committee</a></li>
> > -			<li><a href="http://qemu-advent-calendar.org">QEMU advent calendar</a></li>
> > -		</ul>
> > -		<ul class="style">
> > -			<li><a href="{{ relative_root }}/contribute">Contribute</a></li>
> > -			<li><a href="{{ relative_root }}/contribute/report-a-bug">Reporting a bug</a></li>
> > -			<li><a href="https://wiki.qemu.org/Documentation/GettingStartedDevelopers">New contributors</a></li>
> > -			<li><a href="https://wiki.qemu.org/Contribute/SubmitAPatch">Submitting a patch</a></li>
> > -			<li><a href="https://wiki.qemu.org/Contribute/FAQ">Contributor FAQ</a></li>
> > -		</ul>
> 
> I would rather keep this column, the idea is that this information can
> be found with a quick Ctrl-F "bug" or "Ctrl-F "faq".

If there are useful links that are hidden such that people have to use
"Ctrl-f <term>" to search for them, then I think we've failed at design
already.

I'm inclined to do some work on the top level index page to make these
things be prominent links you can see without scrolling or searching
when hitting the http://qemu.org/ front page.

IMHO the front page has way too much real estate taken up with the
screenshots and big headings, and very little useful content right
now. On my laptop 50% of the vertical space is the top header nav
bar, the huge "QEMU" heading and then the subheading. The other
50% of vertical space is the screenshots. The most interesting
content on the front page is the summary of latest releases, but
that's off screen. I'll have a play with tweaking the layout to
improve this.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


