Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C0C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F6172087D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 04:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="HmhqWl6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6172087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNTRM-0005A2-EW
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 00:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kNTQ1-0004fv-Sb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:08:41 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:9195
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1kNTPz-0007Vg-Oa
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 00:08:41 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4C1N7V31Wfz8PbK;
 Wed, 30 Sep 2020 00:09:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; s=default; bh=NurdpXnaf
 pBGtOCn6/MVgL9uXT4=; b=HmhqWl6cNh8NeTIEzqiqxinBaF6JHw8hgu959gJRv
 tP+uz674qotCjBJ5endeskVtE0FzGjvXzJ/NLHEVhARUdIYSAQlDuPAF3NkIRNQF
 /FphcBhAFHCPddnv6gUYaKtI8Hb1zdkZ12uk+LHpQG5zFCDtCgm10ZoSgpdmOMnC
 t4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=subject:to
 :cc:references:from:message-id:date:mime-version:in-reply-to
 :content-type:content-transfer-encoding; q=dns; s=default; b=cFR
 ck/JMeaKWDkGN9hlgO7cMLUgUBRXAA/PA3BuWLLD9RpMMcNEN+ReheYIcut3g7Bz
 F2EQmupC6qhMoiu1KmhmaCnlk0uQRaCCDpYnf/+XFfKNx3Elqu6cXz5K4617apK4
 eBR54c6TrcMj+8cMxDyL2l3u49Pz5ScLXMmVZaqU=
Received: from [192.168.6.30] (toroon2719w-lp130-10-70-27-139-175.dsl.bell.ca
 [70.27.139.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4C1N7V1sW7z8PbJ;
 Wed, 30 Sep 2020 00:09:42 -0400 (EDT)
Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
References: <1601314138-9930-1-git-send-email-tsimpson@quicinc.com>
 <c4307aa4-f194-a02f-a4db-90b546a6024a@amsat.org>
 <BYAPR02MB4886C5014B1012371DE0DCDFDE320@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
From: Brad Smith <brad@comstyle.com>
Message-ID: <e36c5a77-fdcb-a56b-48b1-9e1654dee547@comstyle.com>
Date: Wed, 30 Sep 2020 00:08:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <8f684258-8b41-ee3b-8921-41693113c1f1@amsat.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/2020 1:01 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/29/20 5:53 PM, Taylor Simpson wrote:
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> =
On
>>> Behalf Of Philippe Mathieu-Daud=C3=A9
>>> Sent: Tuesday, September 29, 2020 6:22 AM
>>> To: Taylor Simpson <tsimpson@quicinc.com>; qemu-devel@nongnu.org
>>> Cc: ale@rev.ng; riku.voipio@iki.fi; richard.henderson@linaro.org;
>>> laurent@vivier.eu; aleksandar.m.mail@gmail.com
>>> Subject: Re: [RFC PATCH v4 00/29] Hexagon patch series
>>>
>>> cc1: all warnings being treated as errors
>>> make: *** [Makefile.ninja:638:
>>> libqemu-hexagon-linux-user.fa.p/target_hexagon_decode.c.o] Error 1
>>>
>>> $ gcc --version
>>> gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)
>>>
>> Thanks for all your feedback.  I really appreciate it and will make th=
e changes you mentioned.
> No problem, I also appreciate the effort you did to address all
> of the previous issues :)
>
>> I'm using an older GCC that doesn't have these errors.  Is this the ve=
rsion of GCC that is recommended (mandated?) for building qemu?
> QEMU aims to support the 2 latest releases of supported distributions.
>  From time to time a brave developer look at the different versions
> packaged and make some cleanup in the code base. It used to be tedious,
> now that repology.org exists it is a bit easier.
>
> The last effort is from Thomas, see commit efc6c070aca:
>
>      The supported distributions use the following version
>      of GCC:
>
>            RHEL-7: 4.8.5
>            Debian (Stretch): 6.3.0
>            Debian (Jessie): 4.8.4
>            OpenBSD (ports): 4.9.4

OpenBSD as of 6.6 uses GCC 8.3.0 for our ports-gcc.

>            FreeBSD (ports): 8.2.0
>            OpenSUSE Leap 15: 7.3.1
>            Ubuntu (Xenial): 5.3.1
>            macOS (Homebrew): 8.2.0
>
>      So we can safely assume GCC 4.8 these days.
FreeBSD and OpenBSD nowadays use Clang for the (system) compiler.
>
> This is the "mandated" compiler version.
>
>
> QEMU has some CI jobs, see:
> https://wiki.qemu.org/Testing/CI
>
> You can use most of them by opening GitLab and Travis/Cirrus
> (for GitHub, which you already use).
>
> GitLab will become our "gating CI" soon, so your series is
> expected to pass all the GitLab jobs. IIRC running the tests
> is as easy as register and push your branch to your account.
>
>> PS  You were right about Richard recommending const.  It's already on =
my TODO list from his review =F0=9F=98=89
>>
> =3D)
>
> Regards,
>
> Phil.
>
>> Thanks,
>> Taylor
>>

