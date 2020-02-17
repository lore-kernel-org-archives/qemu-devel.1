Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D29C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1AF20702
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKFmta/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1AF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3daB-0002Us-GV
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3dZa-0001xb-LL
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3dZZ-0000W0-Mg
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3dZZ-0000VR-Jh
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581935057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWIRw0mgUTIdWWaoRcdveMJoBKnLRf/TG4uP/z0utfA=;
 b=IKFmta/+f4NlOZUKB4ChkqNcLKk6YFeolkaT80qrhJ5mcT+nY15OQ+QOri960nYSXl4IRE
 6ljcXU9avB4vvrM0Cj94shxceRaYCSQWc/Ij+OoE0t7+FvQfCgALLQwMymtpAgqJFSB95U
 i2Qs873UZR0NEf3K64bZzkqZNI0Wvrg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-s2WR7GIkOvmOXO8Ywpo4pA-1; Mon, 17 Feb 2020 05:24:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id t6so8745404wru.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:24:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QaGheahGu26oRBC4+LaOicrzlhNOfalNx0TKGIyqvhg=;
 b=VxprFRg+ZLOoj0Jr6J20l8oGy2HpvMX6icPCpBG73hCk4EZpduT0/dvT2Sxi6D2ENE
 SnaeNwAj2SF6j3zogo2SCrTeljO0MgTsR+/6VlVu/gZssf5m8c1odcY8PAmDFUI3/9Ch
 +mMzJzoOltYJEp8Z28XCG1c+wqQY3v6FhajICnBQ27AlVZKk9/lZzN+np2/hmCw6IwH6
 OLOWAkU8eyNOLxBjWGyj3ODjp68y1gevu8HDLAyxnOE6Z/d/q+iIGvDTQ4Mvqs4mQWD2
 6GRAw09hiNvjKMehPFFTpSH/sfNv+Unu9Bmpl8N7mdqSj9A3R86xogRrhz7PPPwZ1LzP
 9WVw==
X-Gm-Message-State: APjAAAXUSn2JX3S5M6PncLFWRuE1X4fyYMW51pb/8lJxyrVkB5YlZw0A
 +giNLKiTvZ08zyEZBIZd64o+XI08N1aeWQcGknPEUvpgACG728yn2LETJbiOOgu3gaV4FMg4dMQ
 2HWT4wRx3gbgMpO0=
X-Received: by 2002:adf:e448:: with SMTP id t8mr21173628wrm.224.1581935052942; 
 Mon, 17 Feb 2020 02:24:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzJrUV+hdbR4CpvJIU/51pL0/SpLlYi2+GAZO6+Q/mUrwKccpS7rW9clK0oVx0A4DKjPmnXvw==
X-Received: by 2002:adf:e448:: with SMTP id t8mr21173582wrm.224.1581935052621; 
 Mon, 17 Feb 2020 02:24:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a26sm24827wmm.18.2020.02.17.02.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 02:24:12 -0800 (PST)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
Message-ID: <0beab4e0-da3d-48fb-062a-de7a6c244c3f@redhat.com>
Date: Mon, 17 Feb 2020 11:24:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
Content-Language: en-US
X-MC-Unique: s2WR7GIkOvmOXO8Ywpo4pA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 10:26 AM, Philippe Mathieu-Daud=E9 wrote:
> Hi Alexey,
>=20
> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>> The following changes since commit=20
>> 05943fb4ca41f626078014c0327781815c6584c5:
>>
>> =A0=A0 ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +110=
0)
>>
>> are available in the Git repository at:
>>
>> =A0=A0 git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>
>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac2:
>>
>> =A0=A0 pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100)
>>
>> ----------------------------------------------------------------
>> Alexey Kardashevskiy (1):
>> =A0=A0=A0=A0=A0=A0 pseries: Update SLOF firmware image
>>
>> =A0 pc-bios/README=A0=A0 |=A0=A0 2 +-
>> =A0 pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>> =A0 roms/SLOF=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>> =A0 3 files changed, 2 insertions(+), 2 deletions(-)
>=20
> I only received the cover, not the patch, have you posted it?

OK I see the SLOF binary is almost 1MB. Maybe this got blocked by spam=20
filter. FYI you can use 'git-format-patch --no-binary' to emit the patch=20
with the commit description but without the content.

>=20
> I noticed on your repository you included a 'git shortlog' output in the=
=20
> commit description, thanks for that detail, much appreciated!
>=20
> Regards,
>=20
> Phil.


