Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DED8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBA9B2072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkDlScwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBA9B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv576-0002Hq-VK
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iv56N-0001qM-3t
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:58:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iv56M-0002qu-3j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:58:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54959
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iv56M-0002qk-0O
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579895925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXI3jjfT78LFFONEj+eLtwXTXXRq7VnNf3viEDSB1yY=;
 b=hkDlScwKAevqkW8BJAfv4WbsFlPuo9TvRME4NMXAzuVzIipaROt274m9HH+VEZHlLf8IdL
 fKnsvhXbNCdcgTXAnpJLpTgeRfos8u/xQuH2cRDKC0PvjPBgd3ttmmQy64sH1qE6g9TN30
 FCjxtrMIiICDtKQiq71C6zOhXgd2eVg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-9txCK6KjNy-eD67LCT5Wpw-1; Fri, 24 Jan 2020 14:58:43 -0500
Received: by mail-wr1-f72.google.com with SMTP id h30so1948338wrh.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 11:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gbKRxkt6WVIRt4MH8z1ngmAw2z3HCmASvCYuQmK8heA=;
 b=csNsS1v+YFlUf8GdSwtQLjkSqtzh+K0aAi2F1Z6uTCQFHDAs+I5VcqlGdzA4eBTMVC
 3dsdII7VPda6cOkdaTFLwGdARXvGiVINQ+yVkWHimp5tH5LwgzwGFZ4IaXHJsHtQ3jDM
 EAaW8l1V4roiRmfqItDzECZCIIdtJYl/jqosSd4A11BLD0ZZDx42rEFgz/0AY5QU+ogF
 09OWx4YzNqADggbLIZV1zo1noF/tOB1QdF9GUMBcQj4z+qbW8+kdzYcvaDxt6kg6l9PI
 6rZvSfWIIhMz7X6LjNiI2S87KDpLKsdtrgkqoOsIfCA5l0/qVS4qQZEAnC6oD047gxgH
 FE6A==
X-Gm-Message-State: APjAAAVAuCS0IIAyCA3+eG711a66wB9pRJRnwQwOw33ACWstNRPBnQH2
 cEN/D4ocpM5ttshQICfpkWgYswLSfOKxR4yueUE4tWg8naCTvyebzhh4gY6SkuTaP37SWqQHXzx
 2WU5a+es+B3fnU0k=
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr701410wmf.113.1579895920979; 
 Fri, 24 Jan 2020 11:58:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqBpmuviVS7SXEtbk7chYzAOpSsFhuM/Qp62TDxuyeF1qHyuRQhU76mDDfrFdp5l0sF6GD/g==
X-Received: by 2002:a1c:1fd0:: with SMTP id f199mr701286wmf.113.1579895919263; 
 Fri, 24 Jan 2020 11:58:39 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id u1sm7660654wmc.5.2020.01.24.11.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 11:58:38 -0800 (PST)
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Peter Maydell <peter.maydell@linaro.org>
References: <1579857411-12996-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_ex8C=S5QbABQrq8GMO=+YJdr4sAW8NRTxS3xUdE49bQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <24cd32d0-8d58-a874-766a-ad8362ca3155@redhat.com>
Date: Fri, 24 Jan 2020 20:58:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ex8C=S5QbABQrq8GMO=+YJdr4sAW8NRTxS3xUdE49bQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: 9txCK6KjNy-eD67LCT5Wpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

On 24/01/20 17:32, Peter Maydell wrote:
> On Fri, 24 Jan 2020 at 09:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0d=
d40:
>>
>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-202=
00121' into staging (2020-01-21 15:29:25 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to b0993e347e065d2323fbb051fdd5a72c95a6e872:
>>
>>   tests: fix test-qga on macosx (2020-01-24 10:14:32 +0100)
>>
>> ----------------------------------------------------------------
>> * Register qdev properties as class properties (Marc-Andr=C3=A9)
>> * Cleanups (Philippe)
>> * virtio-scsi fix (Pan Nengyuan)
>> * Tweak Skylake-v3 model id (Kashyap)
>> * x86 UCODE_REV support and nested live migration fix (myself)
>> * Advisory mode for pvpanic (Zhenwei)
>=20
> This appears to be hanging somewhere inside 'make check' on
> the OpenBSD tests/vm build-n-test :-(  (all the other build
> hosts passed tests fine.)
>=20
> I haven't investigated particularly, but I tried a kill
> and rerun, and it is hanging on the second run, so I guess
> not an intermittent...

Hmm, it's test-qga.  I'll take a look and possibly drop that patch.

Paolo


