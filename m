Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5377EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19464206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u+Xg5ksc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19464206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiETW-0007ta-DO
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiEHo-0007aK-J9
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:44 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:33271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiEHk-0002NX-0Y
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 05:41:44 -0400
Received: by mail-wr1-x42e.google.com with SMTP id l11so16648733wru.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qnNEavQ1EUeAgIJNVEgFBp92MTwLoTDdtGhC7GxpY6g=;
 b=u+Xg5kscSi8BJQ2EIGpHaoJXYZbX1eV/Xxxk3sokJNTAPZlKkhMcJgrSr58K5fiowm
 gdI6FSpP6mRSbtRNTU4WU6zLhgsdFtuBeYiEr7/DrkNPT1RNRAz9U1GeIYGzOyN7I5YS
 51S19irx9wthwSNp0lrywgNM7fU1W1EjO56SIg/YzmNB3eITGmUyUQG9Ae5xPyQqISZf
 OgsVVubUL31dWp9Nspq8E1kVzWynLIiAcV0nVD4i3nu9QeAlQNyinxNn6mqm3nHFXIfc
 sFXo+xZuuxZdIQhaMK92kI8ZAMe/ldelt0srtXH2r9bnB8qPV+kd+dmZSlkf947sDQZZ
 UuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qnNEavQ1EUeAgIJNVEgFBp92MTwLoTDdtGhC7GxpY6g=;
 b=EikpBMRJ7mxeIdOl4/zZUqOJY9GU75jriHKUz5a2P+GgA0KvRDsyZBV1UIFsZH+s5u
 zYDuBGE81Cl+sLChZ8/Uk+2BsGwzCPdNVbf3XCZkXzLWtUFWJEpUtkkalGmEgZ/QbXRE
 tTu4Y+E46hnbrGB3Slo1Se0FZ/IjIrYp5R7gKuf933z3utd+Df9t2SmW0BWeLEMizkmh
 lOwBmhyrOXhmacC57spibqEr+c3JASbYWARKCNa9x0k2zD1yVOwFPXc4CSw3aosmFNL2
 LH7lF61uJiIUpHXLJNMu7FSVqVzHlHZ9++ws4FQfsCriBQGhHY6g4aRC2RVeKq57rSWu
 2J3w==
X-Gm-Message-State: AOAM533/YceSycZHVhATpDclnGDNL5hMYvtfS2GQAdb/NeEmrzTf6TZi
 y1IS5EDpB0qlmS9NCM9vGHcSHBIOVXwPImtau+yOVDDx
X-Google-Smtp-Source: ABdhPJznTdxvCq2Rl4hn8di31gw2VGu7ESiu5o/ffqwTFieKJnmz7NX28oTTKO52IbUxsPRlIRZf4elmKjq6HkEws48=
X-Received: by 2002:a5d:4385:: with SMTP id i5mr22105070wrq.420.1591609297677; 
 Mon, 08 Jun 2020 02:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <159156173139.32466.16783549689356647947@45ef0f9c86ae>
In-Reply-To: <159156173139.32466.16783549689356647947@45ef0f9c86ae>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 8 Jun 2020 11:41:25 +0200
Message-ID: <CAHiYmc7YcqL0kTgUVts6rgcEghLyfGfVKP5Mf9H_HM=ZpJd5Tw@mail.gmail.com>
Subject: Re: [PULL 00/21] MIPS queue for June 7th, 2020
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 7. =D1=98=D1=83=D0=BD 2020. =D1=83 22:29 <no-reply@patc=
hew.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=
=B0:
>
> Patchew URL: https://patchew.org/QEMU/1591559185-31287-1-git-send-email-a=
leksandar.qemu.devel@gmail.com/
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

I took a look at logs, my conclusion is that the failure is either
test or test environment issue.

There is no, even remote, logical connection between changes in this
pull request and any reported failures.

Thanks,
Aleksandar

> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> make docker-image-centos7 V=3D1 NETWORK=3D1
> time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>
> --- /tmp/qemu-test/src/tests/qemu-iotests/040.out       2020-06-07 19:56:=
39.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/040.out.bad 2020-06-07 20:21:=
34.803254929 +0000
> @@ -1,3 +1,5 @@
> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/=
qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga non=
e -chardev socket,id=3Dmon,path=3D/tmp/tmp.G5tFM6qSxm/qemu-20664-monitor.so=
ck -mon chardev=3Dmon,mode=3Dcontrol -qtest unix:path=3D/tmp/tmp.G5tFM6qSxm=
/qemu-20664-qtest.sock -accel qtest -nodefaults -display none -accel qtest
> +WARNING:qemu.machine:qemu received signal 9: /tmp/qemu-test/build/tests/=
qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64 -display none -vga non=
e -chardev socket,id=3Dmon,path=3D/tmp/tmp.G5tFM6qSxm/qemu-20664-monitor.so=
ck -mon chardev=3Dmon,mode=3Dcontrol -qtest unix:path=3D/tmp/tmp.G5tFM6qSxm=
/qemu-20664-qtest.sock -accel qtest -nodefaults -display none -accel qtest
>  ...........................................................
>  ----------------------------------------------------------------------
>  Ran 59 tests
> ---
> Not run: 259
> Failures: 040
> Failed 1 of 119 iotests
> make: *** [check-tests/check-block.sh] Error 1
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 665, in <module>
>     sys.exit(main())
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3Df770c887f5824103a4bf9eb1cb4665d2', '-u'=
, '1001', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e', 'J=3D14', '-e=
', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', '-e', 'CCACHE_DIR=3D/var/tmp/ccache', =
'-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/=
var/tmp/patchew-tester-tmp-4e7hhqlp/src/docker-src.2020-06-07-16.13.37.3276=
4:/var/tmp/qemu:z,ro', 'qemu:centos7', '/var/tmp/qemu/run', 'test-quick']' =
returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3Df770c887f5824103a4bf=
9eb1cb4665d2
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-4e7hhqlp/src'
> make: *** [docker-run-test-quick@centos7] Error 2
>
> real    15m14.937s
> user    0m9.503s
>
>
> The full log is available at
> http://patchew.org/logs/1591559185-31287-1-git-send-email-aleksandar.qemu=
.devel@gmail.com/testing.docker-quick@centos7/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

