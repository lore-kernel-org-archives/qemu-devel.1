Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8928AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E021B20719
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTnqLW0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E021B20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjYV-0000My-RK
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kHjXq-0007tk-2y
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:09:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kHjXn-0008Hm-Ng
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600070938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1QmtHPWuwYfkxdShXq79XWz0h8cydyKrUz7n5BN394=;
 b=WTnqLW0oTmH391jcuPYgi4ytmJvV/LKEeWZeEQrmEEsjuMLQl/bqo0C04PWndYmGx79nRg
 Xj+9q1wwtpkWFlTlrwbg8xzZs1MDuEi8huKg/IVaesd8ZBPpiATzIcM91Q9hVHluy8fj96
 D7jLMLRNR8h/N5ypl8a1MCaBkRXEEQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-1oCaT9o6PZmSM2XIlErAEA-1; Mon, 14 Sep 2020 04:07:50 -0400
X-MC-Unique: 1oCaT9o6PZmSM2XIlErAEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31717802B70;
 Mon, 14 Sep 2020 08:07:49 +0000 (UTC)
Received: from [10.40.193.180] (unknown [10.40.193.180])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B445F7B7B6;
 Mon, 14 Sep 2020 08:07:37 +0000 (UTC)
Subject: Re: [PATCH v2] cphp: remove deprecated cpu-add command(s)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200914074614.973112-1-imammedo@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f8406b80-0243-49bf-a384-5c625d9a7974@redhat.com>
Date: Mon, 14 Sep 2020 10:07:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914074614.973112-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mprivozn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:33:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, cohuck@redhat.com, david@redhat.com,
 dgilbert@redhat.com, armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 9:46 AM, Igor Mammedov wrote:
> theses were deprecated since 4.0, remove both HMP and QMP variants.
> 
> Users should use device_add command instead. To get list of
> possible CPUs and options, use 'info hotpluggable-cpus' HMP
> or query-hotpluggable-cpus QMP command.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   include/hw/boards.h         |   1 -
>   include/hw/i386/pc.h        |   1 -
>   include/monitor/hmp.h       |   1 -
>   docs/system/deprecated.rst  |  25 +++++----
>   hmp-commands.hx             |  15 ------
>   hw/core/machine-hmp-cmds.c  |  12 -----
>   hw/core/machine-qmp-cmds.c  |  12 -----
>   hw/i386/pc.c                |  27 ----------
>   hw/i386/pc_piix.c           |   1 -
>   hw/s390x/s390-virtio-ccw.c  |  12 -----
>   qapi/machine.json           |  24 ---------
>   tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
>   tests/qtest/test-hmp.c      |   1 -
>   13 files changed, 21 insertions(+), 211 deletions(-)

Thanks to Peter Libvirt uses device_add instead cpu_add whenever 
possible. Hence this is okay from Libvirt's POV.

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal


