Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1010EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD83B214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD83B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAY1m-0001l5-SX
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAY0n-00011k-O5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAY0m-0003DJ-9R
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:20:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAY0m-0003Ck-2F
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:20:40 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C46D83F3C
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:20:39 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so955205wmb.7
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jyYbz0XzIgl9rFyyjM4EMs+yNi5g3xbOPSc4H6Fq+eI=;
 b=kf1q5c+tH+VMERNawMRwj5WuNoGJWcHUyIh1pn7XK4daa97WREJ9QRF8j4O6uIn/Pe
 7jJvYYvqrol48Z63WauoPHR7+qjyn6c1e+2QtkIb0C+e6A+Paak/PioLyiXurQmce4Dx
 yVi8ll13v9vO2axaPbrVA/mM3e+CxhIwkFOlHOWxsxeaAMovMDu/7Nrwg9mEm54mebBJ
 /JWkvXUH5iGVPVXUpO01ISIAT7oH7uxqavt05AJOlz1LbU2RLJyMgBpN3jkqXy/DsAZJ
 n+hlGJXWp28t0PoeeN1EsarTJiWpXzcxxqlnQIIJR7+c+3sUW3F5u6h03bVu1mffDnjk
 f6qA==
X-Gm-Message-State: APjAAAVG7K6R7WvcKm5sc/MMho91f8qLCwzpyZdmyox/z05TvpD4PGgo
 nAE/C/vVcu2+XczaoojYL1oQyJ6fxPs63XEUICsUPnrtdWxUFRu02YyzgiLxTJ3h69ogn7Vg0QA
 0TI6Of7XP4577iag=
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr2864891wrb.61.1568805637335; 
 Wed, 18 Sep 2019 04:20:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwAD7zrobWKT8Uf+YjSw59YDvAauqECDX16g5XEmfqGiAHFYBN2FQOSWI5BdX8ki5+pn/Nk7w==
X-Received: by 2002:a05:6000:1632:: with SMTP id
 v18mr2864872wrb.61.1568805637151; 
 Wed, 18 Sep 2019 04:20:37 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id d10sm2033088wma.42.2019.09.18.04.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:20:36 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20190918085519.17290-1-kwolf@redhat.com>
 <726ed3db-fe67-98ff-5829-344dc6e04278@redhat.com>
 <20190918092944.GE5207@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <abedeaeb-29d9-c74e-dc9b-13dd964c8076@redhat.com>
Date: Wed, 18 Sep 2019 13:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918092944.GE5207@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Require Python 3.5 or later
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
Cc: jsnow@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/18/19 11:29 AM, Kevin Wolf wrote:
> Am 18.09.2019 um 11:20 hat Max Reitz geschrieben:
>> On 18.09.19 10:55, Kevin Wolf wrote:
>>> Running iotests is not required to build QEMU, so we can have stricte=
r
>>> version requirements for Python here and can make use of new features
>>> and drop compatibility code earlier.
>>>
>>> This makes qemu-iotests skip all Python tests if a Python version bef=
ore
>>> 3.5 is used for the build.

Good idea.

>>>
>>> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  tests/qemu-iotests/check | 14 +++++++++++++-
>>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
>>> index 875399d79f..a68f414d6c 100755
>>> --- a/tests/qemu-iotests/check
>>> +++ b/tests/qemu-iotests/check
>>> @@ -633,6 +633,13 @@ then
>>>      export SOCKET_SCM_HELPER=3D"$build_iotests/socket_scm_helper"
>>>  fi
>>> =20
>>> +# Note that if the Python conditional here evaluates True we will ex=
it
>>> +# with status 1 which is a shell 'false' value.
>>
>> I=E2=80=99d expect everything to exit with 1 if something does not wor=
k.  Thus,
>> I find the short script confusing (I think you do, too, or you wouldn=E2=
=80=99t
>> have written this comment).  Why not make it =E2=80=9Csys.exit(0 if
>> sys.version_info >=3D (3, 5) else 1)=E2=80=9D?

Good suggestion :)

>=20
> I just copied it from configure, actually. :-)
>=20
> But we can use your way, too. I don't really mind.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


