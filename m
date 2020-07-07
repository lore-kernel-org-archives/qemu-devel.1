Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6763C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF668206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6GCuJWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF668206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqYb-0005AV-W5
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqBH-0002et-9q; Tue, 07 Jul 2020 12:10:51 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsqBF-0007lU-6c; Tue, 07 Jul 2020 12:10:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id f7so42772470wrw.1;
 Tue, 07 Jul 2020 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uuhPgvFhv/D+1NOUM9brURnzXdt1PoE7vE9LvxA+Y1s=;
 b=c6GCuJWDoU8gEzmyQRxrEe+pD11OA8bNJDW0yDVN0SZDitIm2e4p4bZY+aeZ9wDyYQ
 3A5HZEdTQ+Xp4mK2X9if9ONKcxAsykf4r1trjcWdKY3UDrEdooaBVTybgwNZs2QxP6Cj
 Ab0snwADxgk8Abf9ndE5T6tEte/FpXLT8aeDf5aYyD1MPY2f+uSvMQoEV+GCTrzf8Vh6
 qnf1oeZAx03FHXHdyH84JJ6034SaTQgtB8/jiM3ZYL/fJGnT4dwBbHrIkpHtcqw/yEjP
 OevTUiKI4fQ5BDyDjsjdobfskIx5+uOKv1slJfJ68hFq63XlKLxy8ANsKsTcOCQEU1um
 dmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uuhPgvFhv/D+1NOUM9brURnzXdt1PoE7vE9LvxA+Y1s=;
 b=R0vE2OSM0Axfx+1aERyY3qfZJENwLyLMMRZIVUaJsGWjSZe4fsApya485PWuq62aFB
 ED2JBmfz/kwTxlpe8SIh6NCui+NARn6SenSpXmybkWdgCB6l8ybgFUc5hfcdLJDlDEfu
 HZQZ+7J9HRFpyMcggXGtH7smy2GaSYKXA/XAHn7rqrDWCyVOzBxYpoVtaKsmHctlrd+c
 mBP20A70mLxjzIDRPjGdyq5m6UUiwC/dEbrvlr9NZSTV0Dg3X4sqEG3NtS3fWVuRoRrd
 Lm+OO+KdEl82u+QAclJXjG5d/99mfx8UjaT9w9USRb583C4gJoagfmznUw94i5ErWu6W
 uHtw==
X-Gm-Message-State: AOAM532IhU3uUBUGmHLWOoLf0HHZHCT8bvvqnSHjq5JZKjmG287/q/3W
 ltsrIbJjMoWBgEMruWlJEPE=
X-Google-Smtp-Source: ABdhPJyYWNDda2IkbHH3hOPoCNYdpaGCA2gExGo+3ZBwVV4iRYAHSgeFAyUNmATuprxv7jQbIruLTw==
X-Received: by 2002:a5d:5706:: with SMTP id a6mr18967911wrv.328.1594138247214; 
 Tue, 07 Jul 2020 09:10:47 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 5sm1586122wmk.9.2020.07.07.09.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 09:10:46 -0700 (PDT)
Subject: Re: [PATCH 1/2] tests/acceptance/boot_linux: Truncate SD card image
 to power of 2
To: Alistair Francis <alistair23@gmail.com>
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-2-f4bug@amsat.org>
 <CAKmqyKPSh4e+XVBLni71rHDZoTUV+cYQgZpO+FBYv-riLYW9eQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <99dca865-75ca-6313-c522-6ced46e2f88e@amsat.org>
Date: Tue, 7 Jul 2020 18:10:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPSh4e+XVBLni71rHDZoTUV+cYQgZpO+FBYv-riLYW9eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Qemu-block <qemu-block@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 5:53 PM, Alistair Francis wrote:
> n Tue, Jul 7, 2020 at 6:21 AM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> In the next commit we won't allow SD card images with invalid
>> size (not aligned to a power of 2). Prepare the tests: add the
>> pow2ceil() and image_pow2ceil_truncate() methods and truncate
>> the images of the tests using SD cards.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  tests/acceptance/boot_linux_console.py | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>> index 3d02519660..f4d4e3635f 100644
>> --- a/tests/acceptance/boot_linux_console.py
>> +++ b/tests/acceptance/boot_linux_console.py
>> @@ -28,6 +28,18 @@
>>  except CmdNotFoundError:
>>      P7ZIP_AVAILABLE = False
>>
>> +# round up to next power of 2
>> +def pow2ceil(x):
>> +    return 1 if x == 0 else 2**(x - 1).bit_length()
>> +
>> +# truncate file size to next power of 2
>> +def image_pow2ceil_truncate(path):
>> +        size = os.path.getsize(path)
>> +        size_aligned = pow2ceil(size)
>> +        if size != size_aligned:
>> +            with open(path, 'ab+') as fd:
>> +                fd.truncate(size_aligned)
> 
> Why truncate the image, can't we expand it instead?

pow2ceil() round UP to the next power of 2. I think this
Python truncate() is a simple wrapper around the ftruncate()
syscall. IOW we only "expand the image". Note, these are
test images copied in tmpdir and discarded after the tests
ran. I'll improve the description.

> 
> Alistair
> 
>> +
>>  class LinuxKernelTest(Test):
>>      KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>
>> @@ -635,6 +647,7 @@ def test_arm_orangepi_sd(self):
>>          rootfs_path_xz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
>>          rootfs_path = os.path.join(self.workdir, 'rootfs.cpio')
>>          archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
>> +        image_pow2ceil_truncate(rootfs_path)
>>
>>          self.vm.set_console()
>>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>> @@ -679,6 +692,7 @@ def test_arm_orangepi_bionic(self):
>>          image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
>>          image_path = os.path.join(self.workdir, image_name)
>>          process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
>> +        image_pow2ceil_truncate(image_path)
>>
>>          self.vm.set_console()
>>          self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
>> @@ -728,6 +742,7 @@ def test_arm_orangepi_uboot_netbsd9(self):
>>          image_hash = '2babb29d36d8360adcb39c09e31060945259917a'
>>          image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)
>>          image_path = os.path.join(self.workdir, 'armv7.img')
>> +        image_pow2ceil_truncate(image_path)
>>          image_drive_args = 'if=sd,format=raw,snapshot=on,file=' + image_path
>>          archive.gzip_uncompress(image_path_gz, image_path)
>>
>> --
>> 2.21.3
>>
>>
> 

