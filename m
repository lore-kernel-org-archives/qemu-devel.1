Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86859C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52E7320776
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 15:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAeG4ImL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E7320776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdyBp-0003vw-I6
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 11:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyBC-000367-Rm
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:41:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44510)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdyBB-0000N6-Pe
 for qemu-devel@nongnu.org; Wed, 27 May 2020 11:41:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id y17so16079517wrn.11
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oCO3KeaO4/ERd1QfTeyL1QZSWauitZiDDj2f5mc2Jtw=;
 b=BAeG4ImLmQ5jdNe8rPeEWL8k9F/P3cP+AMWY14Uw3JQBHTba3OIQM0Lt4s5jLiNCOn
 sjDF1n+rIukZKrIi/3PrfAiGqT/uvME3wxRCS+FOXyKwiSZ5CeH9IVewHgQrf7qRRR4R
 zSHjuBDK9+NBOn9li83RvYDTPzN92pB7yTSgb+cW0uSVApVvF0TFrZs48YGO7GGHrvUv
 TG8I7Fhk29qu4+uAagdHu2kDokc9R7PDD36Cqqocl+uNbHq3tC/KO0CFioT3UVh6sLoF
 LXaNOj7WYoxfoOheUu6JBomYKj2w+YGsa+ncnyScW55bVwG9tQWX6AWwB1KS0RHbkpy5
 XCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oCO3KeaO4/ERd1QfTeyL1QZSWauitZiDDj2f5mc2Jtw=;
 b=TOWuBIFW/Fu8VLTzCNYW0pNIrUKelFIQRkkaRyjoH6gtQQ9xReioRcjlmq3JW63Nl6
 OgYvvd7QkJ2Ix73egvhhNKJNPITcUgmtCtDKFPSmWy2Z6AGCzKvs6eR/0PWXj2BuF48x
 KK1pQpS3L3i9S3rSfPN4r0q+Wr9H6j2ZUOFECZRx/ZE+E34X6zpnhCywiv6qPtenuv1G
 W+4pSDB7zJRseVdDIOUR0CU7g2hJvli+JlzIvZyEbGnAgEWOUap+RkBN6XzD6ZkNCdQY
 BlOFSWsC2Gf6jlFhcWR9NtuIaJ7WTm/ueLQZ/8S6kFMH2kcf9VRny+fy3RXLYEVbvKrI
 It0w==
X-Gm-Message-State: AOAM5325IHVcg+Ck6olnDU1fmUVCL89Em68EkUd/BNDC4klZaiTl9cgZ
 BMxlDFx+0Y2aZvMz+eFZLWIZDQ==
X-Google-Smtp-Source: ABdhPJxFLS0hJPPxEZSfWqGiwgHo+PmfUZJ5CECC43c0+tZZwNqnaMQ7r4+YO2zIVuxhErhuozMZTQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr15917058wrw.266.1590594076292; 
 Wed, 27 May 2020 08:41:16 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g10sm3134618wrx.4.2020.05.27.08.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 08:41:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E3341FF7E;
 Wed, 27 May 2020 16:41:14 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
Subject: Re: [PATCH v2 04/11] tests/acceptance: add kernel record/replay
 test for x86_64
In-reply-to: <159057546117.16818.15607496040935344350.stgit@pasha-ThinkPad-X280>
Date: Wed, 27 May 2020 16:41:14 +0100
Message-ID: <87sgfl5qsl.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:

> This patch adds a test for record/replay an execution of x86_64 machine.
> Execution scenario includes simple kernel boot, which allows testing
> basic hardware interaction in RR mode.
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  0 files changed
>
> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_=
kernel.py
> index b8b277ad2f..c7526f1aba 100644
> --- a/tests/acceptance/replay_kernel.py
> +++ b/tests/acceptance/replay_kernel.py
> @@ -55,3 +55,19 @@ class ReplayKernel(LinuxKernelUtils):
>                      True, shift, args)
>          self.run_vm(kernel_path, kernel_command_line, console_pattern,
>                      False, shift, args)
> +
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Darch:x86_64
> +        :avocado: tags=3Dmachine:pc
> +        """
> +        kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
> +                      '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
> +                      '/vmlinuz')
> +        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
> +        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
> +
> +        kernel_command_line =3D self.KERNEL_COMMON_COMMAND_LINE + 'conso=
le=3DttyS0'
> +        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
> +
> +        self.run_rr(kernel_path, kernel_command_line, console_pattern)

This test fails for me on the replay:

  2020-05-27 16:22:21,658 machine          L0326 DEBUG| VM launch command: =
'x86_64-softmmu/qemu-system-x86_64 -display none -vga none -chardev socket,=
id=3Dmon,path=3D/var/tmp/tmp4n_geosi/qemu-9516-monitor.sock -mon chardev=3D=
mon,mode=3Dcontrol -machine pc -chardev socket,id=3Dconsole,path=3D/var/tmp=
/tmp4n_geosi/qemu-9516-console.sock,server,nowait -serial chardev:console -=
icount shift=3D7,rr=3Dreplay,rrfile=3D/var/tmp/avocado_b85h3ycg/avocado_job=
_8xrxksgj/1-._tests_acceptance_replay_kernel.py_ReplayKernel.test_x86_64_pc=
/replay.bin -kernel /home/alex/avocado/data/cache/by_location/df533120a0e0f=
fda2626bed6e8a975d3b07e3f05/vmlinuz -append printk.time=3D0 console=3DttyS0=
 -net none'
  2020-05-27 16:22:21,725 qmp              L0194 DEBUG| >>> {'execute': 'qm=
p_capabilities'}
  2020-05-27 16:22:21,736 qmp              L0202 DEBUG| <<< {'return': {}}
  2020-05-27 16:23:49,372 stacktrace       L0039 ERROR|
  2020-05-27 16:23:49,372 stacktrace       L0042 ERROR| Reproduced tracebac=
k from: /home/alex/lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/site-p=
ackages/avocado/core/test.py:860
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR| Traceback (most rec=
ent call last):
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 73, in te=
st_x86_64_pc
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.run_rr(ker=
nel_path, kernel_command_line, console_pattern)
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 57, in ru=
n_rr
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     False, shift, a=
rgs)
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/replay_kernel.py", line 46, in ru=
n_vm
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     self.wait_for_c=
onsole_pattern(console_pattern, vm)
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/boot_linux_console.py", line 37, =
in wait_for_console_pattern
  2020-05-27 16:23:49,373 stacktrace       L0045 ERROR|     vm=3Dvm)
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", line 1=
31, in wait_for_console_pattern
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     _console_intera=
ction(test, success_message, failure_message, None, vm=3Dvm)
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py", line 8=
3, in _console_interaction
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     msg =3D console=
.readline().strip()
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/usr/lib/py=
thon3.7/socket.py", line 589, in readinto
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     return self._so=
ck.recv_into(b)
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|   File "/home/alex/=
lsrc/qemu.git/builds/all/tests/venv/lib/python3.7/site-packages/avocado/plu=
gins/runner.py", line 89, in sigterm_handler
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR|     raise RuntimeEr=
ror("Test interrupted by SIGTERM")
  2020-05-27 16:23:49,374 stacktrace       L0045 ERROR| RuntimeError: Test =
interrupted by SIGTERM


--=20
Alex Benn=C3=A9e

