Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A906ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AFC2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KR81OTee"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AFC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbK4-0005dT-7x
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iMbIK-0004Ss-Hn
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iMbII-0000jT-SN
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:16:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iMbHq-0000Yx-N8
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571678163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvYTRltvYCaKt9ETWDdeLYaZGdiw0lIpixKqx3eSDKU=;
 b=KR81OTee+K7kQwsFd56kDji5zu0K4J4Y8yOKcmlBc053IDYjencYrNY+nKCI6Xn7iVOH0b
 jTMzmI50rsWTKYV8oTufzHqh5w8MlIun8E87uCwyzchnb5rnLUkdK1PocaPLjmZqrXWyP7
 3DBs53KKn0kEYOLx+6fC4yhrdMPnJ1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-V4pMczBNPd6Bz0f82h-JJw-1; Mon, 21 Oct 2019 13:16:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F4135107AD31;
 Mon, 21 Oct 2019 17:15:58 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8D6A60856;
 Mon, 21 Oct 2019 17:15:35 +0000 (UTC)
Date: Mon, 21 Oct 2019 14:15:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386/kvm: add NoNonArchitecturalCoreSharing Hyper-V
 enlightenment
Message-ID: <20191021171533.GT4084@habkost.net>
References: <20191018163908.10246-1-vkuznets@redhat.com>
 <4d89f852-85bc-8370-5929-848d24b80a6f@redhat.com>
 <878spe197z.fsf@vitty.brq.redhat.com>
 <66f1dd30-3e45-4dc6-ba0a-d52e5aae6501@redhat.com>
MIME-Version: 1.0
In-Reply-To: <66f1dd30-3e45-4dc6-ba0a-d52e5aae6501@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: V4pMczBNPd6Bz0f82h-JJw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 06:26:14PM +0200, Paolo Bonzini wrote:
> On 21/10/19 16:09, Vitaly Kuznetsov wrote:
> >>> +    if (cpu->hyperv_no_nonarch_cs =3D=3D ON_OFF_AUTO_ON) {
> >>> +        env->features[FEAT_HV_RECOMM_EAX] |=3D HV_NO_NONARCH_CORESHA=
RING;
> >>> +    } else if (cpu->hyperv_no_nonarch_cs =3D=3D ON_OFF_AUTO_AUTO) {
> >> Do you want to make auto the default if "-cpu host,migratable=3Doff"? =
 It
> >> can be done on top so I started queueing this patch.
> > Hm, one thing is that CPUID 0x40000004 doesn't exist if no Hyper-V
> > enlightenments are passed so we'll probably have to modify your idea to
> > "-cpu host,migratable=3Doff,+any-hyperv-enlightenment" but then the
> > question is how conservative are we, like if QEMU command line doesn't
> > change can new CPUID flags appear or not? And we'll probably need a way
> > to explicitly disable HV_NO_NONARCH_CORESHARING if needed.
>=20
> I would defer to Eduardo on whether "migratable=3Doff" would allow adding
> new CPUID flags.  The follow-up question however is whether we would
> benefit from a "+hyperv" option that enables all known Hyper-V
> enlightenment for a given machine type.

I'm not sure what "adding new CPUID flags" means exactly, but on
both cases, the answer is yes:

If you mean having new flags appear with the same QEMU command
line, this is 100% OK with "-cpu host".  Doubly so with
"migratable=3Doff".  "-cpu host" doesn't guarantee a stable guest
ABI, and migratable=3Doff doesn't guarantee the ability to live
migrate.

If you just mean the ability to write "-cpu
host,migratable=3Doff,+some-extra-flag", that's OK too.

I would try to make "-cpu host,migratable=3Doff" enable all
features out of the box (because users probably expect that).
But we you have a compelling reason to not enable the hyperv
flags by default (do we?), it's OK to require something like
"-cpu host,...,+hyperv".

--=20
Eduardo


