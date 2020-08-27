Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A51C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:01:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909DC20678
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoUDWeZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909DC20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBJPU-0001o4-Rn
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 11:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBJOY-00017A-Vi
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:00:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBJOW-000154-Ai
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 11:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598540451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qEf5GMbd/2fEKGdCW0AINO7gWCVMG8NlwMzpSfEQXqk=;
 b=hoUDWeZ1TA5SgCEGr7mff9eOZnbNjB0WxL/v6vuGMrb0s/v4efnQEsx295QR7ph+TWpzGn
 ounTqYSEbVd+KeYyTN7P/1pdS/4mub0YseibSvU/wMKY2zRRSJ09YfEjQjXAqKcXtB1O8J
 zJL/9V0cy0HF3RbrmjtXPX8ACWiz9aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-KV4WX34EM2WWyAN0P4QAEQ-1; Thu, 27 Aug 2020 11:00:31 -0400
X-MC-Unique: KV4WX34EM2WWyAN0P4QAEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94AEA18C523C;
 Thu, 27 Aug 2020 15:00:28 +0000 (UTC)
Received: from redhat.com (ovpn-114-113.ams2.redhat.com [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80A825DA82;
 Thu, 27 Aug 2020 15:00:07 +0000 (UTC)
Date: Thu, 27 Aug 2020 16:00:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] cirrus.yml: Exclude some targets in the FreeBSD job to
 speed up the build
Message-ID: <20200827150005.GA216263@redhat.com>
References: <20200824094410.6201-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200824094410.6201-1-thuth@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 11:44:10AM +0200, Thomas Huth wrote:
> The FreeBSD jobs currently hit the 1h time limit in the Cirrus-CI.
> We've got to exclude some build targets here to make sure that the job
> finishes in time again. The targets that are excluded should not hurt
> much, since e.g. all the code from i386-softmmu is covered again by
> x86_64-softmmu.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Not sure why the FreeBSD builds suddenly got slower and hit the 1h
>  time limit now. Looking at https://cirrus-ci.com/github/qemu/qemu
>  it seems like the FreeBSD jobs were already taking ca. 48 minutes
>  since quite a while, but since the Meson build system has been merged,
>  they now always hit the 1h limit. Could it be that Meson is slow on
>  FreeBSD?

No, it appears to just be compiling a lot more than in the past.

$ grep Compiling main.log-meson  | wc -l
5468

$ grep CC main.log-config  | wc -l
4855

This seems to be caused my compiling lots of stuff under tests/
that we did not previously build

$ grep Compiling main.log-meson  | grep tests/ | wc -l
616


not sure if this is specific to FreeBSD, or whether we're doing
this on all platforms and merely noticed first on FreeBSD due
to the timeout.

Mostly it seems to the libtestfloat ad libsoftfloat, but also
a bit of libqtest stuff.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


