Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7EC04AB4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 03:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369EA20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 03:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu4Ub0aw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369EA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58401 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQkdL-0007T1-Db
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 23:31:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hQkcW-00076e-CZ
	for qemu-devel@nongnu.org; Tue, 14 May 2019 23:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hQkcV-0004VH-6m
	for qemu-devel@nongnu.org; Tue, 14 May 2019 23:30:20 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hQkcU-0004TS-Vg
	for qemu-devel@nongnu.org; Tue, 14 May 2019 23:30:19 -0400
Received: by mail-io1-xd41.google.com with SMTP id g84so1084175ioa.1
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 20:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=K/YDkaFhkV6B6zRyNqwrucnfwILVh5KqBbxeeFr3+SA=;
	b=uu4Ub0aw/dzrg9+nqBxTk1NIg17jUAvYr1g9t3hkFFHkIalqSpg1OHOxhA7R/dzbDE
	UEmf1LUwFTii0YfSQa9tOgA/Esh9UhOd8GAKu3cnWrfB6blXwFw0ifL0+WVsK8XJJ5cs
	xcmxz+KSX/oxPNQIS2w+/eRMiA0uh5nrAN6/WtGfBg0/LT07R1SgNkR/QPhKOkOfIKe6
	QEGj176mzQ/BxxSykJS/MLKryc0EymcP+Y6jHRPXwfvPN/qyDtAz6TQme/IJqF7JW9TE
	mz6TKCj0HqbKRb9136MNdZYrhKoNnZxBFAxcGGvqAFzELW3Jb+mgmsONmaaWchxnOsRS
	Nweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=K/YDkaFhkV6B6zRyNqwrucnfwILVh5KqBbxeeFr3+SA=;
	b=WGh3we0i4g8GeI7s18UeyDQqZsnAL6e9gtiPUAEgbk/WDIRgVpE14+9fliW3j1wcF/
	iCSSZODbOYl9EWflxGDkCxTPdYDXPTNBHz66gCLtiGcQ9V10OqwH0vPm4FeEBu2yJw4Z
	O9aByTVOMcriivoMNb/DcsIASbqiYkmfcvd4vxAMD6HWdz8ec4DTtwiQd7hXAjwL/tOh
	51MNJ8Mkqh8FLe4NlEp+WTFcKoIQPFibRTc84iAUF6k67Ir3VkB5oHgy0/OtDasHGu7S
	aJRKY4lkmRWiHcqCFwy3g+449JQcw4OA023G7oCwLGpsBt0+8+MPQRVYJQt+l5O2mrLV
	Wh3A==
X-Gm-Message-State: APjAAAV4BdrfHK5vriBNkvsUPa4Gp6EGUGpQyAjTOyA3aBxg2wmpyI6c
	BquPNCkFQRpFNp3MMGCOx1A=
X-Google-Smtp-Source: APXvYqyHEal+lJMPnoRjg0FNlpyisy9U89temH+70UVQC67t4HyXKeFbcj6Qn/NzHZ0dyLX5db515w==
X-Received: by 2002:a6b:db03:: with SMTP id t3mr14500519ioc.252.1557891017613; 
	Tue, 14 May 2019 20:30:17 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id y99sm583231ita.23.2019.05.14.20.30.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 20:30:16 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <2f0545db-a95c-d4ba-cc46-110c3b15e1e8@redhat.com>
Date: Tue, 14 May 2019 23:30:14 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <CA4535E1-387F-4C16-AA9A-178184AD7E60@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
	<E694EDDC-BFF1-4BE9-BFCC-43B303DE6BF7@gmail.com>
	<99b26a5a-d756-c1d7-0690-5e419075f5e0@redhat.com>
	<3D0C069E-C946-47E0-8A1C-EF5B28CFFB09@gmail.com>
	<2f0545db-a95c-d4ba-cc46-110c3b15e1e8@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d41
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


> On May 12, 2019, at 9:47 AM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 11/05/2019 20.28, Programmingkid wrote:
>>=20
>>> On May 11, 2019, at 2:05 PM, Thomas Huth <thuth@redhat.com> wrote:
>>>=20
>>> On 11/05/2019 19.21, Programmingkid wrote:
>>>>=20
>>>>> On Apr 20, 2019, at 6:40 AM, Thomas Huth <thuth@redhat.com> wrote:
>>>>>=20
>>>>> On 19/04/2019 15.44, G 3 wrote:
> [...]
>>>>>> Thank you for replying. Capstone comes with QEMU? Every time I =
try to
>>>>>> compile QEMU I see an error relating to Capstone not being on my =
system.
>>>>>> Why do you feel that disabling Capstone by default is not a good =
idea?
>>>>>>=20
>>>>>> Here is the error message I see when compiling QEMU:
>>>>>>=20
>>>>>> CHK version_gen.h
>>>>>> make[1]: *** No rule to make target
>>>>>> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
>>>>>> make: *** [subdir-capstone] Error 2
>>>>>=20
>>>>> I assume you're using a git checkout here, right? For git =
checkouts, the
>>>>> Makefile should take care of calling the scripts/git-submodule.sh =
script
>>>>> which should initialize the submodule in the capstone directory.
>>>>>=20
>>>>> What's the content of your .git-submodule-status file? What does
>>>>> "configure" say about capstone support on your system?
>>>>>=20
>>>>> Thomas
>>>>=20
>>>> Yes I use a git checkout.
>>>>=20
>>>> This is the contents of my .git-submodule-status file:
>>>> #!/bin/sh
>>> [...]
>>>=20
>>> That were the contents of scripts/git-submodule.sh. I meant the =
hidden
>>> file .git-submodule-status in the main directory.
>>=20
>> This is it:
>> 88f18909db731a627456f26d779445f84e449536 dtc (v1.4.7)
>> f0da6726207b740f6101028b2992f918477a4b08 slirp =
(v4.0.0-rc0-25-gf0da672)
>> b64af41c3276f97f0e181920400ee056b9c88037 =
tests/fp/berkeley-softfloat-3 (heads/master)
>> 5a59dcec19327396a011a17fd924aed4fec416b3 =
tests/fp/berkeley-testfloat-3 (remotes/origin/HEAD)
>> 6b3d716e2b6472eb7189d3220552280ef3d832ce ui/keycodemapdb =
(heads/master-4-g6b3d716)
>=20
> There should be an entry for capstone in here, too. :-/
>=20
>>>> I did a 'make clean' followed by a 'make distclean'. Then tried =
building again using this command line:
>>>>=20
>>>> ./configure --target-list=3Dppc-softmmu,i386-softmmu,x86_64-softmmu
>>>> make -j 4
>>>=20
>>> That should normally populate the capstone directory. What happens =
if
>>> you run "make git-submodule-update" directly?
>>=20
>> Here is the result:
>> $ make git-submodule-update
>> make[1]: Nothing to be done for `all'.
>> make[1]: *** No rule to make target =
`/Users/John/Documents/Development/Projects/Qemu/qemu-git/capstone/libcaps=
tone.a'.  Stop.
>> make: *** [subdir-capstone] Error 2
>=20
> Apparently the submodule update is not working right for you. What do
> you get when you run:
>=20
> git submodule update capstone
>=20
> ?

Nothing appears to happen. When I try to make QEMU I still see the same =
error about no rule to make target libcapstone.a.

>=20
>>>> I took a look at the capstone folder. There is no 'make' file in =
this folder. Should there be one?
>>>=20
>>> Yes, the capstone folder should be populated automatically. Is it
>>> completely empty for you?
>>=20
>> It isn't empty. All I see are two folders: obj and docs.
>=20
> Maybe try to clean the folder first:
>=20
> rm -r capstone
> mkdir capstone
> make git-submodule-update
>=20
> If that does not help, maybe try a completely fresh git checkout?

That did it! The capstone folder is now fully populated. Thank you so =
much.=

