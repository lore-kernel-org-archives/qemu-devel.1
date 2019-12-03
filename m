Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBCBC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8303020659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfL6KUD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8303020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEtr-0005e6-Mi
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42889)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icDi9-0007dv-OY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icDi3-0008Bs-OL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:19:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36588)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icDi0-00086i-FE
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:19:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so5199414wru.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 11:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kE36sYvi1qr1Au3LY1sHoO9A4xtmGvkxhi6smvQY0S0=;
 b=AfL6KUD44LKUqSFpPDjwZFtIMJB4iKFCsPKmwnbnWGnHaXTVXvre83C11VCbJrO2ed
 rZLTr+LTesM5a3q2yWQeIEdfRhg7+5gpSCwTWJmH2gfsPe98Ozx44W42sUMzRGSuUWMp
 GKlVqGI6Ledhe8vRZcn1qTQgJpK+0lxYXYmtMn6n44pjECPdhuqce2YQ13KI1qpmqS+F
 Ve/CzeNsmuh4IRWOuG/zj0RMVT0OrWwheGEPXBnGU443o2U5Nt0P7t0zf8OUvu6JJDoP
 LSM4CUebTGeXYLO5ij8GLm6hb+1rGNtWE5Vy7McgaAJZB2lah/ORtYf+LGx+DPi6m8xv
 dl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kE36sYvi1qr1Au3LY1sHoO9A4xtmGvkxhi6smvQY0S0=;
 b=AlTKRxiScVIEJcckThvWJmdHt+wErBhGrkUks7769YhFP63ZlSmdpjLh73stmtgEvb
 ZQt2G9ws3lzku5fGOedP7cgQZwIAZF/mJrUzwRAAZMY788xsP/H87DXb5bxdeiYLbcQs
 zqnFLVrQSxv6QrFy8aFxvI2snZlINQE9p6AACyvWPlwnA2drNE2/a4UEvldW3gzS3Irj
 jMBfe29iF4V8B4qQHxmRJNhsA+aC7ZRQXKMii84ySok8rYCj7yeLrg7WtTPNriXq2URz
 lhb0DWCn9qcpt4oF8lLaZufO+4WET/ZDpRpKUJNb77rXvw/ajHUDLxxz1RqSpq7m33ir
 3Ljw==
X-Gm-Message-State: APjAAAWl7mn7c+5zCfgJ/6Cv3w0DsfGFw/vVDsh0WdPw3vHE9586qUyY
 o26UBxuhG/W8X8W9nvGyRzL0GQ==
X-Google-Smtp-Source: APXvYqw+wUTkQtNPmhBlom+66D4ynJTFKgtFTYaWJfOErcUReYmW0xLhdF95qCAWhk2sCKp/7Nsu4w==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr6703033wro.375.1575400777473; 
 Tue, 03 Dec 2019 11:19:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p17sm4880776wrx.20.2019.12.03.11.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 11:19:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A0BD81FF87;
 Tue,  3 Dec 2019 19:19:35 +0000 (GMT)
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-9-crosa@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 8/8] Acceptance test: add "boot_linux" tests
In-reply-to: <20191104151323.9883-9-crosa@redhat.com>
Date: Tue, 03 Dec 2019 19:19:35 +0000
Message-ID: <87lfrt9pyw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> This acceptance test, validates that a full blown Linux guest can
> successfully boot in QEMU.  In this specific case, the guest chosen is
> Fedora version 31.
>
>  * x86_64, pc and q35 machine types, with and without kvm as an
>    accellerator
>
>  * aarch64 and virt machine type, with and without kvm as an
>    accellerator
>
>  * ppc64 and pseries machine type
>
>  * s390x and s390-ccw-virtio machine type
>
> The method for checking the successful boot is based on "cloudinit"
> and its "phone home" feature.  The guest is given an ISO image
> with the location of the phone home server, and the information to
> post (the instance ID).  Upon receiving the correct information,
> from the guest, the test is considered to have PASSed.
>
> This test is currently limited to user mode networking only, and
> instructs the guest to connect to the "router" address that is hard
> coded in QEMU.
>
> To create the cloudinit ISO image that will be used to configure the
> guest, the pycdlib library is also required and has been added as
> requirement to the virtual environment created by "check-venv".
>
> The console output is read by a separate thread, by means of the
> Avocado datadrainer utility module.

Hmm I'm seeing breakage with this final commit:

19:16:36 [alex@zen:~/l/qemu.git] review/boot-linux-acceptance|=E2=80=A6 + /=
bin/sh -c "cd builds/all; make check-acceptance"
make[1]: Entering directory '/home/alex/lsrc/qemu.git/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/alex/lsrc/qemu.git/slirp'
  VENV    /home/alex/lsrc/qemu.git/builds/all/tests/venv
  PIP     /home/alex/lsrc/qemu.git/tests/requirements.txt
  CC      qemu-img.o
  LINK    qemu-img
/usr/bin/ld: //lib/x86_64-linux-gnu/libtirpc.so.3: warning: common of `rpc_=
createerr@@GLIBC_2.2.5' overridden by definition from //lib/x86_64-linux-gn=
u/libc.so.6
  AVOCADO tests/acceptance
JOB ID     : f564c8a207a556b04abceed09e51cf945b48ca56
JOB LOG    : /home/alex/lsrc/qemu.git/builds/all/tests/results/job-2019-12-=
03T19.16-f564c8a/job.log
 (01/60) tests/acceptance/boot_linux.py:BootLinuxX8664.test_pc: ERROR: Trac=
eback (most recent call last):\n  File "/usr/lib/python3.7/imp.py", line 23=
4, in load_module\n
return load_source(name, filename, file)\n  File "/usr/lib/python3.7/imp.py=
", line 171, in load_source\n    module =3D _load(spec)\n  File "<frozen im=
portlib._b... (0.03 s)
Interrupting job (failfast).
RESULTS    : PASS 0 | ERROR 1 | FAIL 0 | SKIP 59 | WARN 0 | INTERRUPT 0 | C=
ANCEL 0
JOB TIME   : 0.15 s
make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:1183: check-acce=
ptance] Error 9


--=20
Alex Benn=C3=A9e

