Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF32C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B2C222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B2C222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDaDP-0003NO-Pu
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 16:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iDaCj-0002vY-W8
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iDaCh-0001c9-AD
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:17:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37760)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iDaCg-0001YE-6m
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:17:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3B6818CB8FF;
 Thu, 26 Sep 2019 20:17:27 +0000 (UTC)
Received: from localhost (ovpn-116-45.gru2.redhat.com [10.97.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B4E95D9C3;
 Thu, 26 Sep 2019 20:17:24 +0000 (UTC)
Date: Thu, 26 Sep 2019 17:17:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v5 0/2] target/i386: cpu.h macros clean up
Message-ID: <20190926201722.GS8144@habkost.net>
References: <20190926021055.6970-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190926021055.6970-1-tao3.xu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 26 Sep 2019 20:17:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: pbonzini@redhat.com, rth@twiddle.net, philmd@redhat.com,
 qemu-devel@nongnu.org, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:10:53AM +0800, Tao Xu wrote:
> Add some comments, clean up comments over 80 chars per line. There
> is an extra line in comment of CPUID_8000_0008_EBX_WBNOINVD, remove
> the extra enter and spaces.
>=20
> Drop the duplicated definition of cpuid AVX512_VBMI macro and rename it
> as CPUID_7_0_ECX_AVX512_VBMI. Rename CPUID_7_0_ECX_VBMI2
> as CPUID_7_0_ECX_AVX512_VBMI2.
>=20

Queued, thanks!

> Changelog:
> v5:
>     - correct commit messages. (Suggested by Stefano Garzarella)
> v4:
>     - rename CPUID_7_0_ECX_VBMI2 as CPUID_7_0_ECX_AVX512_VBMI2.
>       (Suggested by Stefano Garzarella)
> v3:
>     - split the patch into 2 patches. (Suggested by Stefano Garzarella
>       and Eduardo Habkost)
> v2:
>     - correct the comments over 80 chars per line. (Suggested by
>       Philippe Mathieu-Daud=E9)
>=20
> Tao Xu (2):
>   target/i386: clean up comments over 80 chars per line
>   target/i386: drop the duplicated definition of cpuid AVX512_VBMI macr=
o
>=20
>  target/i386/cpu.c           |   8 +-
>  target/i386/cpu.h           | 163 +++++++++++++++++++++++-------------
>  target/i386/hvf/x86_cpuid.c |   2 +-
>  3 files changed, 111 insertions(+), 62 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--=20
Eduardo

