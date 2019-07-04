Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D6C0650E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31F0121882
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sGsuzHaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F0121882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hixsN-0005AF-1r
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33715)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hixqr-0004iV-U8
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hixqq-00062S-Rk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:16:25 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hixqq-00060C-J7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:16:24 -0400
Received: by mail-wr1-x444.google.com with SMTP id f9so5767762wre.12
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OH3tsulfMTfljIlsI9K/6O0vLv5noXguc8CPXtoWDQs=;
 b=sGsuzHaFVS/3XyEAYjla/mMppdJa37xxtX1i2vPMAJI7ZOkphiVwdjwpZ5EuzNTXjr
 W52owbjBDhQ/l29KcZZYLUawK+tJo05gnZteeo0LDApz1+zBFxbz6cMpt0CJu/fqtBld
 EOiHNA1C4voP5UQFcTHR+zqkKW3M19QVbdmVGup3kee7eu70nRW/+SGTtzRetMUPeIbr
 sN5to6jwNgJ7Xsa99e0sh/RVE+DFGzS0IRlNN72T5HsKUnE42LbXCS8OdsUw3Enln3f4
 MWKJ+JEBMWpSymBAvMy9Tx2Og2mgrf+ZvhlHAwa+bnjzxGDjD0tM/rFRfYIYW9O2vVa7
 WlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OH3tsulfMTfljIlsI9K/6O0vLv5noXguc8CPXtoWDQs=;
 b=ZmrqK1+INFB8TNLmENHfXrI+CyPCWdZMFRwXBufLT3Rz82RRwZ2DESq91SNUaQ03pG
 rWNewHR2Hc1aJQQQXlO8cVRXtJTZkkCuXNgqt0/8iVEwQBqjfeYMbQSVnCShEm42Q4zl
 a1GtGQXhYKesy3l8nYUc5af9O4lH6ONsbBHEFRGRkbjxb4aTEohEMxLTU46ot0sKPYs4
 0GJNcvP/arCZFpM5pnrv01JfF+8eDrXvKNSoQMGKLW3HhppgOub5TZwna8lElDswJEb8
 ZNdulqutpbw8N5NXXrIGoS7gUvUkOFFkeUuo4gISwl47bllrHeeHkES4SZPuGp6vlTko
 6UCA==
X-Gm-Message-State: APjAAAV96LkM+Wc0Ut1pXkSHd7HasGac24ZmyQovXuchu8g+3d7eLW65
 eA0VflpCZfgg6OgH3bqClxbhKg==
X-Google-Smtp-Source: APXvYqxF3fU4hiaRdIFZl4tOKXOkNMZXEqaYNS7cJKUafy6ifXjJ0a138y2fQQ9H2h9LVnSgBp/RKA==
X-Received: by 2002:adf:fa49:: with SMTP id y9mr24672195wrr.6.1562231781914;
 Thu, 04 Jul 2019 02:16:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y18sm4951273wmi.23.2019.07.04.02.16.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 02:16:21 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3B311FF87;
 Thu,  4 Jul 2019 10:16:20 +0100 (BST)
References: <20190703135411.28436-1-berrange@redhat.com>
 <87k1cywznu.fsf@zen.linaroharston> <20190704085016.GC20871@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190704085016.GC20871@redhat.com>
Date: Thu, 04 Jul 2019 10:16:20 +0100
Message-ID: <87h882w463.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] doc: document that the monitor console is
 a privileged control interface
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jul 03, 2019 at 10:56:05PM +0100, Alex Benn=C3=A9e wrote:
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
<snip>
>> > The reality is that the monitor console (whether QMP or HMP) is
>> > considered a privileged interface to QEMU and as such must only
>> > be made available to trusted users. IOW, making it available with
>> > no authentication over TCP is simply a, very serious, user
>> > configuration error not a security flaw in QEMU itself.
>>
>> Is this the sort of thing we should emit warnings for? I guess this is a
>> philosophical question as QEMU tends to err towards being taciturn on
>> the command line unless something is actually wrong (and not just
>> stupid).
>>
>> I wouldn't expect a warning for -serial mon:stdio but maybe a
>> non-localhost tcp chardev for o+rw socket might be worth a mention? Of
>> course this sort of sanitising of the command line options does incur
>> cost and complexity in our option processing.
>
> The challenge with issuing warnings is ensuring that we don't give
> false positives, and that's pretty much impossible IMHO.
>
> Even use of plain non-localhost TCP chardevs can be valid in some
> circumstances. For example it would not be surprising to see it
> used if QEMU was inside a Kubernetes container, as two containers
> can communicate with each other over IP & rely on Kubernetes
> networking layer to provide security

That's certainly a valid setup - you're right this is really a policy
question. Oh well I guess if your serious about security you read the
documentation before going to production right ;-)

I assume libvirt et all strive to use secure configurations by default?

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e

