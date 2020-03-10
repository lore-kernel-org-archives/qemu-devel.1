Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B30C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621352467D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 12:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYjBXoaB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621352467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBe3g-0005gc-KJ
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 08:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBe2Q-0004MZ-V7
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBe2P-0002aa-8G
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:31:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20306
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBe2P-0002ZR-53
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 08:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583843468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xOwO2YXdH+QvHbL2qyd10FO3LzcScH2SAVUNvz7Za8Q=;
 b=fYjBXoaB3gitYCJturjRZrXiJLpyl662DKaWO2kVwguhsw2ShSPBImzoXaotA+EIAr0FVb
 wR/7C5quwtwxJyP7ek5RXbq0YEdsm0Iv/K9ls0Xgkko5l20/9BQ60+t7eZ3Vn4Pb4AfLiJ
 sGZnOXHXQy0L9SpH2duJSF72c1kbAWM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-PDuScWL6NJ-1VuHWCbuLyg-1; Tue, 10 Mar 2020 08:31:04 -0400
X-MC-Unique: PDuScWL6NJ-1VuHWCbuLyg-1
Received: by mail-wm1-f69.google.com with SMTP id 20so348081wmk.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 05:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iMi2LQegoQJUKCWNKL2j3KU0cs10q1dTpEGC+G4E+5o=;
 b=Se+JR5i14a9f9fE0955ZSMQD41RboYRiMmYr7zeXBRpUP98bIHG7VFkXXPdHy37PcM
 TLlWJrZ6NNlqua+0zshbk3OcUjWQO6CEu+0tJpaNPdhQLV61j0nWK8mr5mnWaNXw7s1Z
 ZH9zPhBe9apGNKrm3VWaPQpM0iHynXm9E/0OH5/y5S+V6PliYc73Qe8pUqgG4fByCn5U
 0whUhPLBzwh4Q8N6Jay8ZDyobE6O3Q95L/jaJ6ofy9WETFmBvbNlzcdOQ/QYroE6Twx0
 yUUythiQTM+ZL8ghIRFvJ28g/xQvkCUjsL2Y12GqkXk4Hs8xYmcapKgp4G19mQkLTAkK
 NUzQ==
X-Gm-Message-State: ANhLgQ0ABkjt3xAGtix00P6FUkD7fDGVtCJqT9/OsdzrDA7R3rziNUVi
 x4O4UdcHVTjg9TSWgo9Ezcsly1lx+qEkBFx5YUuQiy5a4gWeoeqTw5gelqIaCPi6GYA+8YGvtjj
 ZW3AUJFHS7XQRRUk=
X-Received: by 2002:a05:600c:350:: with SMTP id
 u16mr1964934wmd.168.1583843463451; 
 Tue, 10 Mar 2020 05:31:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvVk7mnQFPtlPZ+dwL+Bo64WlqHv7uQcbw8y4ZdyLv1AxEjLBb3HDx3sfIEYpmR7oHgjnwI2g==
X-Received: by 2002:a05:600c:350:: with SMTP id
 u16mr1964886wmd.168.1583843463149; 
 Tue, 10 Mar 2020 05:31:03 -0700 (PDT)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w9sm28221874wrn.35.2020.03.10.05.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Mar 2020 05:31:02 -0700 (PDT)
Subject: Re: [PULL 00/33] Trivial branch patches
To: Kevin Wolf <kwolf@redhat.com>
References: <20200309150837.3193387-1-laurent@vivier.eu>
 <20200309151621-mutt-send-email-mst@kernel.org>
 <8db36062-b45d-6c2e-c7d8-98dd2b9db06f@redhat.com>
 <0bb2eac1-74ab-bee8-e8d0-bac542562cdd@vivier.eu>
 <20200310114548.GA6926@linux.fritz.box>
 <ced636a7-dbda-9247-5dd7-37e8c2ccabce@redhat.com>
 <20200310121300.GD6926@linux.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76fb6e75-6c62-8dd4-e135-ac6c2bdc154d@redhat.com>
Date: Tue, 10 Mar 2020 13:31:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310121300.GD6926@linux.fritz.box>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/10/20 1:13 PM, Kevin Wolf wrote:
> Am 10.03.2020 um 13:00 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> On 3/10/20 12:45 PM, Kevin Wolf wrote:
>>> Am 10.03.2020 um 09:02 hat Laurent Vivier geschrieben:
>>>> Le 09/03/2020 =C3=A0 20:30, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=
=C2=A0:
>>>>> On 3/9/20 8:17 PM, Michael S. Tsirkin wrote:
>>>>>> On Mon, Mar 09, 2020 at 04:08:04PM +0100, Laurent Vivier wrote:
>>>>>>> The following changes since commit
>>>>>>> 7a5853cec479a448edae0fb2aaf4e2f78c9c774d:
>>>>>>>
>>>>>>>   =C2=A0=C2=A0 Merge remote-tracking branch 'remotes/mst/tags/for_u=
pstream' into
>>>>>>> staging (2020-03-09 10:32:53 +0000)
>>>>>>>
>>>>>>> are available in the Git repository at:
>>>>>>>
>>>>>>>   =C2=A0=C2=A0 git://github.com/vivier/qemu.git tags/trivial-branch=
-pull-request
>>>>>>>
>>>>>>> for you to fetch changes up to 916c92503bd5348a33e561db600d8894bde6=
36bb:
>>>>>>>
>>>>>>>   =C2=A0=C2=A0 monitor/hmp-cmds: Remove redundant statement in
>>>>>>> hmp_rocker_of_dpa_groups() (2020-03-09 15:59:31 +0100)
>>>>>>
>>>>>>
>>>>>> Could you avoid CC everyone involved on the whole PULL req?
>>>>>> I was involved in a patch or two and don't really need to see
>>>>>> the whole series. Just the cover and the relevant patches
>>>>>> would be enough - if I do want it there's always lore.
>>>>>
>>>>> I suppose Laurent used git-publish, which has this limitation.
>>>>>
>>>>
>>>> Yes, I use git publish and CC are automatically added.
>>>>
>>>> Philippe, you told me some time ago you have a patch to fix this
>>>> behaviour and only CC people on a patch base. Is it available?
>>
>> I guess you mean https://github.com/philmd/git-publish/commit/5bab6e2cc7=
7, I
>> haven't improved it but plan to spend time on it during my next holidays=
.
>>
>>> Actually, I don't think it's even necessary to CC anyone at all (except
>>> the relevant lists) for pull requests. These patches were already
>>> reviewed.
>>
>> Well as a contributor I find useful to get notified when patches are mer=
ged.
>=20
> Hm, I guess a matter of different preferences then.
>=20
>> I guess remember some time ago patchew (or another bot?) was sending a
>> notification on pull request merged, this was even more useful than Cc'i=
ng
>> ppl on pull-req. It is also helpful when you track someone else patch on=
 the
>> list.
>> Since most of the maintainers now include the patch RFC822 Message-Id, i=
t is
>> now easy for a bot to reply to patch taken from the last.
>=20
> I don't remember anything like this, but having an automatic reply to
> the email thread of each merged patch series might be a good idea.

It was patchew:=20
https://www.mail-archive.com/qemu-devel@nongnu.org/msg623861.html

   From: no-reply@patchew.org

   Subject: A patch has been merged in QEMU: $PatchSubject

   Congratulations, $PatchSubject was merged by the QEMU maintainers.

>=20
> Kevin
>=20
>=20


