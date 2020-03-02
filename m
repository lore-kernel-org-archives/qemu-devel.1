Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BEBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E5A72465E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGFVWZB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E5A72465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8uhB-0002xO-He
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8ugR-0002Ig-TS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8ugQ-0007PF-4e
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8ugQ-0007P8-1A
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583192469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+oSe8zzqVcSq0vLPv045MHe/kV45bAOCLegyyb3jAI=;
 b=MGFVWZB5IaYfMxQdhgxTA9rKFJZ7gXU54t8+5lKlr4UPU2F5UEolVN5QNqyGwTnQkt2Uzl
 sBkv6HpHTKimAP1uwn5vkBFr1CwrBmSjvm3lHCTnnwmQkIaJZMBWITVCAIaE97BcCHtI63
 7L2G5rJXVGBDIEP+odCvX+Np2FuzN/M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-50BvCIzZM7uJdGQjYe-wlw-1; Mon, 02 Mar 2020 18:40:57 -0500
X-MC-Unique: 50BvCIzZM7uJdGQjYe-wlw-1
Received: by mail-wr1-f70.google.com with SMTP id m18so382075wro.22
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:40:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KuZJ4N+CT8yOv9ErLnVGZrsEX55Cl7IkMYcUe46guzs=;
 b=LD68nZn8dknwjIk98VtIlirDpxP1aNlTzfEj7ov4Kv5B3otYtDURAWhqFNlPjVeD9D
 Q3bk6OoDDGG6xVys4teLz1t52XIfFW8f45TdwgqXLmuC+LTnXo/AKPQ9/MwIwBpYegWn
 doLhhGpC95MXICz5uEE+UcHyn0mUT7JCZ28SNva2jbJUdCu5qkyUw9AiPNrcsniTNsl4
 GFL2qIXKmI8jqkLl/Re0MC0HH9Wlx7TDSW6k6Qcx5OsfbTc1pWSZ1814L1SoVJkO1YuH
 g7zmlI3XFG6h73OJIq/HFK0o5Ebdb4ee2T/sniMdoTqdhMMDqBgc4nnVg+Gemxd/bcnL
 uCjQ==
X-Gm-Message-State: ANhLgQ1XHwOtFWk7HwWoPnOTcD1uR6CiiOohfggKG2oQ+EnggzEuCSjo
 ppsTiqbN7LXSp7cWc/IM/7iTJI8F8FR2VVPRc59BK+ozAS2leJPLL6pXDEdZjrTu6QfEYrX96D3
 O4xkCQd2U2ebqUJE=
X-Received: by 2002:adf:f052:: with SMTP id t18mr1732334wro.192.1583192456338; 
 Mon, 02 Mar 2020 15:40:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvi6ZWzr+cnI6tXYB8wTmVZn4dHx3yqWdLKDS5I9+lCUmWnVBQ0Ttm+xzCKF/MtdDfguO+lqQ==
X-Received: by 2002:adf:f052:: with SMTP id t18mr1732321wro.192.1583192456141; 
 Mon, 02 Mar 2020 15:40:56 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id c8sm21155359wru.7.2020.03.02.15.40.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:40:55 -0800 (PST)
Subject: Re: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux
 logos displayed on framebuffer
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
References: <1582810056-22646-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1582810056-22646-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAFEAcA_ZL8kd+DaHz-debq7A2simEdB8GNzty890sfc=SjrByw@mail.gmail.com>
 <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <741a03d4-4aa0-4782-771b-98468042c060@redhat.com>
Date: Tue, 3 Mar 2020 00:40:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12519E5CF54B5C921CD4404AC6E70@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 9:58 PM, Aleksandar Markovic wrote:
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Sent: Monday, March 2, 2020 9:26 PM
>> To: Aleksandar Markovic
>> Cc: QEMU Developers; Aleksandar Markovic; Philippe Mathieu-Daud=E9
>> Subject: [EXTERNAL]Re: [PULL 5/5] tests/acceptance: Count multiple Tux l=
ogos displayed on framebuffer
>>
>> On Thu, 27 Feb 2020 at 13:28, Aleksandar Markovic
>> <aleksandar.markovic@rt-rk.com> wrote:
>>>
>>> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>>>
>>> Add a test that verifies that each core properly displays the Tux
>>> logo on the framebuffer device.
>>>
>>> We simply follow the OpenCV "Template Matching with Multiple Objects"
>>> tutorial, replacing Lionel Messi by Tux:
>>> https://docs.opencv.org/4.2.0/d4/dc6/tutorial_py_template_matching.html
>>
>> Hi -- this doesn't seem to work on my system:
>>
>=20
> Thank you for bringing this to our attention.
>=20
> It looks like an honest mistake to me. Too bad
> none of us tested the case of environment like
> yours, even though it looked reasonable to test it.

I'm sorry I missed that, I'm pretty sure I tested it as we noticed this=20
"bug" in Avocado more than 1 year ago already (bug =3D class decorator not=
=20
working). I suppose I forgot to test that on Travis-CI and all my=20
systems have opencv2 installed.

>=20
> Philippe, Peter's solution looks good to me. What
> do you think?

Yes this is correct. Alex suggested it earlier and I resend his patch=20
fixed which is exactly the diff Peter pasted (I am just noticing it now):
https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg00389.html

>=20
> Peter, would you like me to submit a patch with your
> proposal, authored by you, and than soon send it as
> a part of a small pull request?
>=20
> Thanks again,
> Aleksandar
>=20
>>   (38/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine=
.test_integratorcp_console:
>> SKIP: untrusted code
>>   (39/74) tests/acceptance/machine_arm_integratorcp.py:IntegratorMachine=
.test_framebuffer_tux_logo:
>> SKIP: Python NumPy not installed
>>   (40/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n800:
>> SKIP: untrusted code
>>   (41/74) tests/acceptance/machine_arm_n8x0.py:N8x0Machine.test_n810:
>> SKIP: untrusted code
>>   (42/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test=
_bootrom_framebuffer_size:
>> PASS (3.47 s)
>>   (43/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test=
_bootrom_framebuffer_ocr_with_tesseract_v3:
>> SKIP: tesseract v3 OCR tool not available
>>   (44/74) tests/acceptance/machine_m68k_nextcube.py:NextCubeMachine.test=
_bootrom_framebuffer_ocr_with_tesseract_v4:
>> SKIP: tesseract v4 OCR tool not available
>>   (45/74) tests/acceptance/machine_mips_malta.py:MaltaMachineFramebuffer=
.test_mips_malta_i6400_framebuffer_logo_1core:
>> ERROR: name 'cv2' is not defined (5.43 s)
>>
>> It looks like the @skipUnless directive on the class didn't
>> have any effect. Moving it to the individual test functions seems
>> to cause them to be skipped as intended (as the integratorcp
>> framebuffer test is):
>>
>> diff --git a/tests/acceptance/machine_mips_malta.py
>> b/tests/acceptance/machine_mips_malta.py
>> index 92b4f28a112..98463f77573 100644
>> --- a/tests/acceptance/machine_mips_malta.py
>> +++ b/tests/acceptance/machine_mips_malta.py
>> @@ -30,8 +30,6 @@ except ImportError:
>>       CV2_AVAILABLE =3D False
>>
>>
>> -@skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> -@skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>   class MaltaMachineFramebuffer(Test):
>>
>>       timeout =3D 30
>> @@ -91,6 +89,8 @@ class MaltaMachineFramebuffer(Test):
>>               cv2.imwrite(debug_png, screendump_bgr)
>>           self.assertGreaterEqual(tuxlogo_count, cpu_cores_count)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>       def test_mips_malta_i6400_framebuffer_logo_1core(self):
>>           """
>>           :avocado: tags=3Darch:mips64el
>> @@ -99,6 +99,8 @@ class MaltaMachineFramebuffer(Test):
>>           """
>>           self.do_test_i6400_framebuffer_logo(1)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>       def test_mips_malta_i6400_framebuffer_logo_7cores(self):
>>           """
>>           :avocado: tags=3Darch:mips64el
>> @@ -108,6 +110,8 @@ class MaltaMachineFramebuffer(Test):
>>           """
>>           self.do_test_i6400_framebuffer_logo(7)
>>
>> +    @skipUnless(NUMPY_AVAILABLE, 'Python NumPy not installed')
>> +    @skipUnless(CV2_AVAILABLE, 'Python OpenCV not installed')
>>       def test_mips_malta_i6400_framebuffer_logo_8cores(self):
>>           """
>>           :avocado: tags=3Darch:mips64el
>>
>> thanks
>> -- PMM
>=20
>=20


