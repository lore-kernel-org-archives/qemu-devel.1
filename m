Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD52C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AF820665
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWwLeOD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21AF820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iukL8-00043S-6g
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 16:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iukK6-0003Oc-Jw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iukK4-0007AD-PJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:47:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58052
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iukK4-000796-D1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 16:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579816051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a5TiTiL80aZ1ZCb8cAUGy47NCYXHjroeUujSWPr+YSc=;
 b=CWwLeOD652Hoa9CpSWwoO5oN/+/ghTlK0nv7voiluXCNsO+dSTZLxh8haj61jDpFaMweFf
 fLZa1TyC9C2lKUbhWZgXRz97Q/our0mjBFNwI0diqGbSHR+UOgdVKWGvzLiNAUNJYw+8Q+
 yo7fM0g9Anky7qC0Q0RSN8E8aB7xrP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-Gj_I2IFSOWyiv5P5QJGo7Q-1; Thu, 23 Jan 2020 16:47:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4898107ACC5;
 Thu, 23 Jan 2020 21:47:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EE378643E;
 Thu, 23 Jan 2020 21:47:21 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot
 Linux with kvm tests
To: Andrew Jones <drjones@redhat.com>
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-3-wainersm@redhat.com>
 <20200122090246.oehdjxeotx5tz64l@kamzik.brq.redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <7106bfc9-067e-6864-c766-046372ed4bd0@redhat.com>
Date: Thu, 23 Jan 2020 19:47:19 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200122090246.oehdjxeotx5tz64l@kamzik.brq.redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Gj_I2IFSOWyiv5P5QJGo7Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/22/20 7:02 AM, Andrew Jones wrote:
> On Tue, Jan 21, 2020 at 10:27:51PM -0300, Wainer dos Santos Moschetta wrote:
>> +    def test_aarch64_virt_kvm(self):
>> +        """
>> +        :avocado: tags=arch:aarch64
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=accel:kvm
>> +        """
>> +        self.do_test_aarch64_virt()
>> +
>> +    def test_aarch64_virt_tcg(self):
>> +        """
>> +        :avocado: tags=arch:aarch64
>> +        :avocado: tags=machine:virt
>> +        :avocado: tags=accel:tcg
>> +        """
>> +        self.do_test_aarch64_virt()
>> +
> Does do_test_aarch64_virt() add more machine parameters? Also, which cpu
> type does it choose? The reason I ask is because aarch64 virt will fail to
> run with KVM unless the appropriate gic version is specified (the
> gic-version machine parameter). Also the cpu type must be 'host' or 'max'.
> 'max' is the better choice as it also works for tcg. gic-version also
> takes 'max' allowing it to auto-select the appropriate version. So if it's
> not already there somewhere, then please ensure aarch64 has these
> additional parameters:
>
>   machine:gic-version=max
>   cpu:max


The test was passing '-cpu cortex-a56', I replaced with '-cpu max'. 
Also, now, it passes the gic version as you pointed out. I will send 
those changes on a v4.

Other than that, I tried '-cpu max -machine virt' (without gic-version) 
and QEMU crashed:

[root@virtlab-arm03 build]# ./aarch64-softmmu/qemu-system-aarch64 -accel 
kvm -cpu max -machine virt -display none -vga none
qemu-system-aarch64: PMU: KVM_SET_DEVICE_ATTR: Invalid argument
qemu-system-aarch64: failed to set irq for PMU
Aborted (core dumped)

----

Should I expect it to crash or rather nicely fail?

Thanks !

- Wainer


>
> Thanks,
> drew


