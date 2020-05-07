Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39CC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D500208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lchO7Qxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D500208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlRq-0007m6-I8
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWlPv-0005My-R5
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:38:43 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36752)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWlPu-00009z-S8
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:38:43 -0400
Received: by mail-wm1-x342.google.com with SMTP id u127so7959145wmg.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7HOTgeqjVGHeHIxUG9aniyafbkHACtnYb+ltLTcgCbs=;
 b=lchO7QxfS/Ia598Wpgs53ufpZJTljkl/Z3clHjqJHrza+6sqSaEEWxPzsvp5u35you
 cas20nduBwVkShX02YNjhlXKCQNdkSt4ylIfbPwADrw0rj9nJKz6HAr9/ZjhitNPlQVY
 7HZgUn292LAbCTU94Avrnf63sL4CRpG3BlWDpwGtnU05OcWO4DU/g1UidoqwGQDkFTel
 g8JJajvmmoNUNWFdapaaepqMB19nhLeywoPv/2C7Mn6zzbbVnGnBlbkyjQmudBTt9KaQ
 AefXGstZ1/JFk673Z7V3roABA9zisymPD9FYrbSbx3/PBln6y309qo9bfMuUPnNMbBVM
 /w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7HOTgeqjVGHeHIxUG9aniyafbkHACtnYb+ltLTcgCbs=;
 b=OgxminldDjKL+QvCtHeo/gSHDsWalrsAkIM9jyEvshmWS+9mvzwWH6jH8cEJvNqnl5
 FpuDvJl1qlgOnjyXD+I7koI+2TFfMiZXv41H1BNNsu3XWmHSDKZQwucxTE9Sbb/RimGg
 YITx6ji/j84hAH33StG1Yce9E4HqC1A6V/FrR161buqgyLktFVorQot7K7fzE/no1SXr
 DtXRn9AQuHoHq//m++tdRAoc0l7DEc0c2P9KtW6Hl5grz0tHXFzT3uK5nH1VRmTCQrzd
 NpjdMbyPFbx/gl4b4AkJwZ3XuZOyghoQX/2KHo0ZUHmrlHjtSuFB8WzC6Xbb3XPSFeSV
 ikvA==
X-Gm-Message-State: AGi0PuZGZVz1lPxCSsQMjDolvoePrZJ56j5o+iJ3/2fDxeUUaVvvmM11
 m4eyrBkov3DeJa4Tj5lhAaZC6w==
X-Google-Smtp-Source: APiQypL6zRw4X1Mzn4TRMDTKkJBPKhzyS5yIz68zpjB9+pTizXNh+YALRJAlAzLsshtC1bdVuUZVRg==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr11932999wmt.153.1588876720749; 
 Thu, 07 May 2020 11:38:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o7sm8765309wmh.46.2020.05.07.11.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 11:38:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A51831FF7E;
 Thu,  7 May 2020 19:38:38 +0100 (BST)
References: <20200507162235.1790-1-philmd@redhat.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
In-reply-to: <20200507162235.1790-1-philmd@redhat.com>
Date: Thu, 07 May 2020 19:38:38 +0100
Message-ID: <874ksr615d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> The BootLinuxAarch64.test_virt_tcg is reported to take >7min to run.
> Add a possibility to users to skip this particular test, by setting
> the AVOCADO_SKIP_SLOW_TESTS environment variable:
>
>   $ AVOCADO_SKIP_SLOW_TESTS=3Dplease make check-acceptance
>   ...
>     (05/88) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_tcg=
: SKIP: Test takes >7min
>   ...

7m =3D 420s - I'm seeing:

  hyperfine "./tests/venv/bin/avocado run ./tests/acceptance/boot_linux.py:=
BootLinuxAarch64.test_virt_tcg"
  Benchmark #1: ./tests/venv/bin/avocado run ./tests/acceptance/boot_linux.=
py:BootLinuxAarch64.test_virt_tcg
    Time (mean =C2=B1 =CF=83):     162.179 s =C2=B1  3.138 s    [User: 204.=
726 s, System: 9.663 s]
    Range (min =E2=80=A6 max):   158.651 s =E2=80=A6 170.036 s    10 runs

Is this on very slow hardware?


>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/boot_linux.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
> index 075a386300..a8df50d769 100644
> --- a/tests/acceptance/boot_linux.py
> +++ b/tests/acceptance/boot_linux.py
> @@ -15,6 +15,7 @@
>  from qemu.accel import kvm_available
>  from qemu.accel import tcg_available
>=20=20
> +from avocado import skipIf
>  from avocado.utils import cloudinit
>  from avocado.utils import network
>  from avocado.utils import vmimage
> @@ -159,6 +160,7 @@ def add_common_args(self):
>          self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
>          self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')
>=20=20
> +    @skipIf(os.getenv('AVOCADO_SKIP_SLOW_TESTS'), 'Test takes >7min')
>      def test_virt_tcg(self):
>          """
>          :avocado: tags=3Daccel:tcg


--=20
Alex Benn=C3=A9e

