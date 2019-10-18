Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CC9CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:29:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877C621897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877C621897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTGH-0006GF-IH
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32877)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iLTEi-0005Fa-8L
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iLTEh-0001TK-4S
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iLTEg-0001SZ-UT
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:28:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 595A118CB91C
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 14:28:09 +0000 (UTC)
Received: from [10.36.118.23] (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60F1260C63;
 Fri, 18 Oct 2019 14:27:59 +0000 (UTC)
Subject: Re: Default CPU models on s390x and ppc64
To: Jiri Denemark <jdenemar@redhat.com>
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
 <3c2d2d20-682e-ab4f-ced4-c7f48473dd24@redhat.com>
 <9083f32c-68db-cc28-e0ea-7fafd014be9b@redhat.com>
 <20191018135821.GR4204@orkuz.int.mamuti.net>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <09604f79-51f4-76c9-31cc-7c5d0c419bd2@redhat.com>
Date: Fri, 18 Oct 2019 16:27:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191018135821.GR4204@orkuz.int.mamuti.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 18 Oct 2019 14:28:09 +0000 (UTC)
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
Cc: David Gibson <dgibson@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <dhildenb@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>> I don't see how the default cpu model could not be "host" if qemu was
>> started with "--enable-kvm"
> 
> I guess the problem could be that QEMU capabilities probing in libvirt
> is done with -machine none. We first probe with KVM enabled and then for
> a few specific commands reprobe with TCG only. We could do it with
> query-machines too to get different default CPU models depending on the
> accelerator, but it wouldn't actually help.
> 
> The full command line used for capabilities probing is
> 
>      qemu-system-s390x \
>          -S \
>          -no-user-config \
>          -nodefaults \
>          -nographic \
>          -machine none,accel=kvm:tcg \
>          -qmp unix:/tmp/qmp-ivG4UN/qmp.monitor,server,nowait \
>          -pidfile /tmp/qmp-ivG4UN/qmp.pid \
>          -daemonize
> 
> One of the command we send is
> 
>      {"execute":"query-kvm","id":"libvirt-5"}
> 
> and the reply is
> 
>      {"return": {"enabled": true, "present": true}, "id": "libvirt-5"}

Right.

> 
> Which means KVM is usable and enabled, but still query-machines returns
> 
>      {
>        "return": [
>          {
>            "hotpluggable-cpus": true,
>            "name": "s390-ccw-virtio-4.0",
>            "numa-mem-supported": false,
>            "default-cpu-type": "qemu-s390x-cpu",
>            "cpu-max": 248,
>            "deprecated": false
>          },
>          {
>            "hotpluggable-cpus": true,
>            "name": "s390-ccw-virtio-3.1",
>            "numa-mem-supported": false,
>            "default-cpu-type": "qemu-s390x-cpu",
>            "cpu-max": 248,
>            "deprecated": false
>          },
>          ...
>        ]
>      }
> 
> So it seems the code is run during the machine initialization and thus
> it doesn't affect what query-machines returns with -machine none.

I can see what's going on. kvm_arch_init() will only modify the single, 
current machine, not all machines. That means, we would actually have to 
overwrite the default model in all machines, not just the one we are 
starting with (here:none).

Hm....

-- 

Thanks,

David / dhildenb

