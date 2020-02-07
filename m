Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BDCC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAF3520838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 16:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DEu35tWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF3520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j06rH-0005bW-W2
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 11:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j06pf-0004AH-35
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j06pd-0005Jg-Kn
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:50:18 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j06pd-0005JB-D6
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 11:50:17 -0500
Received: by mail-wm1-x341.google.com with SMTP id s10so3245574wmh.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 08:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=YIppaXtV7VBSeH2WhK7RaQjEGHXi5D11I34HwoRYAg8=;
 b=DEu35tWLoiZfUxrTXaayVg/K5HwsHHn1XmOcEdPi7VXv2yvshUJWT5oxR49pF8uNQE
 6SyhWUufeuCr7J+X8zkyV3DOq652K3UtRYkotbX+pJrAJxgTb9sWQ4Q/q6DLV23wms3d
 KQ+mV2K0qaK/4VMCcVIr5fgkpWoMcDjAXsfidHG3GXnrKrDpFJiwMiMMDBjrnwgW90Nj
 J3zO0D9JsEC5c7q/OtkrQ7WW0uCesx/g5TYN2bg++jBWUrDgClzvClvVyYO61OwrldxS
 EYfzDOgybeiGz+RlC3Tr+ianPnVnTKiEmwwj6Y7ZDYQufJvFZz9VzA2ZM0qWrnqmpX8M
 8Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=YIppaXtV7VBSeH2WhK7RaQjEGHXi5D11I34HwoRYAg8=;
 b=eEkXYx/zRJ4mcv0F5RzTfespHi1cAAxroAR6FU/PoMOMZ6PR2y6QCtnrjVrNSdDrTE
 vQdyjvBgp19AeR6KmvOPbAVA+pevyq05VTHdBKCcE5tkauiPywcdnG0TVYNAfJgolGVJ
 BLzm/0KCDuLB30c/zbo4juzc/16aSm/lP/JMWP18W1/3qeuWEOdgYewV7GknDoguG8lQ
 aBgVmByZqss4iEU3RQXx1OicGRCw3NmA30H/+Q1UA8dsXsbyIuTQT4xJ9HrxJReYy2Mc
 3F7N1fgXMpNS6xdxuhtwFP83e7LlD0KZc38VGcOZL8sO/Ua2DC0dE5oMH/yGoO/mO2yR
 nl4w==
X-Gm-Message-State: APjAAAWSqFYp1XZJQIoPOmtgFXjGi6wwAFo32nWPTcEqAHev5/kbhqzb
 FkhqPKqWE2JGmQuuGJfKHlzp6w==
X-Google-Smtp-Source: APXvYqw3rJl8tsq96jRthoVlyCaWSMtRfJzKNTlzwxV1MVfwhyYTz/2CV0GsoTP40meaiig8CPhaQg==
X-Received: by 2002:a05:600c:20f:: with SMTP id
 15mr5186892wmi.128.1581094216165; 
 Fri, 07 Feb 2020 08:50:16 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f8sm4032809wru.12.2020.02.07.08.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 08:50:14 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3EA1C1FF87;
 Fri,  7 Feb 2020 16:50:14 +0000 (GMT)
References: <20200205212920.467-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 00/14] tests/vm: Add support for aarch64 VMs
In-reply-to: <20200205212920.467-1-robert.foley@linaro.org>
Date: Fri, 07 Feb 2020 16:50:14 +0000
Message-ID: <877e0y735l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: fam@euphon.net, peter.puhov@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This is version 1 of the patch series to=20
> add support for 2 aarch64 VMs.=20=20
>  - Ubuntu 18.04 aarch64 VM
>  - CentOS 8 aarch64 VM

Testing under TCG with:

  make vm-build-ubuntu.aarch64 V=3D1 QEMU=3Daarch64-softmmu/qemu-system-aar=
ch64

I'm seeing it hang:

  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 sed -ie 's/"1"/"0"/g' /etc/apt/apt.conf.d/20auto-upgrades
  Warning: Permanently added '[127.0.0.1]:37431' (ECDSA) to the list of kno=
wn hosts.
  bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
  Connection to 127.0.0.1 closed.
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 sync && reboot
  Warning: Permanently added '[127.0.0.1]:37431' (ECDSA) to the list of kno=
wn hosts.
  bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
  Connection to 127.0.0.1 closed by remote host.
  Connection to 127.0.0.1 closed.
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 exit 0
  Warning: Permanently added '[127.0.0.1]:37431' (ECDSA) to the list of kno=
wn hosts.
  bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.UTF-8)
  Connection to 127.0.0.1 closed.
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 locale
  ssh_exchange_identification: Connection closed by remote host
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 sed -ie s/^#\ deb-src/deb-src/g /etc/apt/sources.list
  ssh_exchange_identification: Connection closed by remote host
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 apt-get update
  ssh_exchange_identification: Connection closed by remote host
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 apt-get build-dep -y qemu
  ssh_exchange_identification: Connection closed by remote host
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 apt-get install -y libfdt-dev flex bison
  ssh_exchange_identification: Connection closed by remote host
  DEBUG:root:ssh_cmd: ssh -t -o StrictHostKeyChecking=3Dno -o UserKnownHost=
sFile=3D/dev/null -o ConnectTimeout=3D60 -p 37431 -i /home/alex.bennee/lsrc=
/qemu.git/builds/all/vm-test-xxrw1r36.tmp/id_rsa -o SendEnv=3Dhttps_proxy -=
o SendEnv=3Dhttp_proxy -o SendEnv=3Dftp_proxy -o SendEnv=3Dno_proxy root@12=
7.0.0.1 poweroff
  ssh_exchange_identification: Connection closed by remote host

--=20
Alex Benn=C3=A9e

