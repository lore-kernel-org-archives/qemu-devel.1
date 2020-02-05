Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E92C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3563A21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4QuHY0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3563A21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOmN-0005Y6-DM
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izOlA-0004em-TN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izOl8-0003op-FT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:46:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izOl8-0003lc-5z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580924799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cpZVDW56FIWkvRLgqqNwJwiwLtYQMm/ibYzvKJ3dCJw=;
 b=N4QuHY0FFefwlxNJg76zIy6q+6pcpEluYn1CK3PB3GAgVQlsVc/z1xBbW7Fj7RrqsB+0V9
 fRzpyfh+jB6iqbiZccprtfJTgf08+lJCbrQMgwDjg37NO8T+51QwRfw3M5ocBvRQWfIg7q
 FFoYHcaTgbEyysFdZVAbLUujR+b4eV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-oQENjGqPPBSfb_aF0ZKf8w-1; Wed, 05 Feb 2020 12:46:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A4DF800D54;
 Wed,  5 Feb 2020 17:46:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-186.ams2.redhat.com [10.36.116.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0751460BF7;
 Wed,  5 Feb 2020 17:46:25 +0000 (UTC)
Subject: Re: [PATCH for-5.0 3/4] Remove the core bluetooth code
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191120091014.16883-1-thuth@redhat.com>
 <20191120091014.16883-4-thuth@redhat.com>
 <7a775153-f18d-e766-1d8f-33607f5fa05b@amsat.org>
 <2396dfd4-6c85-d17a-b358-bd058c757f14@redhat.com>
 <CAAdtpL7vPCQ8k91nvBWc_NLrmhu6OPVprUSL8uzi_v6HMiSrnw@mail.gmail.com>
 <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c1f04bd-a0e7-6fbc-68d7-fd5babf1e8d0@redhat.com>
Date: Wed, 5 Feb 2020 18:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gd-ymYd3_cods8BAtwbQeJFodmnmsNo-gLx381rXHKxQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: oQENjGqPPBSfb_aF0ZKf8w-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, libvir-list@redhat.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/02/2020 18.40, Aleksandar Markovic wrote:
> On Sat, Feb 1, 2020 at 7:53 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>
>> On Sat, Feb 1, 2020 at 7:51 PM Thomas Huth <thuth@redhat.com> wrote:
>>> On 01/02/2020 17.09, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
>>>>> index 6099be1d84..ecce4ada2d 100755
>>>>> --- a/configure
>>>>> +++ b/configure
>>>>> @@ -349,7 +349,6 @@ unset target_list_exclude
>>>>>  # Distributions want to ensure that several features are compiled in=
, and it
>>>>>  # is impossible without a --enable-foo that exits if a feature is no=
t found.
>>>>>
>>>>> -bluez=3D""
>>>>>  brlapi=3D""
>>>>>  curl=3D""
>>>>>  curses=3D""
>>>>> @@ -1151,10 +1150,6 @@ for opt do
>>>>>    ;;
>>>>>    --enable-brlapi) brlapi=3D"yes"
>>>>>    ;;
>>>>> -  --disable-bluez) bluez=3D"no"
>>>>> -  ;;
>>>>> -  --enable-bluez) bluez=3D"yes"
>>>>> -  ;;
>>>>
>>>> Now than I'm bisecting over this commit, I realize removing this
>>>> option was not a good idea, we should have done like commit
>>>> cb6414dfec8 or 315d3184525:
>>>>
>>>>   @@ -886,10 +885,6 @@ for opt do
>>>>   -  --disable-uuid) uuid=3D"no"
>>>>   -  ;;
>>>>   -  --enable-uuid) uuid=3D"yes"
>>>>   -  ;;
>>>>   ...
>>>>   +  --enable-uuid|--disable-uuid)
>>>>   +      echo "$0: $opt is obsolete, UUID support is always built" >&2
>>>>   +  ;;
>>>
>>> Looks trivial ... so if it bugs you, just send a patch?
>>
>> I thought about it but this won't fix much, it is too late now.
>>
>> I simply wanted to share this bugged me so we try to avoid doing the
>> same mistake again.
>>
>=20
> I vote for addition of a change similar to what Philippe described.

Feel free to send a patch if it bugs you.

> Furthermore, it looks to me the correct way would be to now do full
> deprecation of --enable-bluez and --disable-bluez. This means adding
> this to documentation (not related to bluetooth devices support), not
> only a change in "configure". This also means that only after two next
> full cycles these options could be removed.
>=20
> True, this could have been done together with bluetooth devices
> support deprecation (and in that case we could have deleted these
> options right away), but it wasn't. Users don't have a crystal ball to
> know that we assumed that --enable-bluez and --disable-bluez were part
> of bluetooth devices support, and could rightfully complain about an
> abrupt elimination of a compile time option.

I disagree. If you don't know that "bluez" is about bluetooth, then you
should likely not use these options anyway.

 Thomas


