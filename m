Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6452C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8866420775
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XvUZ6kMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866420775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqYo9-0002ee-RI
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqYnb-0002Eb-Jt
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:12:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40375
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jqYnZ-0002nG-Bv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593594775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uka67gUwyjNcHmPWfZ+KCCW2bvWOV0dJkLXgCT/mpVk=;
 b=XvUZ6kMUBXwqs6Lm4UTue5z9D/eCbDEyXhdnh14q7In5IzTmNmUK9Tt7XTPV25GKGMb1QN
 UdkGb6EODTXbr0scn99w3qq2N11Y4JpiDNNwvCG25r/5WKe5pL6ylc8L2qv9qllxM4VKCp
 c/qlLXylMHfJhUq9fthkAWAZyjO4kGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-7GnqxwfxOa2fFpkmOpymLA-1; Wed, 01 Jul 2020 05:12:52 -0400
X-MC-Unique: 7GnqxwfxOa2fFpkmOpymLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7F2804001;
 Wed,  1 Jul 2020 09:12:51 +0000 (UTC)
Received: from titinator (ovpn-114-227.ams2.redhat.com [10.36.114.227])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 642B019C4F;
 Wed,  1 Jul 2020 09:12:50 +0000 (UTC)
References: <20200616161814.891053-1-dinechin@redhat.com>
 <20200623144415.GP36568@stefanha-x1.localdomain>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] Makefile: Compute libraries for libqemuutil.a and
 libvhost-user.a
In-reply-to: <20200623144415.GP36568@stefanha-x1.localdomain>
Date: Wed, 01 Jul 2020 11:12:48 +0200
Message-ID: <ly1rlvd2en.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-23 at 16:44 CEST, Stefan Hajnoczi wrote...
> On Tue, Jun 16, 2020 at 06:18:14PM +0200, Christophe de Dinechin wrote:
>> In util/Makefile.objs, there is a setting for dbus.o-libs.
>> Trying to copy-paste that to add a library for module.o that was was
>> not otherwise linked yields link errors on a number of binaries,
>> e.g. qemu-ga, with unsatisfied symbols in libqemuutil.a(module.o).
>> The reason is that library dependencies are not propagated to the .a
>> files automatically.
>>
>> Adding a call to extract-libs to get the libraries for the two .a
>> files that are used elsewhere.
>>
>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>> ---
>>  Makefile | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Makefile b/Makefile
>> index 2e93068894..5fb0c78a0b 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -598,6 +598,8 @@ Makefile: $(version-obj-y)
>>  ######################################################################
>>  # Build libraries
>>
>> +libqemuutil.a-libs += $(call extract-libs, $(util-obj-y) $(trace-obj-y) $(stub-obj-y))
>> +libvhost-user.a-libs += $(call extract-libs, $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y))
>>  libqemuutil.a: $(util-obj-y) $(trace-obj-y) $(stub-obj-y)
>>  libvhost-user.a: $(libvhost-user-obj-y) $(util-obj-y) $(stub-obj-y)
>
> I wonder if there is GNU Make syntax to avoid duplicating the
> dependencies of libqemuutil.a and libvhost-user.a?

The dependencies are not identical. Would you want two lines, one with the
shared dependencies, i.e. something like:

  libqemuutils.a libhost-user.a: $(util-obj-y) $(stub-obj-y)
  libqemuutils.a: $(trace-obj-y)
  libvhost-user.a: $(libvhost-user-obj-y)

Or do you mean something else?

>
> Another thing I wonder about: the purpose of the .a files is to compile
> all object files and only link those .o files needed by the program
> (i.e. a subset of the .a file).

I believe that what you are saying is that by passing the required libraries
automatically, the binaries that use libqemuutil.a will inherit undesired
ldd dependencies. Indeed, a quick experiment shows that if you pass a -l
option, the library dependency is recorded even if no symbol in that library
is used. I saw no obvious linker option to address that.

Maybe add a comment, then, because otherwise it is surprising to have an
unsat despite something like:

  foo.o-libs = -lbar

As I pointed out in my commit comment, there is at least one case where this
is used, dbus.o-libs, suggesting that this is expected to work. This seems
to be the only case that goes in util-obj-y today. Apparently, this works
because the link of qemu-system-x86_64 already gets $(GIO_LIBS) from
some .o file that is not going through libqemuutil.a

>
> Now that libqemuutil.a-libs is defined, do programs using libqemuutil.a
> link libs required by .o files that aren't being used?

Yes. The alternative being that you get unsatisfied symbols if you do use
the .o file.

>
> For example, say we had util/mp3encoder.o which depends on an MP3
> encoder library. A utility like qemu-img does not depend on mp3encoder.o
> from libqemuutil.a. Therefore -lmp3enc or whatever shouldn't be on
> qemu-img's linker command-line.

If that's the intent, then util/mp3encoder.o should ideally not be lumped
into the library. Otherwise, you will get unsatisfied symbols when you use
it through the library, but not when you use it directly.

One can certainly argue that it's better to have an explicit "unsatisfied
symbol" error than a silent addition of an unwanted library dependency. If
that's the consensus, then, just add a comment explaining how this works.

Given that discussion, I'm now inclined to believe that the correct solution
is:

a) add a comment in the makefile explaining that .o-libs flags are not
   passed through .a files with a pointer to this discussion.

b) remove the existing dbus.o-libs line which has no effect, to avoid
   monkey-do copy-paste inheritance

--
Cheers,
Christophe de Dinechin (IRC c3d)


