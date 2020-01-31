Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17217C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D65D42067C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 14:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9kr7Egv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D65D42067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixXSk-000724-2P
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 09:40:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50329)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixXRw-0006ae-My
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixXRv-0003gZ-4t
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:39:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixXRv-0003g0-1i
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 09:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580481550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BeE+vuCWexBfgZgiUVnhxC1hnWiZRso5WkmGs/ppe60=;
 b=Q9kr7EgvVG0VkfSC+XPs48wlSoXrwwAnsPuByvSnAp2LJoNLZ9ac4WHi1fmEJ2j4cTlMwS
 /fwWC3yriW2NMiJEdYs0Q5+CD0AoaCQnXJq0Q8U7lHDgphMsuGZ6ZKhGZNiHmm8zvGYkqW
 /kyMcD4gEJ1RALxNgtiKCx41K3ghV/c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Bv9ItNT3MqK6lQDa8Q8jLA-1; Fri, 31 Jan 2020 09:39:01 -0500
Received: by mail-wm1-f72.google.com with SMTP id b202so2898915wmb.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 06:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CIls9w6Bd31ftgXjuHKhY4rvQcEqPd2EkxfiCgI7Fkw=;
 b=UgMeOUx5W3ReUPPeUntzRXnZ5azAnqSqwzseu2niKiq6XYQWSPfFnnOIME7SMADfJh
 0RHWcLBhVtQpyTLZouW1xKU1nB/zxRqVml8jMc4GXKbr9wrrWE1R0DKbx9eN8ZrxgtYe
 iRipw/fT/QsLkNlnKb8cfGglq8uVgU9g3bZGyr6Be76n97Vn6Ua2hjBtonnwTxwnyd0Q
 RhDpPr5ngUjrGJOC7IY6d463PGH0ydnqg7zz22B55HeZqloenGvPe20Nu+ybAE/jDL6Z
 tWuIyGYDX8Lno4GzsJUVqz85gBTMtSs74YSQQhvwnzYlb717GgSP2xqjfKBAlag0AbY9
 DVbQ==
X-Gm-Message-State: APjAAAXged+vqkCQsZNhiKVqoq7lxwTJ6qWx2keUMrn4T4EZOasA6sn2
 5g0n1pPQ8T8CgpfYwkf2+87HzrevDW3OMQHvfIRCSyW7UWQat5kjRD7hwNqASXm0k4ps8uZs2da
 FrchybYys1xXs5Cg=
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr12829054wmj.4.1580481540157; 
 Fri, 31 Jan 2020 06:39:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwflfEx+KbgjwSxlbvbxOKSjO7trst0jjCYmLejzTuthUYrbOuKLW807Vx+RSk4PRs+gjS0pw==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr12828978wmj.4.1580481538982; 
 Fri, 31 Jan 2020 06:38:58 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id e16sm12240849wrs.73.2020.01.31.06.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2020 06:38:58 -0800 (PST)
Subject: Re: [PULL 0/5] Tracing patches
To: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20200130213814.334195-1-stefanha@redhat.com>
 <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f5e22fef-d746-b6f4-2766-0c6258e7b47e@redhat.com>
Date: Fri, 31 Jan 2020 15:38:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_=_8ZFC=DF3UkqvWqvjQsCHjc=_fYcMmbXs=iLp7JrcQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: Bv9ItNT3MqK6lQDa8Q8jLA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 2:57 PM, Peter Maydell wrote:
> On Thu, 30 Jan 2020 at 21:38, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
>>
>> The following changes since commit 928173659d6e5dc368284f73f90ea1d129e1f=
57d:
>>
>>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-2=
0200130' into staging (2020-01-30 16:19:04 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://github.com/stefanha/qemu.git tags/tracing-pull-request
>>
>> for you to fetch changes up to e144a605a614d22165000c69e8e1dc6986d45cd8:
>>
>>    qemu_set_log_filename: filename argument may be NULL (2020-01-30 21:3=
3:50 +0000)
>>
>> ----------------------------------------------------------------
>> Pull request
>>
>> ----------------------------------------------------------------
>>
>> Peter Maydell (3):
>>    docs/devel/tracing.txt: Recommend only
>>      trace_event_get_state_backends()
>>    memory.c: Use trace_event_get_state_backends()
>>    hw/display/qxl.c: Use trace_event_get_state_backends()
>>
>> Philippe Mathieu-Daud=C3=A9 (1):
>>    Makefile: Keep trace-events-subdirs ordered
>>
>> Salvador Fandino (1):
>>    qemu_set_log_filename: filename argument may be NULL
>=20
> Here's a weird one -- with this pullreq applied I
> see a new warning running check-tcg on the linux-user
> static config build:
>=20
>    TEST    linux-test on aarch64
>    TEST    testthread on aarch64
>    TEST    float_madds on aarch64
>    DIFF    float_madds.out with
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/float_ma
> dds.ref
>    TEST    fcvt on aarch64
> warning: TCG temporary leaks before 0000000000400a0c
>    DIFF    fcvt.out with
> /home/petmay01/linaro/qemu-for-merges/tests/tcg/aarch64/fcvt.ref
>    TEST    pauth-1 on aarch64
>    TEST    pauth-2 on aarch64
>=20
> but I'm not sure why any of the patches here would have
> provoked that, unless they're now causing a log message
> that would previously have been suppressed or directed
> somewhere else to be emitted.

Looking at the last patch "qemu_set_log_filename: filename argument may=20
be NULL", maybe these were previously logged into a ./'(null)' logfile?


