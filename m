Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD94C4CED1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:48:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3526A2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 13:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3526A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG1So-0004Qt-9B
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 09:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iG1Rm-0003fj-Uo
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iG1Rm-0005JH-0i
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55672)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iG1Rl-0005Iy-PU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 09:47:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C11F2A09A1
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 13:47:08 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t11so1138457wrq.19
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 06:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IvWHYUyI6ZvM3aQHqOaBs/3DA/Yn+0ZnyW9mLLOgepc=;
 b=UDIX60tPsdJlwANzTIS57g3YTibXYrSUEMk9jwnSYFZrX5CeswDXdT/eECdU/N6m9f
 su8G0xI9rnYi6eo2aTy4ns2kA3Fw94QzVF6LqQxuefahyAN2PfT7EWrgO526hgtCQiQz
 SSv/msrCBcUpOZQ2sl0MAgMkwWKqxt1N+t23c++pPK0SBs5ViBoQLUKBoZL64wJoNNMl
 baMTxEQmLDEja0iPnztkFa9PVDnipCijTXc48QFEFkX0eiOTBOBVNuz7cB40JJP+Bb9o
 3nDpMVT+LJkejVFDa4e91erSwIWEHIrfR5A/KauxUZ+gCjulU/R8fxZbxgjQ45TqLQht
 IMqw==
X-Gm-Message-State: APjAAAXpl+t0y38PfRKjQDy6QBcMLMSXyPHURvzZ+xiDrePMF3GR0VE0
 CvFOMOSqPLHpUH3HS4HrKHQqWQXeG9r9cTELWjnG5oZet+86UcfspOEIJtOLtAUkvpfSMaNJeaf
 Oqul77LSEedv2pAk=
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr6894619wrv.327.1570110426891; 
 Thu, 03 Oct 2019 06:47:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwL4T0giGdyapBvIPp4Fhm8T8p5d4+5jAb5tbfWGjmrGdrjahBFH1+aKe9SLmLCRrZU+C44lg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr6894597wrv.327.1570110426684; 
 Thu, 03 Oct 2019 06:47:06 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g1sm3076711wrv.68.2019.10.03.06.47.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 06:47:06 -0700 (PDT)
Subject: Re: [PATCH v5 01/10] hw/virtio: Factorize virtio-mmio headers
To: Eric Blake <eblake@redhat.com>, Sergio Lopez <slp@redhat.com>
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-2-slp@redhat.com>
 <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com> <87ftkahxyo.fsf@redhat.com>
 <099a33d3-c1ab-f1c9-65e1-7dbd396a4817@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a66479ce-090d-76c7-9a1d-ab399d899762@redhat.com>
Date: Thu, 3 Oct 2019 15:47:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <099a33d3-c1ab-f1c9-65e1-7dbd396a4817@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/19 3:11 PM, Eric Blake wrote:
> On 10/3/19 6:26 AM, Sergio Lopez wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>>>> Put QOM and main struct definition in a separate header file, so it
>>>> can be accessed from other components.
>>>>
>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>=20
>>>> +
>>>> +#ifndef QEMU_VIRTIO_MMIO_H
>>>> +#define QEMU_VIRTIO_MMIO_H
>>>
>>> I'd rather use HW_VIRTIO_MMIO_H
>>
>> Looks like there isn't a consensus in this regard:
>>
>> $ grep "ifndef" *
>=20
>>
>> Do we have an actual policy written somewhere?
>=20
> Past history shows several cleanups near commit fe2611b016, including=20
> commit c0a9956b which mentions scripts/clean-header-guards specifically=
=20
> for this purpose.=C2=A0 So yes, we have a policy, although it is not al=
ways=20
> enforced in a timely manner.

Paul Brook started to use the HW_ prefix introducing the hw/ directory=20
in commit 87ecb68bd (12 years ago). Most of the headers added out of hw/=20
and moved there later do not use this pattern.

