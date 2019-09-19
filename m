Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 359F6218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 359F6218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsRy-00022Y-OJ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAsCt-0001Cf-95
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>) id 1iAsCs-0005jE-2B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 04:54:31 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55166)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <dovgaluk@ispras.ru>)
 id 1iAsCp-0005iB-3j; Thu, 19 Sep 2019 04:54:27 -0400
Received: from PASHAISP (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 73F71540081;
 Thu, 19 Sep 2019 11:54:23 +0300 (MSK)
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20190918153335.20797-1-alex.bennee@linaro.org>
In-Reply-To: <20190918153335.20797-1-alex.bennee@linaro.org>
Date: Thu, 19 Sep 2019 11:54:27 +0300
Message-ID: <001801d56ec7$d80940d0$881bc270$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdVuNoszH7q5RfvASfiDKqZTDLZgqwAkGOsg
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
Subject: Re: [Qemu-devel] [PATCH] tests/tcg: add simple record/replay smoke
 test for aarch64
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
Cc: 'Peter Maydell' <peter.maydell@linaro.org>,
 "'open list:ARM TCG CPUs'" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks!

This seem to correctly run record and replay command lines.
When I break the replay correctness, then the test reports a timeout =
error.

However, we need some kind of a manual for tcg testing. I had to dig =
through makefile and configure
scripts to undestand that testing needs the cross compilers to be =
installed.
Then I installed a random cross compiler and everything worked normally.

Pavel Dovgalyuk

> -----Original Message-----
> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Sent: Wednesday, September 18, 2019 6:34 PM
> To: qemu-devel@nongnu.org
> Cc: Alex Benn=C3=A9e; Pavel Dovgalyuk; Peter Maydell; open list:ARM =
TCG CPUs
> Subject: [PATCH] tests/tcg: add simple record/replay smoke test for =
aarch64
>=20
> This adds two new tests that re-use the memory test to check basic
> record replay functionality is still working. We have to define our
> own runners rather than using the default pattern as we want to change
> the test name but re-use the memory binary.
>=20
> We declare the test binaries as PHONY as they don't rely exist.
>=20
> [AJB: A better test would output some sort of timer value or other
> otherwise variable value so we could compare the record and replay
> outputs and ensure they match]
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
> ---
>  tests/tcg/aarch64/Makefile.softmmu-target | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/tests/tcg/aarch64/Makefile.softmmu-target =
b/tests/tcg/aarch64/Makefile.softmmu-
> target
> index 4c4aaf61dd3..b4b39579634 100644
> --- a/tests/tcg/aarch64/Makefile.softmmu-target
> +++ b/tests/tcg/aarch64/Makefile.softmmu-target
> @@ -32,3 +32,24 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
>=20
>  # Running
>  QEMU_OPTS+=3D-M virt -cpu max -display none -semihosting-config
> enable=3Don,target=3Dnative,chardev=3Doutput -kernel
> +
> +# Simple Record/Replay Test
> +.PHONY: memory-record
> +run-memory-record: memory-record memory
> +	$(call run-test, $<, \
> +	  $(QEMU) -monitor none -display none \
> +		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
> +		  -icount shift=3D5$(COMMA)rr=3Drecord$(COMMA)rrfile=3Drecord.bin \
> +	   	  $(QEMU_OPTS) memory, \
> +	  "$< on $(TARGET_NAME)")
> +
> +.PHONY: memory-replay
> +run-memory-replay: memory-replay run-memory-record
> +	$(call run-test, $<, \
> +	  $(QEMU) -monitor none -display none \
> +		  -chardev file$(COMMA)path=3D$<.out$(COMMA)id=3Doutput \
> +		  -icount shift=3D5$(COMMA)rr=3Dreplay$(COMMA)rrfile=3Drecord.bin \
> +	   	  $(QEMU_OPTS) memory, \
> +	  "$< on $(TARGET_NAME)")
> +
> +TESTS+=3Dmemory-record memory-replay
> --
> 2.20.1



