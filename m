Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDA7C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B378520759
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK+n+Hqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi4h-0004Ph-S5
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFi4B-00040o-AF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:10:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50876
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFi49-0005sz-GO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/7veiZmPWVdKaYd35Zm11OqCEtF9UQMsmacsSx1YB0g=;
 b=eK+n+Hqdebw32sJHfHWvLjrRJc4GSve6bIpU7sCwSje6C5BEr2nlQAoP+wI6rzqyjOUU9N
 SpZYhHHRZnO4H6asvslSUOVU9BpGARr9OYlKidKtXFdgXthTrjigmVSNcS0kLeuz4E/htw
 l8PRSdRqVutyY4obZw39+2lWqV9YcPI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-c-wBSWgKNtW-2GitEUDRWg-1; Tue, 08 Sep 2020 14:09:58 -0400
X-MC-Unique: c-wBSWgKNtW-2GitEUDRWg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58FD8030AE
 for <qemu-devel@nongnu.org>; Tue,  8 Sep 2020 18:09:57 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A129C67CEA;
 Tue,  8 Sep 2020 18:09:21 +0000 (UTC)
Subject: Re: [PATCH v5 9/10] fixup! x68: acpi: trigger SMI before sending
 hotplug Notify event to OSPM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200907112348.530921-10-imammedo@redhat.com>
 <20200908142444.546924-1-imammedo@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <75048583-d5e4-eedf-be9a-623ef4127a3c@redhat.com>
Date: Tue, 8 Sep 2020 20:09:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200908142444.546924-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/08/20 16:24, Igor Mammedov wrote:
> Add comment explaining why while_ctx2 restarts from the last processed CPU.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/acpi/cpu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 1283972001..8dd4d8ebbf 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -601,6 +601,15 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
>                      aml_append(while_ctx, aml_increment(cpu_idx));
>                  }
>                  aml_append(while_ctx2, while_ctx);
> +                /*
> +                 * If another batch is needed, then it will resume scanning
> +                 * exactly at -- and not after -- the last CPU that's currently
> +                 * in CPU_ADDED_LIST. In other words, the last CPU in
> +                 * CPU_ADDED_LIST is going to be re-checked. That's OK: we've
> +                 * just cleared the insert event for *all* CPUs in
> +                 * CPU_ADDED_LIST, including the last one. So the scan will
> +                 * simply seek past it.
> +                 */
>              }
>              aml_append(method, while_ctx2);
>              aml_append(method, aml_release(ctrl_lock));
> 

Thank you!
Laszlo


