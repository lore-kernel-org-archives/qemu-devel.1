Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C422C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:16:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FBEE20865
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBEE20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT485-0005ie-9G
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:16:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT46S-0004YT-D8
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT46Q-0004Xd-9Z
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT46Q-0004Uy-0X
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:15:02 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 20BB7C0568FD
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 13:15:01 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id e3so3131436wrs.17
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 05:15:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RfGG6nxRw4Fehbqx4neSoGAyKdBzJJ31hjvaYDntmB4=;
 b=G2ExcadBkqLWvoE3djuMfOTqKlBbLTh7izQVuGCP+BBb/epe858YWoJpvl2Ep57td1
 vIyeumLxHMXlwMvF6zCT7wMQkV/KD2chMsPc/8L8XUsaiFlKcTB1f6sgNbNlz3EFA7xD
 iYIqCjQNxVldjr9Uv6/rk5mszRLmEsAk8VzuwQbv2TUkqDRFhyWAQw1Nao0HANg3gALW
 ppgx1rEpNzdX3jlEwnTYHvAur37GPItZDsWUIPtrlTmf8K04QogpMHeB4FF5iDUSlXWz
 Oorg134fxRRkfMqoYqUX4Y/4yf9Q3ayojoGtd4UMroorR4aTNjHZDNpZfJEFWg4mx3Id
 bOEA==
X-Gm-Message-State: APjAAAVzlj6JIZX8O1d/jx128/bLqy5c/uGggNvuxQ6PZWieCh3EZVnI
 JNYOhxRpRpu4QMWiNMyjH9ypHdTpHJ4mrGOliHadhnT4c3WcsGj6+P5rOC7H1jgwqmh4+3oW09e
 /dL5LhXYfaTqmXL4=
X-Received: by 2002:adf:f651:: with SMTP id x17mr8846515wrp.114.1573218899895; 
 Fri, 08 Nov 2019 05:14:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzouqWsJKMypjWrkHw9ZEkJVDEBENTP/sseEa+lZYDzQVljLrbg3qfGKGA1aSdugMYrvyVdug==
X-Received: by 2002:adf:f651:: with SMTP id x17mr8846489wrp.114.1573218899530; 
 Fri, 08 Nov 2019 05:14:59 -0800 (PST)
Received: from [192.168.1.38] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id f14sm5009666wrv.17.2019.11.08.05.14.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 05:14:58 -0800 (PST)
Subject: Re: [PATCH v7 2/8] Acceptance tests: introduce utility method for
 tags unique vals
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <619a8f8e-ab0c-f837-853e-34e61e85a583@redhat.com>
Date: Fri, 8 Nov 2019 14:14:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 4:13 PM, Cleber Rosa wrote:
> Currently a test can describe the target architecture binary that it
> should primarily be run with, be setting a single tag value.
>=20
> The same approach is expected to be done with other QEMU aspects to be
> tested, for instance, the machine type and accelerator, so let's
> generalize the logic into a utility method.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptan=
ce/avocado_qemu/__init__.py
> index 9a57c020d8..e676d9c4e7 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -100,14 +100,21 @@ def exec_command_and_wait_for_pattern(test, comma=
nd,
>  =20
>  =20
>   class Test(avocado.Test):
> +    def _get_unique_tag_val(self, tag_name):
> +        """
> +        Gets a tag value, if unique for a key

'Get'?

> +        """
> +        vals =3D self.tags.get(tag_name, [])
> +        if len(vals) =3D=3D 1:
> +            return vals.pop()
> +        return None
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
> +                                    default=3Dself._get_unique_tag_val=
('arch'))
> +
>           default_qemu_bin =3D pick_default_qemu_bin(arch=3Dself.arch)
>           self.qemu_bin =3D self.params.get('qemu_bin',
>                                           default=3Ddefault_qemu_bin)
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

