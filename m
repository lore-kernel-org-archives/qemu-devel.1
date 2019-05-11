Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D7FC04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 18:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 983022173B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 18:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/niPIEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 983022173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34038 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPWks-0002vW-Pz
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 14:29:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hPWk4-0002cs-RO
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hPWk3-0005hS-LR
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:29:04 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:40674)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hPWk3-0005gh-Ga
	for qemu-devel@nongnu.org; Sat, 11 May 2019 14:29:03 -0400
Received: by mail-it1-x144.google.com with SMTP id g71so14338421ita.5
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 11:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=hexg6R3QRBYk1WbU8wvy30nZNdr0JziVAXYWKPs8IDA=;
	b=o/niPIEtVbgEz+hP67ojsGLNzLcOPBEItKYVey13YCm7DDflCy1aSv02YUvCEfrM21
	OAs7Scz5Uexk+FNYQx7zzi9oDOXUgZRBpEAJ0OLGvWybilhpK5HltiaYJZBhXKTP4UZB
	46FtiKfqfw0woIh9GfVjaoDUKksNPFcIvkcXzvSZpEKk7Y4DNMiYY98b60/xPVUdOwfK
	UUh/5JYZ/HKPfV4fVR5kI1PjvfOJ6hCs5mL03yhCv+Z1i8GTf9y4jTVl6mKN3hxLDn7o
	JELIAjrZiJ1AYTHC5Rkheph2Y/rM8cjXmEllh+C5vFE0LgqXMZGIEPfEbEEB4vpLesgi
	E/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=hexg6R3QRBYk1WbU8wvy30nZNdr0JziVAXYWKPs8IDA=;
	b=oiTpVOtj8CFJ7B6Mia1+QZf9mSyiDmLaFDGz5iqCGyMpYgh+gkz1QtB84kYKiUOVOV
	/niaEvtOxLEp1xE5AqMMrcwMOJD+jJVYapjMRgg6hgFRTTna1YO/hZYivFxuwCa7Hnpw
	Q/9hNwOIONtY3aevwrkj0Nu95QVMQXFfgAV06cUQITyutf9G4hrQ2e9geZCbdEnZvB4o
	s65W17UZuraHCDFUL5MnKlVRyQ3JyNFqHvd3oKA5AOoW42YlTsbjXENhN3MbSyBj9o3A
	GLIJOBld0YmvEwImIk3ygZvftTHmk6IzeQWKH6lTBylsCt2SXcZU6gkFJv7jAWGLP+DR
	dorA==
X-Gm-Message-State: APjAAAUds4mmpIV4UiVZTP7d5a9rSgHpMOrve3n4aSsVyRERTUH1GqGi
	277O63ndkIecf1ee35HnU+Y=
X-Google-Smtp-Source: APXvYqwDojV8M6XKOISzowdwBaFSljvnTXb6++tU+15biFgVxfz3iH8DHD4G2eqcNOhzYE/J4sl3Ew==
X-Received: by 2002:a24:920a:: with SMTP id l10mr11632931itd.98.1557599342279; 
	Sat, 11 May 2019 11:29:02 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20]) by smtp.gmail.com with ESMTPSA id
	k197sm4329044itk.36.2019.05.11.11.29.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 11 May 2019 11:29:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <99b26a5a-d756-c1d7-0690-5e419075f5e0@redhat.com>
Date: Sat, 11 May 2019 14:28:59 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D0C069E-C946-47E0-8A1C-EF5B28CFFB09@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
	<E694EDDC-BFF1-4BE9-BFCC-43B303DE6BF7@gmail.com>
	<99b26a5a-d756-c1d7-0690-5e419075f5e0@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::144
Subject: Re: [Qemu-devel] [PATCH] configure: Change capstone's default state
 to disabled
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org,
	=?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
	qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On May 11, 2019, at 2:05 PM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 11/05/2019 19.21, Programmingkid wrote:
>>=20
>>> On Apr 20, 2019, at 6:40 AM, Thomas Huth <thuth@redhat.com> wrote:
>>>=20
>>> On 19/04/2019 15.44, G 3 wrote:
>>>>=20
>>>> On Apr 19, 2019, at 3:10 AM, Thomas Huth wrote:
>>>>=20
>>>>> On 19/04/2019 00.47, John Arbuckle wrote:
>>>>>> Capstone is not necessary in order to use QEMU. Disable it by =
default.
>>>>>> This will save the user the pain of having to figure why QEMU =
isn't
>>>>>> building when this library is missing.
>>>>>>=20
>>>>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>>>> ---
>>>>>> configure | 2 +-
>>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/configure b/configure
>>>>>> index 1c563a7027..77d7967f92 100755
>>>>>> --- a/configure
>>>>>> +++ b/configure
>>>>>> @@ -433,7 +433,7 @@ opengl_dmabuf=3D"no"
>>>>>> cpuid_h=3D"no"
>>>>>> avx2_opt=3D""
>>>>>> zlib=3D"yes"
>>>>>> -capstone=3D""
>>>>>> +capstone=3D"no"
>>>>>> lzo=3D""
>>>>>> snappy=3D""
>>>>>> bzip2=3D""
>>>>>=20
>>>>> AFAIK we ship capstone as a submodule, so how can this be missing? =
Also,
>>>>> our philosophy is to keep everything enabled by default if =
possible, so
>>>>> that the code paths don't bitrot. Thus I don't think that =
disabling this
>>>>> by default is a good idea. ... so if you've got a problem here, =
there
>>>>> must be another solution (e.g. is the system capstone detection =
not
>>>>> working right on your system?).
>>>>>=20
>>>>> Thomas
>>>>=20
>>>> Thank you for replying. Capstone comes with QEMU? Every time I try =
to
>>>> compile QEMU I see an error relating to Capstone not being on my =
system.
>>>> Why do you feel that disabling Capstone by default is not a good =
idea?
>>>>=20
>>>> Here is the error message I see when compiling QEMU:
>>>>=20
>>>> CHK version_gen.h
>>>> make[1]: *** No rule to make target
>>>> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
>>>> make: *** [subdir-capstone] Error 2
>>>=20
>>> I assume you're using a git checkout here, right? For git checkouts, =
the
>>> Makefile should take care of calling the scripts/git-submodule.sh =
script
>>> which should initialize the submodule in the capstone directory.
>>>=20
>>> What's the content of your .git-submodule-status file? What does
>>> "configure" say about capstone support on your system?
>>>=20
>>> Thomas
>>=20
>> Yes I use a git checkout.
>>=20
>> This is the contents of my .git-submodule-status file:
>> #!/bin/sh
> [...]
>=20
> That were the contents of scripts/git-submodule.sh. I meant the hidden
> file .git-submodule-status in the main directory.

This is it:
 88f18909db731a627456f26d779445f84e449536 dtc (v1.4.7)
 f0da6726207b740f6101028b2992f918477a4b08 slirp (v4.0.0-rc0-25-gf0da672)
 b64af41c3276f97f0e181920400ee056b9c88037 tests/fp/berkeley-softfloat-3 =
(heads/master)
 5a59dcec19327396a011a17fd924aed4fec416b3 tests/fp/berkeley-testfloat-3 =
(remotes/origin/HEAD)
 6b3d716e2b6472eb7189d3220552280ef3d832ce ui/keycodemapdb =
(heads/master-4-g6b3d716)


>=20
>> I did a 'make clean' followed by a 'make distclean'. Then tried =
building again using this command line:
>>=20
>> ./configure --target-list=3Dppc-softmmu,i386-softmmu,x86_64-softmmu
>> make -j 4
>=20
> That should normally populate the capstone directory. What happens if
> you run "make git-submodule-update" directly?

Here is the result:
$ make git-submodule-update
make[1]: Nothing to be done for `all'.
make[1]: *** No rule to make target =
`/Users/John/Documents/Development/Projects/Qemu/qemu-git/capstone/libcaps=
tone.a'.  Stop.
make: *** [subdir-capstone] Error 2


>> Here is the error message I see:
>>=20
>> make[1]: *** No rule to make target =
`/Users/John/Documents/Development/Projects/Qemu/qemu-git/capstone/libcaps=
tone.a'. Stop.
>> make: *** [subdir-capstone] Error 2
>>=20
>> I took a look at the capstone folder. There is no 'make' file in this =
folder. Should there be one?
>=20
> Yes, the capstone folder should be populated automatically. Is it
> completely empty for you?

It isn't empty. All I see are two folders: obj and docs.

Thank you.


