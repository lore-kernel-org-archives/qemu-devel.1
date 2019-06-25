Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAABC48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D942085A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 18:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D942085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34658 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfqPH-0007ft-HM
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 14:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53189)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hfqOL-0007EC-70
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hfqOK-0000Kq-6T
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:42:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hfqOG-0000BL-Ib
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 14:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 978E23082134;
 Tue, 25 Jun 2019 18:41:57 +0000 (UTC)
Received: from localhost (ovpn-116-101.gru2.redhat.com [10.97.116.101])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5ED5D9C5;
 Tue, 25 Jun 2019 18:41:54 +0000 (UTC)
Date: Tue, 25 Jun 2019 15:41:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190625184153.GA4166@habkost.net>
References: <20190624123835.28869-1-alex.bennee@linaro.org>
 <c191c41f-a9a5-48de-2700-ed2065a9ee24@redhat.com>
 <f2e9a94e-eac6-597b-31db-feef014355ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f2e9a94e-eac6-597b-31db-feef014355ea@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 25 Jun 2019 18:41:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix feature check in
 hyperv-stub.c
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 03:37:24PM +0200, Paolo Bonzini wrote:
> On 24/06/19 15:22, Paolo Bonzini wrote:
> > On 24/06/19 14:38, Alex Benn=E9e wrote:
> >> Commit 2d384d7c8 broken the build when built with:
> >>
> >>   configure --without-default-devices --disable-user
> >>
> >> The reason was the conversion of cpu->hyperv_synic to
> >> cpu->hyperv_synic_kvm_only although the rest of the patch introduces=
 a
> >> feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC =
in
> >> hyperv-stub to do the same feature check as in the real hyperv.c
> >>
> >> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> >> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> Cc: Roman Kagan <rkagan@virtuozzo.com>
> >> ---
> >>  target/i386/hyperv-stub.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
> >> index fe548cbae2..0028527e79 100644
> >> --- a/target/i386/hyperv-stub.c
> >> +++ b/target/i386/hyperv-stub.c
> >> @@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyp=
erv_exit *exit)
> >>  {
> >>      switch (exit->type) {
> >>      case KVM_EXIT_HYPERV_SYNIC:
> >> -        if (!cpu->hyperv_synic) {
> >> +        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
> >>              return -1;
> >>          }
> >> =20
> >>
> >=20
> > Queued, thanks.
>=20
> Alex will queue it instead, so
>=20
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I was planning to send a machine + x86 pull request today, and
I'll have to include to make sure builds won't fail.  I don't
think this should prevent the patch from being applied to other
trees, though.

--=20
Eduardo

