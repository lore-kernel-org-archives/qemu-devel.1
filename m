Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55033C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E34B2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E34B2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49296 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcufb-0003MK-Dz
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47165)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuF3-0005j2-Ae
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuEy-00065k-LH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40712)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuEv-00063P-1z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:12:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so9743723wmj.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Au/Jo0DE3qjcWpmB9IZ6LyAnpwBtULbK2uBQG7uqBeE=;
 b=IRJAZtjl3LMlVuHNZDCc/pvgi+f65CJOhsocLOjR5KyFV6D316u7sT3EUepoHPtsAC
 +/JCkfqyCVMRJ7HVhr6H7DlxPsI/PHThiv4EMWpZ+EvqzT+6KHT2fUdYJard4p0i3NKf
 17KrkGnl7NdtRv/PHgAXj5FYqOkLynQ+8uu/rtP0z8pCaxL/Plq/mjSakpcdIkJZc1La
 6GsdJZ+iWjUrgUvhKTPzhAKgevesD6isi52KEVImY4aX0lKV01fv2onIVdj+fkS61zZ0
 how70a7v8TKZi1sRLWwUTtIN/S7QL7HGZeiB75b8f/SbZNM4u1vrKxdkgBFohya9ARSG
 uiyQ==
X-Gm-Message-State: APjAAAX2Wl77B4HKQ87OcKPfdKbH4ZVpX7O1hdKmVHJAfAYAOA+pxrWr
 GHWuM3k41n1tkJY12C4dhJwP+A==
X-Google-Smtp-Source: APXvYqzL7kEt4Bqq20QFjop8/5jRw0qhKGeC0UbS39ISgTD3wDwD44kTLr7RVVkvtzYNVjN48EcUvQ==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20202513wmh.141.1560787931918; 
 Mon, 17 Jun 2019 09:12:11 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l1sm12917483wmg.13.2019.06.17.09.12.11
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:12:11 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0115e101-e2fd-2e12-553a-065d510940ef@redhat.com>
Date: Mon, 17 Jun 2019 18:12:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-7-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v4 06/11] tests/vm: serial console support
 helpers
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/17/19 6:38 AM, Gerd Hoffmann wrote:
> Add a bunch of helpers to talk to the guest using the
> serial console.
> 
> Also drop the hard-coded -serial parameter for the vm
> so QEMUMachine.set_console() actually works.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

From v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

