Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A012C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632DD2087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AL+o2Ugk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632DD2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioqcu-00059z-Qp
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42796)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ioq4E-00037W-Fu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ioq4D-0005qe-F2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:42:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ioq4D-0005pz-2G
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 09:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578408163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EcvpDXbfrED4TDgzoIKLdqr3hhn5oG2PdRsSW2xo5CE=;
 b=AL+o2Ugkqn+s2jjIrHrmNtankbKVJ9FFsxwovf9dNx1Vx1SJ6ePKxYW9o5hnan4rLFBq86
 UAac/2WMmyQN482AK6CvMgCkOmhjSt8emGgSlZG4ICHkWytkqVONyKaHECdGCCY4UgLYef
 qHBf+/WQH2XlhfLZ6Z1Q32faOeQ7Y64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-LNBmD_6kNg6uEb-JvgXr0g-1; Tue, 07 Jan 2020 09:42:42 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 630011097F89;
 Tue,  7 Jan 2020 14:42:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C98F272A1;
 Tue,  7 Jan 2020 14:42:31 +0000 (UTC)
Subject: Re: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests
 to recent desugarized -accel option)
To: Paolo Bonzini <pbonzini@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
 <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
 <12334054-4ae7-e580-9727-2d322bfa2bda@redhat.com>
 <1A5859EA-4403-4921-B527-DFD07C59C702@redhat.com>
 <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <82a310b7-9b99-163a-e0d3-967bb09e70f7@redhat.com>
Date: Tue, 7 Jan 2020 15:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <360fa010-ba80-b02b-3a35-19c2b48a462d@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LNBmD_6kNg6uEb-JvgXr0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 15.37, Paolo Bonzini wrote:
> On 07/01/20 14:55, Christophe de Dinechin wrote:
>> So what about ranking the accelerators, so that all combinaisons
>> -accel=3Dkvm:tcg, -accel=3Dtcg:kvm, -accel kvm -accel tcg, etc would
>=20
> (I assume you mean "-machine accel=3Dkvm:tcg" and "-machine accel=3Dtcg:k=
vm"
> for the first two.  This is the "older" way which has now become sugar
> for "-accel kvm -accel tcg").
>=20
>> all pickup kvm if available, and tcg as a fallback? Implementation-wise,
>> it would simply mean ranking the accelerators and updating the accelerat=
or
>> only if it=E2=80=99s available and better.
>=20
> This is an interesting idea.  I like this better than "-accel best",
> because "-accel best" has the problem that you can't add suboptions to
> it (the suboptions for the various accelerators are disjoint).
>=20
> It would break backwards compatibility for "-machine accel=3Dtcg:kvm",
> which so far meant "use TCG if compiled in, otherwise use KVM".  This is
> not something I would have a problem with... except that "tcg:kvm" is
> the default if no -accel option is provided!

Note that we need "-M accel=3Dtcg:kvm" (or "-accel tcg -accel kvm" now) in
tests/boot-serial-test.c for example, since some machines can't use KVM
on certain hosts (e.g. with KVM-HV on POWER8/9).

 Thomas


