Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0284C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5524D2076E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXHQm6ZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5524D2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRIBO-00078L-Gl
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 12:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIAT-0006DZ-Ut
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jRIAS-00030F-Bz
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42144
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jRIAO-0002V6-AY
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 12:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587572642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35qdBk7jI1Uo9ppP5dIhgF2Y+LAOFocWgucYcFjzavE=;
 b=IXHQm6ZAe/e0XGk2Uy7J2iXHzvybRgrItHJ/+93bi5cb0JlrLEuqnu+04+ygQuFdWUXAHq
 VKF7YwVxF9qxH5m8Wu92kBeyXQq8lBtp5XfWN/dqVamKneSxIk82tIWwKnYfywCTM7XHGe
 +vthTaNPJvfrjo52Wf1bw1iItnNyGOU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-7dGxoKHsMny-6p8GDYXWbg-1; Wed, 22 Apr 2020 12:24:01 -0400
X-MC-Unique: 7dGxoKHsMny-6p8GDYXWbg-1
Received: by mail-wm1-f70.google.com with SMTP id n17so1061346wmi.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 09:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p/gx0VDGZL7TB4UuCbzyfM7cMOTYJDsxwFrh5uA0Gj4=;
 b=RDTGqH2JqM2iYwUuV5y0kNpr3MTkmJWPredRzoS64nQOwkzqjnjKvwZn4iF+Nl9alx
 pUKgTRrh3vzrxrPzFYSVlERte5wmi6guLrLRKH3So/wzfV4nUOqoSjMvDkkpqnGItWQp
 +/tF6eX92sKK8jsOlQXyGOQcSIASyVaHnipNBL6z8l/uLmp1nVGk/N5L44ZnnsX9hM8A
 QbZ+vGuT95tZXpChhz/gx63X2U0g1M+mGWbMwF5GatGhSbyGGzIGHxMNIoaqQGlOYTu7
 ATODAT+OdVQ5m+wfyAC0K1ZktyMYIclS77VqPxA5L4Zou+ZDJV+aSa4iZxUzKttiE6nP
 oJ9Q==
X-Gm-Message-State: AGi0Pubkx/xjWrn4/1ZcBJdlf97D6x2cKA0feDGUEs5JPXDF/H1Dq9BU
 ZThs2aZ7R6TDHoub6+2ZEWPGYQL8MRXA7eSKd7lKvGPMGtJExb5OO2WBTRMov2fUZVS7xL7AYkR
 vZZTNPFN4UcTF5vg=
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr33811708wro.347.1587572639411; 
 Wed, 22 Apr 2020 09:23:59 -0700 (PDT)
X-Google-Smtp-Source: APiQypLe+zOZg6zQ4RQpFgsEA36VG7QCbuUkgVLhOMVEWkLKX3/i5neH2eQLmBoPs51BcYxCA8dOEw==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr33811681wro.347.1587572639176; 
 Wed, 22 Apr 2020 09:23:59 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f2sm9173599wro.59.2020.04.22.09.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2020 09:23:58 -0700 (PDT)
Subject: Re: qemu 4.2.0 audiodev soundhw
To: Jakob Bohm <jb-gnumlists@wisemo.com>, qemu-discuss@nongnu.org
References: <CA+enFJ=UmKNam-7T5J6UM6JGY7wy492MNm-d_-qKf7rLa818TQ@mail.gmail.com>
 <CAFEAcA_GqNAS-5+081vhpvn=Zk4qbD-SJz5SmN8s5_1_zerpAA@mail.gmail.com>
 <20200420144433.upkagl3qi3nc2lsj@sirius.home.kraxel.org>
 <CA+enFJkFN7B=-6k44Sb8XC2yAy2EGWoLCDMW0tA=GwwaxaspyA@mail.gmail.com>
 <d6c04095-8ea7-30c2-29f1-61c26aed835a@wisemo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7a90dead-ff67-589c-81a9-826c4d0bd86e@redhat.com>
Date: Wed, 22 Apr 2020 18:23:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d6c04095-8ea7-30c2-29f1-61c26aed835a@wisemo.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jakob,

On 4/21/20 12:06 AM, Jakob Bohm wrote:
[...]
>=20
> In fact, over the years, I have found it excruciatingly difficult to find
> valid qemu documentation, as each feature effort tends to leave behind
> half-updated pages and a bunch of uncoordinated messages about what may o=
r
> may not have been implemented in unspecified versions.
I feel your pain and agree.

How can this get improved?

Keeping the command line backward compatible is not an easy task.

There is a quite important effort in progress to improve the documentation.

Users reporting bad/incomplete/outdated documentation would help and=20
motivate developers to fix it. That would reduce the gap between=20
developers implementing features and users.

Do you other have suggestions about what should be improved?

Thanks,

Phil.

>=20
> On 20/04/2020 19:54, Idar Lund wrote:
>> Hi,
>>
>> Thanks for your response!
>>
>> Yes, I agree with you on the options. If you guys decide on (3), I=20
>> would suggest to make it dynamically like this; "-soundhw=20
>> hda,audiodev=3Dsound1". This would then copy the 'audiodev' (and=20
>> possible other) parameter(s) to the '-device' option.
>>
>> My personal preference would be to recommend option number 1.
>> The reason for this is that maintaining a shortcut like this makes it=20
>> hard to maintain for developers when adding features and fixes bugs on=
=20
>> other options. And of course documentation maintainers :)
>> The second reason as I see it is that people tend to create a .sh=20
>> script or similar to start their qemu virtual machines if they don't=20
>> use libvirt/xml schema. And for that, a more verbose command would=20
>> actually be easier to maintain for users since we then know where to=20
>> put parameters like this.
>>
>> -Idar
>>
>> On Mon, Apr 20, 2020 at 4:44 PM Gerd Hoffmann <kraxel@redhat.com=20
>> <mailto:kraxel@redhat.com>> wrote:
>>
>> =C2=A0=C2=A0=C2=A0 On Fri, Apr 17, 2020 at 12:15:30PM +0100, Peter Mayde=
ll wrote:
>> =C2=A0=C2=A0=C2=A0 > On Fri, 17 Apr 2020 at 12:08, Idar Lund <idarlund@g=
mail.com
>> =C2=A0=C2=A0=C2=A0 <mailto:idarlund@gmail.com>> wrote:
>> =C2=A0=C2=A0=C2=A0 > > I'm using qemu-system-x86_64 with the following o=
ptions:
>> =C2=A0=C2=A0=C2=A0 > > -audiodev pa,id=3Dsound1,server=3D/run/user/1000/=
pulse/native \
>> =C2=A0=C2=A0=C2=A0 > > -soundhw hda
>> =C2=A0=C2=A0=C2=A0 > >
>> =C2=A0=C2=A0=C2=A0 > > After upgrade to 4.2.0 (qemu-4.2.0-7.fc32) I get =
the following
>> =C2=A0=C2=A0=C2=A0 warning:
>> =C2=A0=C2=A0=C2=A0 > > (qemu) audio: Device hda: audiodev default parame=
ter is
>> =C2=A0=C2=A0=C2=A0 deprecated, please specify audiodev=3Dsound1
>> =C2=A0=C2=A0=C2=A0 > >
>> =C2=A0=C2=A0=C2=A0 > > The documentation `man qemu-system-x86_64` seems =
to not
>> =C2=A0=C2=A0=C2=A0 reflect this.
>> =C2=A0=C2=A0=C2=A0 > > How am I supposed to use audiodev and soundhw?
>> =C2=A0=C2=A0=C2=A0 >
>> =C2=A0=C2=A0=C2=A0 > This looks like another question for you, Gerd...
>>
>> =C2=A0=C2=A0=C2=A0 Hmm, good question how to proceed here best ...
>>
>> =C2=A0=C2=A0=C2=A0 "-soundhw hda" is a shortcut for "-device intel-hda -=
device
>> =C2=A0=C2=A0=C2=A0 hda-duplex"
>>
>> =C2=A0=C2=A0=C2=A0 You can use "-device intel-hda -device hda-duplex,aud=
iodev=3Dsound1" to
>> =C2=A0=C2=A0=C2=A0 make the warning go away.=C2=A0 That is pretty verbos=
e when compared to
>> =C2=A0=C2=A0=C2=A0 "-soundhw hda" though ...
>>
>> =C2=A0=C2=A0=C2=A0 So the options I see are:
>>
>> =C2=A0=C2=A0=C2=A0 =C2=A0 (1) deprecate the -soundhw shortcut, expect us=
ers to use -device
>> =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 instead.
>> =C2=A0=C2=A0=C2=A0 =C2=A0 (2) have -soundhw lookup the audiodev and add =
it automatically.
>> =C2=A0=C2=A0=C2=A0 Works
>> =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 only with a single audiodev, but=
 that isn't different from what
>> =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 we have today.=C2=A0 If you want=
 do more complicated things you
>> =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 already have to use the more ver=
bose -device command line.
>> =C2=A0=C2=A0=C2=A0 =C2=A0 (3) add audiodev option to -soundhw.
>>
>> =C2=A0=C2=A0=C2=A0 I don't like (3) much, our command line is already me=
ssy enough.
>> =C2=A0=C2=A0=C2=A0 So my
>> =C2=A0=C2=A0=C2=A0 personal preference would be (1) or (2) ...
>>
>=20
> Enjoy
>=20
> Jakob


