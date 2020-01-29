Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC66C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F022206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvWYpiFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F022206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwryM-000766-9B
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 13:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iwrxc-0006B8-8W
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:21:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iwrxa-00087w-9x
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:21:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27026
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iwrxa-00085t-5L
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580322065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkkUJNWNjNSk8IA3JDq8UQgoEpsrirxL5005cMBFP6Y=;
 b=cvWYpiFaVZsVYmUX+sUnrJ5MtdxPm2oa/r99+7mrjPo4wC7i2UyAVkk8DR0VQBGV58gsVK
 xsPkCQ3kSWMhBHcDoScHs1M2eysUMLpgGB9PAZ+KLd3/eGNaODQ36L1NgDfc62IN06Fomt
 vP35xo3kU2dYSzC+3SdSm6E3K6Mmg0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299--iv4DRlkO5KEIA8wqLkcXw-1; Wed, 29 Jan 2020 13:21:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DDF800D41;
 Wed, 29 Jan 2020 18:21:00 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-51.gru2.redhat.com
 [10.97.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75F195DA7B;
 Wed, 29 Jan 2020 18:20:57 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests/boot_console: Send <carriage return> on serial
 lines
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191010122128.29000-1-f4bug@amsat.org>
 <20191010122128.29000-2-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <22ab02fc-0e2c-f684-c257-8a0734a9af0d@redhat.com>
Date: Wed, 29 Jan 2020 16:20:54 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191010122128.29000-2-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: -iv4DRlkO5KEIA8wqLkcXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>,
 Sven Schnelle <svens@stackframe.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/10/19 9:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Some firmwares don't parse the <Newline> control character and
> expect a <carriage return>.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/acceptance/boot_linux_console.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index 8a9a314ab4..f05452824e 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,7 +51,7 @@ class BootLinuxConsole(Test):
>                   self.fail(fail)
>  =20
>       def exec_command_and_wait_for_pattern(self, command, success_messag=
e):
> -        command +=3D '\n'
> +        command +=3D '\r\n'
>           self.vm.console_socket.sendall(command.encode())
>           self.wait_for_console_pattern(success_message)
>  =20

This doesn't apply anymore since exec_command_and_wait_for_pattern() is=20
now part of the avocado_qemu module.

I'm little worried about this breaking the current tests that use the=20
method. Could you please run those tests before putting it on the pull=20
request, Philippe?

Besides that, this change looks good to me:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


