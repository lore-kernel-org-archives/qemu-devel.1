Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EF0C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927D0218BE
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927D0218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVR1-0000eE-Oh
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59898)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpVQr-0000C1-5t
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@siemens.com>) id 1hpVQq-0007ak-6l
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:20:37 -0400
Received: from david.siemens.de ([192.35.17.14]:36741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jan.kiszka@siemens.com>)
 id 1hpVQp-0007X9-Tl
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:20:36 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
 by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x6MAKWfj025695
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2019 12:20:32 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may
 be forged))
 by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x6MAKWxG023857;
 Mon, 22 Jul 2019 12:20:32 +0200
To: Liran Alon <liran.alon@oracle.com>
References: <bdd53f40-4e60-f3ae-7ec6-162198214953@siemens.com>
 <A9036EC6-848A-4D42-95AF-42E2302EEC0B@oracle.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0972ccd9-386d-b618-f055-e8ae0181b64e@siemens.com>
Date: Mon, 22 Jul 2019 12:20:31 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <A9036EC6-848A-4D42-95AF-42E2302EEC0B@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by david.siemens.de id
 x6MAKWfj025695
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 192.35.17.14
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

On 22.07.19 11:44, Liran Alon wrote:
>=20
>=20
>> On 22 Jul 2019, at 7:00, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> Writing the nested state e.g. after a vmport access can invalidate
>> important parts of the kernel-internal state, and it is not needed as
>> well. So leave this out from KVM_PUT_RUNTIME_STATE.
>>
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> As QEMU never modifies vCPU nested-state in userspace besides in vmload=
 and vCPU creation,
> shouldn=E2=80=99t this be under KVM_PUT_FULL_STATE? Same as the call to=
 kvm_arch_set_tsc_khz().

Reset is a relevant modification as well. If we do not write back a state=
 that
is disabling virtualization, we break.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

