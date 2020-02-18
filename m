Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E283AC34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF9520722
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 05:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXL7/LNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF9520722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3vlI-0000q4-RE
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 00:49:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44504)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3vkd-00008Z-W0
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3vkc-0005uT-DT
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:48:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49528
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3vkc-0005u6-AV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 00:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582004933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcKeZotumshJ+l/DS/dA8XMIT+xFVqKzPfU01AJFm/s=;
 b=MXL7/LNaVNnUd+cMIyRR+08ypXctCHq8iUpTFgXJCjSgFEpl8pYY4IQdpl6eUPTX9+l31U
 IlkkkYWVyKiF7fYlqIJAkbqw5b5CuQ6EA0MEf/jc5kIle3OgnPUGqoNAuJEmJzkUhbMH9j
 1UA1Ju/MNTtwYwaCZLailaoh6NKsDv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-dhvBD-LCMe-mFzNKMfuGXw-1; Tue, 18 Feb 2020 00:48:47 -0500
Received: by mail-wr1-f69.google.com with SMTP id w17so10243253wrr.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 21:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3FkOapW8MTSCC8LkwQe+L8xVixAYtgDelL0EgNfh4LM=;
 b=bBfGsM9bEPuOTXY9XFJlMoek/UA4rWmKXhML+vnPaQGHTzuSukBZoRU1Wqf8tyqZH8
 I+ELUgdhBs3nWvz9aA3JjrNIKUfXsKigAmjJORSFyS7LnQFtT7D+lw40QGOmaysVYIMH
 Jt6ecLSONM8yGe8yJdl54pk/BzrQPjTYB+z9KiqfHQSc+3pz6B18MnysCzp8Ho6DLa2/
 LVZkTIgaibKjapdy78Bx76NXlBRG2g5w7C+mYKypZnYoJT1ysXICYAIW9nJDMHQiU6gY
 qWAGIP66CuVHa/jcC2PfvKIhr7Ur3gYk9rlQSwMjQlfgx9vEtOrhOc9AB6M3jKR9i9VK
 Ck6w==
X-Gm-Message-State: APjAAAXguJ2qWEqvKzcEffjCUuZLVtSFoX8lev927hBKypP4JJ8Icoqr
 VS85OL2NFojNM9Tq+Mvp9Ln++EjQqqvk3AyhFz2urE6qfPvAYwtLo/dPapAUCOWoKkSIyUGgJhZ
 RD+Vzu00dm6/WgkA=
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr28030615wrt.271.1582004925654; 
 Mon, 17 Feb 2020 21:48:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdRAzQvxGdqKxfU/WAIEhTk8bHp3ZSmNyZoiywKDclEKdSqku6COnG90jFWKJ1jej6NaYgxQ==
X-Received: by 2002:a5d:4bd0:: with SMTP id l16mr28030581wrt.271.1582004925287; 
 Mon, 17 Feb 2020 21:48:45 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id x132sm2159382wmg.0.2020.02.17.21.48.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 21:48:44 -0800 (PST)
Subject: Re: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200217021217.95766-1-aik@ozlabs.ru>
 <60c5712e-beb7-e536-1252-642dcf88beec@redhat.com>
 <0beab4e0-da3d-48fb-062a-de7a6c244c3f@redhat.com>
 <20200217224647.GA26464@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <38cfa5c3-2563-7aaa-b1db-c7dd2f053d3c@redhat.com>
Date: Tue, 18 Feb 2020 06:48:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217224647.GA26464@umbus.fritz.box>
Content-Language: en-US
X-MC-Unique: dhvBD-LCMe-mFzNKMfuGXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 11:46 PM, David Gibson wrote:
> On Mon, Feb 17, 2020 at 11:24:11AM +0100, Philippe Mathieu-Daud=E9 wrote:
>> On 2/17/20 10:26 AM, Philippe Mathieu-Daud=E9 wrote:
>>> Hi Alexey,
>>>
>>> On 2/17/20 3:12 AM, Alexey Kardashevskiy wrote:
>>>> The following changes since commit
>>>> 05943fb4ca41f626078014c0327781815c6584c5:
>>>>
>>>>  =A0=A0 ppc: free 'fdt' after reset the machine (2020-02-17 11:27:23 +=
1100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>  =A0=A0 git@github.com:aik/qemu.git tags/qemu-slof-20200217
>>>>
>>>> for you to fetch changes up to ea9a03e5aa023c5391bab5259898475d0298aac=
2:
>>>>
>>>>  =A0=A0 pseries: Update SLOF firmware image (2020-02-17 13:08:59 +1100=
)
>>>>
>>>> ----------------------------------------------------------------
>>>> Alexey Kardashevskiy (1):
>>>>  =A0=A0=A0=A0=A0=A0 pseries: Update SLOF firmware image
>>>>
>>>>  =A0 pc-bios/README=A0=A0 |=A0=A0 2 +-
>>>>  =A0 pc-bios/slof.bin | Bin 931032 -> 968560 bytes
>>>>  =A0 roms/SLOF=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 2 +-
>>>>  =A0 3 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> I only received the cover, not the patch, have you posted it?
>>
>> OK I see the SLOF binary is almost 1MB. Maybe this got blocked by spam
>> filter. FYI you can use 'git-format-patch --no-binary' to emit the patch
>> with the commit description but without the content.
>=20
> Generally Alexey sends SLOF updates to me just as pull requests
> without patches in full, because a huge slab of base64 encoded
> firmware isn't particularly illuminating.

I understand, this is why I later suggested Alexey to use=20
'git-format-patch --no-binary', because Laszlo uses it for EDK2=20
submodule, this allow to quickly review the change on the list (without=20
posting the base64), see:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg624429.html
(pull-request cover)

https://www.mail-archive.com/qemu-devel@nongnu.org/msg624432.html
"roms/edk2: update submodule"

https://www.mail-archive.com/qemu-devel@nongnu.org/msg624435.html
"pc-bios: refresh edk2 build artifacts"


