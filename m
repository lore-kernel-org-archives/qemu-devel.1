Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B114C2D0D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A5AE2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Gp3/sz2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A5AE2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijIVI-0003D9-J8
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 02:51:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53599)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zxq_yx_007@163.com>) id 1ijIUY-0002oW-0O
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zxq_yx_007@163.com>) id 1ijIUW-0001GV-OD
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:51:01 -0500
Received: from m12-18.163.com ([220.181.12.18]:60823)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zxq_yx_007@163.com>) id 1ijIUW-0000cE-4I
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 02:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=1bINh
 Y7hA91hovWzQKpUkwB6QVSkzLOzzUBmNlRW7yA=; b=Gp3/sz2v65gdgKmN5b9MW
 VXAWzpE8Ad2ZYfFgevjEGSS1Wgp/xn8hPiiw9Hjym3E0XsqDlykboHgZwdJ/sDed
 pZb17EIEgpSZMEiiQ4L/SwBUJdsi2yxeSZEVauaHD5ybEeNcrSrjRftAyS+Yg7Vf
 GKgGHo9yeur0CUoVIu8oCg=
Received: from [10.11.32.153] (unknown [39.155.168.46])
 by smtp14 (Coremail) with SMTP id EsCowACnr3O+cQBeqrnrNQ--.1920S2;
 Mon, 23 Dec 2019 15:50:23 +0800 (CST)
Subject: Re: [PATCH v5 07/37] serial: register vmsd with DeviceClass
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20191220134601.571905-1-marcandre.lureau@redhat.com>
 <20191220134601.571905-8-marcandre.lureau@redhat.com>
From: xiaoqiang zhao <zxq_yx_007@163.com>
Message-ID: <f12117af-6f1b-d81c-46e8-847e895364ba@163.com>
Date: Mon, 23 Dec 2019 15:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220134601.571905-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: EsCowACnr3O+cQBeqrnrNQ--.1920S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4Uuw4UXr4rWFy3uFW3Wrg_yoW8ZF47pr
 98KFZ8KFy5tr9rWw43uw4YvFy8WF4DKa1UCr43G34aqr4Fkr1Syr4xGw1avFyUXFZ7tF15
 XF4UurykCan5trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgrc-UUUUU=
X-Originating-IP: [39.155.168.46]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEh+UxlZYGvvLzgAAs1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 220.181.12.18
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


在 2019/12/20 下午9:45, Marc-André Lureau 写道:
> Migration from old to new code works, however the other way fails for
> devices that use serial_init/serial_mm_init with "base", used as
> instance_id previously.
>
> (with qdev_set_legacy_instance_id, the alias_id is only used in
> savevm.c:find_se(), and thus can only be used to match against
> "legacy" instance id values. On new code, instance_id is generated
> incrementally from 0 with calculate_new_instance_id(), based on
> "qdev-path/vmsd-name")
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/char/serial.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 233a9e2076..e926845843 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -990,8 +990,7 @@ SerialState *serial_init(int base, qemu_irq irq, int baudbase,
>       s->baudbase = baudbase;
>       qemu_chr_fe_init(&s->chr, chr, &error_abort);
>       serial_realize_core(s, &error_fatal);
> -
> -    vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_set_legacy_instance_id(dev, base, 2);
>       qdev_init_nofail(dev);
>   
>       memory_region_init_io(&s->io, NULL, &serial_io_ops, s, "serial", 8);
> @@ -1006,6 +1005,7 @@ static void serial_class_init(ObjectClass *klass, void *data)
>   
>       /* internal device for serialio/serialmm, not user-creatable */
>       dc->user_creatable = false;
> +    dc->vmsd = &vmstate_serial;
>   }
>   
>   static const TypeInfo serial_info = {
> @@ -1069,7 +1069,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
>       qemu_chr_fe_init(&s->chr, chr, &error_abort);
>   
>       serial_realize_core(s, &error_fatal);
> -    vmstate_register(NULL, base, &vmstate_serial, s);
> +    qdev_set_legacy_instance_id(dev, base, 2);
>       qdev_init_nofail(dev);
>   
>       memory_region_init_io(&s->io, NULL, &serial_mm_ops[end], s,
Resend, cc peter
Reviewed-by: xiaoqiang zhao <zxq_yx_007@163.com>


