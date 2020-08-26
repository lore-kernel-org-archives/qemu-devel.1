Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB3CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:05:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0733B2087C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0733B2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtFB-0003of-4h
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAt3d-0006ej-D4
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAt3W-0001bL-Qp
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:32 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mv3M8-1kSh1N2i0W-00qyZ1; Wed, 26 Aug 2020 12:53:21 +0200
Subject: Re: linux-user static build broken
To: Paolo Bonzini <pbonzini@redhat.com>
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
 <20200826084442.GH168515@redhat.com>
 <cabd3284-bca8-07ff-e0bc-22ba41df7298@vivier.eu>
 <CABgObfbHtkmp0C5nN+kyAr2a80eRO3LRYa9=MwVqME0O6XMHWQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9c4310b6-c9fc-91d6-08c3-2c5b5140b1b9@vivier.eu>
Date: Wed, 26 Aug 2020 12:53:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CABgObfbHtkmp0C5nN+kyAr2a80eRO3LRYa9=MwVqME0O6XMHWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fYv6iqQMMEUvqgvtK9npgtkhzOqTpogheVUajDFqwPpmnOSbUXa
 9FNMbvEjEt9woI3L1hLQY9u/4spi5PQwnokbn54uSFw2hyuLeTItQtfPec87xkhyJH/Azwv
 RFAzVptZkSWaQoAJl8RuSekUUlTGD9NyvBdkPUm9umYjMi3IMAEMPiBeQoIIXgIy+Rjnggt
 PiRVXfeRMjrXil5aGQuMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3FCJzdQtUVo=:Jvk+09e6S3mJfcLuP4xumG
 FpF5rI6bTOX3fNaQzN8c11dLzGwvbLpcQ4UVuSu6hTx0Mx8ox9o2jzyAnE9FRIbG4dVZFXJrU
 MyDlhZ/0j1b4Gm81IaSJIIVYMwl2hnFNOJMJSAXKkc8u2kc6kA8g+wXSP1no/TdOyPovOZmst
 K61G5/Q76SYwuYhGq3O73cVOkssKN1XKGxbz7O5xEC96U3zYdzbtvzRKLCeIl6Cqw0Ya4dvWm
 8C7Zv3OguXKUzHJIwqNcE383ekvl+6FDE2as1alGH48+yd4V8/XVlIb/e9e7hqpifGaEG9oAU
 UV9WQiKnxilQL2U7CIKP4o/T+t/ez0KTNhTezmXMV3xxUiyqcbmyw+MIgAXtmWf89NlvYJSMM
 cA3vIIvyVaEQYThv6OMfieqzaHfJJCaLkpEUBzGEXzuBU04RyR2oOXNU5YStIHzb2BGvdB7+z
 OsC+U/d4h50LiWlB9qYXiu1fhvbSr+zZqu6YOtlkNnZjg0cVkiLoWaWplaDGKqs71r6vRJE4G
 m/MD2M131CZbF9xBl2tez41CKfGrFYaW9Ki/2bkAb53/RJkQn0YtGvmw+wLbOM43cYUpRiWcG
 FKGJFY8hMSzZZlrYZY1vZ2aFI4uG/2/9grrY7kwbY6hokivv/BbJfflVPZO59URye/gtCb4az
 FElgMeeG37YtsTuZJZDqMT6Lxijl9tPUbDwNuoG46q4ZDn2P+Dk9dQr7DhM29g/M4bq4bUTz2
 QGuUs1OGXtyFdryJASm/c/9UbdwfjqyqnAr769+XADd8dHmnKXuVGXrLyt9R/DI5DRZU0rd3A
 4nSF4jFbMiaHzm8D2xVetEZpvJXkAzmdS9jdxup4O3i+HWGPDk2KFPSPNN5UMrN2p7zvaUW
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.602,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/08/2020 à 11:08, Paolo Bonzini a écrit :
> $ORIGIN is a special literal used by ld.so. It's probably fixed by the
> same patch that was posted for msys.

If I remove the "-Wl,-rpath,RIGIN/" from the command line to build
qemu-m68k, it works again.

What the patch name or series?

Thanks,
Laurent

> Paolo
> 
> Il mer 26 ago 2020, 10:51 Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> ha scritto:
> 
>     Le 26/08/2020 à 10:44, Daniel P. Berrangé a écrit :
>     > On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:
>     >> Hi,
>     >>
>     >> since we have switched to meson, the statically linked binaries
>     of qemu
>     >> linux-user are broken:
>     >>
>     >> cd $OBJ
>     >> $SRC/configure --static --target-list=m68k-linux-user
>     >> make
>     >> ./qemu-m68k
>     >> Segmentation fault (core dumped)
>     >>
>     >> Program received signal SIGSEGV, Segmentation fault.
>     >> 0x00007ffff7bd6833 in __dcigettext ()
>     >> (gdb) bt
>     >> #0  0x00007ffff7bd6833 in __dcigettext ()
>     >> #1  0x00007ffff7bd5352 in __assert_fail ()
>     >> #2  0x00007ffff7c4d74c in _dl_relocate_static_pie ()
>     >> #3  0x00007ffff7bc713e in __libc_start_main ()
>     >> #4  0x00007ffff7a0029e in _start ()
>     >>
>     >> If I build with --disable-pie it works again.
>     >>
>     >> Any idea?
>     >
>     > I'd suggest checking the compiler args used with v5.1.0 vs git master
>     > and see if any flags related to PIE or similar changed. I already
>     found
>     > one bug wrt PIE on Windows builds this way.
>     >
>     > Regards,
>     > Daniel
>     >
> 
>     It's what I'm doing.
> 
>     There are both "--static-pie" and "--pie" on the new command line, but
>     keeping only the first doesn't fix the problem.
> 
>     There is also a strange '-Wl,-rpath,RIGIN/' that would mean "make" is
>     not using $(ORIGIN) but $ORIGIN...
> 
>     Thanks,
>     Laurent
> 


