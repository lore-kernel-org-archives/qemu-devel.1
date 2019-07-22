Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0880C76194
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA97214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA97214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVmn-0005YW-Rh
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37683)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpVmd-0005AF-Bw
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpVmc-0006FG-Dj
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:43:07 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:33097)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hpVmc-00069p-5B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:43:06 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x6MAh20x011043
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2019 12:43:02 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may
 be forged))
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x6MAh2mZ010639;
 Mon, 22 Jul 2019 12:43:02 +0200
To: Liran Alon <liran.alon@oracle.com>
References: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
 <A9036EC6-848A-4D42-95AF-42E2302EEC0B@oracle.com>
 <0972ccd9-386d-b618-f055-e8ae0181b64e@siemens.com>
 <AD612128-FB18-4E98-954D-BCF77954666B@oracle.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a0689914-e043-1ba7-dc50-15c7ad2b9cea@siemens.com>
Date: Mon, 22 Jul 2019 12:43:01 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <AD612128-FB18-4E98-954D-BCF77954666B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by lizzard.sbs.de id
 x6MAh20x011043
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.138.37.39
Subject: Re: [Qemu-devel] [PATCH] i386/kvm: Do not sync nested state during
 runtime
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.07.19 12:31, Liran Alon wrote:
>> On 22 Jul 2019, at 13:20, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 22.07.19 11:44, Liran Alon wrote:
>>>
>>>
>>>> On 22 Jul 2019, at 7:00, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>>>
>>>> Writing the nested state e.g. after a vmport access can invalidate
>>>> important parts of the kernel-internal state, and it is not needed a=
s
>>>> well. So leave this out from KVM_PUT_RUNTIME_STATE.
>>>>
>>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> As QEMU never modifies vCPU nested-state in userspace besides in vmlo=
ad and vCPU creation,
>>> shouldn=E2=80=99t this be under KVM_PUT_FULL_STATE? Same as the call =
to kvm_arch_set_tsc_khz().
>>
>> Reset is a relevant modification as well. If we do not write back a st=
ate that
>> is disabling virtualization, we break.
>>
>> Jan
>=20
> Currently QEMU writes to userspace maintained nested-state only at kvm_=
arch_init_vcpu() and
> when loading vmstate_nested_state vmstate subsection.
> kvm_arch_reset_vcpu() do not modify userspace maintained nested-state.

Hmm, then we probably achieve that effect by clearing the related bit in =
CR4. If
doing that implies an invalidation of the nested state by KVM, we are fin=
e.
Otherwise, I would expect userspace to reset the state to VMCLEAR and pur=
ge any
traces of prior use.

>=20
> I would expect KVM internal nested-state to be reset as part of KVM=E2=80=
=99s vmx_vcpu_reset().

vmx_vcpu_reset is not issued on userspace initiated VM reset, only on INI=
T/SIPI
cycles. It's misleading, and I remember myself running into that when I h=
acked
on KVM back then.

Jan

> Are we missing a call to vmx_leave_nested() there?=20
>=20
> -Liran
>=20

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

