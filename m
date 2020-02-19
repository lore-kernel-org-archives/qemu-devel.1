Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3455C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB1F24656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB1F24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4KlL-0005Eu-Jm
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 03:31:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4KkY-0004bJ-KH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:30:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4KkW-0005Ov-P4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 03:30:30 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:52957)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4KkU-0005Mg-9w; Wed, 19 Feb 2020 03:30:26 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MDQqk-1jCYT12r5i-00AaJS; Wed, 19 Feb 2020 09:29:45 +0100
To: Alistair Francis <alistair23@gmail.com>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <CAKmqyKNjL-+H_7wwK5iU4uZS2LALCw_GZnSHeRdphGQvOsc8SA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
Message-ID: <1a8c05dc-d3b3-d7a4-9037-58c3da51f201@vivier.eu>
Date: Wed, 19 Feb 2020 09:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNjL-+H_7wwK5iU4uZS2LALCw_GZnSHeRdphGQvOsc8SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:00kZi+BCfhJ5Ftiq0hiI/aFRkgn5rhQ4819VZAv2hv+RK6fzCcy
 MoiDhBZ6AhBYKhm+uVWfOIGP/xZSqCGiluo9JSJjb16I50fq28X6aUkB+o2tK3GJjjlM4DY
 OTRIltlF4a2X4RbExJtUGLi9tHEKZDu2VEg0bI66iron84icXb/WX6U8GzW/7IIZ6ql6g2S
 yDZ23B/KRaAR/obqTW26Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cmfei3HJ/0Y=:6PKJQ05KAABFYMQI7U9Z/q
 DQDzp+hBnpI/L5LxZvi9okkT2Uq/qMlSUkXrHYUPWh0RMlbI4NBAjP9pdDwAtCBS4XlYD18jw
 aML2wbZJystQQt3Rp3Kc5Ja6sMxQrLyWN4wj7gpd/wFbDovcS+xnJiOsSdsJNbRYy7nmG2Vua
 kjotrVvb9PxSJm1Gwtg/feDRK6AI0iDvSB/USSIu5WQZ+/c62AXIUlZbUehcru0sCLPzPeJ/r
 rGJhOsmbs7IKT3GufJ04nCzARQTxSpHWTbvXPS6nmpdqrZGc/ZrT764hER5hfut4gIxIvu8FC
 t7h7pNjfLiqQjtjTY8/dcAy1I0nrq3i+wtcqNmnuYVbiTYQN4wwkA6HF8ZPZ/0Kw9EwerDYkt
 TI4GQVTs88Txcbh2IE9/PYDZj5Ws9QReDOsJiBd8nonN9Ubb2XIoAqzj2W6XGQQm03YheCVxn
 mwAy9hO69aHD5lihZoVekpiJlhwpWrCQVguij6XIf74mXqe91lBWHOSGe6483LA1GuzR7OlfW
 qaf2MjCl4j9/1uzZnZ5oHAh9d3s43iKNuHyXvUkN2MaVFyP0Cq4wZ85y5sdlfgM/R+/dJzgTR
 6hgJP875CXdtuJbLbYb/lBabGue/SK0jUOJSAhgzcOvi88CDZFApuV0w82fFL4MKUwpR43PIe
 kbMRQAZDgXhkrk/eHJvQDSG5ULrQzmSp4Wivo2jFxmqTJk4NbPX06UG+hppCIhfDFnhijZrVN
 cu4t6dxxYNbJ+Q14OXFAdxvpi8qTMbw7KuJ3/sxAP81MU1wLgiGPfjQ54I6hzfgzd8cBicHmO
 XPwPqKT0ZiFmajYbT+e9gJECXS5hHeOgVlAl0qrOuN1uqtSbImSkdXELZ4Gxuk6sPLv90/h
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 18/02/2020 à 23:48, Alistair Francis a écrit :
> On Mon, Feb 17, 2020 at 2:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> This series copies the files syscall.tbl from linux v5.5 and generates
>> the file syscall_nr.h from them.
>>
>> This is done for all the QEMU targets that have a syscall.tbl
>> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
>> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>>
>> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>>
>> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.
> 
> What's the plan with these other architectures?
> 
> RISC-V uses asm-generic, is there some way to generate syscall_nr.h from that?

Automatically no. The best to do should be to convert linux parts using
 asm-generic to syscall.tbl and then after that using it in QEMU.


Thanks,
Laurent


