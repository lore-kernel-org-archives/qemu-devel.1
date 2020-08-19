Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996F1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67EF9207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=comstyle.com header.i=@comstyle.com header.b="hkJdK48f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67EF9207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=comstyle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8RNh-0006IL-Ko
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1k8RNA-0005pi-GJ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:55:36 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]:2462
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1k8RN8-0004Gr-MQ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:55:36 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4BWv7v4M8bz8PbJ;
 Wed, 19 Aug 2020 12:56:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=comstyle.com; h=from:to:cc
 :date:message-id:in-reply-to:references:subject:mime-version
 :content-type; s=default; bh=la9GjB9NMoZpgcsJ+/nVnV+9Q4c=; b=hkJ
 dK48f9grJzSeKqP4Tfj0W03p0o9CoaWdtU9OpCxgndGtSIQh7V+xtnTCzQa14D7L
 ry9sPe7GB5GVIr39OJ7UxNYzin2otgKHnCRXFe/e+xZxgrH2hTcwTuucsmYBAls8
 7WUfqp585u3KoLHLI5x5z95pL+dA29W07/ciuTwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=from:to:cc
 :date:message-id:in-reply-to:references:subject:mime-version
 :content-type; q=dns; s=default; b=Ghpqf6IZKRGLdwOlW0bVOyEC5ui1V
 /TmyyLcKboeipXx5v8z/jebddwKejzYut+i3Ag97g6mTubp7gLOliRJvkxslFILA
 NYZ0axjzkOsioke56HWTIFvE57IKlF0YXbCcELywl9Q6QyE9PL5Ku5OzvPdDEDh3
 ha/bSl/N6aOlyM=
Received: from [192.168.3.33]
 (bras-vprn-toroon2719w-lp130-20-50-101-192-154.dsl.bell.ca [50.101.192.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4BWv7v3PDzz8Pb7;
 Wed, 19 Aug 2020 12:56:43 -0400 (EDT)
From: Brad Smith <brad@comstyle.com>
To: Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>
CC: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 19 Aug 2020 12:55:31 -0400
Message-ID: <17407a5a7b8.27f3.c0f5e3539a5acb9c2563017afaca17d6@comstyle.com>
In-Reply-To: <15e35d49-2eee-98d5-7f8c-fd2ccb62ff33@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
 <20200818141025.21608-148-pbonzini@redhat.com>
 <ee10449d-d36e-7138-42e2-1c6cdb68320a@comstyle.com>
 <15e35d49-2eee-98d5-7f8c-fd2ccb62ff33@redhat.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: [PULL 147/150] meson: convert po/
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----------17407a5a9bf635c27f339ca6ef"
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
------------17407a5a9bf635c27f339ca6ef
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you're in need of the tools then the package name needs to be gettext-=
tools.

On August 19, 2020 4:06:32 a.m. Paolo Bonzini <pbonzini@redhat.com> wrote=
:

> On 19/08/20 03:56, Brad Smith wrote:
>>
>>
>> This last part is redundant. If glib2 and/or gtk+3 is installed then
>> gettext
>> is installed.
>>
>> The package name is wrong as well as gettext changed from gettext to
>> gettext-runtime relatively recently.
>
> Are you sure gettext-runtime includes xgettext, and is installed if
> glib2 is?
>
> Paolo
>
>>
>>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>>> index b34b14fc53..5f866e09c4 100755
>>> --- a/tests/vm/freebsd
>>> +++ b/tests/vm/freebsd
>>> @@ -39,6 +39,7 @@ class FreeBSDVM(basevm.BaseVM):
>>>          "bash",
>>>          "gmake",
>>>          "gsed",
>>> +        "gettext",
>>>            # libs: crypto
>>>          "gnutls",
>>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>>> index 93d48b6fdd..ffb65a89be 100755
>>> --- a/tests/vm/netbsd
>>> +++ b/tests/vm/netbsd
>>> @@ -37,6 +37,7 @@ class NetBSDVM(basevm.BaseVM):
>>>          "bash",
>>>          "gmake",
>>>          "gsed",
>>> +        "gettext",
>>>            # libs: crypto
>>>          "gnutls",
>>> diff --git a/tests/vm/openbsd b/tests/vm/openbsd
>>> index 7e27fda642..8356646f21 100755
>>> --- a/tests/vm/openbsd
>>> +++ b/tests/vm/openbsd
>>> @@ -36,6 +36,7 @@ class OpenBSDVM(basevm.BaseVM):
>>>          "bash",
>>>          "gmake",
>>>          "gsed",
>>> +        "gettext",
>>>            # libs: usb
>>>          "libusb1",


Sent with AquaMail for Android
https://www.mobisystems.com/aqua-mail

------------17407a5a9bf635c27f339ca6ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.=
w3.org/TR/html4/loose.dtd">
<html>
<body>
<div dir=3D"auto">
<div dir=3D"auto">If you're in need of the tools then the package name need=
s to be gettext-tools.</div><div dir=3D"auto"><br></div>
<div id=3D"aqm-original" style=3D"color: black;">
<div dir=3D"auto">On August 19, 2020 4:06:32 a.m. Paolo Bonzini &lt;pbonzin=
i@redhat.com&gt; wrote:</div>
<div><br></div>
<blockquote type=3D"cite" class=3D"gmail_quote" style=3D"margin: 0 0 0 0.75=
ex; border-left: 1px solid #808080; padding-left: 0.75ex;">
<div dir=3D"auto">On 19/08/20 03:56, Brad Smith wrote:</div>
<blockquote type=3D"cite" class=3D"gmail_quote" style=3D"margin: 0 0 0 0.75=
ex; border-left: 1px solid #0099CC; padding-left: 0.75ex;">
<div dir=3D"auto"><br></div>
<div dir=3D"auto"><br></div>
<div dir=3D"auto">This last part is redundant. If glib2 and/or gtk+3 is ins=
talled then</div>
<div dir=3D"auto">gettext</div>
<div dir=3D"auto">is installed.</div>
<div dir=3D"auto"><br></div>
<div dir=3D"auto">The package name is wrong as well as gettext changed from=
 gettext to</div>
<div dir=3D"auto">gettext-runtime relatively recently.</div>
</blockquote>
<div dir=3D"auto"><br></div>
<div dir=3D"auto">Are you sure gettext-runtime includes xgettext, and is in=
stalled if</div>
<div dir=3D"auto">glib2 is?</div>
<div dir=3D"auto"><br></div>
<div dir=3D"auto">Paolo</div>
<div dir=3D"auto"><br></div>
<blockquote type=3D"cite" class=3D"gmail_quote" style=3D"margin: 0 0 0 0.75=
ex; border-left: 1px solid #0099CC; padding-left: 0.75ex;">
<div dir=3D"auto"><br></div>
<blockquote type=3D"cite" class=3D"gmail_quote" style=3D"margin: 0 0 0 0.75=
ex; border-left: 1px solid #9933CC; padding-left: 0.75ex;">
<div dir=3D"auto">diff --git a/tests/vm/freebsd b/tests/vm/freebsd</div>
<div dir=3D"auto">index b34b14fc53..5f866e09c4 100755</div>
<div dir=3D"auto">--- a/tests/vm/freebsd</div>
<div dir=3D"auto">+++ b/tests/vm/freebsd</div>
<div dir=3D"auto">@@ -39,6 +39,7 @@ class FreeBSDVM(basevm.BaseVM):</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "b=
ash",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
make",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
sed",</div>
<div dir=3D"auto">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "gettext",</d=
iv>
<div dir=3D"auto">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; # libs: crypto</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
nutls",</div>
<div dir=3D"auto">diff --git a/tests/vm/netbsd b/tests/vm/netbsd</div>
<div dir=3D"auto">index 93d48b6fdd..ffb65a89be 100755</div>
<div dir=3D"auto">--- a/tests/vm/netbsd</div>
<div dir=3D"auto">+++ b/tests/vm/netbsd</div>
<div dir=3D"auto">@@ -37,6 +37,7 @@ class NetBSDVM(basevm.BaseVM):</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "b=
ash",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
make",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
sed",</div>
<div dir=3D"auto">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "gettext",</d=
iv>
<div dir=3D"auto">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; # libs: crypto</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
nutls",</div>
<div dir=3D"auto">diff --git a/tests/vm/openbsd b/tests/vm/openbsd</div>
<div dir=3D"auto">index 7e27fda642..8356646f21 100755</div>
<div dir=3D"auto">--- a/tests/vm/openbsd</div>
<div dir=3D"auto">+++ b/tests/vm/openbsd</div>
<div dir=3D"auto">@@ -36,6 +36,7 @@ class OpenBSDVM(basevm.BaseVM):</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "b=
ash",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
make",</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "g=
sed",</div>
<div dir=3D"auto">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "gettext",</d=
iv>
<div dir=3D"auto">&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; # libs: usb</div>
<div dir=3D"auto">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "l=
ibusb1",</div>
</blockquote>
</blockquote>
</blockquote>
</div><div dir=3D"auto"><br></div>
</div>
<div style=3D"color: black;">
<p style=3D"margin: 0 0 1em 0; color: black; font-family: sans-serif;">Sent=
 with <a href=3D"https://play.google.com/store/apps/details?id=3Dorg.kman.A=
quaMail">AquaMail for Android</a><br>
<a href=3D"https://www.mobisystems.com/aqua-mail">https://www.mobisystems.c=
om/aqua-mail</a></p>
</div>
</body>
</html>

------------17407a5a9bf635c27f339ca6ef--


