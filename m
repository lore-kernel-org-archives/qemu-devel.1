Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896EAC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:03:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5694520720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fsHkjef8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5694520720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04E2-0004Um-GN
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j04Cm-0002cm-02
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j04Ck-0000K5-Kc
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j04Ck-0000Ju-HD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581084118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OzYA7j6sMSvM1+wsQDNqi9C1gEidxZ3+YnF4SDYAQFQ=;
 b=fsHkjef8+d6DUw9r7cJA/OmOr2mnqJ3VgX3Qe2c1P5SQ55rWeX9DhnDsvRiSQzIobxaPnQ
 Q3Rm25UUns7vUmKJnXkvYymHKrBcYp289KBxfJPPHbhbXJbO98u6zsmcmnl4+n7ZC3DQ0P
 pzook0LGW2H9jjKSn6wHQ/4h8H9mNfs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-usmN2D4sPSeKpBO19aPebQ-1; Fri, 07 Feb 2020 09:01:56 -0500
Received: by mail-wm1-f71.google.com with SMTP id a10so768756wme.9
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cV0y7LUvB+UraMl1o3hn8Zz2xU3X8YlPtRsgStWRpwA=;
 b=i9DN9LhVsB1gFD7KNQ62plYV3NTc7UFLm22RNFm2N7q4d9qyEF2yy2UGxvTHBmdB22
 5Rw/UyusJPrX23RxMb+j7uTzzTgtoU9/QKbcsXOAfTkZzuYfSVODvkKlQeQDmPw5EQMz
 a+4GPYfYFtwxRhgbnzoEWxUTc34jNX0eXYilGNbW1LOlqXgEbD2bbVz2OmHKxd+3Kii4
 G1aLWo/znwRXDDO0cGFqZ3NHYkyqnvuhLKR1JnOaGRi3SdajyotXY8kuRyKaR4Oznmj6
 kFwSwAWAQy/iIk9trJgyFGgowGmnaIBxIMASVN+LAyWfaAoFbEXhOmaDK0vIm+Pkm9Km
 nYtQ==
X-Gm-Message-State: APjAAAWutdoDwjJr0rhD/9XULDBxQyL6ZcvZKxrGM5uzx3einax0AyHl
 OK3r8cwrnbcy3VUd7oqhubUbox0Ko0BY3nL0b4QhVSdXcsOvgVQiDR2bDFQRGC1m/Si3WpeptMK
 Gm0Qc+4pD+ZPbIjM=
X-Received: by 2002:a5d:6545:: with SMTP id z5mr4821952wrv.3.1581084115014;
 Fri, 07 Feb 2020 06:01:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8GvwTvUAzPPkBlJmAuQN6CS0cea2WYsbLxxJV5Hy+GW4DX3D1FGWHsY2+LziXUGhWVvDoZg==
X-Received: by 2002:a5d:6545:: with SMTP id z5mr4821826wrv.3.1581084113411;
 Fri, 07 Feb 2020 06:01:53 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y8sm3433731wma.10.2020.02.07.06.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:01:52 -0800 (PST)
Subject: Re: [PULL 00/46] Python queue 2020-02-06
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200206211936.17098-1-philmd@redhat.com>
 <CAFEAcA_bHE1s5q4bUrna0ph4Zw4m0VynjTcRo9GPjZDThqHZZQ@mail.gmail.com>
 <c43d995e-aaba-80ca-1945-e0ba02d67162@redhat.com>
Message-ID: <0d1891e4-b161-e695-cfc9-ce29dfdd3a34@redhat.com>
Date: Fri, 7 Feb 2020 15:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c43d995e-aaba-80ca-1945-e0ba02d67162@redhat.com>
Content-Language: en-US
X-MC-Unique: usmN2D4sPSeKpBO19aPebQ-1
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 1:39 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/7/20 12:51 PM, Peter Maydell wrote:
>> On Thu, 6 Feb 2020 at 21:21, Philippe Mathieu-Daud=C3=A9=20
>> <philmd@redhat.com> wrote:
>>>
>>> Hi Peter,
>>>
>>> I prepared this series on behalf of Eduardo and
>>> Cleber (one of them will ack this cover).
>>>
>>> Regards,
>>>
>>> Phil.
>>>
>>> The following changes since commit=20
>>> 418fa86dd465b4fd8394373cf83db8fa65d7611c:
>>>
>>> =C2=A0=C2=A0 Merge remote-tracking branch=20
>>> 'remotes/stsquad/tags/pull-testing-040220-1' into staging (2020-02-04=
=20
>>> 18:55:06 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://gitlab.com/philmd/qemu.git tags/python-next-202002=
06
>>>
>>> for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d308=
:
>>>
>>> =C2=A0=C2=A0 .readthedocs.yml: specify some minimum python requirements=
=20
>>> (2020-02-06 21:48:24 +0100)
>>
>> Hi; this fails 'make check' (all hosts):
>>
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 252
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 256
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 265
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 267
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 268
>> =C2=A0=C2=A0 TEST=C2=A0=C2=A0=C2=A0 iotest-qcow2: 283 [fail]
>> QEMU=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --
>> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../.=
./x86_64-softmmu/qemu-system-x86_64"=20
>>
>> -nodefaults -display none -accel qtest
>> QEMU_IMG=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --
>> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../.=
./qemu-img"=20
>>
>> QEMU_IO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --
>> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../.=
./qemu-io"=20
>>
>> =C2=A0 --cache writeback --aio threads -f qcow2
>> QEMU_NBD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --
>> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../.=
./qemu-nbd"=20
>>
>> IMGFMT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- qcow2 (compat=3D1.1)
>> IMGPROTO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- file
>> PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 e104462 4.15.0-74=
-generic
>> TEST_DIR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --
>> /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/scrat=
ch=20
>>
>> SOCK_DIR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- /tmp/tmp.oppAzNNHIY
>> SOCKET_SCM_HELPER --
>> /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/socke=
t_scm_helper=20
>>
>>
>> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/283.out
>> =C2=A0 2020-02-06 18:59:06.291529139 +0000
>> +++=20
>> /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/283.o=
ut.bad=20
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2020-02-07 11:25:38.477373907 +0000
>> @@ -1,8 +1 @@
>> -{"execute": "blockdev-add", "arguments": {"driver": "null-co",
>> "node-name": "target"}}
>> -{"return": {}}
>> -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
>> "image": {"driver": "null-co", "node-name": "base", "size": 1048576},
>> "node-name": "source"}}
>> -{"return": {}}
>> -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
>> "image": "base", "node-name": "other", "take-child-perms": ["write"]}}
>> -{"return": {}}
>> -{"execute": "blockdev-backup", "arguments": {"device": "source",
>> "sync": "full", "target": "target"}}
>> -{"error": {"class": "GenericError", "desc": "Cannot set permissions
>> for backup-top filter: Conflicts with use by other as 'image', which
>> uses 'write' on base"}}
>> +./check: line 866: ./283: Permission denied
>> Not run: 220
>> Failures: 283
>=20
> Interesting.
> I apologize this test is not in my suite.

Actually test 283 was merged yesterday few hours before I send this pull=20
request (which is why it passed the new checkpatch test), and it doesn't=20
use the Python 3 interpreter after shebang.

Once updated to Python 3, with this hunk, the test pass:

-- >8 --
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
  #
  # Test for backup-top filter permission activation failure
  #
---

   ...
   TEST    iotest-qcow2: 244
   TEST    iotest-qcow2: 249
   TEST    iotest-qcow2: 251
   TEST    iotest-qcow2: 252
   TEST    iotest-qcow2: 256
   TEST    iotest-qcow2: 265
   TEST    iotest-qcow2: 267
   TEST    iotest-qcow2: 268
   TEST    iotest-qcow2: 283
Not run: 220
Passed all 115 iotests

I'll rebase and respin.

>=20
>> Failed 1 of 115 iotests
>> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:842:
>> recipe for target 'check-tests/check-block.sh' failed


