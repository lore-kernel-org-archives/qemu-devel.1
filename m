Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0AEC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570E020665
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 09:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570E020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiFV9-0006uQ-LM
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 05:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hiFNn-0008UY-BG
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:47:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hiFNl-0007Yl-33
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:47:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hiFNk-0007YR-Rn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 05:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 260F330872FB;
 Tue,  2 Jul 2019 09:47:24 +0000 (UTC)
Received: from redhat.com (ovpn-112-16.ams2.redhat.com [10.36.112.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C58915D717;
 Tue,  2 Jul 2019 09:47:20 +0000 (UTC)
Date: Tue, 2 Jul 2019 10:47:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190702094717.GP21569@redhat.com>
References: <20190628002844.24894-1-ehabkost@redhat.com>
 <20190628002844.24894-10-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628002844.24894-10-ehabkost@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 02 Jul 2019 09:47:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 9/9] i386: Add Cascadelake-Server-v2 CPU
 model
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
Cc: jingqi.liu@intel.com, Tao Xu <tao3.xu@intel.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Hu,
 Robert" <robert.hu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Denemark <jdenemar@redhat.com>, "Lai, Paul C" <paul.c.lai@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 09:28:44PM -0300, Eduardo Habkost wrote:
> Add new version of Cascadelake-Server CPU model, setting
> stepping=3D5 and enabling the IA32_ARCH_CAPABILITIES MSR
> with some flags.
>=20
> The new feature will introduce a new host software requirement,
> breaking our CPU model runnability promises.  This means we can't
> enable the new CPU model version by default in QEMU 4.1, because
> management software isn't ready yet to resolve CPU model aliases.
> This is why "pc-*-4.1" will keep returning Cascadelake-Server-v1
> if "-cpu Cascadelake-Server" is specified.

Hmm, yes, we don't actually need to answer the question I
raised in the earlier patch for another 2 releases yet,
as we'll be sticking with v1 for all machines for a while.

>=20
> Includes a test case to ensure the right combinations of
> machine-type + CPU model + command-line feature flags will work
> as expected.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v1 -> v2:
> * Enable rdctl-no, ibrs-all, skip-l1dfl-vmentry
>   (Suggested by Tao Xu)
>=20
> Cc: "Hu, Robert" <robert.hu@intel.com>
> Cc: Tao Xu <tao3.xu@intel.com>
> Cc: jingqi.liu@intel.com,
> Cc: "Lai, Paul C" <paul.c.lai@intel.com>
> ---
>  target/i386/cpu.c                          | 14 +++++
>  tests/acceptance/x86_cpu_model_versions.py | 73 ++++++++++++++++++++++
>  2 files changed, 87 insertions(+)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

