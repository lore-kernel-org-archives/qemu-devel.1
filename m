Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E33EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68DEE2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lu+kf5Xl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68DEE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGba-0002zT-Kb
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmGay-00024I-8W
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:58:12 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jmGav-0008CP-6w
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:58:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id v3so2109415wrc.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rdv29TNy6rWdsnWoSc0CInSwauLqNQZPYfUU4WpEBRs=;
 b=Lu+kf5Xl7pUSqAHYPcKXC9rnsMfM86FiK8LNeHE0vZ/ROiDmWSVJ4N8d31Gxzo7O3i
 r7T3BROeGYdRBxuidNlwDAbKanWObGtRGq1InLDclzOvZBiKV9sVoZFSYJIIeWpHKDK5
 rpYuXPAhRllxVwhPFh708E5DZtEpSx1RLATFoZYqsBwCEyCBfW4dQXGU0Jp8ciofDUHQ
 C7dBa0yY932Vu1OYtuuVbx2+bbA/NywxMGeT7uLgz3Wa2szIEx64KoRmkhyuDt0YTU5I
 jSnqD7YbhbKHdQmqr5pPav51qNU/7oHBM8cay0jWBqmgpKf+DmqVk9johGECLTNiL3p8
 3heA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rdv29TNy6rWdsnWoSc0CInSwauLqNQZPYfUU4WpEBRs=;
 b=feOTkIIhaM5pgmFOh286r6mISeIdMeFMhTzu2et3bYUDSs923asMlGqTRCW/r3jdI1
 H4RJdiukkCYEwkqbJooddee65PC0naVguNAZIhJlLzAL8I2rxsPTOBnaGoymLOLVWuS5
 q43oID5uyptoYayR5zgPv9IlTQhMtk31Mpq+2+h+V2ldEkS6DGdrA0I05nzp53N5/kaH
 KEud7L8CZGuFqPxiIwoxK2L9qWAktDe2QAM70DDcEKn9wj930GEYHapB7GI9Ts/iMvvx
 vI+9yy4+52oTN1uX6qnenyz9OkoynjNO9J6zXs+uY05j6apIHMS49v/rGwKZ7mYu3zBn
 1Nng==
X-Gm-Message-State: AOAM532ICBpr5v6dF3x9jH8iBT97Mx4pThpC4VRtONVBoMj1XFJBcuaV
 VkLVaelJAOdfGhIlIREmu+aSOw==
X-Google-Smtp-Source: ABdhPJwqN37RSqSDdsWVNMB9WczBgScAI3QcowhQPy0JqthEIXdUqexN4cNVBoMLV2AtwhhFFI5/fg==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr4147762wrt.9.1592571487509;
 Fri, 19 Jun 2020 05:58:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r7sm6459074wmh.46.2020.06.19.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 05:58:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CA1511FF7E;
 Fri, 19 Jun 2020 13:58:05 +0100 (BST)
References: <CAFEAcA_HOxdK5rgKVnww6Bum3vGb=TrhDEp7oqDwsd=UbHmC_g@mail.gmail.com>
 <c47e9e4e-49eb-88c5-fdc7-8ebec121c165@ispras.ru>
 <f4fc4a1b-4054-cffd-0272-22c28d656aba@redhat.com>
 <CAFEAcA-=igrJfoiga7b7rcwZDj46nTNMiT2VEj11DKO7OiJpNA@mail.gmail.com>
 <1364f7e8-3283-8ca2-76f8-75e3eb74af7b@redhat.com>
 <CAFEAcA-8aKX=Qa=i5pahhPTWOBx6MOWfo9ezhFFH+89du8Wf7Q@mail.gmail.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: what are the requirements on target/ code for -icount to work
 correctly?
In-reply-to: <CAFEAcA-8aKX=Qa=i5pahhPTWOBx6MOWfo9ezhFFH+89du8Wf7Q@mail.gmail.com>
Date: Fri, 19 Jun 2020 13:58:05 +0100
Message-ID: <87eeqbus9u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 19 Jun 2020 at 13:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 19/06/20 14:18, Peter Maydell wrote:
>> > On Fri, 19 Jun 2020 at 12:16, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>> >>
>> >> On 19/06/20 07:46, Pavel Dovgalyuk wrote:
>> >>> I think, that we need some efforts from target maintainers to remove=
 all such calls.
>> >>
>> >> I'll take care of target/i386 (which does need one of the three
>> >> gen_io_end calls that are left).
>> >
>> > So why does it need it ? Why can't it just rely on "TB going to
>> > end anyway which will clear the can_do_io flag" ?
>>
>> Because the TB is not always going to end in that case that is left.
>
> OK, so when is it valid not to end the TB after an IO instruction ?
> My initial belief was that the TB should *always* end.

It has to be because the value of icount is either assumes:

  - having executed all instructions in the block
  or
  - done a re-compile, re-crediting the execution not done=20

if not you could associate an io event with the wrong icount value.

--=20
Alex Benn=C3=A9e

