Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0956C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5A0206DD
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 15:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H82F0FNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5A0206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPoqz-0008GN-4a
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 11:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPooF-0006da-G3
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kPoo9-00056v-Km
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 11:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601997796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A1ZlOEodKJ8XSBImIcVvCdJrzG2X2vEC8CvDTsnL34c=;
 b=H82F0FNlnh38igzj+cJ7UJH1Ahm5xahnbIYSjw3DcnDSXTN+OWvfaHk3015xS6Q7qjeE9L
 XRNp6lqLw1q5BVF504tWbA58sqGcpufQM3RZhG6C8WQ7ZTlJpnQo+iI09dCI1q/SxvokU8
 IgdTMMK8R9Cm/PKPcEJuoPhH0XG+GEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-pbVza8dUP5WcO0DfPgzfuQ-1; Tue, 06 Oct 2020 11:23:13 -0400
X-MC-Unique: pbVza8dUP5WcO0DfPgzfuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B602104D3E5;
 Tue,  6 Oct 2020 15:23:12 +0000 (UTC)
Received: from localhost (unknown [10.40.208.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDEDB10013BD;
 Tue,  6 Oct 2020 15:23:10 +0000 (UTC)
Date: Tue, 6 Oct 2020 17:23:09 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PULL 00/21] machine + QOM queue, 2020-10-05
Message-ID: <20201006172309.36585fe1@redhat.com>
In-Reply-To: <20201006170418.67bc8ce6@redhat.com>
References: <20201005211000.710404-1-ehabkost@redhat.com>
 <CAFEAcA_+4b4HHP_8BBqqy+QmoyF6Lx1jmuFvcsbW5THZQDrXww@mail.gmail.com>
 <20201006143637.GP7303@habkost.net>
 <20201006170418.67bc8ce6@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. =?UTF-8?B?QmVy?=
 =?UTF-8?B?cmFuZ8Op?=" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 6 Oct 2020 17:04:18 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Tue, 6 Oct 2020 10:36:37 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Tue, Oct 06, 2020 at 03:03:57PM +0100, Peter Maydell wrote: =20
> > > On Mon, 5 Oct 2020 at 22:10, Eduardo Habkost <ehabkost@redhat.com> wr=
ote:   =20
> > > >
> > > > The following changes since commit 36d9c2883e55c863b622b99f0ebb5143=
f0001401:
> > > >
> > > >   readthedocs: build with Python 3.6 (2020-10-05 16:30:45 +0100)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
> > > >
> > > > for you to fetch changes up to fec5c4b6d3b7f3ffcfcbe1714e0405df6de2=
a222:
> > > >
> > > >   kernel-doc: Remove $decl_type=3D'type name' hack (2020-10-05 12:4=
8:11 -0400)
> > > >
> > > > ----------------------------------------------------------------
> > > > machine + QOM queue, 2020-10-05
> > > >
> > > > * QOM documentation fixes and cleanups (Eduardo Habkost)
> > > > * user-mode: Prune build dependencies (Philippe Mathieu-Daud=C3=A9)
> > > > * qom: Improve error message (Philippe Mathieu-Daud=C3=A9)
> > > > * numa: hmat: require parent cache description before the next
> > > >   level one (Igor Mammedov)
> > > >
> > > > ----------------------------------------------------------------   =
=20
> > >=20
> > > Compile failure on OSX:
> > >=20
> > > ../../hw/core/numa.c:429:20: error: format specifies type 'unsigned
> > > char' but the argument has type 'int' [-Werror,-Wformat]
> > >                    node->level - 1);
> > >                    ^~~~~~~~~~~~~~~~
> > > /Users/pm215/src/qemu-for-merges/include/qapi/error.h:319:35: note:
> > > expanded from macro 'error_setg'
> > >                         (fmt), ## __VA_ARGS__)
> > >                          ~~~      ^~~~~~~~~~~
> > > 1 error generated.   =20
> >=20
> > Is there a CI system where this is tested?  I'd like to be able
> > to detect this kind of failure before sending pull requests. =20
> I usually use travis-ci, but for this patch I didn't run it via CI for so=
me reason.
> Just posted fixed v2.
>=20
> (it looks like pushing to github doesn't trigger travis build anymore)
Looks like travis-ci lost previous authorizations to my github repo,
but giving a new one didn't help.

Something wrong with current QEMU master, travis-ci doesn't recognize QEMU =
repo a valid anymore.


