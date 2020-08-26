Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A43AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0952071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 08:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0952071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArAk-0007rx-Ai
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 04:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAr9x-0007Se-6D
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:51:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37275)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kAr9v-000250-6j
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 04:51:56 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N4NHS-1kZmK233Sg-011NmX; Wed, 26 Aug 2020 10:51:48 +0200
Subject: Re: linux-user static build broken
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
 <20200826084442.GH168515@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cabd3284-bca8-07ff-e0bc-22ba41df7298@vivier.eu>
Date: Wed, 26 Aug 2020 10:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826084442.GH168515@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DhCAuaUjL8cO6bV6KMrFn+ttL+HlauJ42z2WhRu5SaJ5HLz5tzw
 5h+jWuEHI09HFlJb3BoVWO1meFEMqGUZ104U0N2EPaIaHdksnoo/cHLruAcfPJUOTqsQ69o
 Js6IMqD/yUg8nDRBFJqXyzRcPixrHGYJUUBWFg3cRhKXmtXhzs+d1fUnCZVMHqW8jdgScrx
 BqD5youabi0fMq6RBzZ2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DilkpaxvGtk=:fdtfavg6l+3JYevaabs/vy
 zcG55tbyZdaTYNoEQQKc98m0RH1ygo/WuhphvuXs5e9tujozB2AhtlrLiBmumQQDjqb/zC4X/
 v/6SkbzGr8Q4uVbuZSv7k9hL9pjQYY4Z0TiwGl622BlEKIyFgLmHbZr4etoefc4vipfF4LBI8
 IhYdYBEmGxll4YxB9MzPl1LkQ/uqfOyIGUJiOQYDC5G+6jOnBy8bn7Lv+dRiKwhqBgO7JUQU1
 n2M6BAC3JlrB4/Jc9u3ZU7fO9vvnphZuhb2BPrAjoB4aVOGBh9fXFJx/J2BlNChZLpvqNWNib
 eT3qnOuL7cm81hHDavvbbmZbk/zXB7O7nmoUSsuM3Wm3P47FLshyVYVOF4kXRgk4dgfvSssUV
 oFo31lmeliDjW9XUlO0GcN9cEH76o4+iwFes0SzsBPhWcz6aGtC/vlKaRd5W/Epo+2LQlJmDR
 4Uxwkucdy64OXMJRGSNSmcJwcsLWzMWcyXsOpFgG3e3u9GTPpOkkUsyf+iwB+RQ1wAJQk75cz
 rNkVzauCF0iSL7WuGNH3NRJYQsvbGYHlull+o2Iho+xj7tXATRS3nNOSXY4cyRQZO7eK7tOhy
 Ose+i4rDVBq+QThs4CtBfZ0B2IYxZ892YUAsrCqVrRsBT/cuS3G9Xv5cXD1BDkHIzqbH1f3PP
 TWG06nDeFXDDdo4o51XdBBy04tv9wv3dvlu4uTL2m6gQh8ubKIMb9kzJSVK6OnX1LDtctutsG
 v40yLUwUunXxt1gMHr3XeBvpIo9E4kAhdTtM98YVUNA1JlK1URGqcAY+NI3uD1jAVLvOXLLCe
 M9WCTANDHif7Z+WJqtxkhi8RQNfuK53RdArwut0zVAmA78VRukij7Jotq92QuLsHyRiZ/G5
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 04:51:53
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/08/2020 à 10:44, Daniel P. Berrangé a écrit :
> On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:
>> Hi,
>>
>> since we have switched to meson, the statically linked binaries of qemu
>> linux-user are broken:
>>
>> cd $OBJ
>> $SRC/configure --static --target-list=m68k-linux-user
>> make
>> ./qemu-m68k
>> Segmentation fault (core dumped)
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> 0x00007ffff7bd6833 in __dcigettext ()
>> (gdb) bt
>> #0  0x00007ffff7bd6833 in __dcigettext ()
>> #1  0x00007ffff7bd5352 in __assert_fail ()
>> #2  0x00007ffff7c4d74c in _dl_relocate_static_pie ()
>> #3  0x00007ffff7bc713e in __libc_start_main ()
>> #4  0x00007ffff7a0029e in _start ()
>>
>> If I build with --disable-pie it works again.
>>
>> Any idea?
> 
> I'd suggest checking the compiler args used with v5.1.0 vs git master
> and see if any flags related to PIE or similar changed. I already found
> one bug wrt PIE on Windows builds this way.
> 
> Regards,
> Daniel
> 

It's what I'm doing.

There are both "--static-pie" and "--pie" on the new command line, but
keeping only the first doesn't fix the problem.

There is also a strange '-Wl,-rpath,RIGIN/' that would mean "make" is
not using $(ORIGIN) but $ORIGIN...

Thanks,
Laurent


