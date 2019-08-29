Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B4C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A65082166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65082166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53341 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3PDW-0007wi-QF
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3PBZ-0006pa-Kc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3PBX-0000bJ-GB
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:30:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3PBX-0000ZD-1M
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:30:15 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 147D97BDA0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:30:14 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id w11so2521517wru.17
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jj4hff5yR5i1eWywIFRFzYDnvUpK8BCqzwEN7YSMdzQ=;
 b=T+vGTeGH4lnVPMlmj4zlT9qiouksSSU/FJldVVmjsvjS18fc19a4YJESExhU6wAlZk
 DE2kLn+6lW9md/krHYVaghlgoNC1j+BOECFsYunC4eVT1uRPL7wP7s6y+TAv0XS01n4K
 RhnUPxRRRyE/Qm8jKsSvGmI1CEO7T2KlViXm5aOMntzHhxAxDv3CMdZeVLIVvGOq24p1
 jHH7asc5rCFjaAVxtZTeARFE62pUGU5fsCwYErQhFpI7z/FRTFVgcC4d3WeWZ/79AH4b
 acmGAMsgxr+whMaXT79fLC2Vew4MnpDEXoTBL0ny/ai/mpDPDuTNl/bxH565U+iRKHlh
 pt+Q==
X-Gm-Message-State: APjAAAV9GSlTSPyQMhXz7FkcJl9zuxT7wH+aoTBNUR5xw3LZc59Jqrbh
 FXvspHfNgMo+OxGrzZ9ORQpPuKYJ9PmvfKZDLw6E5C+HfKTYZWnzAY8hWlBqyPTED54G4DWs52r
 AR/OwnC6L3ELo/qQ=
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr10445838wrn.299.1567103412838; 
 Thu, 29 Aug 2019 11:30:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9tKQNIXVutPw51tBnhcPvEJaAV86qbsvHS7fEi6JxVA7Injg+qUjmgaLqHCVmYKQodXhONA==
X-Received: by 2002:adf:e7cc:: with SMTP id e12mr10445822wrn.299.1567103412658; 
 Thu, 29 Aug 2019 11:30:12 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id q19sm3728055wra.89.2019.08.29.11.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:30:12 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190820235243.26092-1-jsnow@redhat.com>
 <20190820235243.26092-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <6bdcd03a-39fb-b8a1-c109-ddf7e01d4c67@redhat.com>
Date: Thu, 29 Aug 2019 20:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190820235243.26092-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/4] iotests: add protocol support to
 initialization info
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 1:52 AM, John Snow wrote:
> This will add supported_protocols and unsupported_protocols to all of
> iotests.main, iotests.script_main, and iotests.script_initialize.

With your Signed-off-by:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  tests/qemu-iotests/207        | 4 ++--
>  tests/qemu-iotests/210        | 4 ++--
>  tests/qemu-iotests/211        | 4 ++--
>  tests/qemu-iotests/212        | 4 ++--
>  tests/qemu-iotests/213        | 4 ++--
>  tests/qemu-iotests/iotests.py | 5 ++++-
>  6 files changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
> index ab9e3b6747..35d98f2736 100755
> --- a/tests/qemu-iotests/207
> +++ b/tests/qemu-iotests/207
> @@ -24,8 +24,8 @@ import iotests
>  import subprocess
>  import re
> =20
> -iotests.script_initialize(supported_fmts=3D['raw'])
> -iotests.verify_protocol(supported=3D['ssh'])
> +iotests.script_initialize(supported_fmts=3D['raw'],
> +                          supported_protocols=3D['ssh'])
> =20
>  def filter_hash(qmsg):
>      def _filter(key, value):
> diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
> index 5a7013cd34..d9fe780c07 100755
> --- a/tests/qemu-iotests/210
> +++ b/tests/qemu-iotests/210
> @@ -23,8 +23,8 @@
>  import iotests
>  from iotests import imgfmt
> =20
> -iotests.script_initialize(supported_fmts=3D['luks'])
> -iotests.verify_protocol(supported=3D['file'])
> +iotests.script_initialize(supported_fmts=3D['luks'],
> +                          supported_protocols=3D['file'])
> =20
>  def blockdev_create(vm, options):
>      result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
> diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
> index 4d6aac497f..155fac4e87 100755
> --- a/tests/qemu-iotests/211
> +++ b/tests/qemu-iotests/211
> @@ -23,8 +23,8 @@
>  import iotests
>  from iotests import imgfmt
> =20
> -iotests.script_initialize(supported_fmts=3D['vdi'])
> -iotests.verify_protocol(supported=3D['file'])
> +iotests.script_initialize(supported_fmts=3D['vdi'],
> +                          supported_protocols=3D['file'])
> =20
>  def blockdev_create(vm, options):
>      result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
> diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
> index ec35bceb11..67e5a1dbb5 100755
> --- a/tests/qemu-iotests/212
> +++ b/tests/qemu-iotests/212
> @@ -23,8 +23,8 @@
>  import iotests
>  from iotests import imgfmt
> =20
> -iotests.script_initialize(supported_fmts=3D['parallels'])
> -iotests.verify_protocol(supported=3D['file'])
> +iotests.script_initialize(supported_fmts=3D['parallels'],
> +                          supported_protocols=3D['file'])
> =20
>  def blockdev_create(vm, options):
>      result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
> diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
> index 3d2c024375..23f387ab63 100755
> --- a/tests/qemu-iotests/213
> +++ b/tests/qemu-iotests/213
> @@ -23,8 +23,8 @@
>  import iotests
>  from iotests import imgfmt
> =20
> -iotests.script_initialize(supported_fmts=3D['vhdx'])
> -iotests.verify_protocol(supported=3D['file'])
> +iotests.script_initialize(supported_fmts=3D['vhdx'],
> +                          supported_protocols=3D['file'])
> =20
>  def blockdev_create(vm, options):
>      result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
> index 2970d7304a..661d7f93bf 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -925,7 +925,9 @@ def execute_unittest(debug=3DFalse):
>  def execute_setup_common(supported_fmts=3D[],
>                           supported_oses=3D['linux'],
>                           supported_cache_modes=3D[],
> -                         unsupported_fmts=3D[]):
> +                         unsupported_fmts=3D[],
> +                         supported_protocols=3D[],
> +                         unsupported_protocols=3D[]):
>      """
>      Perform necessary setup for either script-style or unittest-style =
tests.
>      """
> @@ -941,6 +943,7 @@ def execute_setup_common(supported_fmts=3D[],
>      verify_image_format(supported_fmts, unsupported_fmts)
>      verify_platform(supported_oses)
>      verify_cache_mode(supported_cache_modes)
> +    verify_protocol(supported_protocols, unsupported_protocols)
> =20
>      debug =3D '-d' in sys.argv
>      if debug:
>=20

