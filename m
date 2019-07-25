Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D4DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC94E22BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 08:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC94E22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqYvW-0008Hj-U5
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 04:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqYvK-0007nh-SF
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqYvJ-0006ib-6u
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 04:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36298)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqYvF-0006gm-Vr; Thu, 25 Jul 2019 04:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 049258F02B;
 Thu, 25 Jul 2019 08:16:21 +0000 (UTC)
Received: from work-vm (ovpn-117-187.ams2.redhat.com [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD8265DD8E;
 Thu, 25 Jul 2019 08:16:14 +0000 (UTC)
Date: Thu, 25 Jul 2019 09:16:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190725081612.GA2656@work-vm>
References: <20190724143553.21557-1-damien.hedde@greensocs.com>
 <543de194-b4e9-de7b-3dab-55fcc0976bc2@redhat.com>
 <20190724163812.GJ2717@work-vm>
 <e66cc73d-d185-c52a-b9fd-5081f960f0d8@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e66cc73d-d185-c52a-b9fd-5081f960f0d8@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 25 Jul 2019 08:16:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for 4.1?] pl330: fix vmstate description
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Damien Hedde (damien.hedde@greensocs.com) wrote:
>=20
>=20
> On 7/24/19 6:38 PM, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> >> On 7/24/19 4:35 PM, Damien Hedde wrote:
> >>> Fix the pl330 main and queue vmstate description.
> >>> There were missing POINTER flags causing crashes during
> >>> incoming migration because:
> >>> + PL330State chan field is a pointer to an array
> >>> + PL330Queue queue field is a pointer to an array
> >>>
> >>> Also bump corresponding vmsd version numbers.
> >>>
> >>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> >>> ---
> >>>
> >>> I found this while working on reset with xilinx-zynq machine.
> >>>
> >>> I'm not sure what's the vmsd version policy in such cases (for
> >>> backward compatibility). I've simply bumped them since migration
> >>> was not working anyway (vmstate_load_state was erasing critical par=
t
> >>> of PL330State and causing segfaults while loading following fields)=
.
> >>
> >> I still not understand versioning and migration
> >=20
> > Incrementing the version (and minimum) is the right thing
> > to do if you conclude the old one was hopelessly broken.
> > Migration to and from old qemu breaks, but who cares since it was toa=
st
> > anyway.
> > As far as I can tell pl330 is only on our zynq and exynos models
> > so wont break our versioned 'virt' type.
> > So from a migration point of view:
>=20
> Since switching from VARRAY to VARRAY_POINTER does not change the size
> of what's migrated, it should be possible to accept migration from old
> qemu if we can ignore the data in such cases and default to something
> (but what ? put the pl330 in reset state ?)

I don't think it's worth worrying about doing that unless you need to
preserve migration compatibility - which is less important for
stuff where it's used for dev rather than VMs


Dave

> Thanks,
> Damien
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

