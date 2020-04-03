Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B4CC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 141272077D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNsRkKBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141272077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNDu-0005vX-5z
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jKNDJ-0005Vc-1p
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1jKNDG-0005tf-UE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:22:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53238
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1jKNDG-0005tC-KR
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585923745;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=Cesu/Rqb5ccaX21wPu/Qze+09c9Gd3ipVv7CD44dpAY=;
 b=VNsRkKBxWzQY8ii3i+TlBow+wHsMGIisj4POIVLUXHwdidqlIqNGo8HJvAoxIVktYiqdOm
 pt8HuNY9WYB8TCZ2HSlGZG1WnTuRrHnOdBs1oyH7TPcFEP3VFxJgdan1ZL/iXLD3DI5eel
 3wTRwQOPOihIyssxs5Jj4qcOra50YDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-3lydG17HON-oSvni7ERhBw-1; Fri, 03 Apr 2020 10:22:19 -0400
X-MC-Unique: 3lydG17HON-oSvni7ERhBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853DE13F6
 for <qemu-devel@nongnu.org>; Fri,  3 Apr 2020 14:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AD751101D480
 for <qemu-devel@nongnu.org>; Fri,  3 Apr 2020 14:22:17 +0000 (UTC)
Date: Fri, 3 Apr 2020 15:22:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: FYI GitHub pull request / issue tracker lockdown bot
Message-ID: <20200403142213.GO559148@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU, like libvirt, has a github.com project which contains automated
read-only mirrors of QEMU repositories.

  https://github.com/qemu/

An unfortunate side effect of this is that some users will try to open
pull requests against these mirrors. These get ignored until eventually
someone notices and closes the request. QEMU has had about 90 prs opened
over the years.

  https://github.com/qemu/qemu/pulls

The same applies to the issue tracker, but fortunately github lets
projects disable this feature, which QEMU has done.

I have recently discovered that there is a nice 3rd party bot for github
which can autorespond to pull requests with a friendly comment, close the
request, and then lock it to prevent further comments.

  https://github.com/apps/repo-lockdown

I'm setting this up for libvirt and it was suggested QEMU can probably
benefit from it too as an example see:

  https://github.com/libvirt/test/issues/2
  https://github.com/libvirt/test/pull/3


Configuration just requires creation of a ".github/lockdown.yml" file
which provides the friendly message to add to the merge requests. This
can be either done per-repository, or a special repo can be created
called ".github" and this will apply to all repos within the project.

Ideally each repo would have a CONTRIBUTING.md file created too, since
both GitHub and GitLab will direct users to this file for guidelines
on how to contribute.

I don't have time right now to do this for QEMU, so consider this email
a friendly suggestion for some other interested person to do for QEMU...

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


