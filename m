Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F32C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B8320702
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 18:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyZYfShH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B8320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iws6R-0004jW-Qh
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 13:30:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53756)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iws5A-0003NC-Fq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iws58-0004wN-2V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26829)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iws57-0004vq-NO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 13:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580322532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uh5PuRJd365JE5qC7CqLgTH/WhkQ8tcEuJ1EkMTOHrw=;
 b=JyZYfShH7maPIfoOfqEWuTVYJXD02ZlTx6QWztSJo+I5SN18NT0cXORI0Kuux4i+2kNKZy
 19p/GjgbukStZGjauMRKhbW+09cr7906BSOOeoepivz2zsY0ayzCkYP3a3CvOgdLvz6uDW
 w56IQMV/9dlkcdoHCR7G6pcq70LQmeE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-3FcxH2bBPqCex6kkMDGwnw-1; Wed, 29 Jan 2020 13:28:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51D98107B115;
 Wed, 29 Jan 2020 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-51.gru2.redhat.com
 [10.97.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D902E19C70;
 Wed, 29 Jan 2020 18:28:39 +0000 (UTC)
Subject: Re: [PATCH 2/2] tests/boot_console: Test booting HP-UX firmware
 upgrade
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191010122128.29000-1-f4bug@amsat.org>
 <20191010122128.29000-3-f4bug@amsat.org>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <713faaf5-4cdc-6b37-44a1-3b8b749c9feb@redhat.com>
Date: Wed, 29 Jan 2020 16:28:38 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191010122128.29000-3-f4bug@amsat.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 3FcxH2bBPqCex6kkMDGwnw-1
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
> Add a test which boots a HP-UX firmware upgrade CD-ROM.
> It exercise the PCI LSI53C895A SCSI controller.
>
> The ISO image comes from:
> https://web.archive.org/web/20101204061612/http://ftp.parisc-linux.org/ke=
rnels/712/PF_C7120023
>
> This test is very quick, less than 3s:
>
>    $ avocado --show=3Dapp,console run -t arch:hppa tests/acceptance/boot_=
linux_console.py
>    console: Firmware Version 6.1
>    console: Duplex Console IO Dependent Code (IODC) revision 1
>    console: Memory Test/Initialization Completed
>    console: -------------------------------------------------------------=
-----------------
>    console: (c) Copyright 2017-2018 Helge Deller <deller@gmx.de> and SeaB=
IOS developers.
>    console: -------------------------------------------------------------=
-----------------
>    console: Processor   Speed            State           Coprocessor Stat=
e  Cache Size
>    console: ---------  --------   ---------------------  ----------------=
-  ----------
>    console: 0      250 MHz    Active                 Functional          =
  0 KB
>    console: Available memory:     512 MB
>    console: Good memory required: 16 MB
>    console: Primary boot path:    FWSCSI.0.0
>    console: Alternate boot path:  FWSCSI.2.0
>    console: Console path:         SERIAL_1.9600.8.none
>    console: Keyboard path:        PS2
>    console: Available boot devices:
>    console: 1. DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2.5+]
>    console: Booting from DVD/CD [lsi 00:00.0 2:0 Drive QEMU QEMU CD-ROM 2=
.5+]
>    console: Booting...
>    console: Boot IO Dependent Code (IODC) revision 153
>    console: HARD Booted.
>    console: ISL Revision A.00.25 November 18, 1992
>    console: ISL booting  ODE UPDATE ; stable off ; RUN
>    console: Loading...
>    console: *************************************************************=
**************
>    console: ******                                                       =
        ******
>    console: ******             Offline Diagnostic Environment            =
        ******
>    console: ******                                                       =
        ******
>    console: ******      (C) Copyright Hewlett-Packard Co 1993            =
        ******
>    console: ******                    All Rights Reserved                =
        ******
>    console: ******                                                       =
        ******
>    console: ******  HP shall not be liable for any damages resulting from=
 the    ******
>    console: ******  use of this program.                                 =
        ******
>    console: ******                                                       =
        ******
>    console: ******                TC  Version A.00.15                    =
        ******
>    console: ******                SysLib Version A.00.44                 =
        ******
>    console: ******                                                       =
        ******
>    console: *************************************************************=
**************
>    console: Type HELP for command information.
>    console: ISL_CMD> UPDATE ; stable off ; RUN
>    console: *************************************************************=
**************
>    console: ******                                                       =
        ******
>    console: ******                           PDC UPDATER                 =
        ******
>    console: ******                                                       =
        ******
>    console: ******    Copyright (C) 1993, 1994, 1995 by Hewlett-Packard C=
ompany  ******
>    console: ******                         Version A.00.19               =
        ******
>    console: ******                                                       =
        ******
>    console: *************************************************************=
**************
>    console: Type HELP for command information.
>    console: Stable Storage will NOT be updated
>    console: STARTING EXECUTION OF UPDATE
>    console: Unrecognized MODEL TYPE =3D 502
>    console: ERROR 0001
>    console: UPDATE PAUSED> exit
>    console: UPDATE>
>    console: UPDATE> ls
>    console: Modules on this boot media are:
>    console: filename    type    size     created   description
>    console: -------------------------------------------------------------=
----------------
>    console: DAGGER      DATA    118      96/02/15  ?
>    console: IMAGE1A     DATA    512      96/02/15  ?
>    console: IMAGE1B     DATA    388      96/02/15  ?
>    console: UPDATE> exit
>    console: THIS UTILITY WILL NOW RESET THE SYSTEM.....
>    PASS (2.39 s)
>    JOB TIME   : 2.54 s
>
> Suggested-by: Sven Schnelle <svens@stackframe.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> I know this is not a 'Linux' test, but all our console functions
> reside in this file and I don't want to duplicate again.
> Maybe we could rename this file as 'boot_console_tests.py' or
> extract the console related functions.

Yeah, there is some discussion about the fact that boot_linux_console=20
contain more than just Linux boot tests. Also the 'boot something'=20
acceptance tests list is growing fast, thus IMO soon we gonna need to=20
re-organize the code. So I'm ok to merge this in boot_linux_console,=20
then later refactor it all.

I could not test it because the changes no longer applies. The code=20
looks good though, so:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

- Wainer

> ---
>   tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index f05452824e..8bfcd0625a 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -378,3 +378,28 @@ class BootLinuxConsole(Test):
>           self.vm.launch()
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
>           self.wait_for_console_pattern(console_pattern)
> +
> +    def test_hppa_fwupdate(self):
> +        """
> +        :avocado: tags=3Darch:hppa
> +        :avocado: tags=3Ddevice:lsi53c895a
> +        """
> +        cdrom_url =3D ('https://github.com/philmd/qemu-testing-blob/raw/=
ec1b741/'
> +                     'hppa/hp9000/712/C7120023.frm')
> +        cdrom_hash =3D '17944dee46f768791953009bcda551be5ab9fac9'
> +        cdrom_path =3D self.fetch_asset(cdrom_url, asset_hash=3Dcdrom_ha=
sh)
> +
> +        self.vm.set_console()
> +        self.vm.add_args('-cdrom', cdrom_path,
> +                         '-boot', 'd',
> +                         '-no-reboot')
> +        self.vm.launch()
> +        self.wait_for_console_pattern('Unrecognized MODEL TYPE =3D 502')
> +
> +        self.exec_command_and_wait_for_pattern('exit',
> +                                               'UPDATE>')
> +        self.exec_command_and_wait_for_pattern('ls',
> +                                               'IMAGE1B')
> +        self.exec_command_and_wait_for_pattern('exit',
> +                                               'THIS UTILITY WILL NOW '
> +                                               'RESET THE SYSTEM.....')


