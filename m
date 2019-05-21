Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D616C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB64F208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 15:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB64F208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT6tA-0005rk-0D
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 11:41:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hT6rS-0004ze-Q7
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hT6rR-0001mX-Tq
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:39:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hT6rR-0001lb-O2
	for qemu-devel@nongnu.org; Tue, 21 May 2019 11:39:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id i3so3469177wml.4
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 08:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qU1eEJVdW2BV/uEUHxMc2REJsuTq6/6KZx0N9xfMUq4=;
	b=AlHE/cs8NlGDLdBI33QHlemUpmnJD0qIMo0LePAz9KwocMGylk06lVFP9CjqVs34RY
	R5Gs4n5OCeYUahxrC4NXs+LLxFnCNnpiZQEPtRv/FyFH/iCECvR+wBQ4+pCdMZvhFr5p
	cC7CcZGLnDnJ5drI57BpRwppVP5srOZ2ZO8RhTR4KR4sCnHNWDroPtYh8Bdg9Wn3Szr6
	2x0oYAmpqKEwVG8JRUT7VnvL1FkULLwmVKqEeBO8UiZHk43icRIE1fBw4jIXW07xzjEN
	W6Gc2yLcQC/oEMobRsqEDZtHq7J+i//LB36RO/OehBYc6kALgsXVuQhUEBVbbfU7vEwI
	knuQ==
X-Gm-Message-State: APjAAAU23FWVTH1pV4govIO+/Eit5nb7Qg5JYoAu9YlG1eLKGKLopj7+
	2uWH4typjVjJx/s0/kaO/kHMgA==
X-Google-Smtp-Source: APXvYqzo9CZ2zH4wywcSxQYj2A6QbZKXmJqGHfIDHWUGxRyYzT3s1oIxhhnWY4B2ZzDlpy/G7zwasQ==
X-Received: by 2002:a1c:2dc2:: with SMTP id t185mr4109598wmt.52.1558453168694; 
	Tue, 21 May 2019 08:39:28 -0700 (PDT)
Received: from [192.168.1.38] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h14sm20503457wrt.11.2019.05.21.08.39.27
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 08:39:28 -0700 (PDT)
To: Li Qiang <liq3ea@163.com>, alex.williamson@redhat.com, lvivier@redhat.com
References: <20190521151543.92274-1-liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <5e361877-a360-78b4-da08-a40be675df63@redhat.com>
Date: Tue, 21 May 2019 17:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521151543.92274-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 0/4] hw: vfio: some trivial fix
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
Cc: qemu-trivial@nongnu.org, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 5:15 PM, Li Qiang wrote:
> These patchset fix some trivial issues,
> The first patch makes the code more QOMConventions.
> The second decouples VMStateDescription's name with
> QOM TypeInfo's name.
> The third fixes a typo.
> The fourth reduce duplicated code.
> 
> Change since v1:
> Add more commit message.
> 
> Li Qiang (4):
>   vfio: pci: make "vfio-pci-nohotplug" as MACRO
>   hw: vfio: drop TYPE_FOO MACRO in VMStateDescription
>   vfio: platform: fix a typo
>   pci: msix: move 'MSIX_CAP_LENGTH' to header file

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

