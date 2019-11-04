Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81390CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:23:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B5CB20578
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 18:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5CB20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRh0w-0001S4-Cl
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 13:23:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42341)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iRh0D-0000tK-OC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:22:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iRh0B-0000Di-6y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:22:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iRh0A-0000DD-Up
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 13:22:55 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 791555BEC9
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 18:22:53 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id l184so6399113wmf.6
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 10:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xoe9hYl1PIGhGPpWOoY3kRoJcFgY9N6NOPUmhhebeZI=;
 b=S9sanoxXrdjQ3KUcsbzdlZrRtsvOHcQucBGnfkPrDlC9LbuMCCGAMAvoPsumiJZ6wv
 p3snjRD1TIPPYnHIskAFBuxIwsHLscEr0KUsDBpRb+f5dWYWUsd31XJxnQF8u3f4g8K3
 sEG5BkQXB2iWO+dYnRCf/1jHfSucZKB1bOt4c5ztamWwzfK7jEa0KiJCxRR2hT++cKkq
 oBjqK5lkfXghKUZHTIG26Jmfi9afAmM/DW9ovw9DgutNWV7S4Z36j+UyQADOF43pOQCz
 162nEYYi/6k6ENHuXeImonro5nsPTv6BYEjJAVqgVJvvZSnAnTXAEc4of3NxZICUtLVt
 HEdg==
X-Gm-Message-State: APjAAAX2WEBIrOgFNIm/RxQvuIjWvgzzyipNuobCpmIzkJwvl1vLi6ge
 queLMb5qQviOy5fDbQD8O//KGo4+3uNNueTbCWM/X82v3NS1NEVDGh9+LDASNYHdVGnJH4dgbzK
 RCOhCDYe7gI9iL/k=
X-Received: by 2002:adf:e387:: with SMTP id e7mr8416095wrm.180.1572891772095; 
 Mon, 04 Nov 2019 10:22:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfuSiqUAfDJdjgmn5GGxW3A+o12hT52XDahLWG2Y0g2YVsAkK90dQTApjKlGEJdN8KR8gtbA==
X-Received: by 2002:adf:e387:: with SMTP id e7mr8416076wrm.180.1572891771853; 
 Mon, 04 Nov 2019 10:22:51 -0800 (PST)
Received: from [192.168.1.24] (lfbn-1-7864-228.w92-167.abo.wanadoo.fr.
 [92.167.33.228])
 by smtp.gmail.com with ESMTPSA id t13sm11278399wrr.88.2019.11.04.10.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2019 10:22:51 -0800 (PST)
Subject: Re: [PATCH v7 1/8] Acceptance test x86_cpu_model_versions: use
 default vm
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <17a6c15f-9846-e443-e1a7-5fb4e8728a29@redhat.com>
Date: Mon, 4 Nov 2019 19:22:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-2-crosa@redhat.com>
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
> The default vm provided by the test, available as self.vm, serves the
> same purpose of the one obtained by self.get_vm(), but saves a line
> and matches the style of other tests.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   tests/acceptance/x86_cpu_model_versions.py | 100 ++++++++++----------=
-
>   1 file changed, 46 insertions(+), 54 deletions(-)
>=20
> diff --git a/tests/acceptance/x86_cpu_model_versions.py b/tests/accepta=
nce/x86_cpu_model_versions.py
> index 5fc9ca4bc6..6eb977954d 100644
> --- a/tests/acceptance/x86_cpu_model_versions.py
> +++ b/tests/acceptance/x86_cpu_model_versions.py
> @@ -25,10 +25,6 @@
>   import avocado_qemu
>   import re
>  =20
> -def get_cpu_prop(vm, prop):
> -    cpu_path =3D vm.command('query-cpus')[0].get('qom_path')
> -    return vm.command('qom-get', path=3Dcpu_path, property=3Dprop)
> -
>   class X86CPUModelAliases(avocado_qemu.Test):
>       """
>       Validation of PC CPU model versions and CPU model aliases
> @@ -241,78 +237,74 @@ class CascadelakeArchCapabilities(avocado_qemu.Te=
st):
>  =20
>       :avocado: tags=3Darch:x86_64
>       """
> +    def get_cpu_prop(self, prop):
> +        cpu_path =3D self.vm.command('query-cpus')[0].get('qom_path')
> +        return self.vm.command('qom-get', path=3Dcpu_path, property=3D=
prop)
> +
>       def test_4_1(self):
>           # machine-type only:
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.1')
> -        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,=
check=3Doff,enforce=3Doff')
> -        vm.launch()
> -        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.1')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
> +        self.vm.launch()
> +        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
>                            'pc-i440fx-4.1 + Cascadelake-Server should n=
ot have arch-capabilities')
>  =20
>       def test_4_0(self):
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.0')
> -        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,=
check=3Doff,enforce=3Doff')
> -        vm.launch()
> -        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
> +        self.vm.launch()
> +        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
>                            'pc-i440fx-4.0 + Cascadelake-Server should n=
ot have arch-capabilities')
>  =20
>       def test_set_4_0(self):
>           # command line must override machine-type if CPU model is not=
 versioned:
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.0')
> -        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,=
check=3Doff,enforce=3Doff,+arch-capabilities')
> -        vm.launch()
> -        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,+arch-capabilities')
> +        self.vm.launch()
> +        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
>                           'pc-i440fx-4.0 + Cascadelake-Server,+arch-cap=
abilities should have arch-capabilities')
>  =20
>       def test_unset_4_1(self):
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.1')
> -        vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3Don,=
check=3Doff,enforce=3Doff,-arch-capabilities')
> -        vm.launch()
> -        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.1')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server,x-force-features=3D=
on,check=3Doff,enforce=3Doff,-arch-capabilities')
> +        self.vm.launch()
> +        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
>                            'pc-i440fx-4.1 + Cascadelake-Server,-arch-ca=
pabilities should not have arch-capabilities')
>  =20
>       def test_v1_4_0(self):
>           # versioned CPU model overrides machine-type:
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.0')
> -        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
> -        vm.launch()
> -        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-featur=
es=3Don,check=3Doff,enforce=3Doff')
> +        self.vm.launch()
> +        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
>                            'pc-i440fx-4.0 + Cascadelake-Server-v1 shoul=
d not have arch-capabilities')
>  =20
>       def test_v2_4_0(self):
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.0')
> -        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3D=
on,check=3Doff,enforce=3Doff')
> -        vm.launch()
> -        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> -                         'pc-i440fx-4.0 + Cascadelake-Server-v2 should=
 have arch-capabilities')
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-featur=
es=3Don,check=3Doff,enforce=3Doff')
> +        self.vm.launch()
> +        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
> +                        'pc-i440fx-4.0 + Cascadelake-Server-v2 should =
have arch-capabilities')
>  =20
>       def test_v1_set_4_0(self):
>           # command line must override machine-type and versioned CPU m=
odel:
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.0')
> -        vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-features=3D=
on,check=3Doff,enforce=3Doff,+arch-capabilities')
> -        vm.launch()
> -        self.assertTrue(get_cpu_prop(vm, 'arch-capabilities'),
> -                         'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-=
capabilities should have arch-capabilities')
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.0')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server-v1,x-force-featur=
es=3Don,check=3Doff,enforce=3Doff,+arch-capabilities')
> +        self.vm.launch()
> +        self.assertTrue(self.get_cpu_prop('arch-capabilities'),
> +                        'pc-i440fx-4.0 + Cascadelake-Server-v1,+arch-c=
apabilities should have arch-capabilities')
>  =20
>       def test_v2_unset_4_1(self):
> -        vm =3D self.get_vm()
> -        vm.add_args('-S')
> -        vm.set_machine('pc-i440fx-4.1')
> -        vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-features=3D=
on,check=3Doff,enforce=3Doff,-arch-capabilities')
> -        vm.launch()
> -        self.assertFalse(get_cpu_prop(vm, 'arch-capabilities'),
> +        self.vm.add_args('-S')
> +        self.vm.set_machine('pc-i440fx-4.1')
> +        self.vm.add_args('-cpu', 'Cascadelake-Server-v2,x-force-featur=
es=3Don,check=3Doff,enforce=3Doff,-arch-capabilities')
> +        self.vm.launch()
> +        self.assertFalse(self.get_cpu_prop('arch-capabilities'),
>                            'pc-i440fx-4.1 + Cascadelake-Server-v2,-arch=
-capabilities should not have arch-capabilities')
>=20

