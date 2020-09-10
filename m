Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1DFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BA5206A2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfSVLa+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BA5206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGR92-0000YJ-LF
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGR7g-0008Lm-DU; Thu, 10 Sep 2020 14:16:40 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:33232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kGR7e-00020Y-MK; Thu, 10 Sep 2020 14:16:40 -0400
Received: by mail-oo1-xc44.google.com with SMTP id m25so1672141oou.0;
 Thu, 10 Sep 2020 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=jUIAcQbCUkD0PwydJF56+2dLKtzIf3stqbSaEha7K8I=;
 b=pfSVLa+UElD8omX7tO+H5pzipDoCpzldlsb+aCOzz+GBu/6Odsc57B4B0jqUnT6MBw
 NeEoyA6CdCaUGIXH3lt07dAxaIiGeWYjIEoUtvPEOxR7nt8BPpDNlKn5NxyZ19NyYGc3
 AswAUhQ0nHU5uL9lsoU7awylHc0D1JuiI0oMtWgTATmygpNfPf0O1L4rNvnGm1pWvZmj
 GEDHcn21a6JWmP05lgkQhCUzAPY6Gu5cD+JVIsBfuQo8ac2GuDDFbhmD87MSUCHN2tFp
 wl3XaTxzZo5l4+8+XuSFB92LeFvweRBGZ7p+uOe4HC1HZvQNrSOV17HVX2fLXWOwX6bV
 7H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=jUIAcQbCUkD0PwydJF56+2dLKtzIf3stqbSaEha7K8I=;
 b=JZ2g3ZZTDDROzbHPQz4fqi1YFBeEoEoUsyzHk8jr9Hk3NSDH7OPgGtEPcE5J3v9yQG
 sddx/8NwzW8v2WGNzu5ZpYnzwVrko2E5U4HjXFsVB0dYyIZryXL2eqwR74bwpx0MgF4i
 aRJQc+v9FwXyfxPs2yWuGFAPiYYL28h9srLYzfz7c1qYp+po1PwmQCyDsWop91ECJ4Fu
 zTMcTWUgjgweF4TglQ6NaQ60JYVZ/6FFFdwatTnn0mr4tMbpwJvn4qQILvnS9gxnN9rA
 5Iz40jtw10kT+qH+jFl+75E3bKAJQETkL/kh5QSrd8LwwCYxBgIsXC1DJkRWZuHMwAbG
 EVAw==
X-Gm-Message-State: AOAM532/kkCg2q5LE2WK4AD4iB+fxhOE5ATLW2kD/0fg84OVSnBwPxaA
 N4alvGoFaZTOooY3yKqmopE=
X-Google-Smtp-Source: ABdhPJxUdB0pE5lEXKp63afiNOoDl1jpD9E6p7EPTTlzevupbs6eiMGlyXnbDzn6dBOlhNMoqpIK1Q==
X-Received: by 2002:a4a:4845:: with SMTP id p66mr5374696ooa.68.1599761796910; 
 Thu, 10 Sep 2020 11:16:36 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id d83sm1006346oib.43.2020.09.10.11.16.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 10 Sep 2020 11:16:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <70866614-8053-4a87-b3a6-c7448dcff56f@redhat.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
 <70866614-8053-4a87-b3a6-c7448dcff56f@redhat.com>
Message-ID: <159976179054.29065.10842850828338907813@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/77] Patch Round-up for stable 5.0.1,
 freeze on 2020-09-10
Date: Thu, 10 Sep 2020 13:16:30 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=flukshun@gmail.com; helo=mail-oo1-xc44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2020-09-04 04:20:00)
> On 9/3/20 10:58 PM, Michael Roth wrote:
> > Hi everyone,
> > =

> > The following new patches are queued for QEMU stable v5.0.1:
> > =

> >   https://github.com/mdroth/qemu/commits/stable-5.0-staging
> > =

> > Patch freeze is 2020-09-10, and the release is planned for 2020-09-15:
> > =

> >   https://wiki.qemu.org/Planning/5.0
> > =

> > Please respond here or CC qemu-stable@nongnu.org on any additional patc=
hes
> > you think should be included in the release.
> =

> Candidates:
> =

> b638627c723 ("hw/sd: Fix incorrect populated function switch status data
> structure")

I get the following breakage with this patch applied, and also see the
error upstream, so I've left these out for now:

  mdroth@sif:~/w/qemu-build2$ AVOCADO_ALLOW_LARGE_STORAGE=3D1 tests/venv/bi=
n/avocado run -t machine:orangepi-pc tests/acceptance/
  /home/mdroth/dev/kvm/qemu-build2/tests/venv/lib/python3.6/site-packages/a=
vocado/plugins/run.py:214: FutureWarning: The following arguments will be c=
hanged to boolean soon: sysinfo, output-check, failfast, keep-tmp and ignor=
e-missing-references.
    FutureWarning)
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_initrd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_initrd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_sd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_sd
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_bionic
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_uboot_netbsd9
  Fetching asset from tests/acceptance/boot_linux_console.py:BootLinuxConso=
le.test_arm_orangepi_uboot_netbsd9
  JOB ID     : 1efcdbf82a9cb1313078641c403802980018b53d
  JOB LOG    : /home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcdb=
f/job.log
   (1/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi: PASS (4.41 s)
   (2/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi_initrd: PASS (17.86 s)
   (3/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi_sd: PASS (51.11 s)
   (4/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi_bionic: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occu=
rred: Timeout reached\nOriginal status: ERROR\n{'name': '4-tests/acceptance=
/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_bionic', 'logdir'=
: '/home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcd... (90.58 s)
   (5/5) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_o=
rangepi_uboot_netbsd9: INTERRUPTED: Test interrupted by SIGTERM\nRunner err=
or occurred: Timeout reached\nOriginal status: ERROR\n{'name': '5-tests/acc=
eptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_uboot_netb=
sd9', 'logdir': '/home/mdroth/avocado/job-results/job-2020-09-10T11.0... (9=
0.64 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 2 | =
CANCEL 0
  JOB TIME   : 255.19 s
  JOB HTML   : /home/mdroth/avocado/job-results/job-2020-09-10T11.08-1efcdb=
f/results.html

> 6d2d4069c47 ("hw/sd: Correct the maximum size of a Standard Capacity SD
> Memory Card")
> =

> And maybe "memory: assert and define MemoryRegionOps callbacks"
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg729048.html
> =

> > =

> > Thanks!
>=20

