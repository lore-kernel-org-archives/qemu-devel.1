Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8891C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BDD206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 13:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yt8cIvzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BDD206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLSHX-00015t-QL
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 09:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1jLSDd-0005oz-3i
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1jLSDb-00035a-D4
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:55:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58663
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1jLSDb-00034w-6I
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 09:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586181314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toarXByCKt2mim18PYUHUF9o0fDDqbxkNKZGSw6amXE=;
 b=Yt8cIvzjY2fFzKG4H5uyHIaL6AOhWdIVfwn01WPclc09BMaZx6TeF0XJx7oFxzkenqd4Zp
 b3Bzb7Xw3fcVb7yv/kfRtzkWCLGY/gycr47Zj/qD3mLP/ovlmQ8IxcjhCLTmmHuAhx/A8w
 jkUjsac/5U+QiRwpq+LLI+4Oon+spWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-Oq0HlvXZPrmzR7rOazaSYg-1; Mon, 06 Apr 2020 09:55:10 -0400
X-MC-Unique: Oq0HlvXZPrmzR7rOazaSYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EF74107B7E8;
 Mon,  6 Apr 2020 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com
 [10.97.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C2EC19C4F;
 Mon,  6 Apr 2020 13:54:57 +0000 (UTC)
Subject: Re: [PATCH-for-5.0 3/8] tests/acceptance/ppc_prep_40p: Use mirror for
 ftp.software.ibm.com
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-4-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <8c5017c2-d242-8437-60e3-3e28e2116d42@redhat.com>
Date: Mon, 6 Apr 2020 10:54:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200403172919.24621-4-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 4/3/20 2:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> To avoid regular failures on Travis-CI with ftp.software.ibm.com,
> use a mirror.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/ppc_prep_40p.py | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/ppc_prep_40p.py b/tests/acceptance/ppc_prep=
_40p.py
> index 138064285a..1515561249 100644
> --- a/tests/acceptance/ppc_prep_40p.py
> +++ b/tests/acceptance/ppc_prep_40p.py
> @@ -30,7 +30,8 @@ def test_factory_firmware_and_netbsd(self):
>           :avocado: tags=3Dmachine:40p
>           :avocado: tags=3Dslowness:high
>           """
> -        bios_url =3D ('ftp://ftp.boulder.ibm.com/rs6000/firmware/'
> +        bios_url =3D ('http://ftpmirror.your.org/pub/misc/'
> +                    'ftp.software.ibm.com/rs6000/firmware/'
>                       '7020-40p/P12H0456.IMG')

I checked the bios file can be downloaded from the mirror. I cannot=20
judge the mirror is more reliable than ftp.boulder.ibm.com or not, though.

Code-wise, looks good. So:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>           bios_hash =3D '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
>           bios_path =3D self.fetch_asset(bios_url, asset_hash=3Dbios_hash=
)


