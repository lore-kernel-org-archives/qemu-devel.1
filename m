Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FCAC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:06:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA52206B5
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pzlquoth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA52206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPoYC-0007kf-6N
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPoVz-00069O-GF
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:04:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPoVx-0001mi-5z
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601996665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCuDKZbBZaxBXhHcICKhvFF2wLqx8huyYJdthimddJQ=;
 b=PzlquothD3RsusTj2uj93+w9OndTShbV6wgIkQlpHtonVsFPR4/kp+VsB9ZLoZ/QLVXry+
 Kx0Khfa7v4eKJ3lD+Gnep2zslH41hyofUuFoxdFkZYlN13OpcobqfjY4QTF1iLu3KHLV6s
 MPcLLBxFkoKOz2Ke+LJVwG+5hUIB7Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-NZDPoE8SMiePD2QtjNbs2g-1; Tue, 06 Oct 2020 11:04:23 -0400
X-MC-Unique: NZDPoE8SMiePD2QtjNbs2g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92656800688;
 Tue,  6 Oct 2020 15:04:22 +0000 (UTC)
Received: from localhost (unknown [10.40.208.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B7E176646;
 Tue,  6 Oct 2020 15:04:20 +0000 (UTC)
Date: Tue, 6 Oct 2020 17:04:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
Message-ID: <20201006170418.67bc8ce6@redhat.com>
In-Reply-To: <20201006143637.GP7303@habkost.net>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 10:36:37 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 06, 2020 at 03:03:57PM +0100, Peter Maydell wrote:
> > On Mon, 5 Oct 2020 at 22:10, Eduardo Habkost <ehabkost@redhat.com> wrot=
e: =20
> > >
> > > The following changes since commit 36d9c2883e55c863b622b99f0ebb5143f0=
001401:
> > >
> > >   readthedocs: build with Python 3.6 (2020-10-05 16:30:45 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> > >
> > > for you to fetch changes up to fec5c4b6d3b7f3ffcfcbe1714e0405df6de2a2=
22:
> > >
> > >   kernel-doc: Remove $decl_type=3D'type name' hack (2020-10-05 12:48:=
11 -0400)
> > >
> > > ----------------------------------------------------------------
> > > machine + QOM queue, 2020-10-05
> > >
> > > * QOM documentation fixes and cleanups (Eduardo Habkost)
> > > * user-mode: Prune build dependencies (Philippe Mathieu-Daud=C3=A9)
> > > * qom: Improve error message (Philippe Mathieu-Daud=C3=A9)
> > > * numa: hmat: require parent cache description before the next
> > >   level one (Igor Mammedov)
> > >
> > > ---------------------------------------------------------------- =20
> >=20
> > Compile failure on OSX:
> >=20
> > ../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
> > char' but the argument has type 'int' [-Werror,-Wformat]
> >                    node->level - 1);
> >                    ^~~~~~~~~~~~~~~~
> > /Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
> > expanded from macro 'error_setg'
> >                         (fmt), ## __VA_ARGS__)
> >                          ~~~      ^~~~~~~~~~~
> > 1 error generated. =20
>=20
> Is there a CI system where this is tested?  I'd like to be able
> to detect this kind of failure before sending pull requests.
I usually use travis-ci, but for this patch I didn't run it via CI for some=
 reason.
Just posted fixed v2.

(it looks like pushing to github doesn't trigger travis build anymore)


