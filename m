Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB836C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC122084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 15:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC122084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hctEq-0008LZ-TO
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 11:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49362)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hcsrL-000585-7N
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hcsrK-0006Wg-6q
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:43:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48618)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hcsrK-0006WJ-1X
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:43:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A0723082141;
 Mon, 17 Jun 2019 14:43:40 +0000 (UTC)
Received: from localhost (ovpn-116-100.phx2.redhat.com [10.3.116.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D17991F2E;
 Mon, 17 Jun 2019 14:43:32 +0000 (UTC)
Date: Mon, 17 Jun 2019 11:43:31 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190617144331.GB19178@habkost.net>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
 <56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
 <20180202182326.GB22556@localhost.localdomain>
 <20180205122235.03fdeaad@redhat.com>
 <20180205135401.GA3300@localhost.localdomain>
 <20180205154202.7d1269a9@redhat.com>
 <20180205224205.GA3291@localhost.localdomain>
 <20180206154320.288acdc2@redhat.com>
 <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <62d7649e-e85d-43a2-2df8-85e2a0953e89@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 17 Jun 2019 14:43:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
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
Cc: marcel@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, alistair23@gmail.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 07:09:59AM +0200, Philippe Mathieu-Daud=E9 wrote:
[...]
>=20
> We get cpu names with suffix:
>=20
>   $ arm-softmmu/qemu-system-arm -M netduino2 -cpu arm926
>   qemu-system-arm: Invalid CPU type: arm926-arm-cpu
>   The valid types are: cortex-m3-arm-cpu, cortex-m4-arm-cpu
>=20
> I understand you won't want a global cpu_name_by_type_name, how do you
> want to do then?

I would like having a global cpu_name_by_type_name() function.
I wouldn't want to force each architecture to provide yet another
string conversion/parsing function, though.

>=20
> Should we define an automatically expanded TARGET_CPU_TYPE_SUFFIX?
> Then we could have generic machine code to parse the names.

I think we could do that, but with a CPUClass field instead of a
preprocessor macro.

For a reference on existing corner cases of CPU model name
parsing that might get in the way, see this series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg611813.html

If you are interested, I have work in progress for a generic CPU
model listing function at:
https://github.com/ehabkost/qemu-hacks/commits/work/cpu-generic-list
https://github.com/ehabkost/qemu-hacks/commit/df122e7e47476d7e2b7b809a4b4=
120537f50c137

--=20
Eduardo

