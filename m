Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B798C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96A1A206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 15:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A1A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44948 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYYK5-0006cy-NT
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 11:59:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYYIv-000613-7z
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:58:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1hYYIs-0002OM-MG
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 11:58:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>)
	id 1hYYIh-0000xy-UR; Wed, 05 Jun 2019 11:58:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F71230BC577;
	Wed,  5 Jun 2019 15:57:24 +0000 (UTC)
Received: from localhost.localdomain (ovpn-121-163.rdu2.redhat.com
	[10.10.121.163])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6919E5C260;
	Wed,  5 Jun 2019 15:57:19 +0000 (UTC)
Date: Wed, 5 Jun 2019 11:57:17 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Message-ID: <20190605155717.GA7080@localhost.localdomain>
References: <20190520220635.10961-1-f4bug@amsat.org>
	<20190520220635.10961-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190520220635.10961-2-f4bug@amsat.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Wed, 05 Jun 2019 15:57:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] BootLinuxConsoleTest: Do not log empty
 lines
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
	Caio Carrara <ccarrara@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 21, 2019 at 12:06:34AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Avoid to log empty lines in console debug logs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/acceptance/boot_linux_console.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/=
boot_linux_console.py
> index d5c500ea30..f593f3858e 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -37,8 +37,10 @@ class BootLinuxConsole(Test):
>          console =3D self.vm.console_socket.makefile()
>          console_logger =3D logging.getLogger('console')
>          while True:
> -            msg =3D console.readline()
> -            console_logger.debug(msg.strip())
> +            msg =3D console.readline().strip()
> +            if not msg:
> +                continue
> +            console_logger.debug(msg)
>              if success_message in msg:
>                  break
>              if failure_message in msg:
> --=20
> 2.19.1
>=20

This is particularly useful in the boot_linux_console.py:BootLinuxConsole=
.test_s390x_s390_ccw_virtio test, where in my experience empty lines were=
 being logged.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

