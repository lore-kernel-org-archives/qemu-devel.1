Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47D8C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ABB324673
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 04:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgJpvHg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ABB324673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuUYj-0002Vh-Fs
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 23:57:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuUY6-00020o-2j
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:56:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuUY4-0003hy-6S
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:56:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39700
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuUY4-0003gh-2Z
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 23:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579755415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=d99YhoPkiXFx61RJGFaj73S8dt/TyKjeSwwEtWpr/7U=;
 b=UgJpvHg8QYWc5CbMEIb+Aw9yWXMPQn8jJw6qGkcflx6JQ5Bih6BdI3k0gGFCBlV7i9vjN3
 a2Gofkc7Ybhl1cAI2OSITSj9wUehFSL7AbiDzOJPToPjd1PClkGT5H1PkxPpsBk4huq8oy
 K+fpWSGaWXZzX7YpHj/Xbs/A+Tgba8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-2tXPqHN3O9i2WY0AFCoYRw-1; Wed, 22 Jan 2020 23:56:50 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6EEB8017CC;
 Thu, 23 Jan 2020 04:56:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5482898C;
 Thu, 23 Jan 2020 04:56:45 +0000 (UTC)
Subject: Re: [PATCH rc1 14/24] target/avr: Add section about AVR into QEMU
 documentation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-15-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <486b80d9-4f11-0888-7327-d6a72f2bb67c@redhat.com>
Date: Thu, 23 Jan 2020 05:56:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200123000307.11541-15-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 2tXPqHN3O9i2WY0AFCoYRw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: S.E.Harris@kent.ac.uk, me@xcancerberox.com.ar, dovgaluk@ispras.ru,
 imammedo@redhat.com, mrolnik@gmail.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 01.02, Richard Henderson wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 39f950471f..515aacfae9 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1741,6 +1741,7 @@ differences are mentioned in the following sections.
>  * Microblaze System emulator::
>  * SH4 System emulator::
>  * Xtensa System emulator::
> +* AVR System emulator::
>  @end menu
>  
>  @node PowerPC System emulator
> @@ -2514,6 +2515,56 @@ so should only be used with trusted guest OS.
>  
>  @c man end
>  
> +@node AVR System emulator
> +@section AVR System emulator
> +@cindex system emulation (AVR)
> +
> +Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based machine having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and xmega7.
> +
> +As for now it does not support any real MCUs. However, it does support a "sample" board for educational and testing purposes. This "sample" board hosts USART & 16 bit timer devices and it's enought to run FreeRTOS based applicaton (like this @url{https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf,,demo})

The "sample" board has been replaced by the boards that Philippe added,
hasn't it? In that case, the above sentence should be adjusted accordingly.

> +Following are examples of possible usages, assuming program.elf is compiled for AVR cpu
> +@itemize
> +
> +@item Continious non interrupted execution

s/Continious/Continuous/

> +@example
> +qemu-system-avr -kernel program.elf
> +@end example
> +
> +@item Continious non interrupted execution with serial output into telnet window

s/Continious/Continuous/

> +@example
> +qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nographic
> +@end example
> +and then in another shell
> +@example
> +telent localhost 5678

s/telent/telnet/

> +@end example
> +
> +@item Continious non interrupted execution with serial output into stdout

s/Continious/Continuous/

> +@example
> +qemu-system-avr -kernel program.elf -serial stdio
> +@end example

... and I'm not sure whether we really need multiple examples for
"-serial" here ... one should be enough, "-serial" is described
somewhere else in the documentation already.

> +@item Debugging wit GDB debugger
> +@example
> +qemu-system-avr -kernel program.elf -s -S
> +@end example
> +and then in another shell
> +@example
> +avr-gdb program.elf
> +@end example
> +and then within GDB shell
> +@example
> +target remote :1234
> +@end example
> +
> +@item Print out executed instructions
> +@example
> +qemu-system-avr -kernel program.elf -d in_asm
> +@end example
> +
> +@end itemize
> +
>  @node QEMU User space emulator
>  @chapter QEMU User space emulator

 Thomas


