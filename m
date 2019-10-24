Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B38CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:14:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A51F21928
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T1lU+QsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A51F21928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNkR2-00054T-Fr
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 17:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iNkPT-0003yC-4h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 17:12:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iNkPP-0001DL-IF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 17:12:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45160
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iNkPP-0001D6-5d
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 17:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571951558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnapdk8TPg6adCbVHt9h2NKWAnkELyyA2ePsc+y5olA=;
 b=T1lU+QsNidKxDzcyFQKzButZG3LxsCFhPa865sSu8W3LBKh3DgZLSC0Tz5QFtoivTH6E9M
 kupQD8JoVbwmAY4La+7zryNGZQDWS1WX5yyyJqAtbPngK7vmOeCqD4oy/LnMW11k1g5f28
 uSjYgPdY+/1PdlSH47dozIbrse6V68A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-46oig6P_OlWjkKEiAVObcQ-1; Thu, 24 Oct 2019 17:12:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F183D800D4C;
 Thu, 24 Oct 2019 21:12:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-152.rdu2.redhat.com
 [10.10.122.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA2265C1D4;
 Thu, 24 Oct 2019 21:12:26 +0000 (UTC)
Subject: Re: [PATCH 2/3] Acceptance tests: introduce utility method for tags
 unique vals
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190924194501.9303-1-crosa@redhat.com>
 <20190924194501.9303-3-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <53219208-0345-cba4-0482-aea085bca6c0@redhat.com>
Date: Thu, 24 Oct 2019 18:12:25 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190924194501.9303-3-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 46oig6P_OlWjkKEiAVObcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cleber,

On 9/24/19 4:45 PM, Cleber Rosa wrote:
> Currently a test can describe the target architecture binary that it
> should primarily be run with, be setting a single tag value.
>
> The same approach is expected to be done with other QEMU aspects to be
> tested, for instance, the machine type and accelerator, so let's
> generalize the logic into a utility method.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index bd41e0443c..02775bafcf 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -54,14 +54,21 @@ def pick_default_qemu_bin(arch=3DNone):
>  =20
>  =20
>   class Test(avocado.Test):
> +    def _get_unique_tag_val(self, tag_name):
> +        """
> +        Gets a tag value, if unique for a key
> +        """
> +        vals =3D self.tags.get(tag_name, [])
> +        if len(vals) =3D=3D 1:


An small optimization:

if vals:

 =C2=A0 return vals.pop()


> +            return vals.pop()
> +        return None

Does it allows to express a scenario like "I want my test method to run=20
on x86_64 and aarch64" using tags? If so, _get_unique_tag_val logic=20
returns None for multi-value tags (e.g. 'tags=3Darch:x86_64,arch:aarch64').

Thanks,

Wainer

> +
>       def setUp(self):
>           self._vms =3D {}
> -        arches =3D self.tags.get('arch', [])
> -        if len(arches) =3D=3D 1:
> -            arch =3D arches.pop()
> -        else:
> -            arch =3D None
> -        self.arch =3D self.params.get('arch', default=3Darch)
> +
> +        self.arch =3D self.params.get('arch',
> +                                    default=3Dself._get_unique_tag_val('=
arch'))
> +
>           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>           self.qemu_bin =3D self.params.get('qemu_bin',
>                                           default=3Ddefault_qemu_bin)


