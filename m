Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F3BC43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246A9206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="h3qrCuYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246A9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHvvI-0001fe-91
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 16:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <viktor.madarasz@yahoo.com>) id 1jHtrj-00064V-4T
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <viktor.madarasz@yahoo.com>) id 1jHtrh-0001fj-LG
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:37:58 -0400
Received: from sonic311-24.consmr.mail.ne1.yahoo.com ([66.163.188.205]:34607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <viktor.madarasz@yahoo.com>)
 id 1jHtrh-0001dn-AW
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 14:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1585334275; bh=EePCCBDD/1H6QdgUXlHzl9dtFW2qcqAaGfbQKUuUrTk=;
 h=To:From:Subject:Date:References:From:Subject;
 b=h3qrCuYHfKSt+mfrSxW4pE0MIT4Qc9zU96VGE+lW1PTd/aAO63WI/iu5b2f1pJ93yjnJkXIazdhsOUEyUaUzv5VljzX7F3h2KJPUOUuCjNiiYEXSL3A74NnOGpia5CMwvO+vLvxgVWH9OlRH7xi7c53FSoN/OEEoux7N1O78cw4rE4PD2t29dc424otkkQbX8NvTUG4TYczqG6rYzccedGplMqT7D61mrphmS4tf7dYrXlsXfGiMJz6bv0ZKNkGREJEVRrfGWNyCGAKklu66xNiqv2GGjJ1cQ5KN5J5IyIQFKT2OVo3AHWXnxRCOy1QHS7FcvKQ0tPTF101mIAB7OA==
X-YMail-OSG: XfqG2akVM1miypkg0e31Ov7cu5H4j9FFeOrT106OwjKV8.fTPOu0whAeyq0Z5be
 .k3LwBL6X7MQ5of24DpPJdLUiKg5IR4shBtsPu2rMTjmYTyeKA0kMKFkHyezZWwzbDZXFgbPZxPq
 VCXGi3XxH2J729Z8D8mP_Pi6Dbjud0OBKOEVn.dstddMpBm_EsEAx__.xmR3t4igjH_vEwWp1Z59
 GdQzAEk7arbRTivWvGSl3YcnwsdwasUvzudGpDA.UggdTa_.TSkMoS.UpW1_qksQUjAGjbjKfF9S
 CdJhCRjyQJ07KwPJD8ZmM6aLNeyL74LDhumYAmgdP73t6V9Y.64soJ.Tea6yVxFqE6lblCrwf4Yi
 hESjRwHmCx3Ws_r0F8TtF1jwqPSY0nmfIQ6emnIIVbeQXLQjh_Xs_zm3f16Nm4FT.x8NEQZqMj5H
 SmhWiqTWbBtJO.7hrTbBNOoyUym8jakhmYCUrH8Xo4_nQAHGAFSgeo7482HY0lJ2oJBQcEdc2_nQ
 Y_K1zltSN8egs02FjeFYOuj0kvzlLzozoZPzNsCJUhn9vspw7CVO04Sdup6yDG9nAJGp2cQoFdzP
 wZjQyJR7y3AK8b0M606OCr8IMkGHxzmRdRs5M7MUgNVAc8pZGZF0EO1jsNb6RDSAKEP4qq4Qsudq
 CqWvbPFVzaCTGt_HnikKNMWlM1yvuD3fql1WfG4reXn7DT8TvNZ.5ffvGmhCZgbcfkLa9mi_91Qr
 Z9sWd8JAII0xEdzj1F3emeSljo_Ix7nVxSTKfZO5fgULUP0ga5FIgJ56pWXiktAAaRbpCkH3Js7.
 Q6BZE_cQ_WYs4PlavV4bfM67Na5aMU72dKqxFuXyc8AWyyISMNo6hq2W7LmLEFzeJhqfYahajY6D
 80n_Q1D8.adex2nBynKaIusv0nda2wHbT11eNal3JucZdPgLl6O7lZQwUUVqsaxO.QU2LfdWLZtL
 CHgD3AGlb6DZ.uFh9NQ1JP1FTVPswKvitS8VRMN45ob7rMgw4GsPfa838Tz8hzv5oJCnHwu6ClIx
 FNTYpDCVkg4TvyQ0hyLahl.w3Jvx_2UwDGTtSM7VEqQvYYUVokUIuXQ207h7MhcgttiNa8FqzW_U
 s_jwwI1rjPI3fcja9iCrZPREPtIvKShj6IM0TWCaOlfqUVtBG.Av2aC4tu0qHGXd6UwTTE0PApbi
 58NWHnMuh5l8vlsYzBBIlxuKJXW6aHA2PSRV8nUpd2useXUPfzEBFYMg8yiw7xhXAxzcKMnKxXVc
 sXyLLhihzlwOvXppvM8OioHp4BHYc2YThUCpI.YRiVONuES4qJ50nbnUosbnut11nenIDAZTFpX3
 4yX82vY1OtppQ3dP_4.lNbEiH2ZfXzra6fPY3zUYJv53o9DOpgrkPXagjDBfT4X3oCtBEDK_z0ym
 qmHtZ
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 27 Mar 2020 18:37:55 +0000
Received: by smtp414.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 73d1b64f2eb1e97e26005612846e2b23; 
 Fri, 27 Mar 2020 18:37:53 +0000 (UTC)
To: qemu-devel@nongnu.org
From: Viktor Madarasz <viktor.madarasz@yahoo.com>
Subject: Error building Qemu 2.12.0 on Fedora 31 GCC 9.2.1 with the below error
Message-ID: <6dbdab0f-93ff-1df0-bff8-dd720d990be3@yahoo.com>
Date: Fri, 27 Mar 2020 19:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
References: <6dbdab0f-93ff-1df0-bff8-dd720d990be3.ref@yahoo.com>
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_242)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.188.205
X-Mailman-Approved-At: Fri, 27 Mar 2020 16:48:52 -0400
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

Hi

Im trying to build Qemu 2.12.0 on Fedora 31 with GCC 9.2.1 as this 
particular qemu version is the only one working for my 
qemu-systems-ppc64 emulation I need

./configure runs with no problem but running make breaks at this point.

--------------


   CC      aarch64_be-linux-user/accel/tcg/cpu-exec-common.o
   CC      aarch64_be-linux-user/accel/tcg/translate-all.o
   CC      aarch64_be-linux-user/accel/tcg/translator.o
   CC      aarch64_be-linux-user/accel/tcg/user-exec.o
   CC      aarch64_be-linux-user/accel/tcg/user-exec-stub.o
   CC      aarch64_be-linux-user/linux-user/main.o
   CC      aarch64_be-linux-user/linux-user/syscall.o
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/ioctls.h:176:9: 
error: ‘SIOCGSTAMP’ undeclared here (not in a function); did you mean 
‘SIOCSRARP’?
   176 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
       |         ^~~~~~~~~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/syscall.c:5678:23: 
note: in definition of macro ‘IOCTL’
  5678 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
       |                       ^~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/ioctls.h:177:9: 
error: ‘SIOCGSTAMPNS’ undeclared here (not in a function); did you mean 
‘SIOCGSTAMP_OLD’?
   177 |   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
       |         ^~~~~~~~~~~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/syscall.c:5678:23: 
note: in definition of macro ‘IOCTL’
  5678 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
       |                       ^~~
make[1]: *** [/home/viktormadarasz/Emulator/qemu-2.12.0/rules.mak:66: 
linux-user/syscall.o] Error 1
make: *** [Makefile:478: subdir-aarch64_be-linux-user] Error 2
[viktormadarasz@m93pserver qemu-2.12.0]$ make >> makeerror
make[1]: flex: Command not found
make[1]: bison: Command not found
make[1]: flex: Command not found
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/ioctls.h:176:9: 
error: ‘SIOCGSTAMP’ undeclared here (not in a function); did you mean 
‘SIOCSRARP’?
   176 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
       |         ^~~~~~~~~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/syscall.c:5678:23: 
note: in definition of macro ‘IOCTL’
  5678 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
       |                       ^~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/ioctls.h:177:9: 
error: ‘SIOCGSTAMPNS’ undeclared here (not in a function); did you mean 
‘SIOCGSTAMP_OLD’?
   177 |   IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
       |         ^~~~~~~~~~~~
/home/viktormadarasz/Emulator/qemu-2.12.0/linux-user/syscall.c:5678:23: 
note: in definition of macro ‘IOCTL’
  5678 |     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
       |                       ^~~
make[1]: *** [/home/viktormadarasz/Emulator/qemu-2.12.0/rules.mak:66: 
linux-user/syscall.o] Error 1
make: *** [Makefile:478: subdir-aarch64_be-linux-user] Error 2


-----------------


Thanks a lot for helping


Viktor


