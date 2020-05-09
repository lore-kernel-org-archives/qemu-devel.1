Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244E8C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 16:50:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D346D21582
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 16:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OwAmN7kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D346D21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXSgU-00050M-2C
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 12:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jXSfp-0004H4-JW
 for qemu-devel@nongnu.org; Sat, 09 May 2020 12:50:01 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51652)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jXSfo-0000wm-DJ
 for qemu-devel@nongnu.org; Sat, 09 May 2020 12:50:01 -0400
Received: by mail-wm1-x342.google.com with SMTP id f134so1189051wmf.1
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 09:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1zRik5emFN1qw8G0OAN5gieuX57kaHmj/cdkq1/OA78=;
 b=OwAmN7kxDBU9f4TUtSCaSK+MONafEE9CXQTK02USGiSrElaCszqSIc3+ilVv/t4GF8
 81r4wDaaK96ApHIndKKch+ZLxtG3gLWQF0MNV6J0v0XF1d5UvUwuH9oY620ciU6vrcY6
 cuiykKLLdkls/9uUXwFekd4FhzWIpR+LYN9NbfrOfqNyRVoHgAxzffqIywwYVe2tCd2z
 fBp7FytuuK2asgw0ZEq2Y/FcJ/wQ7EC4feqOKVtKb2SHiift3rh3gxt9XfODRmvhh6jk
 AmLh4x2pZb+Uet6+eGYuEgzLbRSlmMfz/jCkcQSzMr8gzrJoQwcdsqRg1WmtddOrlC2f
 JtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1zRik5emFN1qw8G0OAN5gieuX57kaHmj/cdkq1/OA78=;
 b=WuYZYx4QOrUV89s7wAay4ZSjpvBqMR1bZWjPA/O4/AMNJ86ZmYD3YtPCRzv2Y3MZvJ
 Q14H7TbVOigAxB3uUcQguO54aKRbilpYkhAVcqEFADf95oNxPoNh9Jf0EmJY98YtcOpQ
 Nu2vjRE+NuIsSViawIHTgiah7ewaBLSaQ7x3WyqLuZJBGZR974LRkt+TWfY5FXrynvhO
 ieRHEV/xptu+OAEIQ4f6HuHGYbEzDHivGdp59SbYvldbRehoS0rVEGzb85woY/vyDtUU
 cIkT/49zxXG2gwdSe5m924wuYjIH/r6ddMZKyZB2JgaYDz3iJhTb5UKEmAWoHfAq0LN1
 e9vw==
X-Gm-Message-State: AGi0PuZ6N2deJ2bW74y7jMNhx+uHCsjuZ1H/xxV4Dwmpbp1RHkoeR1Lu
 +j4QDay8AHAIxBjNryYtBaLFGg==
X-Google-Smtp-Source: APiQypJ3Cu1+iUkxhFSWNmdqn2VRJ4nezk+IRcf7jSrhAOVOItDMfAGT0tYc6Zm7JCFqwrSCVEn7hA==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr3019602wml.84.1589042998192; 
 Sat, 09 May 2020 09:49:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q74sm11499694wme.14.2020.05.09.09.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2020 09:49:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0FDF01FF7E;
 Sat,  9 May 2020 17:49:56 +0100 (BST)
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
 <87imh95mof.fsf@linaro.org>
 <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
 <CABoDooNCszaFGJz6nLWsNYDh1VJpDmMr+OJEfALYqHnoYgYsEA@mail.gmail.com>
 <CAHiYmc4ovS5B1ctaMpRGxtf3NzC64AzUAs-A5Of-A_cV7Lc1tw@mail.gmail.com>
 <CABoDooMJcJi0gKx4HNk50X4YZ4DazgoMLU3y5-KgNrwR_w6-jw@mail.gmail.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Subject: Re: [INFO] Some preliminary performance data
In-reply-to: <CABoDooMJcJi0gKx4HNk50X4YZ4DazgoMLU3y5-KgNrwR_w6-jw@mail.gmail.com>
Date: Sat, 09 May 2020 17:49:55 +0100
Message-ID: <87v9l5vyrw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?utf-8?B?THVr?= =?utf-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ahmedkhaledkaraman@gmail.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 "Emilio G . Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Desnogues <laurent.desnogues@gmail.com> writes:

> On Sat, May 9, 2020 at 2:38 PM Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
>>
>> =D1=81=D1=83=D0=B1, 9. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:37 Laurent Des=
nogues
>> <laurent.desnogues@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> >
>> > On Sat, May 9, 2020 at 12:17 PM Aleksandar Markovic
>> > <aleksandar.qemu.devel@gmail.com> wrote:
>> > >  =D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:26 Alex B=
enn=C3=A9e <alex.bennee@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> > >
>> > > > This is very much driven by how much code generation vs running yo=
u see.
>> > > > In most of my personal benchmarks I never really notice code gener=
ation
>> > > > because I give my machines large amounts of RAM so code tends to s=
tay
>> > > > resident so not need to be re-translated. When the optimiser shows=
 up
>> > > > it's usually accompanied by high TB flush and invalidate counts in=
 "info
>> > > > jit" because we are doing more translation that we usually do.
>> > > >
>> > >
>> > > Yes, I think the machine was setup with only 128MB RAM.
>> > >
>> > > That would be an interesting experiment for Ahmed actually - to
>> > > measure impact of given RAM memory to performance.
>> > >
>> > > But it looks that at least for machines with small RAM, translation
>> > > phase will take significant percentage.
>> > >
>> > > I am attaching call graph for translation phase for "Hello World" bu=
ilt
>> > > for mips, and emulated by QEMU: *tb_gen_code() and its calees)
>> >
>>
>> Hi, Laurent,
>>
>> "Hello world" was taken as an example where code generation is
>> dominant. It was taken to illustrate how performance-wise code
>> generation overhead is distributed (illustrating dominance of a
>> single function).
>>
>> While "Hello world" by itself is not a significant example, it conveys
>> a useful information: it says how much is the overhead of QEMU
>> linux-user executable initialization, and code generation spent on
>> emulation of loading target executable and printing a simple
>> message. This can be roughly deducted from the result for
>> a meaningful benchmark.
>>
>> Booting of a virtual machine is a legitimate scenario for measuring
>> performance, and perhaps even attempting improving it.
>>
>> Everything should be measured - code generation, JIT-ed code
>> execution, and helpers execution - in all cases, and checked
>> whether it departs from expected behavior.
>>
>> Let's say that we emulate a benchmark that basically runs some
>> code in a loop, or an algorithm - one would expect that after a
>> while, while increasing number of iterations of the loop, or the
>> size of data in the algorithm, code generation becomes less and
>> less significant, converging to zero. Well, this should be confirmed
>> with an experiment, and not taken for granted.
>>
>> I think limiting measurements only on, let's say, execution of
>> JIT-ed code (if that is what you implied) is a logical mistake.
>> The right conclusions should be drawn from the complete
>> picture, shouldn't it?
>
> I explicitly wrote that you should consider a wide spectrum of
> programs so I think we're in violent agreement ;-)

If you want a good example for a real world use case where we could
improve things then I suggest looking at compilers.

They are frequently instantiated once per compilation unit and once done
all the JIT translations are thrown away. While the code-path taken by a
compiler may be different for every unit it compiles I bet there are
savings we could make by caching compilation. The first step would be
identifying how similar the profiles of the generated code generated is.

--=20
Alex Benn=C3=A9e

