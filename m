Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36BBC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47A6217BA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 20:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKoTqw6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47A6217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2L4l-0004C1-Q0
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 15:27:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j2L2Z-00025I-B9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j2L2X-0005qY-7B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28813
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j2L2X-0005pA-2O
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 15:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581625488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JfrV3R3U6fsvWIf//S18w/1Nd77SECfsn7uVUow0Og=;
 b=AKoTqw6VGYBut+bB14CU1NyM+oEwM3epRgajAy8pntzBq7q4NkALcrpW32tWo/qgEERzRz
 Fm/6+ur/Egm8SggDHK7S0qK3iQCyMr4ZEj+laapHlOYc+elztsMfnYMjKdBb/OMalsFG7D
 HWv+bcqvZVTmMjx/6rRR+zmTOv9OKeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-OGN49DWgN0e4dI115XCYIQ-1; Thu, 13 Feb 2020 15:24:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C33431857343;
 Thu, 13 Feb 2020 20:24:38 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-24.gru2.redhat.com
 [10.97.116.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5B775C1BB;
 Thu, 13 Feb 2020 20:24:30 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance/ppc_prep_40p: Use cdn.netbsd.org hostname
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200211134504.9156-1-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <ceea0b44-6925-72c7-e593-1111da4541bf@redhat.com>
Date: Thu, 13 Feb 2020 18:24:29 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200211134504.9156-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: OGN49DWgN0e4dI115XCYIQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: qemu-ppc@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2/11/20 11:45 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Use NetBSD content delivery network to get faster downloads.
>
> Suggested-by: Kamil Rytarowski <kamil@netbsd.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/ppc_prep_40p.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)


LGTM.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep=
_40p.py
> index efe06037ba..6729d96f5e 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -34,7 +34,7 @@ def test_factory_firmware_and_netbsd(self):
>                       '7020-40p/P12H0456.IMG')
>           bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>           bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash=
)
> -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/NetBSD-archive=
/'
> +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/NetBSD-archive=
/'
>                        'NetBSD-4.0/prep/installation/floppy/generic_com0.=
fs')
>           drive_hash =3D 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
>           drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_h=
ash)
> @@ -67,7 +67,7 @@ def test_openbios_and_netbsd(self):
>           :avocado: tags=3Darch:ppc
>           :avocado: tags=3Dmachine:40p
>           """
> -        drive_url =3D ('https://ftp.netbsd.org/pub/NetBSD/iso/7.1.2/'
> +        drive_url =3D ('https://cdn.netbsd.org/pub/NetBSD/iso/7.1.2/'
>                        'NetBSD-7.1.2-prep.iso')
>           drive_hash =3D 'ac6fa2707d888b36d6fa64de6e7fe48e'
>           drive_path =3D self.fetch_asset(drive_url, asset_hash=3Ddrive_h=
ash,


