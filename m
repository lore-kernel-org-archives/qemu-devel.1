Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3FBC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:11:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF382166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 15:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pcdOpnPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF382166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39172 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdcF3-0000Zg-7u
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 11:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37807)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hdcDY-0007yk-EY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hdcDW-0007Yn-SH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:09:44 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53969)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hdcDV-0007GG-F5
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 11:09:41 -0400
Received: by mail-wm1-x341.google.com with SMTP id x15so2216956wmj.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 08:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a79gXW68UvQGxTSUA12ggCauoaRecv6mDAemyR6B7TE=;
 b=pcdOpnPo89rkt8eHSNF0ybLafIuEXKvhEBadbqmAvlxyq/wwKRR9ccVIr/GSOr7Ojv
 rHUmbjshcIvJMm6P9s0/XdlESQFKBfq9iaMADacGuUDYR5hs7pM73zLnh4uxADoQJQnb
 r6ep6SAjZME8wdvO+lQcpTaeIeAF9N4VKIZljLMrS/4VY02SlP47Ecm4qznzmxsPglq5
 u81xBvE7y9dr3o9SPgll0OsQtW29uDKXoBj6NSLalpsqf9IZWJBz1dEVTL37LbochLP7
 qS+l3aWj7gLX58hu32XgfujOzS7a5WK1648UOzRhx1HIiWQM2p1aW4di0Fc9CPMLRgMr
 ejCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a79gXW68UvQGxTSUA12ggCauoaRecv6mDAemyR6B7TE=;
 b=LFeDTlp+ZCOqqFJR26hp9opk3hwcY94M5tTXp0GbIAYcxshw4DGJh1KlIwDTKFfR28
 Jv5g2nEGBIa9GS0J7EGRtizyo6mgQx7nCCpKufu87EH8lBLLHb1vN7jA8uHrIln/l2Kp
 zOxJKNrKoxoVmATs8tJfGLHSzfSFKauEezuYO27gOnUUNtvaM6rjDFuBMah9keSzR9RA
 h/8GusDjm8tvTfjX+eZQU76jQt7vXiPAvU4YXUglAOV54W69TW92+paGPyFgzke6rfNX
 ujRYL0WKcMe8xeIejE1QF/pRWYRIwykLptPczBpugzXY67GMMqP8KtOXjucc+PJdsbTU
 hK4w==
X-Gm-Message-State: APjAAAU4veZOpEowoOUfHQfQaInML/E6rjUJxwdVBtRAWkrHaPgGIzJP
 i/3QB6KTYxzFNYWsxAotGieinbCvKF8=
X-Google-Smtp-Source: APXvYqy0YBZLhWz452pdon3T7NDVXbL0s30OIAn5NU8vBzvPZF/TH+V8kt5jWoc0cZYMcAum2o97Rg==
X-Received: by 2002:a1c:f319:: with SMTP id q25mr8553483wmq.129.1560956954968; 
 Wed, 19 Jun 2019 08:09:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d4sm12877834wra.38.2019.06.19.08.09.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 19 Jun 2019 08:09:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0BC271FF87;
 Wed, 19 Jun 2019 16:09:13 +0100 (BST)
References: <CAOJt3afDmLtb1328ZWRvbO=SYgqtGZYX-aApTMoDPffiErygGg@mail.gmail.com>
 <CAHDbmO2cxxAv2Fqotfw8S8DBh7J+9oa67N8K_Ps_25vRbtpe3Q@mail.gmail.com>
 <CAOJt3ad2HbohoBRv8Ey9fknBRGeiN1SJ7wAk9gX+Vpf4pig_KA@mail.gmail.com>
 <CAOJt3acuu-eLwnKFUpEQ9V0JqqQs8=dyRUKJVRHKSDzbdGVGpA@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ryan Boyce <ryanpboyce12@gmail.com>
In-reply-to: <CAOJt3acuu-eLwnKFUpEQ9V0JqqQs8=dyRUKJVRHKSDzbdGVGpA@mail.gmail.com>
Date: Wed, 19 Jun 2019 16:09:13 +0100
Message-ID: <87zhmd8vdy.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] qemu processes
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Ryan Boyce <ryanpboyce12@gmail.com> writes:

> Alex,
>
> I have another KVM/qemu related CPU question. I am hoping you will be so
> kind as to answer again. I have a Dell Poweredge T430 server running a
> single Intel Xeon E5-2603 v3 CPU with 6 cores. I have 6 VMs running CentOS
> 7 via KVM. I am noticing some terrible host CPU performance when a VM runs
> a simple process such as a recursive search on its file system. I see VM
> CPU acting normally but the host CPU skyrockets to well over 100%. I have=
 a
> few ideas as to why this is but am hoping you might be able to point me in
> the right direction. Thank you so much for your help!

A lot will depend on caching and how much of your guest file-system is
already in the host page cache. Otherwise you have a round-trip to make
to load the blocks into RAM.

However usually my first step is to run something like:

  perf top

And see where the host is spending its time and go from there.

>
> Ryan
>
> On Wed, Jun 12, 2019 at 12:50 PM Ryan Boyce <ryanpboyce12@gmail.com> wrot=
e:
>
>> Thank you my friend!
>>
>> On Wed, Jun 12, 2019 at 12:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
>> wrote:
>>
>>> You've actually contacted the development list but I can answer the
>>> question.
>>>
>>> QEMU is multi-threaded so there will be a thread per KVM based vCPU
>>> (and also for TCG based vCPUs where MTTCG is enabled). There will also
>>> be a number of additional threads created including at least one for
>>> the main monitor thread and potentially additional threads for
>>> servicing IO requests. So expect to see $SMP + 1 + n threads for each
>>> QEMU instance.
>>>
>>> On Wed, 12 Jun 2019 at 16:32, Ryan Boyce <ryanpboyce12@gmail.com> wrote:
>>> >
>>> > Hi Stefan,
>>> >
>>> > I am a big fan of your blog! In relation to your blog post,
>>> >
>>> http://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.ht=
ml
>>> ,
>>> > I have a question I am really hoping you can answer:
>>> >
>>> > When I start a VM, I see that the qemu-kvm processes start and run as
>>> > "qemu-kvm..... -name "something1"...."
>>> > My issue, though, is I see multiple processes running as "qemu-kvm...=
..
>>> > -name "something1"...." and each of these processes has memory/cpu/di=
sk
>>> > mapped to it.
>>> > Does qemu-kvm run VMs on a one-to-one VM-to-host process basis? Or do=
es
>>> > each virtual cpu on the guest get its own process on the host?
>>> > For example, If I have a VM that has 4 virtual cpus, will I see 4
>>> processes
>>> > (PIDs) on the host or should I see just see one for the VM itself.
>>> >
>>> > Any help you can give would be GREATLY appreciated. Thank you!
>>> >
>>> > Ryan
>>>
>>>
>>>
>>> --
>>> Alex Benn=C3=A9e
>>> KVM/QEMU Hacker for Linaro
>>>
>>


--
Alex Benn=C3=A9e

