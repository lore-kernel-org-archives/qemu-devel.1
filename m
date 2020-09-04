Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50803C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B8E20791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B8E20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8x3-0005O5-9k
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE8wS-0004v1-Ab
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:27:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37590
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kE8wQ-0004OA-6K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 06:27:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-cSoSLD_bMsW9sKJVrZzTGg-1; Fri, 04 Sep 2020 06:27:31 -0400
X-MC-Unique: cSoSLD_bMsW9sKJVrZzTGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70C2D801AB4;
 Fri,  4 Sep 2020 10:27:30 +0000 (UTC)
Received: from redhat.com (ovpn-114-5.ams2.redhat.com [10.36.114.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CBB1F7EEB5;
 Fri,  4 Sep 2020 10:27:25 +0000 (UTC)
Date: Fri, 4 Sep 2020 11:27:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] meson: install ivshmem-client and ivshmem-server
Message-ID: <20200904102722.GN721059@redhat.com>
References: <20200903153524.98168-1-brogers@suse.com>
 <4eba2feb-a9b3-8bb7-6ed7-6b02c79519b1@redhat.com>
 <20200903154906.GA441291@redhat.com>
 <69f279ce-30e8-e83c-718b-021d3e6b264d@redhat.com>
 <87a6y6dmy4.fsf@dusky.pond.sub.org>
 <22ec640f-a9e4-22ad-020c-e035e8143e6c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <22ec640f-a9e4-22ad-020c-e035e8143e6c@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Bruce Rogers <brogers@suse.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 11:37:58AM +0200, Philippe Mathieu-Daudé wrote:
> On 9/4/20 9:24 AM, Markus Armbruster wrote:
> > Paolo Bonzini <pbonzini@redhat.com> writes:
> > 
> >> On 03/09/20 17:49, Daniel P. Berrangé wrote:
> >>> On Thu, Sep 03, 2020 at 05:44:25PM +0200, Paolo Bonzini wrote:
> >>>> On 03/09/20 17:35, Bruce Rogers wrote:
> >>>>> Turn on the meson install flag for these executables
> >>>>>
> >>>>> Signed-off-by: Bruce Rogers <brogers@suse.com>
> >>>>> ---
> >>>>>  contrib/ivshmem-client/meson.build | 2 +-
> >>>>>  contrib/ivshmem-server/meson.build | 2 +-
> >>>>>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/contrib/ivshmem-client/meson.build b/contrib/ivshmem-client/meson.build
> >>>>> index 1b171efb4f..83a559117f 100644
> >>>>> --- a/contrib/ivshmem-client/meson.build
> >>>>> +++ b/contrib/ivshmem-client/meson.build
> >>>>> @@ -1,4 +1,4 @@
> >>>>>  executable('ivshmem-client', files('ivshmem-client.c', 'main.c'),
> >>>>>             dependencies: glib,
> >>>>>             build_by_default: targetos == 'linux',
> >>>>> -           install: false)
> >>>>> +           install: true)
> >>>>> diff --git a/contrib/ivshmem-server/meson.build b/contrib/ivshmem-server/meson.build
> >>>>> index 3a53942201..a1c39aa3b3 100644
> >>>>> --- a/contrib/ivshmem-server/meson.build
> >>>>> +++ b/contrib/ivshmem-server/meson.build
> >>>>> @@ -1,4 +1,4 @@
> >>>>>  executable('ivshmem-server', files('ivshmem-server.c', 'main.c'),
> >>>>>             dependencies: [qemuutil, rt],
> >>>>>             build_by_default: targetos == 'linux',
> >>>>> -           install: false)
> >>>>> +           install: true)
> >>>>>
> >>>>
> >>>> They weren't installed before the conversion, were they?
> >>>
> >>> Unfortunately they were historically installed with --enable-tools.
> >>>
> >>> IMHO nothing in contrib/ should be installed by default. If we consider
> >>> something maintained and high enough quality for end users, it should
> >>> migrate out of contrib/ into tools/.
> >>
> >> Ah, via the tools variable in configure.  Nice maze.  I've queued the patch.
> > 
> > Please don't.
> > 
> > These programs are examples to help people understand how the ivhsmem
> > device works.  They might even be useful for debugging.  They are *not*
> > to be used in production.
> > 
> > docs/specs/ivshmem-spec.txt:
> > 
> >     Example server code is in contrib/ivshmem-server/.  Not to be used in
> >     production.  It assumes all clients use the same number of interrupt
> >     vectors.
> > 
> >     A standalone client is in contrib/ivshmem-client/.  It can be useful
> >     for debugging.
> 
> Renaming the file names to contain "example" would make this clear.

That's essentially what 'contrib' already means. We shold probablt
add a contrib/README.rst file though to explicitly tell people what
we consider the state of these things to be.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


