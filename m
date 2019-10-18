Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE42CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BC4222C5
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BC4222C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTY7-0006OJ-T0
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLTWG-0004xP-Vn
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLTWF-0000k9-Qy
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34762)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLTWF-0000je-JE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:46:19 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 942B460A8C
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 14:46:18 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id a15so2805078wrr.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6BoLZwoIc+QA0o2XzVDZggds+HRJ668pCAMkU4cajSQ=;
 b=pu2s3GY1ftduVrlIMkzQF/bM31AQO1UQOM/pDrL8V9eLOw+3SHTyc1p6v9MnVfAcgB
 I1KceeArMzTVCVsqlNYrqaFY+Anvdiqon3crMz7/tls1Ab8UTbjM+cqYcZnPUm7296rp
 +MN3MI/YHo60QKyuEppSz3JRNB/5T2sc9uptWFu3wLy4LY/HaXlgqtW/YO8AOaoM3Enu
 R0BPqzFQRCpWu3b9ivMUsRONCIJm9R3y2xbJ5IQyc+MlVovO43n/SAlFwzeQFAjA0xUS
 cMd44EgJDb4yy2drr5+JBqd8CQUc6bV9S2tkBVK0J+2opPHpeCqaJ5c4vPDzf9YYI97u
 9g3g==
X-Gm-Message-State: APjAAAVSa7dQ9VzjOxafyg4kpWOfQM3l54RYRIGUNuJ5Otv7dVCLdhoO
 cyt/bp07t2jGXqrMFcwOfHy2NOQmBij7YJOLwBJjBhn3PugFLzHs05s8l5VwmS556ZEL93k/G01
 mvxqSgEXGN8zienk=
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr7838760wrq.291.1571409976845; 
 Fri, 18 Oct 2019 07:46:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwEvEy8J0O7ESNhuvuus8J1D/HR6laOB+iDq1hmrxZ2fG7T4eKjRbB6UB68OR2t4XOfnyk4oQ==
X-Received: by 2002:a5d:4a81:: with SMTP id o1mr7838741wrq.291.1571409976619; 
 Fri, 18 Oct 2019 07:46:16 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id c18sm5604998wrv.10.2019.10.18.07.46.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:46:16 -0700 (PDT)
Subject: Re: [PATCH] iotests: Skip read-only cases in 118 when run as root
To: Kevin Wolf <kwolf@redhat.com>
References: <20191018115127.2671-1-kwolf@redhat.com>
 <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
 <20191018142720.GH6122@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8a05c6e-0143-63f8-9661-15a56c699d53@redhat.com>
Date: Fri, 18 Oct 2019 16:46:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018142720.GH6122@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:27 PM, Kevin Wolf wrote:
> Am 18.10.2019 um 14:59 hat Philippe Mathieu-Daud=C3=A9 geschrieben:
>> Hi Kevin,
>>
>> On 10/18/19 1:51 PM, Kevin Wolf wrote:
>>> Some tests in 118 use chmod to remove write permissions from the file
>>> and assume that the image can indeed not be opened read-write
>>> afterwards. This doesn't work when the test is run as root, because r=
oot
>>> can still open the file as writable even when the permission bit isn'=
t
>>> set.
>>>
>>> Introduce a @skip_if_root decorator and use it in 118 to skip the tes=
ts
>>> in question when the script is run as root.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>    tests/qemu-iotests/118        |  3 +++
>>>    tests/qemu-iotests/iotests.py | 10 ++++++++++
>>>    2 files changed, 13 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
>>> index ea0b326ae0..9eff46d189 100755
>>> --- a/tests/qemu-iotests/118
>>> +++ b/tests/qemu-iotests/118
>>> @@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>>>            self.assert_qmp(result, 'return[0]/inserted/ro', True)
>>>            self.assert_qmp(result, 'return[0]/inserted/image/filename=
', new_img)
>>> +    @iotests.skip_if_root
>>
>> Why not have case_notrun() return 'reason' and use:
>>
>> @unittest.skipIf(os.getuid() =3D=3D 0, case_notrun("cannot be run as r=
oot"))
>=20
> Because we can't skip test cases using unittest functionality, it
> results in different output (the test is marked as 's' instead of '.'
> and a message '(skipped=3Dn)' is added), which means failure for
> qemu-iotests.

Ah, I see.

>=20
> Apart from that, it would duplicate the logic and the error message in
> every place, which wouldn't be very nice anyway. With the necessary
> iotests.case_notrun() the line becomes > 80 characters, too.

OK.

>=20
>>>        def test_rw_ro_retain(self):
>>>            os.chmod(new_img, 0o444)
>>>            self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
>>> @@ -530,6 +531,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>>>            self.assert_qmp(result, 'return[0]/inserted/ro', True)
>>>            self.assert_qmp(result, 'return[0]/inserted/image/filename=
', new_img)
>>> +    @iotests.skip_if_root
>>>        def test_make_ro_rw(self):
>>>            os.chmod(new_img, 0o444)
>>>            self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
>>> @@ -571,6 +573,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>>>            self.assert_qmp(result, 'return[0]/inserted/ro', True)
>>>            self.assert_qmp(result, 'return[0]/inserted/image/filename=
', new_img)
>>> +    @iotests.skip_if_root
>>>        def test_make_ro_rw_by_retain(self):
>>>            os.chmod(new_img, 0o444)
>>>            self.vm.add_drive(old_img, 'media=3Ddisk', 'none')
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotes=
ts.py
>>> index 3a8f378f90..9c66db613e 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -920,6 +920,16 @@ def skip_if_unsupported(required_formats=3D[], r=
ead_only=3DFalse):
>>>            return func_wrapper
>>>        return skip_test_decorator
>>> +def skip_if_root(func):
>>
>> skip_if_user_is_root() is slightly less confuse.
>=20
> Ok, I can make this change.

Thanks.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

