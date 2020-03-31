Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF2720781
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+57/SUP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF2720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIRz-000482-4V
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJIPt-0000kA-Ug
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJIPs-0000zC-Ja
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52246
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJIPs-0000yl-Fg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585666980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KsMfc3G3rgC448QbeLy34bUqTkrTHHmdZ1uGo1rAiJ8=;
 b=X+57/SUPcl/DOD5Hrvm3Lgb8MbQP9w0uQmykCNZmlz2qKPtRkQd0ivmi7pazcEWzO9sZeM
 G5UYNzy+uL3rnhkjbxvTizOmp8EbZu1vSLKVCcSnGw5Cn7Ws5o77eXwWLSC7yFgQkEmSOo
 k1Box/002/emW1ExySo2jurkGMP6Lfc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-E96MzWlFPt28FImgk_dCuA-1; Tue, 31 Mar 2020 11:02:55 -0400
X-MC-Unique: E96MzWlFPt28FImgk_dCuA-1
Received: by mail-ed1-f71.google.com with SMTP id b100so18998875edf.15
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 08:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=in+QUcmMYUk6+ZHJv8Yt8BajPooc4ZxTObE1AjaRxRw=;
 b=TYiI+ohsdEeqXrsf7DvKHb8d4exUJ4t1OxhRbeaEVdVQKW7ySw4o1ALtYhcfyNOHy1
 kZibk8rvJsJcruPNyW9l+pA9YJN6O0QhVUOZ3fBS0Glqcn2PBvs7JlqtAbLy9htiMJKR
 nNoXlZ3XVO6q3oPtpQsTur0J37Koc0Vjm9ByNwYGrphvKyQPHbUXX9tC3MyoJDm9sz+1
 5HsXDQzgHh/yLUlRHpyk4PZ3Wb04Gt3U+wn2m5QryzU60fnpJxrLW7RC0zwI4Sz5Y9GC
 KxgxhcIQZrNedmhEy8un3vlO2naVZ8KFPO3BaRrBfN7YCW7I5yXKk3fXoMEp8c+dz8tq
 nfrA==
X-Gm-Message-State: ANhLgQ2D5w7Z0uqMgz32TMwCa0cRY20XziVvbRtFHGPgg5i7xK9cNEZF
 s9ycLj7VO2SR3ggfFqFAL3dpPaSvgHYhYtRoNHpxUe8/BR1ejhYNX2W4Ntq8CGmi3hKo+mTTrjg
 ReKsVEULUdgQ0vEA=
X-Received: by 2002:a17:906:8405:: with SMTP id
 n5mr16079633ejx.214.1585666974147; 
 Tue, 31 Mar 2020 08:02:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt/Zz7sVSHi/TS3qrEod7cw/NhBgRnlN1kwmzredJ4+c0/TQpiZfRt5T8K75qNB+H0UL0Gs2Q==
X-Received: by 2002:a17:906:8405:: with SMTP id
 n5mr16079610ejx.214.1585666973920; 
 Tue, 31 Mar 2020 08:02:53 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id v23sm2212054eji.81.2020.03.31.08.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:02:53 -0700 (PDT)
Subject: Re: [PULL for-5.0 00/10] tcg patch queue
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200331035456.6494-1-richard.henderson@linaro.org>
 <CAFEAcA8ZZPQpgSciPbHc+G03CwoPhfU++0=v5656nmtzjbYo2w@mail.gmail.com>
 <87a73wfzxs.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb05d334-4473-1ce1-79ac-5d3f99a88764@redhat.com>
Date: Tue, 31 Mar 2020 17:02:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87a73wfzxs.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 2:53 PM, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Tue, 31 Mar 2020 at 04:54, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> My tcg patch queue, plus one mips patch on request of Aleksander.
>>>
>>>
>>> r~
>>>
>>>
>>> The following changes since commit 5acad5bf480321f178866dc28e38eeda5a3f=
19bb:
>>>
>>>    Merge remote-tracking branch 'remotes/jnsnow/tags/ide-pull-request' =
into staging (2020-03-28 00:27:04 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/rth7680/qemu.git tags/pull-tcg-20200330
>>>
>>> for you to fetch changes up to b412378785c1bd95e3461c1373dd8938bc54fb4e=
:
>>>
>>>    decodetree: Use Python3 floor division operator (2020-03-30 11:44:04=
 -0700)
>>>
>>> ----------------------------------------------------------------
>>> Improve PIE and other linkage
>>> Fix for decodetree vs Python3 floor division operator
>>> Fix i386 INDEX_op_dup2_vec expansion
>>> Fix loongson multimedia condition instructions
>>
>> NB: something in your workflow is leaving the '---' and the following
>> v1/v2 changes info in the commit messages in pull requests. We usually
>> prefer to strip those out.

Same happened to me because I was not applying my own patches (since I=20
have them locally) but they would then miss the Message-ID tag.

>=20
> FWIW I used to have a script that reminded me if they were in and
> triggered a clean-up re-base. As people on list have mentioned the
> usefulness of maintaining a Message-Id I have now changed my process to
> always build a PR by applying messages from the list which
>=20
>    a) applies a Message-Id
>    b) strips version history

I'm doing that with my own patches now.

>=20
> The one thing I have to watch out for is if I've started applying tags
> to a branch - so now I only do that once I've made the decision to
> either rev a branch or create a PR.
>=20
>>
>> Applied, thanks.
>>
>> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
>> for any user-visible changes.
>>
>> -- PMM
>=20
>=20


