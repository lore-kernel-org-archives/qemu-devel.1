Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4124C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C238B20714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 10:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWTC8YVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C238B20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE9aG-0005Yt-U6
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jE9UA-0004y8-Gy
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jE9U8-0003Ti-Sf
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:20095)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jE9U8-0003QR-M6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 06:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584441008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LItzE5+LtCAY5gnPBkGuTscdu6mkriXnuQqoFYxvYM8=;
 b=bWTC8YVQOyLo3E61avGrJX3jA/MzGle3r/L1lJVFjfB3wEQ7V7k44MuVPdzJSyahRSmqPU
 amuntNHjZ9UBjJA9OXIJV3fg4DVJEPScSjMkwWTK/qqbAUXxW6Why8C+FD4BMEouUFbXGm
 IYgcGCPgSDM8pjDuNQh34uf2vhThuvs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-pMZioqbLOJ6F7IttP2XNuA-1; Tue, 17 Mar 2020 06:30:04 -0400
X-MC-Unique: pMZioqbLOJ6F7IttP2XNuA-1
Received: by mail-wr1-f69.google.com with SMTP id b11so10444363wru.21
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 03:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U4pERgLsSH+Hq2YILmQCBhGUKnco1uq2TEic1W6Crmo=;
 b=HC39xq2BRw7zJEL5G+7Yh/UXsORdf8n2i3SfgIkrjRyD1r7oGP6mgYNxzMTz355Fs2
 E9/PMZdjSZBa33XgJ7o5iJzuGjrA2doeK0LdXwUoJkeI/omJBLz7jzU9OeZDq8B78oNY
 jaAMbh43dLSpChlXM0F8HBgdLwN6ez3nTHGfERIUERROroTaaMhiOQqVeSv0ZnxuucK0
 cA2Xn2LVpRQg2F/CHgT+SUSowQUC/zCGzTF0/VYZ/Qf8t+8uoCyf2r74MqI4sEwAQo9W
 Aw5UGuGch3NTUkEQb4VwoC1EJ9zLU3+ONW78jSsaGtcCMU7zL/R4d2nbuUqGv3fJQjLG
 uZMg==
X-Gm-Message-State: ANhLgQ2bMyO02AkPPBzE+3g4DajL5FYEHCI9mCRbHsqvOfEJ9fPP1S1Y
 7Ta4k0qNRGNWdTeKuLv/uOdlAHk3VYa71v4TfPHj5tEVsagH1i5m4nQdvRw93PGELpy6Go8YXyn
 MDcbsoZDHw7VNAQY=
X-Received: by 2002:a5d:6146:: with SMTP id y6mr5357690wrt.107.1584441003545; 
 Tue, 17 Mar 2020 03:30:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuBMUsyhAjjnQdbMWYOiDBzKYIp8AvJka6VWjwYEEpSGGOXHICf7vdCk5jRM9E3FW2LWVh/4Q==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr5357674wrt.107.1584441003361; 
 Tue, 17 Mar 2020 03:30:03 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id x17sm3379108wmi.28.2020.03.17.03.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Mar 2020 03:30:02 -0700 (PDT)
Subject: Re: [PATCH v1 23/28] tests/tcg/aarch64: add a gdbstub testcase for
 SVE registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200316172155.971-1-alex.bennee@linaro.org>
 <20200316172155.971-24-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2515f01-c42b-48e1-7e2d-00a69363aba9@redhat.com>
Date: Tue, 17 Mar 2020 11:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316172155.971-24-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 6:21 PM, Alex Benn=C3=A9e wrote:
> A very simple test case which sets and reads SVE registers while
> running a test case. We don't really need to compile a SVE binary for
> this case but we will later so keep it simple for now.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>=20
> ---
> v5
>    - properly plumb in
>    - skip if fails to connect
> ---
>   tests/.gitignore                      |  1 +
>   tests/tcg/aarch64/Makefile.target     | 15 +++++
>   tests/tcg/aarch64/gdbstub/test-sve.py | 81 +++++++++++++++++++++++++++
>   3 files changed, 97 insertions(+)
>   create mode 100644 tests/tcg/aarch64/gdbstub/test-sve.py
>=20
> diff --git a/tests/.gitignore b/tests/.gitignore
> index 7306866f216..d03c037d772 100644
> --- a/tests/.gitignore
> +++ b/tests/.gitignore
> @@ -10,6 +10,7 @@ qht-bench
>   rcutorture
>   test-*
>   !test-*.c
> +!test-*.py
>   !docker/test-*
>   test-qapi-commands.[ch]
>   test-qapi-init-commands.[ch]
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index a25afc071cc..b61b53e4dd1 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -46,6 +46,21 @@ ifneq ($(DOCKER_IMAGE)$(CROSS_CC_HAS_SVE),)
>   # System Registers Tests
>   AARCH64_TESTS +=3D sysregs
>   sysregs: CFLAGS+=3D-march=3Darmv8.1-a+sve
> +
> +ifneq ($(HAVE_GDB_BIN),)
> +GDB_SCRIPT=3D$(SRC_PATH)/tests/guest-debug/run-test.py
> +
> +AARCH64_TESTS +=3D gdbstub-sysregs
> +
> +.PHONY: gdbstub-sysregs
> +run-gdbstub-sysregs: sysregs
> +=09$(call run-test, $@, $(GDB_SCRIPT) \
> +=09=09--gdb $(HAVE_GDB_BIN) \
> +=09=09--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
> +=09=09--bin $< --test $(AARCH64_SRC)/gdbstub/test-sve.py, \
> +=09"basic gdbstub SVE support")
> +endif
> +
>   endif
>  =20
>   TESTS +=3D $(AARCH64_TESTS)
> diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gd=
bstub/test-sve.py
> new file mode 100644
> index 00000000000..90201d80094
> --- /dev/null
> +++ b/tests/tcg/aarch64/gdbstub/test-sve.py
> @@ -0,0 +1,81 @@
> +from __future__ import print_function
> +#
> +# Test the SVE registers are visable and changeable via gdbstub
> +#
> +# This is launched via tests/guest-debug/run-test.py
> +#
> +
> +import gdb
> +import sys
> +
> +MAGIC =3D 0xDEADBEEF
> +
> +failcount =3D 0
> +
> +def report(cond, msg):
> +    "Report success/fail of test"
> +    if cond:
> +        print ("PASS: %s" % (msg))
> +    else:
> +        print ("FAIL: %s" % (msg))
> +        global failcount
> +        failcount +=3D 1
> +
> +def run_test():
> +    "Run through the tests one by one"
> +
> +    gdb.execute("info registers")
> +    report(True, "info registers")
> +
> +    gdb.execute("info registers vector")
> +    report(True, "info registers vector")
> +
> +    # Now all the zregs
> +    frame =3D gdb.selected_frame()
> +    for i in range(0, 32):
> +        rname =3D "z%d" % (i)
> +        zreg =3D frame.read_register(rname)
> +        report(True, "Reading %s" % rname)
> +        for j in range(0, 4):
> +            cmd =3D "set $%s.q.u[%d] =3D 0x%x" % (rname, j, MAGIC)
> +            gdb.execute(cmd)
> +            report(True, "%s" % cmd)
> +        for j in range(0, 4):
> +            reg =3D "$%s.q.u[%d]" % (rname, j)
> +            v =3D gdb.parse_and_eval(reg)
> +            report(str(v.type) =3D=3D "uint128_t", "size of %s" % (reg))
> +        for j in range(0, 8):
> +            cmd =3D "set $%s.d.u[%d] =3D 0x%x" % (rname, j, MAGIC)
> +            gdb.execute(cmd)
> +            report(True, "%s" % cmd)
> +        for j in range(0, 8):
> +            reg =3D "$%s.d.u[%d]" % (rname, j)
> +            v =3D gdb.parse_and_eval(reg)
> +            report(str(v.type) =3D=3D "uint64_t", "size of %s" % (reg))
> +            report(int(v) =3D=3D MAGIC, "%s is 0x%x" % (reg, MAGIC))
> +
> +#
> +# This runs as the script it sourced (via -x, via run-test.py)
> +#
> +try:
> +    inferior =3D gdb.selected_inferior()
> +    arch =3D inferior.architecture()
> +    report(arch.name() =3D=3D "aarch64", "connected to aarch64")
> +except (gdb.error, AttributeError):
> +    print("SKIPPING (not connected)", file=3Dsys.stderr)
> +    exit(0)
> +
> +try:
> +    # These are not very useful in scripts
> +    gdb.execute("set pagination off")
> +    gdb.execute("set confirm off")
> +
> +    # Run the actual tests
> +    run_test()
> +except:
> +    print ("GDB Exception: %s" % (sys.exc_info()[0]))
> +    failcount +=3D 1
> +
> +print("All tests complete: %d failures" % failcount)
> +
> +exit(failcount)
>=20


