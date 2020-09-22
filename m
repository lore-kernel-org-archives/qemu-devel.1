Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F559C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26DC235FD
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWBdnRlJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26DC235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKmOf-0007TB-KR
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKmKT-0004dC-Hs
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kKmKR-0003qU-LJ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600796626;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwEtph4Nq8zHlHNKyWMvw3GmPB5KnzYkhzXsiQ5btFA=;
 b=VWBdnRlJPRslx3WDFAETWvMVqaKk9BaFLnpotG/CFb0guf8Bj9eU46owEnHthsnlbmNdtN
 xwE+6yGhoZizd7OEiFIAVpnzzs9190i2fDpW5ajv8kmX0c2ZotEMCJbKA+cNgQ2gxfbmgP
 fqqBHlBFsfZRRVIeNKz0Mx2VzlzdXx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-ZUcjdyqxNqa8movHoqdU7g-1; Tue, 22 Sep 2020 13:43:20 -0400
X-MC-Unique: ZUcjdyqxNqa8movHoqdU7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B60E80EFBF;
 Tue, 22 Sep 2020 17:43:17 +0000 (UTC)
Received: from redhat.com (ovpn-114-64.ams2.redhat.com [10.36.114.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6F4468432;
 Tue, 22 Sep 2020 17:42:55 +0000 (UTC)
Date: Tue, 22 Sep 2020 18:42:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Neal Gompa <ngompa13@gmail.com>
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
Message-ID: <20200922174252.GU1989025@redhat.com>
References: <20200922161611.2049616-1-berrange@redhat.com>
 <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 libvir-list <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 01:09:06PM -0400, Neal Gompa wrote:
> On Tue, Sep 22, 2020 at 12:16 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > 2 years back I proposed dropping the sheepdog mailing list from the
> > MAINTAINERS file, but somehow the patch never got picked up:
> >
> >   https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html
> >
> > So here I am with the same patch again.
> >
> > This time I go further and deprecate the sheepdog driver entirely.
> > See the rationale in the second patch commit message.
> >
> > Daniel P. Berrangé (2):
> >   block: drop moderated sheepdog mailing list from MAINTAINERS file
> >   block: deprecate the sheepdog block driver
> >
> >  MAINTAINERS                |  1 -
> >  block/sheepdog.c           | 15 +++++++++++++++
> >  configure                  |  5 +++--
> >  docs/system/deprecated.rst |  9 +++++++++
> >  4 files changed, 27 insertions(+), 3 deletions(-)
> >
> > --
> > 2.26.2
> >
> >
> 
> I don't know of anyone shipping this other than Fedora, and I
> certainly don't use it there.
> 
> Upstream looks like it's unmaintained now, with no commits in over two
> years: https://github.com/sheepdog/sheepdog/commits/master
> 
> Can we also get a corresponding change to eliminate this from libvirt?

This is only deprecation in QEMU, the feature still exists and is
intended to be as fully functional as in previous releases.

Assuming QEMU actually deletes the feature at end of the deprecation
cycle, then libvirt would look at removing its own support.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


