Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B2C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:50:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F00E214AF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 05:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F00E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59787 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOFTe-0004u1-Gn
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 01:50:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFRH-000335-CO
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:48:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hOFRG-0006ay-DD
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:48:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hOFRG-0006a5-7d
	for qemu-devel@nongnu.org; Wed, 08 May 2019 01:48:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so1531396wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 22:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=sPDAoLX32kPBn7ETAMXPYULK5FcB3ouvQzH/iSKeQPg=;
	b=SgS1Haem9eiXbj8nMjVh/HVanUtrKxr0zRo9x6E2dh6r82S5zDkyfDyu28HbbAT9pO
	WMCuBcGXsvQCAv74QGSOAYbl8/nBOnn2RMcL2fBJocap4AtjhorVX73K84BbI15HVcD3
	3lMvfcrg4dLc5AudFwHYdhZk7/c+zTml6yEo2d7X7+3vhAtHMt0QRrkgw+R7zXCXm08o
	KCefbGnGyvtvHLoKUrmyOeHVsXxjP3pB9ER8Eya6t4jYYNgANUvSavgNqp8wa0AkN/DT
	pN+TKcXyNzNrql2Xv9oXJ4oO7Hfaxo0O8ok4l85BVKopnCIJv0vDKf7UTdKjsKj6RtY2
	5kNQ==
X-Gm-Message-State: APjAAAV6cbgHvtKBEdjWa3b3+lOImWXpqG2Kggl1vz4uWlfiP9AUnbBW
	uyQDBN1Hhv55pxpJyMHSxnqhUg==
X-Google-Smtp-Source: APXvYqyeH6YzD4vgPwKJLQZZX84oxu/sOlBpdrbF6gMO/tFoqEG/Z/NbXu3LqpvHzuZZXT7YQQ1r9Q==
X-Received: by 2002:a7b:c3c3:: with SMTP id t3mr1465314wmj.88.1557294500246;
	Tue, 07 May 2019 22:48:20 -0700 (PDT)
Received: from [192.168.1.37] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	d16sm11736100wrs.68.2019.05.07.22.48.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 22:48:19 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190502223007.29494-1-samuel.thibault@ens-lyon.org>
	<0da3ec00-9040-f367-7666-a54824f1dcde@redhat.com>
	<20190507141906.GT27205@redhat.com>
	<CAFEAcA9NM8c0bX+D-VFOvO7iOWjcyv1U=F5K5810mHRb-zgDZw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6bb0085-34a3-7b65-da19-b78cd71e9630@redhat.com>
Date: Wed, 8 May 2019 07:48:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9NM8c0bX+D-VFOvO7iOWjcyv1U=F5K5810mHRb-zgDZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 0/2] slirp: move slirp as git submodule
 project
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/7/19 7:01 PM, Peter Maydell wrote:
> On Tue, 7 May 2019 at 15:19, Daniel P. Berrangé <berrange@redhat.com> wrote:
>> On Tue, May 07, 2019 at 09:11:09AM -0500, Eric Blake wrote:
>>> In the meantime, where do we stand on our goal of disabling in-tree builds?
>>
>> The view was largely positive when we discussed it. So I think it just
>> needs someone to step up with a patch proposal, and at the start of the
>> dev cycle is a good time for such a change i guess.
> 
> Pitfalls to watch out for include checking whether any of:
>  * the tests/vm scripting for the BSDs
>  * various travis/etc CI configs
>  * etc

   * most of roms/

> are currently using in-tree builds.
> Paolo will also need to update his coverity build config.
> 
> thanks
> -- PMM
> 

