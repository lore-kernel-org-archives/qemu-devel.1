Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95090C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C41A20718
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 07:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMLLVtH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C41A20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iutBN-0006Gx-Go
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 02:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iutAl-0005jQ-3x
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:14:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iutAj-00064Z-OD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:14:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iutAj-00063G-Kw
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 02:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579850069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cQ9gL/KOwh3t5IosdL0LXKwdsA6JTafa+gJobfej92A=;
 b=OMLLVtH8sRYyGWz9IkE9FOUftwwdjQhfZtJ9TlMqMJolSkd7rDLQFiL2lFxs5Y6ug/fYlx
 7d38N/PPi+cED+0rjEQsHG+3Y80B6q7dCEGRvrE25Uks/uJUhrX4RiSIZhuo3TpbPIqCIq
 pbrXtBe1aVPM5hv6O7aDkS5qbFUcKEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-Kj88nHq1NjmORWbJCDk4yQ-1; Fri, 24 Jan 2020 02:14:26 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D35E1882CC0;
 Fri, 24 Jan 2020 07:14:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D3F35D9E2;
 Fri, 24 Jan 2020 07:14:13 +0000 (UTC)
Subject: Re: [PATCH rc2 14/25] target/avr: Add section about AVR into QEMU
 documentation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-15-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <50348fa2-0fda-78fd-ad64-f7cc94d6d158@redhat.com>
Date: Fri, 24 Jan 2020 08:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124005131.16276-15-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Kj88nHq1NjmORWbJCDk4yQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 01.51, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [PMD: Fixed typos]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> rc2: Fixed typos, s/sample/Arduino/, removed -serial section (thuth)
> ---
>  qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 39f950471f..89df1d325e 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1741,6 +1741,7 @@ differences are mentioned in the following sections=
.
>  * Microblaze System emulator::
>  * SH4 System emulator::
>  * Xtensa System emulator::
> +* AVR System emulator::
>  @end menu
> =20
>  @node PowerPC System emulator
> @@ -2514,6 +2515,56 @@ so should only be used with trusted guest OS.
> =20
>  @c man end
> =20
> +@node AVR System emulator
> +@section AVR System emulator
> +@cindex system emulation (AVR)
> +
> +Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit based =
machine
> +having one for the following cores: avr1, avr2, avr25, avr3, avr31, avr3=
5, avr4,
> +avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5, xmega6 and x=
mega7.
> +
> +As for now it supports few Arduino boards for educational and testing pu=
rposes.
> +These boards use a ATmega controller, which model is limited to USART & =
16 bit
> +timer devices, enought to run FreeRTOS based applications (like this @ur=
l{https://github.com/seharris/qemu-avr-tests/blob/master/free-rtos/Demo/AVR=
_ATMega2560_GCC/demo.elf,,demo})
> +
> +Following are examples of possible usages, assuming program.elf is compi=
led for
> +AVR cpu
> +@itemize
> +
> +@item Continuous non interrupted execution
> +@example
> +qemu-system-avr -kernel program.elf
> +@end example
> +
> +@item Continuous non interrupted execution with serial output into telne=
t window
> +@example
> +qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -nog=
raphic
> +@end example
> +and then in another shell
> +@example
> +telnet localhost 5678
> +@end example
> +
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

If you don't have a default board anymore, I think you need to list -M
here, too.
And didn't you mention that -kernel is not working anyway? Do you need
to replace it with -bios ?

 Thomas


