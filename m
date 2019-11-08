Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481F4FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5092084D
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:14:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5092084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT46L-00044t-9G
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iT44Z-0002M1-MH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iT44Y-0001v4-Gx
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:13:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:20154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iT44Y-0001uM-7y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:13:06 -0500
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EE415C057867
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 13:13:04 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j17so3150581wru.13
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 05:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hiUvA3Hm+PV20+e2UC0nmfG5QGIi6yJ/ofNe0luHeew=;
 b=PR248DbQrzjy1gqcomaeTMH705zezzohUM43krn0jIw2dZjpdfdnaY1OQBnCqQqjX+
 AfkrKRGzz+yJzHf6TlVhrg+hRxGGEcSCSJJbwhKhsslF6JMmYrVt0vTgyxdFfIODVvR0
 CigvoshOryt42ReiJrY6jvx7FZU+RNCUkkXGr/8vQgKVjzsbYq1HqewGkrie4s796zzs
 GKwYpZefQJCZkyb/m8ednoZCPxbjvPcrHKVjlI1o9HXMpJOKI8QCa0l0oXka6VbOk6Om
 fn8cAFgFcemWVx4hXSi4dvn1z9VshnGMxHhgBQtnc4qvCGOQVowU5l9YUxsb7cIVSd9j
 R1Ng==
X-Gm-Message-State: APjAAAVGjrPH/5q2Kx5q8BCH6nn7dtQoUV4t+VpOHZQm6HACm8RB5zyw
 omPnkT47XiKrEywboqwwrT4vhRPbyNaMGSPVdVvEKKHLDaIJMmOEIHv7JFZWo+mjuv4qaR3CFZx
 3KVQUWWGFbV7AfMk=
X-Received: by 2002:adf:f084:: with SMTP id n4mr8290203wro.369.1573218783751; 
 Fri, 08 Nov 2019 05:13:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzm5HAY8TKstmPrabsQy4fPlfmAsgMkVg09Xyaj9yZjNpEwG1+qxTHNcXLxOvIU7SIhVlZyXg==
X-Received: by 2002:adf:f084:: with SMTP id n4mr8290178wro.369.1573218783546; 
 Fri, 08 Nov 2019 05:13:03 -0800 (PST)
Received: from [192.168.1.38] (62.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.62])
 by smtp.gmail.com with ESMTPSA id x205sm9132072wmb.5.2019.11.08.05.13.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2019 05:13:03 -0800 (PST)
Subject: Re: [PATCH v7 6/8] Acceptance tests: add the build directory to the
 system PATH
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b93b5913-22f1-6aa9-75a1-4b577153288e@redhat.com>
Date: Fri, 8 Nov 2019 14:13:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-7-crosa@redhat.com>
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 4:13 PM, Cleber Rosa wrote:
> So that when binaries such as qemu-img are searched for, those in the
> build tree will be favored.  As a clarification, SRC_ROOT_DIR is
> dependent on the location from where tests are executed, so they are
> equal to the build directory if one is being used.
> 
> The original motivation is that Avocado libraries such as
> avocado.utils.vmimage.get() may use the matching binaries, but it may
> also apply to any other binary that test code may eventually attempt
> to execute.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance/avocado_qemu/__init__.py
> index 17ce583c87..a4bb796a47 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -110,6 +110,12 @@ class Test(avocado.Test):
>           return None
>   
>       def setUp(self):
> +        # Some utility code uses binaries from the system's PATH.  For
> +        # instance, avocado.utils.vmimage.get() uses qemu-img, to
> +        # create a snapshot image.  This is a transparent way of
> +        # making sure those utilities find and use binaries on the
> +        # build tree by default.
> +        os.environ['PATH'] = '%s:%s' % (SRC_ROOT_DIR, os.environ['PATH'])

But qemu-img is compiled in BUILD_ROOT_DIR, isn't it?

Maybe we should pass its path by argument, such --qemu-img /path/to/it.

>           self._vms = {}
>   
>           self.arch = self.params.get('arch',
> 

