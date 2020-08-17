Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12942C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E3D20758
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 18:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFcsEW1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E3D20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7jXg-0006kR-3V
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 14:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1k7jX0-0006H7-GJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 14:06:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1k7jWx-0001Vt-Pa
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 14:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597687605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDsoR0OwJykptr50mQ/zZemdxsk9nvF8Sb/o+HoTiJk=;
 b=gFcsEW1nFgfQ33Rr9weWHxqFyzw2MxppNN6Lf0m31uVwJZcmXpKUFhTxSmIa5XBNq2WQUb
 /3l1vDzusKbSOVZNGqz5E5Aqq1/w94gcMFPjdIU307fFPmdErOZqfT5qwNxXQaANL/HuIB
 4xeL1211HdhvjbbSFtMvM3JgmbaUzMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-VZQXtmuAMlq-QWLDlG6eJA-1; Mon, 17 Aug 2020 14:06:42 -0400
X-MC-Unique: VZQXtmuAMlq-QWLDlG6eJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EF771014DEE;
 Mon, 17 Aug 2020 18:06:41 +0000 (UTC)
Received: from [10.10.118.138] (ovpn-118-138.rdu2.redhat.com [10.10.118.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82FF27A3B4;
 Mon, 17 Aug 2020 18:06:37 +0000 (UTC)
Subject: Re: hw-display-qxl.so: undefined symbol: qemu_qxl_io_log_semaphore
To: Gerd Hoffmann <kraxel@redhat.com>
References: <3a19e8c0-215a-bc18-9817-450affec7f08@redhat.com>
 <20200729125034.GG37763@stefanha-x1.localdomain>
 <3206f141-be6b-02e1-d1f3-5f56551ef1d5@redhat.com>
 <20200817053909.yivisow25afbrulf@sirius.home.kraxel.org>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <01e27737-bd35-4a9e-ada8-fa0f0b690926@redhat.com>
Date: Mon, 17 Aug 2020 14:06:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200817053909.yivisow25afbrulf@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crobinso@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crobinso@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:39 AM, Gerd Hoffmann wrote:
>   Hi,
> 
>> FWIW I'm still hitting issues with qemu-5.1.0 GA but maybe it's
>> unrelated to that specific fix. Issues reproduce on fedora 33+, not
>> fedora 32.
> 
>> +Failed to open module:
>> /builddir/build/BUILD/qemu-5.1.0-rc3/build-dynamic/x86_64-softmmu/../hw-display-qxl.so:
>> undefined symbol: qemu_qxl_client_monitors_config_crc_semaphore
> 
>> /builddir/build/BUILD/qemu-5.1.0/build-dynamic/s390x-softmmu/../hw-usb-smartcard.so:
>> undefined symbol: ccid_card_send_apdu_to_guest
> 
>> So maybe there's a more general problem. FWIW Fedora 33 started using
>> LTO by default, but it was disabled for the qemu package.
> 
> Hmm, the first looks like a problem.  I'm wondering why it happens on
> f33 only, not f32.  LTO could explain that (optimizing away symbols used
> by modules but not main qemu), but with that already turned off I have
> no clue offhand.
> 

I stripped down the reproducer. Dropping --enable-trace-backend=dtrace
makes things work AFAICT. This is on f33

dnf builddep -y qemu  # to get all the fedora package build deps
cd qemu.git
git checkout v5.1.0
./configure --target-list=x86_64-softmmu --disable-werror
--enable-modules --enable-trace-backend=dtrace
make
./x86_64-softmmu/qemu-system-x86_64 -vga qxl

# ./x86_64-softmmu/qemu-system-x86_64 -vga qxl
Failed to open module: /root/qemu.git/x86_64-softmmu/../ui-gtk.so:
undefined symbol: qemu_xkeymap_keymap_semaphore
Failed to open module: /root/qemu.git/x86_64-softmmu/../ui-sdl.so:
undefined symbol: qemu_sdl2_process_key_semaphore
Failed to open module:
/root/qemu.git/x86_64-softmmu/../hw-display-qxl.so: undefined symbol:
qemu_qxl_render_blit_semaphore
qemu-system-x86_64: QXL VGA not available

So nothing specific to qxl, seems all modules are busted.
I tried downgrading gcc to f32 versions, no difference. Same after
downgrading binutils. Downgrading glibc downgrades the whole distro so I
didn't attempt it

Output of this looks similar on f33 and f32:

nm {hw-display-qxl.so,x86_64-softmmu/qemu-system-x86_64} | grep
qemu_qxl_spice_destroy_surfaces_complete_semaphore

Any suggestions?

Thanks,
Cole


