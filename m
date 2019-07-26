Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AB8C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0EA2171F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 10:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0EA2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqx1C-0004Q4-1J
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 06:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqx0u-0003y4-J7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqx0o-0006rr-Eu
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:59:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqx0j-0006Rv-5Y; Fri, 26 Jul 2019 05:59:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CC0355AFE3;
 Fri, 26 Jul 2019 09:59:34 +0000 (UTC)
Received: from work-vm (ovpn-117-185.ams2.redhat.com [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B978E60C44;
 Fri, 26 Jul 2019 09:59:27 +0000 (UTC)
Date: Fri, 26 Jul 2019 10:59:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190726095925.GF2657@work-vm>
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-2-peter.maydell@linaro.org>
 <20190725170228.GL2656@work-vm>
 <c5a0799e-2ebe-5a79-915a-af52d471a589@redhat.com>
 <CAFEAcA8PROpFeKfxXFdVvVoZaus-MsX_EHGxw+yEUty_mnQdMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA8PROpFeKfxXFdVvVoZaus-MsX_EHGxw+yEUty_mnQdMQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 26 Jul 2019 09:59:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1? 1/2] stellaris_input: Fix vmstate
 description of buttons field
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 25 Jul 2019 at 18:40, Philippe Mathieu-Daud=E9 <philmd@redhat.c=
om> wrote:
> >
> > On 7/25/19 7:02 PM, Dr. David Alan Gilbert wrote:
> > > * Peter Maydell (peter.maydell@linaro.org) wrote:
> > >> gamepad_state::buttons is a pointer to an array of structs,
> > >> not an array of structs, so should be declared in the vmstate
> > >> with VMSTATE_STRUCT_VARRAY_POINTER_INT32; otherwise we
> > >> corrupt memory on incoming migration.
> > >>
> > >> We bump the vmstate version field as the easiest way to
> > >> deal with the migration break, since migration wouldn't have
> > >> worked reliably before anyway.
> > >>
> > >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > >
> > > OK, it would be great to change num_buttons to uint32_t and make th=
at a
> > > UINT32 at some point;  it's hard to press negative buttons.
> >
> > Since the version is incremented, now seems to be a good time.
>=20
> ...except this patch is for 4.1 and we've already done rc2,
> so it's not really an ideal time to put in code cleanups...

Don't worry; you can always change the int to a uint later without
bumping the version again.  Unless someone somewhere has a device with
-ve buttons it'll be fine.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

