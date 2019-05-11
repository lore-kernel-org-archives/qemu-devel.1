Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C3CC04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 17:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B6E2183F
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 17:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCVBYaRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B6E2183F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPVwX-0007ls-Eu
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 13:37:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hPVuf-00064F-HB
	for qemu-devel@nongnu.org; Sat, 11 May 2019 13:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1hPVgg-0008I7-6e
	for qemu-devel@nongnu.org; Sat, 11 May 2019 13:21:31 -0400
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:35607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1hPVgg-0008Hr-20
	for qemu-devel@nongnu.org; Sat, 11 May 2019 13:21:30 -0400
Received: by mail-it1-x144.google.com with SMTP id u186so14241191ith.0
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=/OifHYoeKQau5UtsD7K3eTkae4+wBLh8zoKgk6VfuTo=;
	b=mCVBYaRGbPCxOQxni/yHlrpDZWfjAyDrvSNpQtlvKT2glbHH+B/S7MuYJligcz2D+K
	muI931T/Ktk8FCcDWY5u63Us+SLljrBodxBo/4u0u5QBQzhlzYn5hyChlooZSAURdgv4
	JJV0WmlLyxOlnxJkRUBGnOYsS/AYOjW+bBJXVb1sUo1YTRZWDL6a7K5hhugRkzNUwoV9
	aVycl6slTkRISo9X06KCj4UCgQu5D408EwlXZeisNhqzKZjiD8C0Ud6PM1vnZnJ6GchP
	N1xIMJoFBK2L6tRyGq1Zn8voXj8uY40OEqvTCxU7G7Id/bVxBQDNnA83hxJXfhmRVqLU
	1dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to;
	bh=/OifHYoeKQau5UtsD7K3eTkae4+wBLh8zoKgk6VfuTo=;
	b=K2R/b+ib4DUo/L7eS5W6kyQ31uZRXpdqWQr2yRq2zzeo/Nro8oogvO//BgNtnErlkf
	wjCIBRl/TmyLTdwvBq4xCT+k31hxHBxRj1o7lieMCr4xmyuKVgzYztMANvEdZc9YIfYb
	t3x2zdwn/HMAhRSk5SBDfppBnU3g1FLFGEot0ja4tH+oAVfVONPKAlK0f1kYMM1AcSsl
	5RwC06clDJfvHeCDeXQs4UTVIz1ugV55161HmdScIAKz/hylKzXrLG7n5ERoUj6G8Iis
	n09thQidwuCjpbK50I7VyXoSHCFPPScB2OWR9FFSgDSi7KPleI9No4G0dG0iGEZ5dR0O
	sa2g==
X-Gm-Message-State: APjAAAXqVJ7i0lkh9jnvGQz/1RK9zKulIaeQkxq/yQmLb9zlkg9Hvmac
	btZK78wevBzs2FEycSLbyu4=
X-Google-Smtp-Source: APXvYqxtz/beoD55luz4G9PT2HiWHjAb5e3y/QglLGq9uEjjRiFj8EaHdR9ufCKVCxcuyGs9TsO+Ag==
X-Received: by 2002:a24:6d2:: with SMTP id 201mr12239631itv.75.1557595288692; 
	Sat, 11 May 2019 10:21:28 -0700 (PDT)
Received: from [192.168.0.2] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id c3sm2632238iob.80.2019.05.11.10.21.27
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 11 May 2019 10:21:27 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
Date: Sat, 11 May 2019 13:21:25 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <E694EDDC-BFF1-4BE9-BFCC-43B303DE6BF7@gmail.com>
References: <20190418224706.14014-1-programmingkidx@gmail.com>
	<723372ae-a37a-d7cd-098f-452c7513ce8a@redhat.com>
	<4B73E5E6-2129-43B8-A35E-0CF7DCAE163B@gmail.com>
	<1c4c309a-b785-64d2-60ce-4f0501fcc415@redhat.com>
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


> On Apr 20, 2019, at 6:40 AM, Thomas Huth <thuth@redhat.com> wrote:
>=20
> On 19/04/2019 15.44, G 3 wrote:
>>=20
>> On Apr 19, 2019, at 3:10 AM, Thomas Huth wrote:
>>=20
>>> On 19/04/2019 00.47, John Arbuckle wrote:
>>>> Capstone is not necessary in order to use QEMU. Disable it by =
default.
>>>> This will save the user the pain of having to figure why QEMU isn't
>>>> building when this library is missing.
>>>>=20
>>>> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
>>>> ---
>>>>  configure | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/configure b/configure
>>>> index 1c563a7027..77d7967f92 100755
>>>> --- a/configure
>>>> +++ b/configure
>>>> @@ -433,7 +433,7 @@ opengl_dmabuf=3D"no"
>>>>  cpuid_h=3D"no"
>>>>  avx2_opt=3D""
>>>>  zlib=3D"yes"
>>>> -capstone=3D""
>>>> +capstone=3D"no"
>>>>  lzo=3D""
>>>>  snappy=3D""
>>>>  bzip2=3D""
>>>=20
>>> AFAIK we ship capstone as a submodule, so how can this be missing? =
Also,
>>> our philosophy is to keep everything enabled by default if possible, =
so
>>> that the code paths don't bitrot. Thus I don't think that disabling =
this
>>> by default is a good idea. ... so if you've got a problem here, =
there
>>> must be another solution (e.g. is the system capstone detection not
>>> working right on your system?).
>>>=20
>>>  Thomas
>>=20
>> Thank you for replying. Capstone comes with QEMU? Every time I try to
>> compile QEMU I see an error relating to Capstone not being on my =
system.
>> Why do you feel that disabling Capstone by default is not a good =
idea?
>>=20
>> Here is the error message I see when compiling QEMU:
>>=20
>> CHK version_gen.h
>> make[1]: *** No rule to make target
>> `/Users/John/qemu-git/capstone/libcapstone.a'.  Stop.
>> make: *** [subdir-capstone] Error 2
>=20
> I assume you're using a git checkout here, right? For git checkouts, =
the
> Makefile should take care of calling the scripts/git-submodule.sh =
script
> which should initialize the submodule in the capstone directory.
>=20
> What's the content of your .git-submodule-status file? What does
> "configure" say about capstone support on your system?
>=20
> Thomas

Yes I use a git checkout.

This is the contents of my .git-submodule-status file:
#!/bin/sh
#
# This code is licensed under the GPL version 2 or later.  See
# the COPYING file in the top-level directory.

substat=3D".git-submodule-status"

command=3D$1
shift
maybe_modules=3D"$@"

test -z "$GIT" && GIT=3Dgit

error() {
    echo "$0: $*"
    echo
    echo "Unable to automatically checkout GIT submodules '$modules'."
    echo "If you require use of an alternative GIT binary (for example =
to"
    echo "enable use of a transparent proxy), then please specify it by"
    echo "running configure by with the '--with-git' argument. e.g."
    echo
    echo " $ ./configure --with-git=3D'tsocks git'"
    echo
    echo "Alternatively you may disable automatic GIT submodule =
checkout"
    echo "with:"
    echo
    echo " $ ./configure --disable-git-update"
    echo
    echo "and then manually update submodules prior to running make, =
with:"
    echo
    echo " $ scripts/git-submodule.sh update $modules"
    echo
    exit 1
}

modules=3D""
for m in $maybe_modules
do
    $GIT submodule status $m 1> /dev/null 2>&1
    if test $? =3D 0
    then
        modules=3D"$modules $m"
    else
        echo "warn: ignoring non-existent submodule $m"
    fi
done

if test -n "$maybe_modules" && ! test -e ".git"
then
    echo "$0: unexpectedly called with submodules but no git checkout =
exists"
    exit 1
fi

case "$command" in
status)
    if test -z "$maybe_modules"
    then
         test -s ${substat} && exit 1 || exit 0
    fi

    test -f "$substat" || exit 1
    CURSTATUS=3D$($GIT submodule status $modules)
    OLDSTATUS=3D$(cat $substat)
    test "$CURSTATUS" =3D "$OLDSTATUS"
    exit $?
    ;;
update)
    if test -z "$maybe_modules"
    then
        test -e $substat || touch $substat
        exit 0
    fi

    $GIT submodule update --init $modules 1>/dev/null
    test $? -ne 0 && error "failed to update modules"

    $GIT submodule status $modules > "${substat}"
    test $? -ne 0 && error "failed to save git submodule status" >&2
    ;;
esac

exit 0



The Configure command says:
capstone          git

I did a 'make clean' followed by a 'make distclean'. Then tried building =
again using this command line:

./configure --target-list=3Dppc-softmmu,i386-softmmu,x86_64-softmmu
make -j 4

Here is the error message I see:

make[1]: *** No rule to make target =
`/Users/John/Documents/Development/Projects/Qemu/qemu-git/capstone/libcaps=
tone.a'.  Stop.
make: *** [subdir-capstone] Error 2

I took a look at the capstone folder. There is no 'make' file in this =
folder. Should there be one?

Thank you.=

