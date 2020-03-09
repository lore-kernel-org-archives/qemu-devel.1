Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A393C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 292AB20873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3dEHnBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292AB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBPQI-00083y-CD
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBPPZ-0007bK-Ru
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBPPY-0000Ym-Bg
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:54:05 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:33060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBPPY-0000YQ-3u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:54:04 -0400
Received: by mail-ot1-x32b.google.com with SMTP id g15so4937084otr.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j7HNl+3iX314cOvpPmh8SxmKrff7P4cAYTIorD1VxVQ=;
 b=f3dEHnBHbEH+5W/z7QIz8mAwWiEE/zQLhhm5du4RkqmKkcdke+r3M7weLrpw/oFVOD
 1U9vjuHcrj/XGDNysSoodhsmxluI6ElJH77B4/Rr04/XADyJ04oJehPYuwEOmhK7k2fh
 4vbCN1z/e8FxAszLVppwOyCcT1uR2Y8OAjzZnMt3+6FpGkM1GryB1uxEAad7oCkaMRET
 oZorhSDjd5Di+wc/8JQzj11iGRN1+p56cpSC/Srbc37mwfrzMlihURIueNlKefw6ng/R
 TUf6/f25ti5pc1eCPEkvBXMrgoc4oRqNpyz49HZGORHFYhbggv5InQlNiMy85KZGboVx
 JC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j7HNl+3iX314cOvpPmh8SxmKrff7P4cAYTIorD1VxVQ=;
 b=VFmac0KFKrcNKOc8wE5cAoktzKffeX6o3lFm0AoTHIsn+na1OVh1uAwWOnfzi3JauM
 4yiKAhdBs1hiPC5eShKSFkVpEWDXviKZOlQjF/XVIZXUvdJHD+2owRqQbcGYeuH4KMAw
 wxSeBwmv1unMxcqPq0qTuYCtzp0HTjYlKp57BWLfrJtM9bApj87Yx1578GOlMwRLsTQu
 3TU9yAT8+ZTWkuUlysPTPXvL4vPfTPmzHRDP7duwgGjdIYCoux1o3EGUmmGEhXR6z3nB
 uMKjAaRWYvVCuFQHXgISuOY5vjL6qzIAcPEqgu5+0czC82CZ3eUGZg+1HeJ0DY0W4Jfh
 /AWA==
X-Gm-Message-State: ANhLgQ1ribr5/sph0egPp3wALd3N7JHgZx0H3rRxeaxfbwrHuFUvDCum
 fTM8OcbmyMnJa8A7NU+KY2n8S1ihOc4gb8KLlVtbNbg3QtI=
X-Google-Smtp-Source: ADFU+vsu0pI+Blf1joqaDHfQYT4OpohKekum6RLDIkRZ2CD0DLI7TtxUraXsq241P1QslYVzZ9FCmm0icH2ZxiI+bvY=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr3616849otq.232.1583787242829; 
 Mon, 09 Mar 2020 13:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200309194650.160552-1-dgilbert@redhat.com>
 <158378679131.20878.15191150168369473187@39012742ff91>
In-Reply-To: <158378679131.20878.15191150168369473187@39012742ff91>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 20:53:51 +0000
Message-ID: <CAFEAcA_q+VrpURmMiVH=_9hYreWeQQuM0dxXz7ERa9eLqGWXfw@mail.gmail.com>
Subject: Re: [PULL 00/12] hmp queue
To: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Mar 2020 at 20:48, <no-reply@patchew.org> wrote:
>
> Patchew URL: https://patchew.org/QEMU/20200309194650.160552-1-dgilbert@re=
dhat.com/
>
>
>
> Hi,
>
> This series failed the asan build test. Please find the testing commands =
and
> their output below. If you have Docker installed, you can probably reprod=
uce it
> locally.

Hi Paolo -- looks like the 'asan' patchew config is also running into
the dbus-daemon problem :-(

Can we disable the offending test in 'make check' so we don't need
to disable the entire patchew config, maybe?

thanks
-- PMM
(trimmed patchew output below)

> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> export ARCH=3Dx86_64
> make docker-image-fedora V=3D1 NETWORK=3D1
> time make docker-test-debug@fedora TARGET_LIST=3Dx86_64-softmmu J=3D14 NE=
TWORK=3D1
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D

[...]

> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/drive_del-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"drive_del-test"
> PASS 1 drive_del-test /x86_64/drive_del/without-dev
> PASS 2 drive_del-test /x86_64/drive_del/after_failed_device_add
> =3D=3D9151=3D=3DWARNING: ASan doesn't fully support makecontext/swapconte=
xt functions and may produce false positives in some cases!
> PASS 3 drive_del-test /x86_64/blockdev/drive_del_device_del
> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}  QTEST=
_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=3Dqemu-img =
tests/qtest/wdt_ib700-test -m=3Dquick -k --tap < /dev/null | ./scripts/tap-=
driver.pl --test-name=3D"wdt_ib700-test"
> PASS 1 wdt_ib700-test /x86_64/wdt_ib700/pause
> ---
> dbus-daemon[9321]: Could not get password database information for UID of=
 current process: User "???" unknown or no memory to allocate password entr=
y
>
> **
> ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.c:114:get_connecti=
on: assertion failed (err =3D=3D NULL): The connection is closed (g-io-erro=
r-quark, 18)
> cleaning up pid 9321
> ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/dbus-vmstate-test.=
c:114:get_connection: assertion failed (err =3D=3D NULL): The connection is=
 closed (g-io-error-quark, 18)
> make: *** [/tmp/qemu-test/src/tests/Makefile.include:632: check-qtest-x86=
_64] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 664, in <module>
> ---
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '=
--label', 'com.qemu.instance.uuid=3D88b7cca75c974326a7bec1f2d1a837c5', '-u'=
, '1003', '--security-opt', 'seccomp=3Dunconfined', '--rm', '-e', 'TARGET_L=
IST=3Dx86_64-softmmu', '-e', 'EXTRA_CONFIGURE_OPTS=3D', '-e', 'V=3D', '-e',=
 'J=3D14', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D', '-e', 'CCACHE_DIR=3D/var/=
tmp/ccache', '-v', '/home/patchew2/.cache/qemu-docker-ccache:/var/tmp/ccach=
e:z', '-v', '/var/tmp/patchew-tester-tmp-swu9ovfa/src/docker-src.2020-03-09=
-16.18.07.16195:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 't=
est-debug']' returned non-zero exit status 2.
> filter=3D--filter=3Dlabel=3Dcom.qemu.instance.uuid=3D88b7cca75c974326a7be=
c1f2d1a837c5
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory `/var/tmp/patchew-tester-tmp-swu9ovfa/src'
> make: *** [docker-run-test-debug@fedora] Error 2
>
> real    28m23.541s
> user    0m8.580s
>
>
> The full log is available at
> http://patchew.org/logs/20200309194650.160552-1-dgilbert@redhat.com/testi=
ng.asan/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com

