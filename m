Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F02C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B524C24681
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 11:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B524C24681
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBd4X-0005vo-Ri
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 07:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBd36-0004Yv-JW
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBd35-0008Jm-Hc
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 07:27:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:51015)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBd33-000864-2V; Tue, 10 Mar 2020 07:27:45 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M5Qhx-1jAFzX1dIL-001Ort; Tue, 10 Mar 2020 12:27:02 +0100
Subject: Re: [PATCH v4 00/21] linux-user: generate syscall_nr.sh
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200310103403.3284090-1-laurent@vivier.eu>
 <CAFEAcA8iXabS+Dj+6SiBCoNn2U2gFi0hoH6ogAmv15raGYUHUA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e6873533-5354-53b9-7511-79b1aed9683f@vivier.eu>
Date: Tue, 10 Mar 2020 12:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8iXabS+Dj+6SiBCoNn2U2gFi0hoH6ogAmv15raGYUHUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xU094jaW/QkF8GnI2fad3oIx/XzEB021CxTQgcllzOPgm1D/EOn
 9ms39bLlJY8U2TxMfsQ6+c0MFqzwQwwqbJcaluoHDTsW8D8CJeALCLjdUnVHrR+BVzDcq5R
 yi/fnu/q/y36JoukVHV7ythjRHCIPQAKvf647X/uwuNlr/lFh45pq3chj+E7e1Lll7S/9/h
 IeS3qQTeRgBP2nc+LjheQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UvRmoHuWa4I=:XEYGyhfL+P3lcIMT6rC0FS
 AtWQkHAaZX56RinE1ddUF/X95maGrW9mST5bD44cUjILuCMxdIpdX73r4K6kccPUqdpKAiSnU
 uNCvswUe8++Mviana5hoJbvGxHUbUMTB4CrODpTaGTTZCmMB11FviSJAAiwvGQhmgW8S4tmSq
 gxXwGlE1urS2GbS3UnLcWzZ/ldDmnbdLrHyVJxLVcjLxNp+wU0tSe4y/GPk4QbEDYQJY4W8EG
 bH5gIRT6vwgGS9tGPHFh092xt+vct/ObSdc5Bj4/WBsV7Yd3jGpkzINYwUF47tol+n5rIEYYS
 413uXY7iQHFsOUaQGdWoz7kl+kwoWw2WaAvYbiQWM1vS3kkg9zIBuLenbuNXYAsq3YYugQ7gO
 l2nKwX0M/et8r8GqVvDdzYGJV9JYvVmiwa/frRxYRdhN5JSQuaCwrs+3qg8miK3EXP/qIW5j9
 /0HLxLYYi9nO/pW5IsCl70i37f7PT1bSvESq+tqfjgc67a7ZSogCi9cmtvhSC2v0QGHxBPure
 5AagGx65Xh/jf+h4uxw+Fi84ISDNKrWdb7DHwOmr8hJoDA/QCu9uto+ux3HenByUZEh5kULsM
 DfujxFkUf7wau2OJKzGPEExePrapJ4iQP+BgXZ4WpDl3hYnAdJYZ4VGLAvFPvMbMSQ/Ty+DOu
 XzCmxFQlzpxvKK4aSqbewPca2sYeHB60oLycTrDf4IDDl5DPaYfUkTFRdsbF1spR2uD9V8ODq
 zHtQVMAn+JcSfHaZtKgmpeLwMTGGRsOP2qIHRqJP7fDMfm2tjuB9HNmi+Um3W3vUmSnd/Fvp6
 EVZrEyaH4ANombhV1ZrDfeW/eUB/WC/UXhneWTMj10BKp0afECMYgDpjuHgsgfYnf1NkGhw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Taylor Simpson <tsimpson@quicinc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 10/03/2020 à 12:15, Peter Maydell a écrit :
> On Tue, 10 Mar 2020 at 10:36, Laurent Vivier <laurent@vivier.eu> wrote:
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
>> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux and files
>> are generated manually with the help of a script from the asm-generic/unistd.h
> 
> Incidentally I hear from Arnd Bergmann that eventually the plan
> is to have a syscall.tbl equivalent for the asm-generic users,
> though I don't think there's a timescale for when this might happen.

Thank you for the information.

Anyway I've sent a second series to generate the syscall_nr.h file from
the asm-generic file.

Laurent

