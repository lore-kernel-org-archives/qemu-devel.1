Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC344C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AF82070B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 08:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AF82070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYo9Z-00041j-IK
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 04:53:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYnyu-00047y-PJ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hYnyt-0003pq-Le
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hYnyt-0003Q9-Du
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 04:42:43 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FA1E811DC;
	Thu,  6 Jun 2019 08:42:26 +0000 (UTC)
Received: from work-vm (ovpn-116-119.ams2.redhat.com [10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B1ED18640;
	Thu,  6 Jun 2019 08:42:25 +0000 (UTC)
Date: Thu, 6 Jun 2019 09:42:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190606084222.GA2788@work-vm>
References: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38B8F53B-F993-45C3-9A82-796A0D4A55EC@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 06 Jun 2019 08:42:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU/KVM migration backwards compatibility broken?
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	kvm list <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
> Hi,
>=20
> Looking at QEMU source code, I am puzzled regarding how migration backw=
ards compatibility is preserved regarding X86CPU.
>=20
> As I understand it, fields that are based on KVM capabilities and guest=
 runtime usage are defined in VMState subsections in order to not send th=
em if not necessary.
> This is done such that in case they are not needed and we migrate to an=
 old QEMU which don=E2=80=99t support loading this state, migration will =
still succeed
> (As .needed() method will return false and therefore this state won=E2=80=
=99t be sent as part of migration stream).
> Furthermore, in case .needed() returns true and old QEMU don=E2=80=99t =
support loading this state, migration fails. As it should because we are =
aware that guest state
> is not going to be restored properly on destination.
>=20
> I=E2=80=99m puzzled about what will happen in the following scenario:
> 1) Source is running new QEMU with new KVM that supports save of some V=
MState subsection.
> 2) Destination is running new QEMU that supports load this state but wi=
th old kernel that doesn=E2=80=99t know how to load this state.
>=20
> I would have expected in this case that if source .needed() returns tru=
e, then migration will fail because of lack of support in destination ker=
nel.
> However, it seems from current QEMU code that this will actually succee=
d in many cases.
>=20
> For example, if msr_smi_count is sent as part of migration stream (See =
vmstate_msr_smi_count) and destination have has_msr_smi_count=3D=3Dfalse,
> then destination will succeed loading migration stream but kvm_put_msrs=
() will actually ignore env->msr_smi_count and will successfully load gue=
st state.
> Therefore, migration will succeed even though it should have failed=E2=80=
=A6
>=20
> It seems to me that QEMU should have for every such VMState subsection,=
 a .post_load() method that verifies that relevant capability is supporte=
d by kernel
> and otherwise fail migration.
>=20
> What do you think? Should I really create a patch to modify all these C=
PUX86 VMState subsections to behave like this?

I don't know the x86 specific side that much; but from my migration side
the answer should mostly be through machine types - indeed for smi-count
there's a property 'x-migrate-smi-count' which is off for machine types
pre 2.11 (see hw/i386/pc.c pc_compat_2_11) - so if you've got an old
kernel you should stick to the old machine types.

There's nothing guarding running the new machine type on old-kernels;
and arguably we should have a check at startup that complains if
your kernel is missing something the machine type uses.
However, that would mean that people running with -M pc   would fail
on old kernels.

A post-load is also a valid check; but one question is whether,
for a particular register, the pain is worth it - it depends on the
symptom that the missing state causes.  If it's minor then you might
conclude it's not worth a failed migration;  if it's a hung or
corrupt guest then yes it is.   Certainly a warning printed is worth
it.

Dave

> Thanks,
> -Liran
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

