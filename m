Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDCFC004C9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0481221783
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvXnOApJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0481221783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59583 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqAA-0004kC-Tz
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:24:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLq9I-0004PW-FF
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLq9F-0003ko-DT
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLq9F-0003kJ-6C
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:23:49 -0400
Received: by mail-wr1-x441.google.com with SMTP id k23so1799583wrd.4
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=X/X/GkR+j5LtWiIxgCLouqHjw+ezjmjiWjIouofNdK8=;
	b=KvXnOApJxBhpN/98fDZxdhLnZV7+Qbv5Ai+D1Hz2GLCAOsMk/E2UUiBRLh8iigPVLY
	7FEv2p2ZxDGPQ12A2IO1VzLML4pjD7uJ2+qwKu7Lnu65330F+9lPpATKjDwSy3rbC6xS
	MEtB+Trznsyd8+IG7LibkMwnWHAZO92dnHxRFxpqgiiQ9n6WCZbwetomD+DuL863NmU8
	zUmYPAxz5kUnRem8bKPPFIAWWT7OGQdrtiWh3kxSdoXWT4ohj2EJKm4k4wBsaedIDUJC
	TR+1q0fq5pDq0EnIyPO5/YFl2HJckKWRieGW+eFg5eOZpPPkw4pNwUfGucZh5kVdYhb5
	YSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=X/X/GkR+j5LtWiIxgCLouqHjw+ezjmjiWjIouofNdK8=;
	b=NY0mcj4r+p51ZKPq4Ps+IGWO9XWEMZaID1XIvMLzBK1otbvKPimTxjuAnUMHk5lfmp
	IlsRkCUNe55+2s0uHPZDbMfSGkldNCcadYnq8Hgp9ayLkxbetW0d9NZA9O5N3e3OJoBy
	Z5wvaqgPF4mNGi7Gplt0ey6L9cmXNbcz1gFRDd/rbJQGmBX4PLzvuh4JO81RpVIqRedg
	m2540w8f+2M2rrV9virJbi10kvWaMAs+L0sqwT2nOIkr1wM161DBTZYPrAN4Th6V1J8k
	4VTIDwncSsZuMiIgyw/hP+OqwWSLwmoOTkmCFJ7uhxBcGNgns81Iq/Rrs7SaZhP1Wj3q
	sj4A==
X-Gm-Message-State: APjAAAUY6EUDAerkWSqfnoNg1owgDPHDc1WSE9+1XB2DX9iqKtZVGEzx
	Gdpm1YbRnoGlM3+jm0Uwjucy/Q==
X-Google-Smtp-Source: APXvYqzu0U6DM9SeZvH/Acfeil/E+LTfIw2lZLMX9JR2sXIqb0BfP6r+aMHoSTJen+HNMZWb2xC9PQ==
X-Received: by 2002:adf:f109:: with SMTP id r9mr14770718wro.321.1556720627867; 
	Wed, 01 May 2019 07:23:47 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a184sm7266158wmh.36.2019.05.01.07.23.47
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 07:23:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id C2DC11FF87;
	Wed,  1 May 2019 15:23:46 +0100 (BST)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-3-thuth@redhat.com>
	<877eba77ps.fsf@zen.linaroharston>
	<3911e5a6-fe1c-9b4b-d6f8-2da54a47742c@redhat.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <3911e5a6-fe1c-9b4b-d6f8-2da54a47742c@redhat.com>
Date: Wed, 01 May 2019 15:23:46 +0100
Message-ID: <8736ly6yod.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 2/8] tests/qemu-iotests/005: Add a
 sanity check for large sparse file support
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Christophe Fergeau <cfergeau@redhat.com>,
	Max Reitz <mreitz@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501142346.YasJ6PKpbx6YJFMD8pWazB8E0ySl7cMke_c0UE1zjuk@z>


Thomas Huth <thuth@redhat.com> writes:

> On 01/05/2019 13.08, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> "check -raw 005" fails when running on ext4 filesystems - these do not
>>> support such large sparse files. Use the same check as in test 220 to
>>> skip the test in this case.
>>>
>>> Suggested-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/qemu-iotests/005 | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/005 b/tests/qemu-iotests/005
>>> index 2fef63af88..6136ced5c8 100755
>>> --- a/tests/qemu-iotests/005
>>> +++ b/tests/qemu-iotests/005
>>> @@ -55,6 +55,15 @@ if [ "$IMGPROTO" =3D "sheepdog" ]; then
>>>      _notrun "image protocol $IMGPROTO does not support large image siz=
es"
>>>  fi
>>>
>>> +# Sanity check: For raw, we require a file system that permits the cre=
ation
>>> +# of a HUGE (but very sparse) file.  tmpfs works, ext4 does not.
>>
>> Is this comment correct? Running on my ext4 home partition this test
>> seems to be running fine and not skipping.
> Maybe it depends on the kernel version (I'm still using a 3.10-based
> kernel here) or the way how the file system was created? It fails at
> least for me on my ext4 partition.
> But I can adjust a little bit for sure.

  # Sanity check: For raw, we require a file system that permits the
  # creation of a HUGE (but very sparse) file. Check we can create such
  # a file before continuing.

?

>
>  Thomas


--
Alex Benn=C3=A9e

