Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C84C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:23:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0432067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVkWgheo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0432067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipVup-00083x-7z
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:23:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ipVu8-0007cZ-Vv
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:23:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ipVu7-0002Vw-AO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:23:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ipVu7-0002RL-3J
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578568986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RugsgcqjIYRnH+b6ThL+qQ32ykdd1eVPfufXoKIdGvY=;
 b=XVkWgheov8nCVhagW9YGnbM5rIvwps3YYenKBE2Blcg2VcPdXbeh0DV0dJkctSoeTy99LX
 dxfruDjpT7aMQZbxDdkMtQZc7fZ3t7hm2hA5U9r+FTeBW0XeKPq//38wUAwZB9XasuNBXs
 SZjDrNa20lXBorcIf3omV7io3lE2vv4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-giAV-4YDMoe0Q9dfzsjiNA-1; Thu, 09 Jan 2020 06:23:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id c6so2744467wrm.18
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:23:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=RugsgcqjIYRnH+b6ThL+qQ32ykdd1eVPfufXoKIdGvY=;
 b=Q8UxiY0p79vIJIj5do6jvsnu+djdS5OweqRBYgC2WNzimJKHVhlqzv2CF8bbv633xh
 FtG+a6BXrLueUHuPNCQotnuQoLJXUY8HCrq87N8t5kOS1W9rutJhUE0vkXi2Q2Epu2bW
 g+rfI6dKgkGX1DirV76N3n27s6EsdNzE3Z+m4pUecAMe1wC6lNADidGx+O6coDzKLhl1
 9RhCu90gngcqbknfNTJ1gqvvFFKJSMPH9mliLq7xf5MH1/rFr9YYeVoDHKyuw86WIzdq
 J2GlVwJ8feoXvW487OtnF8ONlyQ4u2JRIaPePFdHBv+3Fw67U9sNyhd0eAnvxGP+IBLE
 a7yA==
X-Gm-Message-State: APjAAAVtfevYlGfvRJkdPXhsi70TzDq9ifH22ZzAgvbftm6C/c6FprgR
 YYzuPWsMf6wQvA6M2L62osm4zP1a1zQSsgRcKPXQmjNROkhczXRz13r1IdwXCBVJWbs84yPOseK
 9XtdoGWc43otCa/k=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr3974180wme.121.1578568983161; 
 Thu, 09 Jan 2020 03:23:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzoMuCzM7spdPQ8PHawfkIvykqpMN/SqrcROPRtqIymNkHddIg7jA33lkY39bGUD5qlrk6YhA==
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr3974146wme.121.1578568982888; 
 Thu, 09 Jan 2020 03:23:02 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x16sm2516644wmk.35.2020.01.09.03.23.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2020 03:23:02 -0800 (PST)
To: qemu-devel <qemu-devel@nongnu.org>, Like Xu <like.xu@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Subject: Difference between 'current_machine' vs MACHINE(qdev_get_machine())
Message-ID: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
Date: Thu, 9 Jan 2020 12:23:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-MC-Unique: giAV-4YDMoe0Q9dfzsjiNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

"hw/boards.h" declare current_machine, and vl.c defines it:

     current_machine = 
MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine), &error_abort);

The bigger user of 'current_machine' is the accel/KVM code.

Recently in a0628599f..cc7d44c2e0 "Replace global smp variables with 
machine smp properties" we started to use MACHINE(qdev_get_machine()).

qdev_get_machine() resolves the machine in the QOM composition tree.
I am confused by this comment:

   /* qdev_get_machine() can return something that's not TYPE_MACHINE
    * if this is one of the user-only emulators; in that case there's
    * no need to check the ignore_memory_transaction_failures board flag.
    */

Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again.

What are the differences between both form, when should we use one or 
another (or can we use a single one?). Can this break user-only mode?

Thanks,

Phil.


