Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EACFA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402B821848
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 11:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNKMLf82"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402B821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKh27-0002jU-Eq
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 06:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iKh1Q-0002KR-1K
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iKh1O-0004nY-Et
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:59:15 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33537)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iKh1O-0004nM-7j
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 06:59:14 -0400
Received: by mail-wm1-x341.google.com with SMTP id r17so4404629wme.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 03:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kRorM4tPxYfcs5bC2pgvjXKpi6nHXZJ2Y6BpTsWM+fM=;
 b=yNKMLf82ae7gROoStQTA4rsrMbIoCSwU+I8ZlSdqL8lipW4oNFYW0P4cQzelwpojf6
 NH3IGTMz4HcqWvW+W+kXPsqJjbrx4JFbRiFrJAbRRr53aAu6Ao28+3FP+2pP/V/xG2Mq
 KElryEKKldISN432S8EkZjDb9D0gXv1qcFemGHkNudwr+pm0VY/jAGDO/CQFm1ix3jRN
 VeLzhvWryDt0Ayl3XjPhatvFZ9UPUBfFDQvNzZSyfxF8goEf6pNlFhCalLBS6cwIWuLX
 T0nl3E5tTEvM7vLTfho2Kudm2GrqmbBQx24SfWUMdL2k37upnh8chjvmDMy5Kd3yprVQ
 9Fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kRorM4tPxYfcs5bC2pgvjXKpi6nHXZJ2Y6BpTsWM+fM=;
 b=Iu90MRduQ4BIeG3ci8c1z4cmduRh9q3mKIjJhR1OiBijCQe1ihzS1xrod7xAFQSTWD
 /fvXEaqVIGXzKHDSGX0axYcVI8Gi44Y4CimdiAoiexBYMdjtODwtmGSafO51x9dtcrBO
 XXcCr+krICtAw/+8j/4Zwo0Mhhr908rKRET5/bYijoomcklZgQOJuDO6Gz2pDYNIubJ8
 IhjU+jNRUNFAB2cK+9U47L9UtiG33NfMuN8Rd5TMAudC+b7AIl5YmRnzD8721h2G/KBx
 HumWYaL0rE6+pHXMXqC24b/7CwGlRyQlwLVSHSuN/lmbYnMA5OrlIkVN4IZSeBUrl+9a
 gFlw==
X-Gm-Message-State: APjAAAXtwTtBflzMzDnlT0GWN7KUhzZJVllp4YX/1oDR7p3Ph3PVKAiD
 h9ohIAj/LHndv3v37MRnLpjoTw==
X-Google-Smtp-Source: APXvYqz+s3Xr7vZPX+vvCjpc1vb4oNt7Ah7XgQHOwHKqfyZG+BH1S0DvXy6Rdps3zDjjyT0BqO5G6w==
X-Received: by 2002:a1c:bc07:: with SMTP id m7mr2911571wmf.103.1571223552822; 
 Wed, 16 Oct 2019 03:59:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t203sm2623404wmf.42.2019.10.16.03.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 03:59:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 649631FF87;
 Wed, 16 Oct 2019 11:59:11 +0100 (BST)
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <b61252af-9eae-d655-0602-d270ce6223ef@gmx.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: Python 2 and test/vm/netbsd
In-reply-to: <b61252af-9eae-d655-0602-d270ce6223ef@gmx.com>
Date: Wed, 16 Oct 2019 11:59:11 +0100
Message-ID: <875zkp5534.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?utf-8?Q?Marc-?= =?utf-8?Q?Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kamil Rytarowski <n54@gmx.com> writes:

> On 16.10.2019 08:11, Thomas Huth wrote:
>> On 16/10/2019 05.00, Eduardo Habkost wrote:
>>> On Tue, Sep 17, 2019 at 08:31:40PM -0300, Eduardo Habkost wrote:
>>>> On Mon, Jul 01, 2019 at 07:25:27PM -0300, Eduardo Habkost wrote:
>>>>> On Mon, Jun 10, 2019 at 01:58:50PM +0100, Peter Maydell wrote:
>>> [...]
>>>>>> The configure check also spits out deprecation warnings for
>>>>>> the NetBSD/FreeBSD/OpenBSD tests/vm configurations. It would be nice
>>>>>> to get those updated.
>>>>>
>>>>> CCing the test/vm maintainers.
>>>>>
>>>>> Fam, Alex, are you able to fix this and create new BSD VM images
>>>>> with Python 3 available?  I thought the VM image configurations
>>>>> were stored in the source tree, but they are downloaded from
>>>>> download.patchew.org.
>>>>
>>>> Fam, Alex, can you help us on this?  Python 2 won't be supported
>>>> anymore, so we need the VM images to be updated.
>>>
>>> Anyone?
>>>
>>> I'm about to submit patches to remove Python 2 support, and this
>>> will break tests/vm/netbsd.
>>>
>>> I'm powerless to fix this issue, because the netbsd image is
>>> hosted at download.patchew.org.
>>
>> Gerd had a patch to convert the netbsd VM script to ad hoc image
>> creation, too:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg04459.html
>>
>> But there was a regression with the serial port between QEMU v3.0 and
>> v4.x, so it was not included:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06784.html
>>
>> I guess someone=E2=84=A2 needs to bisect that regression, so we can fix =
that bug
>> and finally include Gerd's patch...
>>
>>   Thomas
>>
>
> Is this a regression in qemu? How to reproduce the problem? "make
> vm-build-netbsd V=3D1" ?

You'll need to apply the patch from that series:

  tests/vm: netbsd autoinstall, using serial

(all the others got merged)

> I can have a look but I need to know exact specifics of the problem.

Make sure you've cleared out any cached images. As was mentioned in the
thread it seems to be a little host dependant - some host systems it was
working and some it was not.


--
Alex Benn=C3=A9e

