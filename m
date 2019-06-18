Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A3C31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDC42054F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 16:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDC42054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdH1A-0000kp-AE
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 12:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37100)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdGLT-0003YO-HG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdGLR-0001lD-Ns
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdGLR-0001cv-FM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 11:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3AC04309703F;
 Tue, 18 Jun 2019 15:48:22 +0000 (UTC)
Received: from work-vm (ovpn-117-76.ams2.redhat.com [10.36.117.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A8307D925;
 Tue, 18 Jun 2019 15:48:20 +0000 (UTC)
Date: Tue, 18 Jun 2019 16:48:17 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190618154817.GI2850@work-vm>
References: <20190617175658.135869-1-liran.alon@oracle.com>
 <20190617175658.135869-8-liran.alon@oracle.com>
 <20190618090316.GC2850@work-vm>
 <32C4B530-A135-475B-B6AF-9288D372920D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <32C4B530-A135-475B-B6AF-9288D372920D@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 18 Jun 2019 15:48:22 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU PATCH v3 7/9] KVM: i386: Add support for
 save and restore nested state
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
>=20
> > On 18 Jun 2019, at 12:03, Dr. David Alan Gilbert <dgilbert@redhat.com=
> wrote:
> >=20
> > * Liran Alon (liran.alon@oracle.com) wrote:
> >>=20
> >> +static const VMStateDescription vmstate_vmx_vmcs12 =3D {
> >> +	.name =3D "cpu/kvm_nested_state/vmx/vmcs12",
> >> +	.version_id =3D 1,
> >> +	.minimum_version_id =3D 1,
> >> +	.needed =3D vmx_vmcs12_needed,
> >> +	.fields =3D (VMStateField[]) {
> >> +	    VMSTATE_UINT8_ARRAY(data.vmx[0].vmcs12,
> >> +	                        struct kvm_nested_state, 0x1000),
> >=20
> > Where did that magic 0x1000 come from?
>=20
> Currently, KVM folks (including myself), haven=E2=80=99t decided yet to=
 expose vmcs12 struct layout to userspace but instead to still leave it o=
paque.
> The formal size of this size is VMCS12_SIZE (defined in kernel as 0x100=
0). I was wondering if we wish to expose VMCS12_SIZE constant to userspac=
e or not.
> So currently I defined these __u8 arrays as 0x1000. But in case Paolo a=
grees to expose VMCS12_SIZE, we can use that instead.

Well if it's not defined it's bound to change at some state!
Also, do we need to clear it before we get it from the kernel - e.g.
is the kernel guaranteed to give us 0x1000 ?

Dave

> -Liran
>=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

