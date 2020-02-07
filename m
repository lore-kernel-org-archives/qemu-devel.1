Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF898C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC84921741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzV1ws3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC84921741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02vd-000112-UP
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:40:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j02uq-0000bU-O1
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j02up-0004t9-G5
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:39:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42081
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j02up-0004sV-CU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581079162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHUuOUx1DaIUNhlfqMWeOqpmGvjyYQ/xIc8BIOjS2R4=;
 b=HzV1ws3GVJMWdqoC5TNVDvbl+KinjdVxYSj1gTANXV/SljKx4Rmn4DeMTFH4dNBmF+Btds
 eJ/vCH7RFJLWHTHg5xgsTTGr4O6sXIUDXxoIPFXsNvkq2WDKyCNe97oQ8cBxv8cPshyd6V
 +k5eS0Z0pmSs06gDxZGESVOglZz15Bo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-FOZ-JVMQM82-wvxSLJtlkA-1; Fri, 07 Feb 2020 07:39:21 -0500
Received: by mail-wm1-f70.google.com with SMTP id l11so1609407wmi.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 04:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Gy6BvbWxrSYK5z4aRoGi1TT2BOv0LeGf3/KftoRAWgo=;
 b=GFiM85pKr3Y1oiP27HZtErj5dbwzuJDC73awLQqVc7XnCGn/7Dux3ZnRST9MJwO3r6
 wnHHoyZTLEwDxqbZjIJfkFgROI+99+OT8JkSu+YS6o/WLKaR1VqzLRzfawDhogFPVTll
 +XIvWQ8RRkOQym6TvT4jVY0DJ2a5JVW3eNHW3cmBdbigyZAXIATq684+LyoEgvJeI35m
 mzr3KX4gOPGGiP8SF5LrnZRXPkGEngorzV5uuY3VKxuTWk8iEXXlDnyr0Eg+g7LBoTLb
 Cpnd3cv5kgYhuszqmGQviI6K6CfJKOqscm7g6ZXO/ns9A7HPmzuBscq7QP/Z/bSLK/0/
 1C+g==
X-Gm-Message-State: APjAAAXXkDWC8dtj+xOhS9PzlvCpK2eyfH/daitGsak2JBMLkvq56WK8
 x40B4Vb0ypgl1F/YDxdbXyXiDgAizdUqkqM3eJdmMu+JJkqMJlsjo3eFr3oRPxEkmcr5WrgwYj1
 SR9ec8/T2P3Y8eYs=
X-Received: by 2002:a5d:514e:: with SMTP id u14mr4375972wrt.69.1581079159897; 
 Fri, 07 Feb 2020 04:39:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqwdf2SNNMavCcNNAu3a7Gj89k7fvaAO2zia49QJuUNrz9QVMZBPGG+xl5ifUj+M9anJgLhwWw==
X-Received: by 2002:a5d:514e:: with SMTP id u14mr4375951wrt.69.1581079159693; 
 Fri, 07 Feb 2020 04:39:19 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x7sm3249570wrq.41.2020.02.07.04.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 04:39:19 -0800 (PST)
Subject: Re: [PULL 00/46] Python queue 2020-02-06
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200206211936.17098-1-philmd@redhat.com>
 <CAFEAcA_bHE1s5q4bUrna0ph4Zw4m0VynjTcRo9GPjZDThqHZZQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c43d995e-aaba-80ca-1945-e0ba02d67162@redhat.com>
Date: Fri, 7 Feb 2020 13:39:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_bHE1s5q4bUrna0ph4Zw4m0VynjTcRo9GPjZDThqHZZQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: FOZ-JVMQM82-wvxSLJtlkA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Cleber Rosa <crosa@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/7/20 12:51 PM, Peter Maydell wrote:
> On Thu, 6 Feb 2020 at 21:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>
>> Hi Peter,
>>
>> I prepared this series on behalf of Eduardo and
>> Cleber (one of them will ack this cover).
>>
>> Regards,
>>
>> Phil.
>>
>> The following changes since commit 418fa86dd465b4fd8394373cf83db8fa65d76=
11c:
>>
>>    Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-04022=
0-1' into staging (2020-02-04 18:55:06 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/philmd/qemu.git tags/python-next-20200206
>>
>> for you to fetch changes up to 3e3481a5df933a26b47f08e5913821672d28d308:
>>
>>    .readthedocs.yml: specify some minimum python requirements (2020-02-0=
6 21:48:24 +0100)
>=20
> Hi; this fails 'make check' (all hosts):
>=20
>    TEST    iotest-qcow2: 252
>    TEST    iotest-qcow2: 256
>    TEST    iotest-qcow2: 265
>    TEST    iotest-qcow2: 267
>    TEST    iotest-qcow2: 268
>    TEST    iotest-qcow2: 283 [fail]
> QEMU          --
> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../..=
/x86_64-softmmu/qemu-system-x86_64"
> -nodefaults -display none -accel qtest
> QEMU_IMG      --
> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../..=
/qemu-img"
> QEMU_IO       --
> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../..=
/qemu-io"
>   --cache writeback --aio threads -f qcow2
> QEMU_NBD      --
> "/home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/../..=
/qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 e104462 4.15.0-74-generic
> TEST_DIR      --
> /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/scratc=
h
> SOCK_DIR      -- /tmp/tmp.oppAzNNHIY
> SOCKET_SCM_HELPER --
> /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/socket=
_scm_helper
>=20
> --- /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/283.out
>   2020-02-06 18:59:06.291529139 +0000
> +++ /home/petmay01/linaro/qemu-for-merges/build/all/tests/qemu-iotests/28=
3.out.bad
>       2020-02-07 11:25:38.477373907 +0000
> @@ -1,8 +1 @@
> -{"execute": "blockdev-add", "arguments": {"driver": "null-co",
> "node-name": "target"}}
> -{"return": {}}
> -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
> "image": {"driver": "null-co", "node-name": "base", "size": 1048576},
> "node-name": "source"}}
> -{"return": {}}
> -{"execute": "blockdev-add", "arguments": {"driver": "blkdebug",
> "image": "base", "node-name": "other", "take-child-perms": ["write"]}}
> -{"return": {}}
> -{"execute": "blockdev-backup", "arguments": {"device": "source",
> "sync": "full", "target": "target"}}
> -{"error": {"class": "GenericError", "desc": "Cannot set permissions
> for backup-top filter: Conflicts with use by other as 'image', which
> uses 'write' on base"}}
> +./check: line 866: ./283: Permission denied
> Not run: 220
> Failures: 283

Interesting.
I apologize this test is not in my suite.

> Failed 1 of 115 iotests
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:842:
> recipe for target 'check-tests/check-block.sh' failed


