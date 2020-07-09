Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E6AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B9120708
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hfG9WPmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B9120708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWRa-0000U2-Va
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtWR3-0008VZ-B8
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:17:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtWR1-0001Sl-DD
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=byb2mh+FEdYMkDhhhZKOIM1g2Wn9p6gHz4ykOohnFZc=;
 b=hfG9WPmGq5B+huKJ6wkBiLOpK/F+poFzYNxOCy5Kjc/+rQsWV1L9BDzL3xezScL49m5Aof
 5Aw4ZiYZEty0BeMGQVCgZdYI+2P0vYcE1ysC6LkFuAMoGjhUP4H2tpnzIUcbEMJDZKyQAx
 ToHKiOYIwWYf155kYvAJys9YUPiTo8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-qpzflvTgOZWZ1dVSKHOS-Q-1; Thu, 09 Jul 2020 09:17:40 -0400
X-MC-Unique: qpzflvTgOZWZ1dVSKHOS-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06E1A8015FB;
 Thu,  9 Jul 2020 13:17:39 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8035060BE2;
 Thu,  9 Jul 2020 13:17:29 +0000 (UTC)
Date: Thu, 9 Jul 2020 14:17:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: Delete some Wiki pages (was: Migrating custom qemu.org
 infrastructure to GitLab)
Message-ID: <20200709131726.GP3753300@redhat.com>
References: <CAJSP0QV3uB4QY6mzw2JFDedr0PJhGkU5FdmLF5PbjMPyxiYSuw@mail.gmail.com>
 <20200708105353.GE3229307@redhat.com>
 <20200709101602.lc2uipjlxobjvjn3@sirius.home.kraxel.org>
 <3dacddaa-c739-445b-a24a-02f9e51b9b0e@redhat.com>
 <8e1276e2-8957-49db-0409-e85ab2f09739@redhat.com>
 <4e5404a7-20dc-cb5d-6307-b66fae8f77a4@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4e5404a7-20dc-cb5d-6307-b66fae8f77a4@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:33:23
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cleber Rosa <cleber@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 09, 2020 at 03:10:44PM +0200, Thomas Huth wrote:
> On 09/07/2020 12.33, Paolo Bonzini wrote:
> > On 09/07/20 12:22, Thomas Huth wrote:
> >> FWIW, seems like we could use the "pandoc" tool to convert Mediawiki
> >> (our old Wiki) to Markdown (Gitlab wiki). I've done a quick test and
> >> converted https://wiki.qemu.org/Contribute/MailingLists into
> >> https://gitlab.com/huth/qemu/-/wikis/Contribute/MailingLists with some
> >> few clicks.
> >>
> >> But the longer I look at most Wiki pages, the more I think that we
> >> should convert the important pages rather into a part of qemu-web
> >> instead. I'll have a closer look and will suggest some patches when time
> >> permits...
> > 
> > The wiki was cleaned up more or less at the same time as the
> > qemu-web.git repo was created (actually as a prerequisite), it's
> > actually not in a bad shape.
> 
> There are still quite a bit of pages that either contain hardly any
> usable information or are completely outdated. Paolo, Stefan, may I ask
> you to check whether the following pages could be deleted? I don't have
> access rights to delete a page, so if you agree that they are mostly
> useless, please go ahead and delete them:

> - https://wiki.qemu.org/Features/LibvirtWiresharkDissector
>   seems to be a libvirt proposal - IMHO should not be in the QEMU wiki

This was a GSoC project and at that time libvirt GSoC projects were
under the QEMU umbrella. Libvirt now runs GSoC itself.

Either way, there's no particularly important content here, but it is
the second hit in google for "libvirt wireshark" ! I'm fine with it
being removed in general unless we want to keep a record of old GSoc
projects ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


