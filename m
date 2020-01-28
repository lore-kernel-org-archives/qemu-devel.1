Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861102070A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iZafE3F+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861102070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37039 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwX39-0001wn-PE
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwX1g-0000vm-RC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwX1f-0005J6-Mv
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:59:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwX1f-0005Gb-Jw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 14:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580241595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeEKSXYR1Ji59qMJtA9DX5BYeqKl2VtTGJxQarbmB+A=;
 b=iZafE3F+spd1lhmuLJ1i1u/ckzBzmJtmTMT5YPd7ra0AqzSeNzA+Tb1d6g9r11GIDXYUD4
 8/WMRsVdqDg6uh+8UP5EhOpbUrFlbX/lKqVQk+LJ4LT9uDz2T5uPoh3bsVfeMY7v/N8PKC
 Z8BI/NE/nm/tK8+hmugz/f0Qfly5eWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-HFIrU1QOMgavX5y24yFsaA-1; Tue, 28 Jan 2020 14:59:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80CCE8010F2;
 Tue, 28 Jan 2020 19:59:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-65.gru2.redhat.com
 [10.97.116.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD58B19486;
 Tue, 28 Jan 2020 19:59:42 +0000 (UTC)
Subject: Re: [PATCH v4 3/7] Acceptance tests: Add
 interrupt_interactive_console_until_pattern()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200120235159.18510-1-f4bug@amsat.org>
 <20200120235159.18510-4-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <3516f76f-8ac6-be45-16f0-c7846264a594@redhat.com>
Date: Tue, 28 Jan 2020 17:59:40 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200120235159.18510-4-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HFIrU1QOMgavX5y24yFsaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/20/20 9:51 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> We need a function to interrupt interactive consoles.
>
> Example: Interrupt U-Boot to set different environment values.
>
> Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 32 +++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 0a50fcf2be..d4358eb431 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -56,13 +56,15 @@ def pick_default_qemu_bin(arch=3DNone):
>  =20
>  =20
>   def _console_interaction(test, success_message, failure_message,
> -                         send_string):
> +                         send_string, keep_sending=3DFalse):
> +    assert not keep_sending or send_string
>       console =3D test.vm.console_socket.makefile()
>       console_logger =3D logging.getLogger('console')
>       while True:
>           if send_string:
>               test.vm.console_socket.sendall(send_string.encode())
> -            send_string =3D None # send only once
> +            if not keep_sending:
> +                send_string =3D None # send only once
>           msg =3D console.readline().strip()
>           if not msg:
>               continue
> @@ -74,6 +76,32 @@ def _console_interaction(test, success_message, failur=
e_message,
>               fail =3D 'Failure message found in console: %s' % failure_m=
essage
>               test.fail(fail)
>  =20
> +def interrupt_interactive_console_until_pattern(test, success_message,
> +                                                failure_message=3DNone,
> +                                                interrupt_string=3D'\r')=
:
> +    """
> +    Keep sending a string to interrupt a console prompt, while logging t=
he
> +    console output. Typical use case is to break a boot loader prompt, s=
uch:
> +
> +        Press a key within 5 seconds to interrupt boot process.
> +        5
> +        4
> +        3
> +        2
> +        1
> +        Booting default image...
> +
> +    :param test: an Avocado test containing a VM that will have its cons=
ole
> +                 read and probed for a success or failure message
> +    :type test: :class:`avocado_qemu.Test`
> +    :param success_message: if this message appears, test succeeds
> +    :param failure_message: if this message appears, test fails
> +    :param interrupt_string: a string to send to the console before tryi=
ng
> +                             to read a new line
> +    """
> +    _console_interaction(test, success_message, failure_message,
> +                         interrupt_string, True)
> +
>   def wait_for_console_pattern(test, success_message, failure_message=3DN=
one):
>       """
>       Waits for messages to appear on the console, while logging the cont=
ent


