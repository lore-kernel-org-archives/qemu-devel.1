Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAADC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C8F2071C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3IwjMtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C8F2071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDs1I-0006Pr-DW
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDqXw-0003gJ-7x
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDqXu-0003dW-DN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:16:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDqXu-0003Ki-31
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:16:46 -0400
Received: by mail-wm1-x343.google.com with SMTP id n8so17837656wmc.4
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a+mtKyvXP8jKU2yXEjRlCK2fLYbStgyzukK2SXyELhQ=;
 b=D3IwjMtJAAiqOadrut1MXwmHc2zGNZrxVq6KGsaaJtHWujfl6WJ/P2zXXd3McwIuQP
 vielrGDH8CO4bf6IlIX5X7Nk/9dQ/sjiFIi9e+Jmc38j26LwFDYcPbSbXGpMxI/96Zn3
 LgTvTKuzAHvjDnf9emTv1TOQuLVgBZyXbtwS/gxnEDMMXdMnrcwDXEF5hPlFjw+ZefMn
 guFIoYCjmuVscRnbcQOt7El8ka692Uvjm7fv+6aKy4RNVmbljBeVvgWipI9CdX0AVEfq
 ImnZrFZoARs53HWcj6BLkNLCvmI6hwqelEFRLMSYlbFPE9fggWkCvTz4qk7F/32hlGM8
 Z1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a+mtKyvXP8jKU2yXEjRlCK2fLYbStgyzukK2SXyELhQ=;
 b=U3Wec07N8x0Yg+tc0Xbkq6zu/yMJAc3Gln+CBqEUKs6IfwDC17aHUnsA+Ja+TRktlr
 Pst/YL7yHK2I7Lh3DOo5DjH/UvRmQejjacWd4NJXTdlNLq8X19ODTSf1tls485TAoCll
 i1DSEG9ezeDuiw29kcl0pNNxuTxY+iw/LTX+CIgANnw1ZwZp60QeYiSl8jz0Y4fS6tJB
 vNQ2i68vHuDKK2ewObhVhXiRpVSqSkmatkj+AWRmPFHsJKHh3bBE2n5hY8akYBzHZk7z
 290e/0/BuXoIPR+bOSiIkgHUOPJZy2VTtKWFbfpk0K4oBEjSyrwyg8/5gZo2brlDcOZY
 rx5A==
X-Gm-Message-State: ANhLgQ0ld2SDBwVe9CpW9gaBvZ3wHsMoG0p+4RFqY1Nz4pBZNm7DCAsa
 uU9JSju58dH85IWa0u8tboMR6A==
X-Google-Smtp-Source: ADFU+vviC7kb7Dsoa8eOBGoj79Y5ZXHJKcPdECrnCB98FXebT2bFKfKIDrAFks3sRa23yXOveCA2CQ==
X-Received: by 2002:a1c:2dc7:: with SMTP id
 t190mr28934571wmt.137.1584368204437; 
 Mon, 16 Mar 2020 07:16:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u1sm71900wrt.78.2020.03.16.07.16.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 07:16:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7044A1FF7E;
 Mon, 16 Mar 2020 14:16:42 +0000 (GMT)
References: <20200310083218.26355-1-kraxel@redhat.com>
 <20200310083218.26355-2-kraxel@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] tests/vm: write raw console log
In-reply-to: <20200310083218.26355-2-kraxel@redhat.com>
Date: Mon, 16 Mar 2020 14:16:42 +0000
Message-ID: <87wo7kjsfp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Gerd Hoffmann <kraxel@redhat.com> writes:

> Run "tail -f /var/tmp/*/qemu*console.raw" in another terminal
> to watch the install console.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

I suspect this is what's breaking "make check-acceptance" so I've
dropped the series from testing/next for now.

  2020-03-11 12:12:30,546 stacktrace       L0039 ERROR|
  2020-03-11 12:12:30,546 stacktrace       L0042 ERROR| Reproduced tracebac=
k from: /home/alex.bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6=
/site-packages/avocado/c\
  ore/test.py:860
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| Traceback (most rec=
ent call last):
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages/avoc=
ado/core/test.py", line \
  1456, in test
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     self.error(self=
.exception)
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/all/tests/venv/lib/python3.6/site-packages/avoc=
ado/core/test.py", line \
  1064, in error
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     raise exception=
s.TestError(message)
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| avocado.core.except=
ions.TestError: Traceback (most recent call last):
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/lib/py=
thon3.6/imp.py", line 235, in load_module
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     return load_sou=
rce(name, filename, file)
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/usr/lib/py=
thon3.6/imp.py", line 172, in load_source
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     module =3D _loa=
d(spec)
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen imp=
ortlib._bootstrap>", line 684, in _load
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen imp=
ortlib._bootstrap>", line 665, in _load_unlocked
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen imp=
ortlib._bootstrap_external>", line 678, in exec_module
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "<frozen imp=
ortlib._bootstrap>", line 219, in _call_with_frames_removed
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/all/tests/acceptance/machine_mips_malta.py", li=
ne 15, in <module>
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from avocado_qe=
mu import Test
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/__init__.py",=
 line 22, in <module>
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.machi=
ne import QEMUMachine
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|   File "/home/alex.=
bennee/lsrc/qemu.git/builds/all/tests/acceptance/avocado_qemu/../../../pyth=
on/qemu/machine.py", lin\
  e 27, in <module>
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|     from qemu.conso=
le_socket import ConsoleSocket
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR| ModuleNotFoundError=
: No module named 'qemu.console_socket'
  2020-03-11 12:12:30,547 stacktrace       L0045 ERROR|
  2020-03-11 12:12:30,547 stacktrace       L0046 ERROR|
  2020-03-11 12:12:30,548 test             L0865 DEBUG| Local variables:
  2020-03-11 12:12:30,561 test             L0868 DEBUG|  -> self <class 'av=
ocado.core.test.TestError'>: 1-./tests/acceptance/machine_mips_malta.py:Mal=
taMachineFramebuffer.tes\
  t_mips_malta_i6400_framebuffer_logo_1core


> ---
>  tests/vm/basevm.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
> index 8400b0e07f65..c53fd354d955 100644
> --- a/tests/vm/basevm.py
> +++ b/tests/vm/basevm.py
> @@ -213,6 +213,9 @@ class BaseVM(object):
>      def console_init(self, timeout =3D 120):
>          vm =3D self._guest
>          vm.console_socket.settimeout(timeout)
> +        self.console_raw_path =3D os.path.join(vm._temp_dir,
> +                                             vm._name + "-console.raw")
> +        self.console_raw_file =3D open(self.console_raw_path, 'wb')
>=20=20
>      def console_log(self, text):
>          for line in re.split("[\r\n]", text):
> @@ -234,6 +237,9 @@ class BaseVM(object):
>          while True:
>              try:
>                  chars =3D vm.console_socket.recv(1)
> +                if self.console_raw_file:
> +                    self.console_raw_file.write(chars)
> +                    self.console_raw_file.flush()
>              except socket.timeout:
>                  sys.stderr.write("console: *** read timeout ***\n")
>                  sys.stderr.write("console: waiting for: '%s'\n" % expect)


--=20
Alex Benn=C3=A9e

