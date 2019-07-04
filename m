Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A0DC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37011218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBCL4S3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37011218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hixzB-0000YX-Fe
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hixyP-0008QG-Jh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hixyO-0003X5-9k
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:24:13 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hixyO-0003Tm-0K
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:24:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so4828723wmd.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fkWmLhKOASIpvSqyGh+P1zg1vpj8sKjmnbzQtpkBQwc=;
 b=QBCL4S3Tvx8FjdgUeWPjPhjrElQPF5QwGs86C/Hyr8xjWVlbNj8HHv7YuJiX6/HB8p
 z5S7mnqSfwjc5UAxhLCDJ6JaboZKM/3C+2c2WV3NL/ZJTMooee/yyIl0clgms25gp6fV
 15ViMGxHMHH/NGJp3JuqFBmYxBVJl8uUbCECyVvArt2WjNxV1pZhm707ANPRIorsqTZ2
 atufGTxM05FQ4bLehM56EdYgcuNG1ShrLAG9OV+awJq7Bw8qJ/Rur2zjsy+8etNicGfV
 UwLIzfkyePdfViOgZ5mi35/CWElNGRBcxy9Xqt81o+/I3xrpaiAM8EclYqfhwCZeQbAz
 78kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fkWmLhKOASIpvSqyGh+P1zg1vpj8sKjmnbzQtpkBQwc=;
 b=F3vieWEREjvqWTKfi7liStl48y73jZFlpyVvwtbrzvQvpD81IXzGpFPpkn6uHv2n39
 S2y7Arv08gmsIH2IEyWyeqCLvWUDlTO67lETIwK8M/3O/TeigkyTVFlgOH4obYfg5ibM
 eGm9ZiEHDfZBytW3AaNh6p7ZzkStaDFW63es34ybFLQ4/uGf9WtR9Du3Zik2oqhdD/Nu
 K5vOzToh825pmKCiDyK7RydEWwbs/L3atpesB/bjtQjClZ4IHF4Ybou4nHJVmSUY/Q0X
 dXw1+o4hhsJAWSaXuE8JNrQqWjnv7pFank8naPXnK9K6dnctHRFBor7oGfLhR7B1KJZR
 NDxg==
X-Gm-Message-State: APjAAAUTQ5+TLRsPJXA7Q45rgUm9G9ZKRUDcEC/i4OeEIoS+scc31R7Q
 DFUZEA+xDvxu0edvBSDB0nAonA==
X-Google-Smtp-Source: APXvYqzPUH5NGTQiE6b7oWiwH7HvAXQytIBzWBn7la8A/Q+HyDiX475wl/33pTk27ldnAJ3ApaNMvQ==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr11033395wmj.99.1562232250430; 
 Thu, 04 Jul 2019 02:24:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id z9sm6868002wrs.14.2019.07.04.02.24.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 02:24:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 66B271FF87;
 Thu,  4 Jul 2019 10:24:09 +0100 (BST)
References: <20190703135411.28436-1-berrange@redhat.com>
 <87k1cywznu.fsf@zen.linaroharston> <20190704085016.GC20871@redhat.com>
 <87h882w463.fsf@zen.linaroharston> <20190704091921.GE20871@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-reply-to: <20190704091921.GE20871@redhat.com>
Date: Thu, 04 Jul 2019 10:24:09 +0100
Message-ID: <87ftnmw3t2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

> On Thu, Jul 04, 2019 at 10:16:20AM +0100, Alex Benn=C3=A9e wrote:
>>
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>> > On Wed, Jul 03, 2019 at 10:56:05PM +0100, Alex Benn=C3=A9e wrote:
>> >>
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> <snip>
>> >> > The reality is that the monitor console (whether QMP or HMP) is
>> >> > considered a privileged interface to QEMU and as such must only
>> >> > be made available to trusted users. IOW, making it available with
>> >> > no authentication over TCP is simply a, very serious, user
>> >> > configuration error not a security flaw in QEMU itself.
>> >>
>> >> Is this the sort of thing we should emit warnings for? I guess this i=
s a
>> >> philosophical question as QEMU tends to err towards being taciturn on
>> >> the command line unless something is actually wrong (and not just
>> >> stupid).
>> >>
>> >> I wouldn't expect a warning for -serial mon:stdio but maybe a
>> >> non-localhost tcp chardev for o+rw socket might be worth a mention? Of
>> >> course this sort of sanitising of the command line options does incur
>> >> cost and complexity in our option processing.
>> >
>> > The challenge with issuing warnings is ensuring that we don't give
>> > false positives, and that's pretty much impossible IMHO.
>> >
>> > Even use of plain non-localhost TCP chardevs can be valid in some
>> > circumstances. For example it would not be surprising to see it
>> > used if QEMU was inside a Kubernetes container, as two containers
>> > can communicate with each other over IP & rely on Kubernetes
>> > networking layer to provide security
>>
>> That's certainly a valid setup - you're right this is really a policy
>> question. Oh well I guess if your serious about security you read the
>> documentation before going to production right ;-)
>>
>> I assume libvirt et all strive to use secure configurations by default?
>
> Yes, libvirt exclusively uses a UNIX domain socket for the monitor, and
> of course even if we used a TCP socket, the SELinux/AppArmour policy
> will block any attempts at elevating privs via QMP commands that spawn
> processes or try to access arbitrary files.

Maybe this would make a good topic for a QEMU blog post?

--
Alex Benn=C3=A9e

