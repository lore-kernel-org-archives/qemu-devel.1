Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98502C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67CF021E6F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 04:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67CF021E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDLA4-0006S1-Eg
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 00:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iDL8p-0005ou-O9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iDL8g-0007xD-J9
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:12:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iDL8g-0007ll-9M
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 00:12:22 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EACA2026F
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 04:12:19 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id k67so436652wmf.3
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 21:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eQ4DlzDHsQJk2JIF3zeQL3TGothVoDZVFPPT2GR77dg=;
 b=E2OFrJvreYyIXXL+0fMvlA1ALcRqTgrO246GeqkDE13bS+mHgFlmyIEuYEpJchYjd2
 OD53rRbTZ7x39pLXzBwqLLP7LcY6Y8EEW87HqNYQ8+YLqTlRypH6bBdD5aDpjNvyDwlr
 85/IwZXT2Bf69wc9prjQ6pWDAcvIpmnFyI+2kKc0hHQdqAt+BcxAJHrXf1pvSVgYbTPX
 30Y5rmzDJFQw/1N3JgTJukMKMezGSGYowh4NpRatuao/Y1RkOB2AnPe6B7GuDXgNodlB
 vjzX1+nd567jqTKU+qqW7W46GODsOdhleXlKyEImUmg0qXIV5tkRD56ciIEyj+DuS+e5
 Dl0g==
X-Gm-Message-State: APjAAAVibmofT1swV9jq7S7GiiejO/IRIDxIuiG6fo0AWxWvLmDkPnkz
 ErxBKEB4iKHRFCs4/H6ADSJceB22O/0LjJIkNtpDLpEeX+W7E6JL0GpBSvlIgXqYMWdj+YhyyiK
 B++ByenVdhZxuZEU=
X-Received: by 2002:a05:600c:238a:: with SMTP id
 m10mr1161383wma.51.1569471137959; 
 Wed, 25 Sep 2019 21:12:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy9s1beenUetEEX8kwHK1b/mtv/4FsSL4ha8WKt+7HnUFV0af6coq2Vzf9PwNJimtsKhBjlDw==
X-Received: by 2002:a05:600c:238a:: with SMTP id
 m10mr1161371wma.51.1569471137755; 
 Wed, 25 Sep 2019 21:12:17 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id e6sm939360wrp.91.2019.09.25.21.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 21:12:17 -0700 (PDT)
Subject: Re: [PATCH] docker: fix uid maping with podman
To: qemu-devel@nongnu.org
References: <156945431831.7374.10340030777705777822@8230166b0665>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8f79d00c-317a-0c74-dcee-9f750d13b987@redhat.com>
Date: Thu, 26 Sep 2019 06:12:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156945431831.7374.10340030777705777822@8230166b0665>
Content-Type: text/plain; charset=utf-8
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
Cc: fam@euphon.net, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 alex.bennee@linaro.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/26/19 1:31 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com/
> 
> Hi,
> 
> This series failed the asan build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> export ARCH=x86_64
> make docker-image-fedora V=1 NETWORK=1
> time make docker-test-debug@fedora TARGET_LIST=x86_64-softmmu J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> The full log is available at
> http://patchew.org/logs/4b9204cc8ade1c965dc5412c53c6f7c5b4f019a2.1569413332.git.tgolembi@redhat.com/testing.asan/?type=message.

The issue does not seem related to this particular patch:

  SPHINX  docs/specs
Exception occurred:
  File
"/usr/lib/python3.7/site-packages/sphinx/environment/__init__.py", line
612, in get_doctree
    doctree = pickle.load(f)
_pickle.UnpicklingError: pickle data was truncated
The full traceback has been saved in /tmp/sphinx-err-d58j1r8p.log, if
you want to report the issue to the developers.
Please also report this if it was a user error, so that a better error
message can be provided next time.
A bug report can be filed in the tracker at
<https://github.com/sphinx-doc/sphinx/issues>. Thanks!
make: *** [Makefile:990: docs/interop/index.html] Error 2

