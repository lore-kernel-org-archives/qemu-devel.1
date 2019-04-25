Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8940C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E1D214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 10:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E1D214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJbXt-0003fg-Hp
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 06:24:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJbX6-0003MI-3B
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJbX4-0004ns-Ne
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJbX4-0004nG-FL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 06:23:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so9745935wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 03:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=EWcZQsfDKT1wNmhW15Pjm9RHtLJeuTHvtp5bO8sqnp0=;
	b=LXiDdONhNLduLjMTPU4wiQZ1XSwYzgZPyjEIj2bPVC3ntEi4Zv3G1kHcHZPRywzlYu
	9wVSylbwCoqwYoj9D35eXgl1NZGBbYwIUfl3ayGr+3d+KVOrlHIgd2kUKA3+vUdcPXTZ
	4thcexOvkDf+G2b3mq8uj9WYqzTzV7GkJ+2TT4HaAp+TrM4680eWKagJUMPuOf2+6AW7
	+Btn2MPjeD00TWA7v7zOK7WauHYkD4Gd2XuB/OK1lu5Lqa9Td7XM8vnjds9UlQV0HGtK
	t/3RjkN16udoVXitHoDiP3donOdM+XvVKF7UXqfSAut8qs/keH6FodSIqVmmrvyMkwIu
	Nk9Q==
X-Gm-Message-State: APjAAAWcKK9I9s+R54kNq8QNYPDjIV9J6IHODuN6RAshMaDn9ETEulBp
	3Dld3ETQXff2HNAZCMGypdJf+JtVdkfqfg==
X-Google-Smtp-Source: APXvYqxrnUk+ONZuOLAcBq4Kw4nfofFB2uZKvcLkfGPm+0eebEjW5VhNEVAInJoss6bc/d8PA5jcHw==
X-Received: by 2002:a1c:7211:: with SMTP id n17mr2839276wmc.32.1556187788146; 
	Thu, 25 Apr 2019 03:23:08 -0700 (PDT)
Received: from [192.168.1.25] (abayonne-654-1-209-122.w109-222.abo.wanadoo.fr.
	[109.222.216.122]) by smtp.gmail.com with ESMTPSA id
	v14sm1634828wra.58.2019.04.25.03.23.06
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 25 Apr 2019 03:23:07 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
	<CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d773a58b-e33c-fa66-5afc-05bdc85efa53@redhat.com>
Date: Thu, 25 Apr 2019 12:23:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
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
Cc: lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>,
	Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425102303.QSwGOjR1ziTa6jNJN5uSmocb_p6bDzAeSL2b8Todswk@z>

On 4/25/19 10:29 AM, Li Qiang wrote:
> 
> 
> Gerd Hoffmann <kraxel@redhat.com <mailto:kraxel@redhat.com>> 于2019年4月
> 25日周四 下午4:15写道：
> 
>     On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
>     > Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>> 于2019年4
>     月24日周三 上午12:29写道：
>     >
>     > > Is this endianess-safe? Or do you need to byteswap
>     reboot_timeout if the
>     > > host and guest endianess does not match?
>     >
>     > Good question!
>     >
>     > IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
> 
>     No.  Integers are defined to be little endian.  See fw_cfg_add_i64() for
>     example, there is an explicit cpu_to_le64() call for that.
> 
> 
> 
> Yes, for the fw_cfg 'integer' entry it is stored as little endian.
> But for the fw_cfg 'file' entry interpred as an integer, there is no
> specify the endianess.

I agree with Li, the endianess of 'reboot-timeout' is not clear.

From docs/specs/fw_cfg.txt:

  === All Other Data Items ===

  Please consult the QEMU source for the most up-to-date
  and authoritative list of selector keys and their respective
  items' purpose, format and writeability.

So checking the git history, this code was introduced in commit
ac05f3492421, very similar to commit 3d3b8303c6f8 for the
'boot-menu-wait' entry, which explicitely use little-endian, so I think
it is safe to consider it little-endian and add a comment about its
endianess (referring the previous commits in the patch description).

Thanks,

Phil.

> 
> Thanks,
> Li Qiang
> 
>  
> 
>     cheers,
>       Gerd
> 

