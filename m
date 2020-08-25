Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8756C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E20320665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 14:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UG6lsURx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E20320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAZkr-0005RC-QZ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 10:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAZkG-00050S-It
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kAZkA-0002t7-MA
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 10:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598364967;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qpbpjv3zUYOlMXWKPBtnLmhOZFGC+TkTRCOxGH2a6Gk=;
 b=UG6lsURxiQsrF6CPBq6DsegXQN5pkF9R7riyydncZ52wQb4p2k+A2BBL6vU/byN38qHlNY
 AJ/X1xQ5OUzlIoeuI1twv6/0K/lXfcsOloUI5h4WCXT2THstOl1X7sTfGPHhKhLeNW4TOP
 1o2qYYDUkmNo7oc931oBurjTEYjZfEs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-5cpqCOkbNraDyE7fOUGzDw-1; Tue, 25 Aug 2020 10:16:01 -0400
X-MC-Unique: 5cpqCOkbNraDyE7fOUGzDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5461780ED9A;
 Tue, 25 Aug 2020 14:16:00 +0000 (UTC)
Received: from redhat.com (ovpn-114-231.ams2.redhat.com [10.36.114.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92FCC5C1C2;
 Tue, 25 Aug 2020 14:15:58 +0000 (UTC)
Date: Tue, 25 Aug 2020 15:15:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: meson.build files are missing copyright/license headers
Message-ID: <20200825141555.GR107278@redhat.com>
References: <CAFEAcA_0R9mQNFnyzdpR65YRHoDs0uPKWxmCOQUojbpAM-jP8A@mail.gmail.com>
 <CAJ+F1CL1Hp-g8gNMpdGgk2d0KCzJfBde9f_mX8TLtewe3-B48g@mail.gmail.com>
 <CAFEAcA_u_3P9MQ23zWTUH-aM8Nabbt+PVv+4qOWpEAhiuJq+cg@mail.gmail.com>
 <e9155559-9a06-ec6f-4be0-2a692364c665@redhat.com>
 <CAFEAcA919wJg00vVTyVksaZGNmD50gH1jQj6RWA1ZAafEJAbOg@mail.gmail.com>
 <ec7272ca-ffed-10b3-4176-8d2905d25772@redhat.com>
 <CAFEAcA9AMc62FhA8gn-=M2Jhe7Ahkf3AP-pWcJsYUEBLU=Jw3g@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9AMc62FhA8gn-=M2Jhe7Ahkf3AP-pWcJsYUEBLU=Jw3g@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 03:04:57PM +0100, Peter Maydell wrote:
> On Tue, 25 Aug 2020 at 14:58, Thomas Huth <thuth@redhat.com> wrote:
> > On 25/08/2020 11.53, Peter Maydell wrote:
> > >  * decide what our plan is for 3rd-party code (libvixl, etc)
> > >    [where any SPDX line we add will be lost again next time
> > >    we resync our copy of the code]
> >
> > For things like libvixl, I wonder why this is not a git submodule instead?
> 
> Because we only take a few files from it, not the whole thing
> (which is massive and includes an assembler and a simulator).
> 
> > >  * update existing files (I think the kernel folks probably
> > >    have scripted stuff for the easy parts of this; multi-license
> > >    files like fpu/softfloat.c likely need by-hand conversion)
> >
> > Yes. I think we have to be very careful here with old files - adding the
> > tags is likely ok, but e.g. removing the boilerplate text in the various
> > headers at the same time could be problematic (e.g. the MIT license says
> > "... this permission notice shall be included in all copies or
> > substantial portions of the Software")...
> 
> Presumably the kernel folks have been down this route before us...

Advice I've received is that, in general, removing existing license
header text NOT OK unless you are the exclusive copyright holder.

IIUC the kernel folks went through a bunch of work behind the scenes,
involving lawyers to make what they did ok.

IOW, don't compare QEMU to kernel based solely on the public commits
you see doing the change in linux.git, as that would miss any of the
background work involved.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


