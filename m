Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84132CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C6BE222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C6BE222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRry-0008KC-CU
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iLRqv-0007fV-4J
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:59:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iLRqs-0004gz-OT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:59:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28252)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iLRqs-0004gW-FQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:59:30 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95A03328E
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 12:59:28 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id p8so2631512wrj.8
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xXxQHY+brNO6DStSLLuuqCqG4VnNvFHWtW/iDoN5ePI=;
 b=SS53uF+fODMxz2eOADzjnAMBrfvKbmqJ5GcmAKnbeaodE5nUpnCxqkr44n25IoQ+Pf
 KilMFflej+kcZ2egW5FrZek8BLnOb8cD52BzD0c8nFc5Pp3ERL1DnCSg6QyqKA/v075H
 SnBeaWSoJS7Hal1PHyQvxKov1PaRRfcQlmNRimY9dlxhlp5CBV1nvEEk3yDcQ41SpA9d
 GQGPgjAsRuBlvGcSQtmKUIegCXAXk+Y7Zwhm5aS9WwzMPkp6WzcVdEMa2w6uTPhMHf9S
 Nc0ySO9v9A+jWK7WgXvEQtPgEzkDBeRh1Cb24yeDxOnsxDzSwmNibm3PrJQEOzwHRwHa
 fKBg==
X-Gm-Message-State: APjAAAUbMBmCPAY9F8g2zmG5ZrY0e64gkGvW34ZBcZ6jB2Cb7RNKbuKo
 g9fVt5WXAVkXjJKhNbznHQFESE+bEzsKiESsjKP+RdYX/1oajunIH7EYeiznPssQh4dc/pqWkQX
 m8zNNCreDkNR1tCQ=
X-Received: by 2002:adf:e302:: with SMTP id b2mr7248314wrj.298.1571403566782; 
 Fri, 18 Oct 2019 05:59:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzUSwecJ22VBxvqkRPgK5UqUvsh4pGetWJXOzW6UMd/QrWUG+Qr3FQBGAIXeb/QTKi/Ts0Pdg==
X-Received: by 2002:adf:e302:: with SMTP id b2mr7248301wrj.298.1571403566531; 
 Fri, 18 Oct 2019 05:59:26 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id g185sm5499091wme.10.2019.10.18.05.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Oct 2019 05:59:25 -0700 (PDT)
Subject: Re: [PATCH] iotests: Skip read-only cases in 118 when run as root
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191018115127.2671-1-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a810971a-639e-e7dc-d5e6-6b0bb524079b@redhat.com>
Date: Fri, 18 Oct 2019 14:59:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018115127.2671-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Kevin,

On 10/18/19 1:51 PM, Kevin Wolf wrote:
> Some tests in 118 use chmod to remove write permissions from the file
> and assume that the image can indeed not be opened read-write
> afterwards. This doesn't work when the test is run as root, because root
> can still open the file as writable even when the permission bit isn't
> set.
> 
> Introduce a @skip_if_root decorator and use it in 118 to skip the tests
> in question when the script is run as root.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/qemu-iotests/118        |  3 +++
>   tests/qemu-iotests/iotests.py | 10 ++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
> index ea0b326ae0..9eff46d189 100755
> --- a/tests/qemu-iotests/118
> +++ b/tests/qemu-iotests/118
> @@ -446,6 +446,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>           self.assert_qmp(result, 'return[0]/inserted/ro', True)
>           self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>   
> +    @iotests.skip_if_root

Why not have case_notrun() return 'reason' and use:

@unittest.skipIf(os.getuid() == 0, case_notrun("cannot be run as root"))


>       def test_rw_ro_retain(self):
>           os.chmod(new_img, 0o444)
>           self.vm.add_drive(old_img, 'media=disk', 'none')
> @@ -530,6 +531,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>           self.assert_qmp(result, 'return[0]/inserted/ro', True)
>           self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>   
> +    @iotests.skip_if_root
>       def test_make_ro_rw(self):
>           os.chmod(new_img, 0o444)
>           self.vm.add_drive(old_img, 'media=disk', 'none')
> @@ -571,6 +573,7 @@ class TestChangeReadOnly(ChangeBaseClass):
>           self.assert_qmp(result, 'return[0]/inserted/ro', True)
>           self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
>   
> +    @iotests.skip_if_root
>       def test_make_ro_rw_by_retain(self):
>           os.chmod(new_img, 0o444)
>           self.vm.add_drive(old_img, 'media=disk', 'none')
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 3a8f378f90..9c66db613e 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -920,6 +920,16 @@ def skip_if_unsupported(required_formats=[], read_only=False):
>           return func_wrapper
>       return skip_test_decorator
>   
> +def skip_if_root(func):

skip_if_user_is_root() is slightly less confuse.

> +    '''Skip Test Decorator
> +       Runs the test only without root permissions'''
> +    def func_wrapper(*args, **kwargs):
> +        if os.getuid() == 0:
> +            case_notrun('{}: cannot be run as root'.format(args[0]))
> +        else:
> +            return func(*args, **kwargs)
> +    return func_wrapper
> +
>   def execute_unittest(output, verbosity, debug):
>       runner = unittest.TextTestRunner(stream=output, descriptions=True,
>                                        verbosity=verbosity)
> 

