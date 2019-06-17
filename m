Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688A9C31E5C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4507120863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4507120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49504 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuor-0003a3-CW
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcuC4-000201-QK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcuC2-0003nN-Oq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcuBw-0003hi-UN
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:09:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so10612718wrr.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eX2LMw32zdOYCO340HHqDX4Uqxot+hgujeybt5kItSo=;
 b=SD9OzMb1J/wHo4/CX+Ylqf1PGMAEJMB+uG4UMhufKFWAaOIjPAM8wxzi5pdCF+HYd6
 5KoV4uf2pTV3TiQM50AB+aPrLA9f4w7bqkR8gDMkKOSHBgWYiK6Nnb49/rWNwHqbm4Pq
 ySAyUfAj9Tr0RJVlZbx/2+TIIfYsVDLBOu+7ufilEmjaROEOjV6sQOkVkKImzjN14rhB
 J5dfyC+TQmerHJou7Xpk6InWB9dahHbEYi8rdZCqmkfw82zjUjb8fI2MUiTKdD/pXj2O
 VObLaB71kGIxqbL86lPzEQQntDy1MD+gMjsVsJRGf7kktEzUzoPKjA0cFRGH7/Si8KHH
 eCBw==
X-Gm-Message-State: APjAAAW1j7ri3kQ8/YE3Go32mdaaPGyKmHjamdbAxzk8m8yYIFPrN8ys
 ZvbOrVqaSGj9vVKtHZZqM2+yXQ==
X-Google-Smtp-Source: APXvYqz+Ms3oY9Zs7rLAp3HHBId3hSOwuE1D0DxOAvrOd0I7ZBJyOr8smkDsBhayqQNsnBhr8Opt0Q==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr2123814wrq.350.1560787746522; 
 Mon, 17 Jun 2019 09:09:06 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id n10sm12886690wrw.83.2019.06.17.09.09.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 09:09:05 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190617043858.8290-1-kraxel@redhat.com>
 <20190617043858.8290-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <98658c41-4387-9cfa-92ef-522eaa0becf7@redhat.com>
Date: Mon, 17 Jun 2019 18:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190617043858.8290-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v4 02/11] tests/vm: use ssh with pty
 unconditionally
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
> Allways ask ssh to run with a pseudo terminal.
> Not having a terminal causes problems now and then.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Thomas Huth <thuth@redhat.com>

Tags from v3:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

