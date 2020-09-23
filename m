Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFABC4727D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4CA2388A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7UPM/NB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4CA2388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL05J-0005Sc-9L
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 04:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kL04d-0004xC-2J
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:24:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1kL04a-0004jx-EH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 04:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600849458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WfkIDOE4FRctedpGK2/4YwlsCEHs2Uwlnm4WDRQjbRM=;
 b=R7UPM/NBcavCgesOwUp33+PFjGKzByd1NowktECbk83cEArmBvn7VuSZb0SBrtdw9+VEuW
 ZsdpsJSJYXl7CoMN+nG87+o01cVb8pR9G5wEdI5/1C45i/rFlxwuH666X4bRRx3BcJbIcy
 V61Q4VRFPN+83q736DdnBp6HTUKieBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-qu7PZOlYPd-6PQ8-5_7Qyg-1; Wed, 23 Sep 2020 04:24:15 -0400
X-MC-Unique: qu7PZOlYPd-6PQ8-5_7Qyg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE4E80046B;
 Wed, 23 Sep 2020 08:24:13 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60ABD19C4F;
 Wed, 23 Sep 2020 08:24:07 +0000 (UTC)
Date: Wed, 23 Sep 2020 10:24:04 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 0/2] block: deprecate the sheepdog driver
Message-ID: <20200923082404.GJ3371440@angien.pipo.sk>
References: <20200922161611.2049616-1-berrange@redhat.com>
 <CAEg-Je-td5R-pqbzUgpNYo856QnyfVafSh7QNNaWv8qvcRaJ9A@mail.gmail.com>
 <20200922174252.GU1989025@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922174252.GU1989025@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pkrempa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 03:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 sheepdog@lists.wpkg.org, qemu-block@nongnu.org,
 libvir-list <libvir-list@redhat.com>, Neal Gompa <ngompa13@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 18:42:52 +0100, Daniel Berrange wrote:
> On Tue, Sep 22, 2020 at 01:09:06PM -0400, Neal Gompa wrote:
> > On Tue, Sep 22, 2020 at 12:16 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > >
> > > 2 years back I proposed dropping the sheepdog mailing list from the
> > > MAINTAINERS file, but somehow the patch never got picked up:
> > >
> > >   https://lists.gnu.org/archive/html/qemu-block/2018-03/msg01048.html
> > >
> > > So here I am with the same patch again.
> > >
> > > This time I go further and deprecate the sheepdog driver entirely.
> > > See the rationale in the second patch commit message.
> > >
> > > Daniel P. Berrangé (2):
> > >   block: drop moderated sheepdog mailing list from MAINTAINERS file
> > >   block: deprecate the sheepdog block driver
> > >
> > >  MAINTAINERS                |  1 -
> > >  block/sheepdog.c           | 15 +++++++++++++++
> > >  configure                  |  5 +++--
> > >  docs/system/deprecated.rst |  9 +++++++++
> > >  4 files changed, 27 insertions(+), 3 deletions(-)
> > >
> > > --
> > > 2.26.2
> > >
> > >
> > 
> > I don't know of anyone shipping this other than Fedora, and I
> > certainly don't use it there.
> > 
> > Upstream looks like it's unmaintained now, with no commits in over two
> > years: https://github.com/sheepdog/sheepdog/commits/master
> > 
> > Can we also get a corresponding change to eliminate this from libvirt?
> 
> This is only deprecation in QEMU, the feature still exists and is
> intended to be as fully functional as in previous releases.
> 
> Assuming QEMU actually deletes the feature at end of the deprecation
> cycle, then libvirt would look at removing its own support.

There are two sheepdog-related bits in libvirt which are IMO completely
separate:

1) the blockdev backend handling for the 'sheepdog' protocol driver

 This is the one connected to qemu's deprecation, but until there is a
 qemu version where sheepdog wasn't deprecated/removed supported by
 libvirt we can't really do much about it.

 On the other hand it's just a few generators of arguments for
 -drive/-blockdev so the burden is very low.

2) the sheepdog storage driver

 This one is completely separate from qemu and we can decide to
 deprecate/delete it at our own schedule as it will not influence the
 ability to start VMs.

 The last non-housekeeping commit in that driver seems to be dated:
 Thu Jun 18 16:20:42 2015

 Similarly the burden of keeping this around is low, but I would not bat
 an eye if we remove it right away even.


