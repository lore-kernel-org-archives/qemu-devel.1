Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE8C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B082075E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 05:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9cbeCq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B082075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52233 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKyhB-0002mp-9V
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 01:19:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hKyg9-0002F6-TE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hKyYj-0006vq-R4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:10:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hKyYj-0006sa-Je
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 01:10:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id y64so1789756oia.7
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 22:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=yG14rhIN4V/CX5S5vdSMOyanm1VEbDywtWE7TAUNMNM=;
	b=X9cbeCq1ru06P3BPYbJwuYc5XlLyk1EN+ph3jTBrXDryXCAe1ZewQAgRqtXdJGibmy
	gojScX9TjBv5Wjd6uEYru3bnAjK9ASVbwkYs8LReAwj5NxMD9TXmCgG9EvTAez02gUDO
	yh0U5G+95BC5ao9TmgbPle0zLlj1Mwuelg76VHmYm5CYBNL4s5Z9/z1J3QlHaSVV5G7z
	uErCf0QUAeDH17r7SH7PbxgT6RTh74oObH7ouo1P/8Vgi6w73EEg+hMrDNZYlRooNUsS
	ux2fo1BQTX8ZTWS+qA4RYkbmvwJvGP9dVkK+j7KDDoeMm/Gf9POWmpup4GYCAgbzBbAx
	Oi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=yG14rhIN4V/CX5S5vdSMOyanm1VEbDywtWE7TAUNMNM=;
	b=aI7gJZPn8WBQNvDX2ZulYVrFdcKojZLvuSNG7sdeLlYPz2GN7lZlNHkExI19pWdHju
	pJnKzDPgWdl/Z/xr8XAg0uP8VcCkxfk+DZn8JybqcsvQcLhdNym7K/jd/zvnwpUpS5O5
	x4ua8X6iCV/KifxyfA6n6UmMSax7RDOMYVsS1PE5a83n5IFQvvujmc8ay++9Qk/+G9f2
	IoTopO2W7XQUeYVSVPtVb+jikPbbNHb4xYDuWhfYLYkf3SHbR9VpCsu5EK2uGVmfuWFd
	MNqO96EWMdvG69buVe8SYIlwV5UCw30CoWpM0vKnFrtld6zXxLtXUBfEuziSrXor26PD
	qkDA==
X-Gm-Message-State: APjAAAWqduJZAmNNQDgF4pMvBOUhHzLkv2opMrzONhvU9Crq29KaHG7L
	YKMSqQWMcV/1tzfmk85eKpf5j0tSLi3g2H3AqaY=
X-Google-Smtp-Source: APXvYqzwkHtfheB1F3sm9CzyjmRuTrVRRdyaqfPDvMkpzF7OU/T4AH3SOBavrMYkK2Q+AH6NPZy3RUqbycVackc6Gw8=
X-Received: by 2002:aca:e18b:: with SMTP id
	y133mr15432372oig.157.1556514626979; 
	Sun, 28 Apr 2019 22:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190424140643.62457-1-liq3ea@163.com>
	<2b623811-1be2-159c-0fa6-c548aa9eea82@redhat.com>
	<CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
In-Reply-To: <CAKXe6SLXrthYFrQGVQNT4hK1-22wrteMNyygZgx_j=jtDfYC6g@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Apr 2019 13:09:51 +0800
Message-ID:
 <CAKXe6SL8XWMg1x8qztepjypgqdmXpZDj0G0AHU+BLV8OsbRjOg@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
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
Cc: lvivier@redhat.com, Laszlo Ersek <lersek@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429050951.mWoPwoFLbkeBcwkkJx9zh5P1Fr205KkEyk1HTO-1v74@z>

Li Qiang <liq3ea@gmail.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:29=E5=86=99=E9=81=93=EF=BC=9A

>
>
> Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:57=E5=86=99=E9=81=93=EF=BC=9A
>
>> On 24/04/2019 16.06, Li Qiang wrote:
>> > In the disscuss of adding reboot timeout test case:
>> > https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
>> >
>> > Philippe suggested we should uses the only related option for one
>> > specific test. However currently we uses one QTestState for all the
>> > test cases. In order to achieve Philippe's idea, I split the test case
>> > for its own QTestState. As this patchset has changed a lot, I don't bu=
mp
>> > the version.
>> >
>> > Change since v1:
>> > Add a patch to store the reboot_timeout as little endian
>> > Fix the endian issue per Thomas's review
>>
>> The test still aborts on a big endian host:
>>
>> $ QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system-x86_64 tests/fw_cfg-tes=
t
>> /x86_64/fw_cfg/signature: OK
>> /x86_64/fw_cfg/id: OK
>> /x86_64/fw_cfg/uuid: OK
>> /x86_64/fw_cfg/ram_size: OK
>> /x86_64/fw_cfg/nographic: OK
>> /x86_64/fw_cfg/nb_cpus: OK
>> /x86_64/fw_cfg/max_cpus: OK
>> /x86_64/fw_cfg/numa: OK
>> /x86_64/fw_cfg/boot_menu: OK
>> /x86_64/fw_cfg/reboot_timeout: **
>>
>> ERROR:/home/thuth/devel/qemu/tests/fw_cfg-test.c:190:test_fw_cfg_reboot_=
timeout:
>> assertion failed (reboot_timeout =3D=3D 15): (251658240 =3D=3D 15)
>> Aborted
>>
>> 251658240 is 0x0F000000, i.e. a byte-swapped 0xf =3D 15 ... i.e. you sti=
ll
>> got an endianess issue somewhere in the code.
>>
>
>
> Hmmmm,
>
> I have thought a long time, still can't point where is wrong.
>
> Let's from the result:
> 0x0f000000 in the big endian laid as this:
> low ---> high
> 0x0f 00 00 00
>
> As I have swapped before the compare so it is read as this:
> low ---> high
> 00 00 00 0x0f
>
> However from the store side:
> the 15 in big endian is:
> low ---> high
> 00 00 00 0x0f
>
> But Before I store it, I convert it to little endian, so following should
> be stored:
> low ---> high
> 0x0f 00 00 00
>
> Do you apply the patch 3 and recompile the qemu binary?
>


Hello Thomas,
I have tested again this and just store it as big endian(so that the
store/load has different endianness),
I don't see any error.

Also, can we add these test sceneries(big-endian host) in our CI? so that
the bot can report for every commit.


Thanks,
Li Qiang



If it is, I may need your help as I have no big endian host device.
>
> You can debug and  inspect the memory layout and point out where is wrong=
.
>
> Thanks,
> Li Qiang
>
>
>
>
>
>
>
>>
>>  Thomas
>>
>
