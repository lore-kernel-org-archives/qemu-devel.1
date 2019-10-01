Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D5DC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06E62086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClkjwA4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06E62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKJE-0004da-86
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFK4O-0007uQ-Jc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFK4N-0002NH-6U
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:28:08 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44042)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFK4M-0002ML-Vv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:28:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id z9so2934198wrl.11
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QdmsaPDopLbECYZOKWwQ5aje7PlktW6233psnJFqa3s=;
 b=ClkjwA4B2F1P71zkmkhTBhKhMlcH2LxcT9KxJRFJJOW4U7Dzvskn/7Cc7g5TQ6rD25
 9cq+UUV4n2eeVHoqtHpPr0f4TWTXZ+xI5ZqEKTqZmzCvVEuGxTyijDP73f/Q9zmbedlx
 H9QdCkKwOO2cge6CsKfSWXe55yfL6EILE/bQIdE7O9m9LRtr0Q7XWDJYTM1/cSX/CIJ4
 O+hIZOYtSb/+WbRuaENazsBl8OKHzdVP7Khuy/+VAomZsiNefx5jmiHJ4IVKJ/8nuV4T
 ty9NC71saAKMDm/7QvNlKEZhuUqraK1KlAN164Oc7PXGkMLVBiHtsbTtOJXBOvjk16OI
 NZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QdmsaPDopLbECYZOKWwQ5aje7PlktW6233psnJFqa3s=;
 b=fIFzKgYtU90iD5obuP/jVe1mNR7iPRVmv4EOs1bbA1WjKYwIMnQps+NxzdocOulKqy
 qm2dGnc5y7WVDXbCe3EZHDxaQoGOhrbyWE8Px8mfwykT5npPzhWhkRpXM0HqGTrheLVc
 RHFXvyg+60JVQ+YgJWMBcdyJoFtf53ZPp/xJTLV0rqeTXJ7XxHWGAjPXhEsZ3y93ujMy
 VzcwCu22LKLCu2nhfUCFXMWw5fS0jOllQ8Hvvvu7lDJuGdr1XvBRjIEh6xh7D+jzLRDW
 6oeJY9APy3SVy1XHCY2UStMj9ETvWoTQMZaLdCFpJNbxCVlkzmmVVaNg/b1krNEjR8vc
 +dyw==
X-Gm-Message-State: APjAAAXX69tLstputQ8/6wKeONr/UqLXVP9nsq+b3oSzTalEZktI6B0P
 878fe6faXhc4efzY4bO8f5zQVA==
X-Google-Smtp-Source: APXvYqzhU5ooUcy27bmPJIilhlGkpvuGUKaSMkkZwpmCNtHvgXSQSKygLextAOqPSQCnwAXIMQNzWg==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr1599441wro.300.1569943685146; 
 Tue, 01 Oct 2019 08:28:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b184sm3217090wmg.47.2019.10.01.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 08:28:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B00E51FF87;
 Tue,  1 Oct 2019 16:28:03 +0100 (BST)
References: <CAEfK_44VEF17nRgzNvVe+MPmAfS34kiJ_ozubWFkVYV0rm71sw@mail.gmail.com>
 <CAFEAcA9nz9S4R+O9fwa0k38dB3r1smguG4bQRzwm1s0zJCvfDA@mail.gmail.com>
 <96703fc4-cbeb-5487-89b2-78c37b40237a@redhat.com>
 <87ftkdlhet.fsf@linaro.org>
 <9cdb8f02-0aa4-f0ec-d482-244e346bfc96@redhat.com>
 <87eezwluvg.fsf@linaro.org>
 <e84bb7eb-07df-1c84-c4d7-285c40436751@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Lockup with --accel tcg,thread=single
In-reply-to: <e84bb7eb-07df-1c84-c4d7-285c40436751@redhat.com>
Date: Tue, 01 Oct 2019 16:28:03 +0100
Message-ID: <875zl8lc3g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Doug Gale <doug16k@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 01/10/19 10:42, Alex Benn=C3=A9e wrote:
>>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>>> On 30/09/19 21:20, Alex Benn=C3=A9e wrote:
>>>> Does seem to imply the vCPU CPUState is where the queue is. That's not
>>>> to say there shouldn't be a single work queue for thread=3Dsingle.
>>>
>>> Indeed it doesn't.  I confused this with commit a8efa60633 ("cpus: run
>>> work items for all vCPUs if single-threaded", 2018-11-27).
>>>
>>> Are you going to make a patch to have a single work queue, or should
>>> I?
>>
>> What's the neatest way to do it? Are you thinking just special case
>> queue_work_on_cpu to special case first_cpu when mttcg is not enabled?
>
> Yes, I cannot think of anything better.

And I am immediately stymied by the fact that cpus-common is a common
blob so can't have differentiation for SOFTMMU cases in it.

Did you have a look at:

  Date: Mon, 30 Sep 2019 17:38:15 +0100
  Message-ID: <87h84tloy0.fsf@linaro.org>

Is that too ugly?

>
> Paolo


--
Alex Benn=C3=A9e

