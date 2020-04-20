Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E65C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC7720736
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC7720736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41049 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbny-0006Ci-Ai
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51504 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQbmy-0005kv-Rq
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:09:06 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <frederic.konrad@adacore.com>) id 1jQbmx-0007nM-UR
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:09:04 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:46445
 helo=smtp.eu.adacore.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.konrad@adacore.com>)
 id 1jQbmw-0007iO-W1
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:09:03 -0400
Received: from localhost (localhost [127.0.0.1])
 by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 1879A81345;
 Mon, 20 Apr 2020 21:09:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
 by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gS9dn2i2Se7l; Mon, 20 Apr 2020 21:09:01 +0200 (CEST)
Received: from localhost.localdomain (lfbn-tou-1-1471-22.w90-89.abo.wanadoo.fr
 [90.89.4.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp.eu.adacore.com (Postfix) with ESMTPSA id B1B6181339;
 Mon, 20 Apr 2020 21:09:00 +0200 (CEST)
Subject: Re: [PATCH v1] target/m68k: fix gdb for m68xxx
To: Laurent Vivier <laurent@vivier.eu>
References: <1587391275-12748-1-git-send-email-frederic.konrad@adacore.com>
 <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <268c0a26-9ed2-4812-a985-1321e35eb00a@adacore.com>
Date: Mon, 20 Apr 2020 21:08:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <429d6d9c-fff7-d64d-3dfb-917d1985ec90@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:2ab8:224:1::a0a:d2;
 envelope-from=frederic.konrad@adacore.com; helo=smtp.eu.adacore.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a02:2ab8:224:1::a0a:d2
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



Le 4/20/20 à 5:46 PM, Laurent Vivier a écrit :
> Le 20/04/2020 à 16:01, frederic.konrad@adacore.com a écrit :
>> From: KONRAD Frederic <frederic.konrad@adacore.com>
>>
>> Currently "cf-core.xml" is sent to GDB when using any m68k flavor.  Thing is
>> it uses the "org.gnu.gdb.coldfire.core" feature name and gdb 8.3 then expects
>> a coldfire FPU instead of the default m68881 FPU.
> 
> 
> I checked in gdb sources and there is no cf definition.
> 
> Moreover if I change only the cf to m68k in QEMU it seems to work in
> both cases:
> 
> diff --git a/gdb-xml/cf-core.xml b/gdb-xml/cf-core.xml
> index b90af3042c..5b092d26de 100644
> --- a/gdb-xml/cf-core.xml
> +++ b/gdb-xml/cf-core.xml
> @@ -5,7 +5,7 @@
>        are permitted in any medium without royalty provided the copyright
>        notice and this notice are preserved.  -->
>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> -<feature name="org.gnu.gdb.coldfire.core">
> +<feature name="org.gnu.gdb.m68k.core">
>     <reg name="d0" bitsize="32"/>
>     <reg name="d1" bitsize="32"/>
>     <reg name="d2" bitsize="32"/>

Doesn't that break gdb with coldfire?

> diff --git a/gdb-xml/m68k-fp.xml b/gdb-xml/m68k-fp.xml
> index 64290d1630..0ef74f7488 100644
> --- a/gdb-xml/m68k-fp.xml
> +++ b/gdb-xml/m68k-fp.xml
> @@ -5,7 +5,7 @@
>        are permitted in any medium without royalty provided the copyright
>        notice and this notice are preserved.  -->
>   <!DOCTYPE feature SYSTEM "gdb-target.dtd">
> -<feature name="org.gnu.gdb.coldfire.fp">
> +<feature name="org.gnu.gdb.m68k.fp">
>     <reg name="fp0" bitsize="96" type="float" group="float"/>
>     <reg name="fp1" bitsize="96" type="float" group="float"/>
>     <reg name="fp2" bitsize="96" type="float" group="float"/>
> 
> As I have not checked the gdb sources for that, I'd like to have your
> opinion.

In the GDB 8.3 sources: m68k-tdep.c:1091:

       feature = tdesc_find_feature (info.target_desc,
				    "org.gnu.gdb.m68k.core");
       if (feature == NULL)
	{
	  feature = tdesc_find_feature (info.target_desc,
					"org.gnu.gdb.coldfire.core");
	  if (feature != NULL)
	    flavour = m68k_coldfire_flavour;
	}

Hence the change I suggested.  Little later it has also:

       feature = tdesc_find_feature (info.target_desc,
				    "org.gnu.gdb.coldfire.fp");
       if (feature != NULL)
	{
	  valid_p = 1;
	  for (i = M68K_FP0_REGNUM; i <= M68K_FPI_REGNUM; i++)
	    valid_p &= tdesc_numbered_register (feature, tdesc_data, i,
						m68k_register_names[i]);
	  if (!valid_p)
	    {
	      tdesc_data_cleanup (tdesc_data);
	      return NULL;
	    }
	}
       else
	has_fp = 0;

Which is why I didn't made the change you suggested about the m68k-fp.xml but I
just tried with this additional change and it doesn't seem to hurt.

Cheers,
Fred

> 
> Thanks,
> Laurent
> 

