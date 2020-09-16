Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652D6C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:42:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4092068D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKdkXCdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4092068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIS5c-0000C4-9B
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 03:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIS4e-0008Bw-NH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:41:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIS4a-0008Rq-HI
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 03:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600242106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03V0A4T8nCOVl1Uo8k5ciY2svi9iFl6hj8ZVcsJZPHE=;
 b=aKdkXCdHnR91uC7uI0frSPDkAMZ0P/o8yQ1uZQlF5QRtbIsecXOWQB0CJT9JdoT1fanvpv
 fWd+fc/umOobFyPyjHtfkr9iyAdvrw8b/6fIt1mX5pWO7URU8VTMbhtCtMMVPSg4q3ydxM
 /VWRsnp9E+RHIrhdnr3zOlBLKDPto4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-EsZsu2MkNgWq0rFqGg2L-A-1; Wed, 16 Sep 2020 03:41:45 -0400
X-MC-Unique: EsZsu2MkNgWq0rFqGg2L-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02677185A0EA;
 Wed, 16 Sep 2020 07:41:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 792E767CF5;
 Wed, 16 Sep 2020 07:41:43 +0000 (UTC)
Subject: Re: [PATCH v4 10/11] tests/acpi: unit test exercizing hotplug off for
 pci root bus & bridge in i440fx
To: Ani Sinha <ani@anisinha.ca>
References: <20200916061335.14045-1-ani@anisinha.ca>
 <20200916061335.14045-11-ani@anisinha.ca>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3be8a75b-d1be-16a2-9ed4-a26674cde0e7@redhat.com>
Date: Wed, 16 Sep 2020 09:41:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200916061335.14045-11-ani@anisinha.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi!

On 16/09/2020 08.13, Ani Sinha wrote:
> This change adds a unit test to exercize the case when hotplug is disabled both for

exercize ==> exercise
(also in the subject, please)

[...]> diff --git a/tests/qtest/bios-tables-test.c
b/tests/qtest/bios-tables-test.c
> index 7632cfe1be..4c834474ad 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -768,6 +768,21 @@ static void test_acpi_piix4_bridge_hotplug(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_piix4_bridge_root_hotplug(void)
> +{
> +    test_data data;
> +
> +    memset(&data, 0, sizeof(data));
> +    data.machine = MACHINE_PC;
> +    data.variant = ".hpbrroot";

You could use:

    test data = {
        .machine = MACHINE_PC;
        .variant = ".hpbrroot";
    };

... then you don't need the memset() call anymore.

  Thomas


