Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5C1C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6717924686
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVJgJTVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6717924686
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBdaZ-0005db-Lp
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBdYl-0003t8-Cw
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:00:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBdYg-0004ju-2g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:00:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48652
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBdYe-0004dM-3g
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583841620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dqdZodhtruS33yIfsVAQ2EvYwwPKsiH4qtRU837xkE=;
 b=QVJgJTVWxMdb834dRyLPmNtF0gHr/coi0bcahTwgrCG+CaBRhDK6dr8m3jwwwXOaknhRsi
 ahokthT1yA9r/4BAEIQ2uFJ+Y6Zp8klXJcFDg+JQuqp7Z32L9YuEJUCS+NRVxUlGrbKDGb
 zLlyDmlpWDozzACtvAZTxS8awSRV5As=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-eIe5A4CRMd2wkfrd-NYt8w-1; Tue, 10 Mar 2020 08:00:17 -0400
X-MC-Unique: eIe5A4CRMd2wkfrd-NYt8w-1
Received: by mail-wm1-f71.google.com with SMTP id i16so281159wmd.9
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7RD8yJxjCiupv/XrS76fvkYC+KM/an7NRp3tjWahsjc=;
 b=c6Wd/ZSNMWnfAkAZoqSQHMKN44mtNa/cMEyqA7kbzsEHWGW7Qq5g9KrVagykzA04WK
 IOogx1eyqAWdhbsUVUYC5oy1yjbC++glwMvKeDjDN2XL7xn5K0PTbXQtmrvNVMOOHvdY
 1V9XXuTpCgyHGVHvgkdz/zXEyAi4dB7AdEBBuaqTm9KYS0e5qCbb5eQoFcwXtK3/J8Y1
 2P2k7Tt3stzUVc51k+fCjSSB3MUZjDXUmk0ORdMtEJ8cE4Q7ntdgAPBpQSfHGx1UIZl1
 fq9AmTV4Q7wZi5by1kxovCEJ5oRqWOhOAPFDAndTEjWw84Kss/gxeuRaILuPpPBHNLlA
 3DVQ==
X-Gm-Message-State: ANhLgQ1lTyG73SLfSu/JKgIvZG6q/v4rFy0OGtSvHGdY4trqmdHDn/w/
 l9dysnNRNn70dAEYBqsVfiZB9uQt5dg3JiIDEt/7tneRqHpxuzIOgDPxatdnYtLY8/52u0Ev4xV
 /USEX/KsFPanoNkM=
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr1761811wmc.166.1583841616562; 
 Tue, 10 Mar 2020 05:00:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs2fYSTSDGOKjPlxF9zaftKQTk1E/jQ7VGgMfO8MMiB3//I0Jhxtp9o3TQZLEAniXrtCArEvA==
X-Received: by 2002:a1c:7e08:: with SMTP id z8mr1761752wmc.166.1583841616158; 
 Tue, 10 Mar 2020 05:00:16 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c26sm3775280wmb.8.2020.03.10.05.00.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 05:00:14 -0700 (PDT)
Subject: Re: [PULL 00/33] Trivial branch patches
To: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
 <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
 <0bb2eac1-74ab-bee8-e8d0-bac542562cdd@vivier.eu>
 <20200310114548.GA6926@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
Date: Tue, 10 Mar 2020 13:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310114548.GA6926@linux.fritz.box>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 12:45 PM, Kevin Wolf wrote:
> Am 10.03.2020 um 09:02 hat Laurent Vivier geschrieben:
>> Le 09/03/2020 =C3=A0 20:30, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=
=A0:
>>> On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
>>>> On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
>>>>> The following changes since commit
>>>>> 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
>>>>>
>>>>>  =C2=A0=C2=A0 Merge remote-tracking branch 'remotes/mst/tags/for_upst=
ream' into
>>>>> staging (2020-03-09 10:32:53 +0000)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>  =C2=A0=C2=A0 git://github.com/vivier/qemu.git tags/trivial-branch-pu=
ll-request
>>>>>
>>>>> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde636=
bb:
>>>>>
>>>>>  =C2=A0=C2=A0 monitor/hmp-cmds: Remove redundant statement in
>>>>> hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
>>>>
>>>>
>>>> Could you avoid CC everyone involved on the whole PULL req?
>>>> I was involved in a patch or two and don't really need to see
>>>> the whole series. Just the cover and the relevant patches
>>>> would be enough - if I do want it there's always lore.
>>>
>>> I suppose Laurent used git-publish, which has this limitation.
>>>
>>
>> Yes, I use git publish and CC are automatically added.
>>
>> Philippe, you told me some time ago you have a patch to fix this
>> behaviour and only CC people on a patch base. Is it available?

I guess you mean=20
https://github.com/philmd/git-publish/commit/5bab6e2cc77, I haven't=20
improved it but plan to spend time on it during my next holidays.

> Actually, I don't think it's even necessary to CC anyone at all (except
> the relevant lists) for pull requests. These patches were already
> reviewed.

Well as a contributor I find useful to get notified when patches are merged=
.

I guess remember some time ago patchew (or another bot?) was sending a=20
notification on pull request merged, this was even more useful than=20
Cc'ing ppl on pull-req. It is also helpful when you track someone else=20
patch on the list.
Since most of the maintainers now include the patch RFC822 Message-Id,=20
it is now easy for a bot to reply to patch taken from the last.

>=20
> Kevin
>=20


