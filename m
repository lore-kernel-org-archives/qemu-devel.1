Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C51CECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A1E2067B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A1E2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIybM-0004zm-Dx
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iIxXg-0007T1-OW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iIxXe-0001Ez-Dg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iIxXe-0001EO-7c
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:13:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 961C54628B;
 Fri, 11 Oct 2019 16:13:20 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-177.rdu2.redhat.com
 [10.10.120.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BABDD600C4;
 Fri, 11 Oct 2019 16:13:11 +0000 (UTC)
Subject: Re: [RFC 0/3] acpi: cphp: add CPHP_GET_CPU_ID_CMD command to cpu
 hotplug MMIO interface
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191010055356-mutt-send-email-mst@kernel.org>
 <20191010153815.4f7a3fc9@redhat.com>
 <20191010095459-mutt-send-email-mst@kernel.org>
 <20191010175754.7c62cf8f@Igors-MacBook-Pro>
 <20191010192039.GE4084@habkost.net>
 <e17adca7-f5f4-3a28-a4a2-6b921c1c2e2f@redhat.com>
 <20191011085852-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e47c373b-959c-deb8-5585-a04e119c86d8@redhat.com>
Date: Fri, 11 Oct 2019 18:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191011085852-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 11 Oct 2019 16:13:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/11/19 15:00, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 10:01:42AM +0200, Laszlo Ersek wrote:

[...]

>> ... I must admit: I didn't expect this, but now I've grown to *prefer*
>> the CPU hotplug register block!
> 
> OK, send an ack then.

This RFC isn't mature enough for an ACK, but I like the direction, and
I've given ample feedback. I'm looking forward to v1.

When Igor posts v1, I plan to first write firmware code for deriving
"max_cpus" through the register block. For that, I only need the docs to
reflect reality *closely* (I've posted my own suggestions for the docs);
plus "max_cpus" is something I can put to use immediately.

Regarding the CPHP_GET_CPU_ID_CMD feature, I'll have to test that from
within the SMI handler. Thus, until my "final" ACK, it's going to take a
while. I'm OK if the QEMU patch set remains pending on the list meanwhile.

Igor -- can you please answer my questions in this thread? (Part of my
feedback has been questions.)

Thanks!
Laszlo


