Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D594C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 518AF20775
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 14:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518AF20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQXjf-0002OE-FF
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 10:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQXhq-0001It-Dr
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:47:30 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jQXhp-0006VQ-O9
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:47:30 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45477)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jQXhp-0006TJ-5E
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 10:47:29 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M433w-1jQXhg2hQO-00086v; Mon, 20 Apr 2020 16:47:21 +0200
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: frederic.konrad@adacore.com
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5669114b-b6d8-5696-407a-98b30896e0b7@vivier.eu>
Date: Mon, 20 Apr 2020 16:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oAepb2lQMz7rQjv3xf3fmNBVgVwXzLOtTXNL1KoEQyDgJSrrAJK
 iu3QNPLubPGUYIPwwLYjGG0Wo1QiIOoMIMato4MITXW92dNeZfkkv9WSvA6XFtDBQKzOrix
 ksYxGykmAOx/rViRfJonmK0KB7BQcfyL8plR9Xl1zMungcVGnttNB0HrZ/AwjYKzkOEP39E
 E8KUf51DkMe9QdK6T8vdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0xm5NuRA0JU=:YlcdXYefE/fGUWiWlaak+e
 WGDiSrTfcfLXXNx/qj+2qfECkdAeHrXa4+aI24zeq5GKrv5q0MGpxTLCp/NsI5n/x0YbtVbly
 z1h9zJtPECQoy5XfgJEY7SzU2PyAdh0e2AraSdnt/6OpExQpk87veVYHLFj/kHYAdy/xiME8k
 Uv8TPtVX6BJUlscRZ/iJML2WLTUOon71hfHpcrQoStzFn3Iq8HDbjVvxQKnjTF89sgfg4nS6O
 6ZV2jJbKVZsP+3D1jBzu8Sc9LfqS17rfd1iDj4aM2FU+yJ+977NsEr7Yav5tquk2/WbiwGYx+
 QTTuqOSkKiOhyrDYg/ieJx9Z6oYwx+BkXLXWJ9TDUZc0iphTPm7QdmG5IFfGr9NrlqpQ5jUJP
 yXwFc7Dd3VnQFxTDwKYiwlb9fr3QVH6M/xf+P65/q0LuGMHnB7qHgtY0yW7trAfQn+EyEwdIo
 GI3Kho2MODu9WvqN6O3wMb60mV/bcsHHA2Wb+eXU6JCxsm955WeVQSVdX4JOo7lv6k5wHkPCG
 xKRP0c0Nij+cbBetcl0tVhgnt01D/NkuxysIrRt/xA7w0D+eMe+HjU07jd3IW1IH7e3hRkrLh
 jLQEL7wtUXB3/YdbI63oy18xcuqWFae9SQezzcElNx8mZ+A8tuvZpgnLv76puCzudK8zCFt+I
 L/NPtXXoZWOUS2QAvLy0XhlJWuOVSsYKQnGWjxvHRADMd9KPRfaozsPtJEMz5qUaUPg5H583O
 yacSg4axIX75obds6akmhg/pNuqlwQ11ppOOuGi4KqzLujhNkb1Chm0Ptm1+RVc111m+VVTlO
 DqADrg+nESC27qdQTWkcAbOXIBJJQghr7BEzjrC9zpklItrq2N9MYrmuBDhBF/dKMtmebKb
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 10:47:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 212.227.126.131
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
Cc: huth@tuxfamily.org, alex.bennee@linaro.org, f4bug@amsat.org,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 pierre@freepascal.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
> From: KONRAD Frederic <frederic.konrad@adacore.com>
> 
> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
> a coldfire FPU instead of the default m68881 FPU.
> 
> This is not OK because the m68881 floats registers are 96 bits wide so it
> crashes GDB with the following error message:
> 
> (gdb) target remote localhost:7960
> Remote debugging using localhost:7960
> warning: Register "fp0" has an unsupported size (96 bits)
> warning: Register "fp1" has an unsupported size (96 bits)
> ...
> Remote 'g' packet reply is too long (expected 148 bytes, got 180 bytes):    \
>   00000000000[...]0000
> 
> With this patch: qemu-system-m68k -M none -cpu m68020 -s -S
> 
> (gdb) tar rem :1234
> Remote debugging using :1234
> warning: No executable has been specified and target does not support
> determining executable automatically.  Try using the "file" command.
> 0x00000000 in ?? ()
> (gdb) p $fp0
> $1 = nan(0xffffffffffffffff)
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  configure             |  2 +-
>  gdb-xml/m68k-core.xml | 29 +++++++++++++++++++++++++++++
>  target/m68k/cpu.c     | 30 +++++++++++++++++++++++++-----
>  3 files changed, 55 insertions(+), 6 deletions(-)
>  create mode 100644 gdb-xml/m68k-core.xml
> 
> diff --git a/configure b/configure
> index 23b5e93..2b07b85 100755
> --- a/configure
> +++ b/configure
> @@ -7825,7 +7825,7 @@ case "$target_name" in
>    ;;
>    m68k)
>      bflt="yes"
> -    gdb_xml_files="cf-core.xml cf-fp.xml m68k-fp.xml"
> +    gdb_xml_files="cf-core.xml cf-fp.xml m68k-core.xml m68k-fp.xml"
>      TARGET_SYSTBL_ABI=common
>    ;;
>    microblaze|microblazeel)
> diff --git a/gdb-xml/m68k-core.xml b/gdb-xml/m68k-core.xml
> new file mode 100644
> index 0000000..5b092d2
> --- /dev/null
> +++ b/gdb-xml/m68k-core.xml
> @@ -0,0 +1,29 @@
> +<?xml version="1.0"?>
> +<!-- Copyright (C) 2008 Free Software Foundation, Inc.
> +
> +     Copying and distribution of this file, with or without modification,
> +     are permitted in any medium without royalty provided the copyright
> +     notice and this notice are preserved.  -->
> +<!DOCTYPE feature SYSTEM "gdb-target.dtd">
> +<feature name="org.gnu.gdb.m68k.core">

So I guess you should also update feature name in gdb-xml/m68k-fp.xml ?

Thanks,
Laurent


