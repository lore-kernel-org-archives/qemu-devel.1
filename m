Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7056C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7D42073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 11:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4A1pE5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7D42073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKK3y-0004rp-Hm
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 07:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jKK3F-0004QJ-Ai
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jKK3D-0002LI-P4
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:59:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jKK3D-0002KG-I0
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585911590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dBhgQwRnhRhyqZPgY7rhFik48s9K4zY0LvRjNwszXZ0=;
 b=A4A1pE5j784LC8RtDssJzTgNQjL/PfrbJJ4hYGHlFj6CayyiG70Oe14x4fYauWrXOKKXyn
 fqvU4OXvPpfSyLWmawT3wYYQfUl1K4my9kzEZwjuBk/IsNgtvquqcpOleZE/VgHrBc+Np8
 cMPcM7TtXp0xBhutuF//Cg5LTUmdc4M=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-k7LTQVwrNVmbVbe8sZbjpA-1; Fri, 03 Apr 2020 06:59:48 -0400
X-MC-Unique: k7LTQVwrNVmbVbe8sZbjpA-1
Received: by mail-ed1-f69.google.com with SMTP id bm25so5117736edb.18
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K6vhkvOUJkkTm2h3cyWca9LpO+IJte31DT4b2orkc40=;
 b=q8G0laAZQmgZ5lPbdxMfxfq1wBzWlLUWXAThCaDpsczQAb27DvAKKqEKY8kgytVafD
 8doi1bBXfUFo8J7BcWZV+VKYkpx6Jaj3UtiMl+PU947Rw1NIiA2g11kuUz/MtE1boYV9
 RoFWTyGpWY6VlPDpjiIYwui46Qjh+2SqzA6BCQ48zAnU++q5UnZA5OyYn7ZwccAfCSsJ
 oepsekWbX2Yx02IANkQqgli1M26ELn0hHc/kNJwyg03gGAjLJSdTNmclDn+gfuVSkOgm
 K3x6fcoNCxN4wrZ9cHIXswpRy11nP1lEf4fE59PypkoMdKRHCZhIWvbzCYVciwlDWIyJ
 aKsA==
X-Gm-Message-State: AGi0PuajViuiBxblFIVLyL3WyvhFecj1r4yJjdF8tDJ+IOhRP4aePO2l
 oxcbAKfYw5eC7LL52GEs3FCNLye3bv1zwPxjTXpaKkCR3IzVh/1hU4Ds5SjWR5V3dB2H3OAzmO3
 nQtKV85m3PI1Mc9A=
X-Received: by 2002:aa7:c48f:: with SMTP id m15mr6828696edq.164.1585911587200; 
 Fri, 03 Apr 2020 03:59:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLM6Cvsn+CavhUEOCvpKlxvueIRkRM5E3CRcwU14UMYY107/zbpmyq1ZbcbtMqIP9i9d9b1Ag==
X-Received: by 2002:aa7:c48f:: with SMTP id m15mr6828679edq.164.1585911586879; 
 Fri, 03 Apr 2020 03:59:46 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 94sm1333367eda.7.2020.04.03.03.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2020 03:59:46 -0700 (PDT)
Subject: Re: [PATCH for-5.0?] docs: Improve our gdbstub documentation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200403094014.9589-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <935d91d2-20e1-009f-7ebd-a66e5a70768a@redhat.com>
Date: Fri, 3 Apr 2020 12:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403094014.9589-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/3/20 11:40 AM, Peter Maydell wrote:
> The documentation of our -s and -gdb options is quite old; in
> particular it still claims that it will cause QEMU to stop and wait
> for the gdb connection, when this has not been true for some time:
> you also need to pass -S if you want to make QEMU not launch the
> guest on startup.
>=20
> Improve the documentation to mention this requirement in the
> executable's --help output, the documentation of the -gdb option in
> the manual, and in the "GDB usage" chapter.
>=20
> Includes some minor tweaks to these paragraphs of documentation
> since I was editing them anyway (such as dropping the description
> of our gdb support as "primitive").
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Maybe 5.0 material since it's just a docs improvement?
>=20
>   docs/system/gdb.rst | 22 +++++++++++++++-------
>   qemu-options.hx     | 24 ++++++++++++++++++------
>   2 files changed, 33 insertions(+), 13 deletions(-)
>=20
> diff --git a/docs/system/gdb.rst b/docs/system/gdb.rst
> index 639f814b32d..a40145fcf84 100644
> --- a/docs/system/gdb.rst
> +++ b/docs/system/gdb.rst
> @@ -3,17 +3,25 @@
>   GDB usage
>   ---------
>  =20
> -QEMU has a primitive support to work with gdb, so that you can do
> -'Ctrl-C' while the virtual machine is running and inspect its state.
> +QEMU supports working with gdb via gdb's remote-connection facility
> +(the "gdbstub"). This allows you to debug guest code in the same
> +way that you might with a low-level debug facility like JTAG

"JTAG" is a standard, maybe replace by "JTAG adapter"?

> +on real hardware. You can stop and start the virtual machine,
> +examine state like registers and memory, and set breakpoints and
> +watchpoints.
>  =20
> -In order to use gdb, launch QEMU with the '-s' option. It will wait for
> -a gdb connection:
> +In order to use gdb, launch QEMU with the ``-s`` and ``-S`` options.
> +The ``-s`` option will make QEMU listen for an incoming connection
> +from gdb on TCP port 1234, and ``-S`` will make QEMU not start the
> +guest until you tell it to from gdb. (If you want to specify which
> +TCP port to use or to use something other than TCP for the gdbstub
> +connection, use the ``-gdb dev`` option instead of ``-s``.)
>  =20
>   .. parsed-literal::
>  =20
> -   |qemu_system| -s -kernel bzImage -hda rootdisk.img -append "root=3D/d=
ev/hda"
> -   Connected to host network interface: tun0
> -   Waiting gdb connection on port 1234
> +   |qemu_system| -s -S -kernel bzImage -hda rootdisk.img -append "root=
=3D/dev/hda"
> +
> +QEMU will launch but will silently wait for gdb to connect.
>  =20
>   Then launch gdb on the 'vmlinux' executable::
>  =20
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 16debd03cb6..292d4e7c0ce 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3680,14 +3680,26 @@ SRST
>   ERST
>  =20
>   DEF("gdb", HAS_ARG, QEMU_OPTION_gdb, \
> -    "-gdb dev        wait for gdb connection on 'dev'\n", QEMU_ARCH_ALL)
> +    "-gdb dev        accept gdb connection on 'dev'. (QEMU defaults to s=
tarting\n"
> +    "                the guest without waiting for gdb to connect; use -=
S too\n"
> +    "                if you want it to not start execution.)\n",
> +    QEMU_ARCH_ALL)
>   SRST
>   ``-gdb dev``
> -    Wait for gdb connection on device dev (see
> -    :ref:`gdb_005fusage`). Typical connections will likely be
> -    TCP-based, but also UDP, pseudo TTY, or even stdio are reasonable
> -    use case. The latter is allowing to start QEMU from within gdb and
> -    establish the connection via a pipe:
> +    Accept a gdb connection on device dev (see
> +    :ref:`gdb_005fusage`). Note that this option does not pause QEMU
> +    execution -- if you want QEMU to not start the guest until you
> +    connect with gdb and issue a ``continue`` command, you will need to
> +    also pass the ``-S`` option to QEMU.
> +
> +    The most usual configuration is to listen on a local TCP socket::
> +
> +        -gdb tcp::3117

FYI OpenOCD uses 3333.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> +
> +    but you can specify other backends; UDP, pseudo TTY, or even stdio
> +    are all reasonable use cases. For example, a stdio connection
> +    allows you to start QEMU from within gdb and establish the
> +    connection via a pipe:
>  =20
>       .. parsed-literal::
>  =20
>=20


