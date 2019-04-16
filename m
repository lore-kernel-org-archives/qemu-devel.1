Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C04C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:13:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07A76206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 12:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A76206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35809 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGMyI-0003K2-2D
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 08:13:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGMxW-00031L-W3
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hGMxV-0006nZ-Ux
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hGMxV-0006i6-Ip
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:13:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29CE9307D978;
	Tue, 16 Apr 2019 12:12:49 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 241B7608C1;
	Tue, 16 Apr 2019 12:12:43 +0000 (UTC)
Date: Tue, 16 Apr 2019 13:12:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190416121241.GL31311@redhat.com>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Tue, 16 Apr 2019 12:12:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416121241.LGXGxHcNoq-y0VpWVVBMW4b-t3kQVEP1jcuTN2MB_KE@z>

On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>=20
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
>=20
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1=
].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.
>=20
> Reference:
> [1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87
>=20
> Signed-off-by: Pu Wen <puwen@hygon.cn>
> ---
> v2->v3:
>   - Remove the Dhyana machine types in the back-compat property tables
>     since there is no Dhyana CPU model in older QEMU releases.
>=20
> v1->v2:
>   - Remove CPU model 'Dhyana' and rename the CPU model 'Dhyana-IBPB' to
>     'Dhyana' because Dhyana CPUs already have the IBPB feature.
>=20
>  target/i386/cpu.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++=
+++
>  target/i386/cpu.h |  2 ++
>  2 files changed, 52 insertions(+)

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

