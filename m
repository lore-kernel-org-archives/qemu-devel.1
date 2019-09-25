Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4026C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8858F21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8858F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5a8-0002si-Fg
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iD5YS-0001aY-93
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iD5YQ-0005fn-NI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59240)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iD5YQ-0005fH-Eu
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:54 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 879C0356C5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:33:53 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id s19so1870974wmj.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 04:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bx730Wer+pwc4VBmfSAfJ04BjpCVUv0kzXLIsC10EIQ=;
 b=HyRNI9qC534p0tKP+56Ko1mOEc82NXbWN4Ss1riwJ6/8FwhiVvjQZTnY66YNVGlmWa
 R8g57YqYw9XNXd3gxTjE5XxFt6IBNkEcwRUf9xSsgnMQ6sY6bbScpjjt2Sjz1pkDM3r6
 EkJnQJ4UGJcm5yCBjusjKLqmfmD50R2T/cJJlxi9QFVY13QdT43qtvVhaXwqEpf4m1Tq
 7fJ29fAhiLWtYiObGWIyngrlvq7juy1mLoVw07DlInQyzJOcGc5D+tK1V3YCkfJm0vgL
 utf4fTpigM4Hn4dYTeji6ickxKvgCNIbfKDaEnHTBQER+0DYIGi1l5/1veOJCvLobgJe
 xcmw==
X-Gm-Message-State: APjAAAW+YTroqtYazd5FLKzDbqLpfUt7d3jIlynO0abViC0ZNL47fTnM
 8eHehKnpvAcFfyP+a+ADWLIYzQEuQl/0NBguQzRftLPr1xv5PBRctkx+4NAIcx09MXKSl1em+U0
 R+vIqG3AWx3RlNww=
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr7199626wmi.151.1569411232342; 
 Wed, 25 Sep 2019 04:33:52 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxVVzdy3sluWBfXThx9vefVXa6Catg/jAgWcYuW4h3xaWL6k4hs4K+rCEuz/1gUkZjmkG355A==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr7199588wmi.151.1569411232117; 
 Wed, 25 Sep 2019 04:33:52 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id x6sm4329672wmf.35.2019.09.25.04.33.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 04:33:51 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20190924124433.96810-1-slp@redhat.com>
 <CAFEAcA_2-achqUpTk1fDGWXcWPvTTLPvEtL+owNSWuZ5L3p=XA@mail.gmail.com>
 <87pnjosz3d.fsf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2d5d7297-0a02-276b-5482-948321f5a8bc@redhat.com>
Date: Wed, 25 Sep 2019 13:33:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87pnjosz3d.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 7:51 AM, Sergio Lopez wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Tue, 24 Sep 2019 at 14:25, Sergio Lopez <slp@redhat.com> wrote:
>>>
>>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>>> constructed after the machine model implemented by the latter.
>>>
>>> It's main purpose is providing users a minimalist machine type free
>>> from the burden of legacy compatibility, serving as a stepping stone
>>> for future projects aiming at improving boot times, reducing the
>>> attack surface and slimming down QEMU's footprint.
>>
>>
>>>  docs/microvm.txt                 |  78 +++
>>
>> I'm not sure how close to acceptance this patchset is at the
>> moment, so not necessarily something you need to do now,
>> but could new documentation in docs/ be in rst format, not
>> plain text, please? (Ideally also they should be in the right
>> manual subdirectory, but documentation of system emulation
>> machines at the moment is still in texinfo format, so we
>> don't have a subdir for it yet.)
> 
> Sure. What I didn't get is, should I put it in "docs/microvm.rst" or in
> some other subdirectory?

Should we introduce docs/machines/?

