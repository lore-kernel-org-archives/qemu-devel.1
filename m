Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60986C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:10:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B80A214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAyMQE+e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B80A214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkMV-0007EA-5J
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:10:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jandryuk@gmail.com>) id 1iSkLQ-00064E-Cg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jandryuk@gmail.com>) id 1iSkLP-0001Lv-1d
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:09:12 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:43736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1iSkLO-0001Kz-OS
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:09:10 -0500
Received: by mail-lf1-x144.google.com with SMTP id j5so2002550lfh.10
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MuW1HrYB1fRl5RhtcZDvTpRDK6OMWig1ZEWjL4Ok3U8=;
 b=QAyMQE+e6HsS6YuRuoMJ+u6GJmXj4RXdOfyQiBkM4p9Rm16RyqHT/oCogP+qfGvJfR
 +meI4GszeFPeXzcF+r/tCvtckIhe+kKJrH2EuIg+5QaCvBtzTxWvhMIgd8J7+Mf2t4UM
 4UbViBsFce+RADgZhNJxi8o99GhjmJNlarl1Oa8OigrC4F2FRl+7Pw3ccD4BMPDOZX86
 Iwhwq6ZDwBPf3J99TdBq1uQxm9SY3NU5zx0Nm1buso5U7j/ytg7sGnIi0hkhrYpb6t69
 nnKvSFPlllDyTTOdY84qcUjYJKU8JsTjj9LcO3IHLPcr2birZhrbHFgMLaeJcdjXHl5i
 YY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MuW1HrYB1fRl5RhtcZDvTpRDK6OMWig1ZEWjL4Ok3U8=;
 b=PGOh3pRa2WEOEwytC7NSU9PD+dUccj/+PfvU5N6sqz72fcs/8kZ6b7csudROqaS7Ju
 //t6UBGbOB61yDltgF60DXnWhEf7rzbQifxbjRxWK+VLBuorYgldDhs+8/fUFmMwp3jh
 W1GoZtYYs7w9F80eL/B6VNBzJeL5YOlf6I5vGy+JyowBVU2cTXcBW3oRuB2pH+t0lhGV
 0+6EC6CFjfhn6JH/6QvIOsNYE+XMcRWddfJIBoo6c2F2vKQDWT+GwKuQQHpM8se8IYJq
 bjqhuPkRwOa0W8U/L43p5KPDAgYVEXNwIheKdBeZe0R+aDmlGy3PMg5VHSeXJlnR3JER
 dJFw==
X-Gm-Message-State: APjAAAVgsA4Et9Mab0rCAbJGVq8qAfM1cUOSNlhfkAHEG3OSDCAfZ0W6
 poovZO2Z1XKEr6ixuRvmzDlo+DyQzHA7Ip6ygOg3zvzl
X-Google-Smtp-Source: APXvYqzQiniKWdpuAi+d8f9C8cmDuCJ+tHW3OgtjCJlcWZANM5Q//FOq6aWBuqovWetwnaPx7fTGrXMo3uNd0ZGWIvM=
X-Received: by 2002:a19:cbd2:: with SMTP id b201mr2873627lfg.192.1573142948505; 
 Thu, 07 Nov 2019 08:09:08 -0800 (PST)
MIME-Version: 1.0
References: <20191106130309.6737-1-jandryuk@gmail.com>
 <157308892815.21358.10901801479118764429@37313f22b938>
In-Reply-To: <157308892815.21358.10901801479118764429@37313f22b938>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Thu, 7 Nov 2019 11:08:57 -0500
Message-ID: <CAKf6xpudC7Ke20NpqPuUEJprbB7GsGbUT9vLUKPeTp9Ujdu7=w@mail.gmail.com>
Subject: Re: [PATCH] qmp: Reset mon->commands on CHR_EVENT_CLOSED
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 8:08 PM <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20191106130309.6737-1-jandryuk@gmai=
l.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the t=
esting commands and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.
>
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
>   TEST    iotest-qcow2: 268
> Failures: 060 071 176 184
> Failed 4 of 108 iotests
> make: *** [check-tests/check-block.sh] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 662, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Dcb707bce0c3c456d8ecec70aeb08fddc', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '=
/var/tmp/patchew-tester-tmp-mxl5_jec/src/docker-src.2019-11-06-19.55.47.207=
36:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']'=
 returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Dcb707bce0c3c456d8ece=
c70aeb08fddc
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-mxl5_jec/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    13m1.810s
> user    0m8.371s
>
>
> The full log is available at
> http://patchew.org/logs/20191106130309.6737-1-jandryuk@gmail.com/testing.=
docker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

The full logs shows iotest failures:

Failures: 060 071 176 184
Failed 4 of 108 iotests

The failures are the lack of SHUTDOWN events:
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP},
"event": "SHUTDOWN", "data": {"guest": false, "reason":
"host-qmp-quit"}}

The results are inconsistent though.  On my workstation, for one run I
had test 071 fail, but the others pass.  On another couple of runs,
they all passed.  An a final one, 176 failed.

Looking at 071, they all send a qmp command to exit, but only some of
the tests have an expected shutdown event.  Looking more broadly, it
seems like tests expect shutdown events.

I don't know the code flow, but is it possible on shutdown for the
chardev to be marked closed before the QMP event is generated?  After
this patch, those would not be sent.  If "quit" is expected to always
generate a QMP event, it seems like some ordering needs to be
enforced.

For the tests, the QMP input comes from a shell "here document" ('<<
EOF'), so I suppose stdin could read EOF and mark the chardev closed
before the QMP event is generated.  Before this change, QMP events
would still be generated and stdout would still be connected. Indeed,
chardev/char-fd.c:fd_chr_read() closes the chardev on stdio EOF
regardless of stdout state.

Regards,
Jason

