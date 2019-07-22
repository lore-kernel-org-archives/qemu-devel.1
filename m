Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B1C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024B42190D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 14:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024B42190D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpZY3-0000MD-8I
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 10:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hpZXs-0008NP-Hb
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hpZXr-0000Vs-FL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:44:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hpZXr-0000VO-AH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 10:44:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 999784627A;
 Mon, 22 Jul 2019 14:44:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-244.ams2.redhat.com
 [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BA3E5C221;
 Mon, 22 Jul 2019 14:43:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 09A8D113865F; Mon, 22 Jul 2019 16:43:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <87y30t43cp.fsf@dusky.pond.sub.org>
 <316ea157-4c44-5d75-e4f4-7977d2e13345@redhat.com>
Date: Mon, 22 Jul 2019 16:43:57 +0200
In-Reply-To: <316ea157-4c44-5d75-e4f4-7977d2e13345@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sat, 20 Jul 2019 11:42:07
 +0200")
Message-ID: <87d0i2yvrm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 22 Jul 2019 14:44:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Use of TARGET_FMT_plx in hw/tpm/trace-events
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/20/19 8:39 AM, Markus Armbruster wrote:
>> Consider hw/tpm/trace-events
>>=20
>>     # tpm_crb.c
>>     tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB r=
ead 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
>>     tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB =
write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
>>=20
>> Format is TARGET_FMT_plx formats a hwaddr, but the parameter type is
>> uint64_t.  They happen to be the same.  Is this kosher?
>>=20
>
> Missed when converting from DPRINTF() to trace-events:
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3Dec427498;hp=3D8cb34=
0c613
>
> PRIx64 certainly makes sense here.
>
> Since it is the single use, once updated we can remote this hunk from
> scripts/tracetool/format/log_stap.py:
>
>     if macro =3D=3D "TARGET_FMT_plx":
>         return "%016x"

Good point, thanks!

[...]

