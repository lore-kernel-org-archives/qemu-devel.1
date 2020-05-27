Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C32C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D48742071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvUjFlpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D48742071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdpKj-00009m-3O
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdpKA-00086q-Vz
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:13:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41610
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jdpK9-000312-MC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 02:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590560036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUMha3O/QnMlYwxJpD0CVZk4J5RAOV467jhHCNZiIBE=;
 b=YvUjFlpg4cSQgy9HqsGdbRukOlJ8X4McHT9LVnIg9oiYoJmjDDLXJ5WaO+cCYeqhNw3V8a
 j6YbZsbFtOe1ymdUllKoHYWdvyq+vGRnnHWLoqVihYdGdPJkL3LgA8MJIg7uXxC2NDRif7
 kF7Mt4IK+V58u2BA5RA4hGzjt2Sxr0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-eNP6ElIXOkWKSHWF3mEXlg-1; Wed, 27 May 2020 02:13:55 -0400
X-MC-Unique: eNP6ElIXOkWKSHWF3mEXlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33844BFC1;
 Wed, 27 May 2020 06:13:53 +0000 (UTC)
Received: from gondolin (ovpn-112-223.ams2.redhat.com [10.36.112.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C89210013D7;
 Wed, 27 May 2020 06:13:48 +0000 (UTC)
Date: Wed, 27 May 2020 08:13:45 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h"
 (reserved to system-mode)
Message-ID: <20200527081345.0d71d3e5.cohuck@redhat.com>
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
References: <20200526172427.17460-1-f4bug@amsat.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: David Hildenbrand <david@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 May 2020 19:24:20 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
> system-mode emulation only.
> This series is a preparatory cleanup to allow later poisoning
> it in user-mode code.
>=20
> Missing review: patche 7
> - target/s390x: Restrict system-mode declarations
>=20
> Maybe PPC/S390X maintainers can take their patches and let
> the rest to Paolo, or he can take all the series. They are
> not dependents.

I can take the s390x patches (want to send a pull req soon anyway), but
I'm also fine with them going via Paolo, if that is more convenient.

Paolo: Just let me know if you plan to queue them, otherwise I'll go
ahead.

>=20
> Since v1:
> - Do not poison hwaddr type
> - Addressed Cornelia & David review comments
> - Added R-b/A-b
>=20
> $ git backport-diff -u v1
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/7:[----] [--] 'sysemu/accel: Restrict machine methods to system-mode'
> 002/7:[----] [--] 'sysemu/tcg: Only declare tcg_allowed when TCG is avail=
able'
> 003/7:[----] [--] 'sysemu/hvf: Only declare hvf_allowed when HVF is avail=
able'
> 004/7:[----] [--] 'target/ppc: Restrict PPCVirtualHypervisorClass to syst=
em-mode'
> 005/7:[----] [--] 'target/s390x: Only compile decode_basedisp() on system=
-mode'
> 006/7:[0002] [FC] 'target/s390x/helper: Clean ifdef'ry'
> 007/7:[0005] [FC] 'target/s390x: Restrict system-mode declarations'
>=20
> Supersedes: <20200509130910.26335-1-f4bug@amsat.org>
>=20
> Philippe Mathieu-Daud=C3=A9 (7):
>   sysemu/accel: Restrict machine methods to system-mode
>   sysemu/tcg: Only declare tcg_allowed when TCG is available
>   sysemu/hvf: Only declare hvf_allowed when HVF is available
>   target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
>   target/s390x: Only compile decode_basedisp() on system-mode
>   target/s390x/helper: Clean ifdef'ry
>   target/s390x: Restrict system-mode declarations
>=20
>  include/sysemu/accel.h          |  2 ++
>  include/sysemu/hvf.h            |  6 +++---
>  include/sysemu/tcg.h            |  2 +-
>  target/ppc/cpu.h                |  4 ++--
>  target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
>  target/s390x/internal.h         | 16 +++++++++++-----
>  target/ppc/translate_init.inc.c |  4 ++++
>  target/s390x/helper.c           |  5 -----
>  8 files changed, 34 insertions(+), 27 deletions(-)
>=20


