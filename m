Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8368CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D46120772
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 05:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTQqoKy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D46120772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsgEk-0005m2-Jt
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 01:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsgE2-0004yI-0S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:33:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55591
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jsgDz-0006QH-MV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 01:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594099978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=06T+kuWqJ3FHvRYdNLCjqmABGC3pzPSfu6BAy1hmaOw=;
 b=fTQqoKy20fFn29bUqHaCPfIOgPRDt5Yp1SlxuzozpEisaQVM0X1cI6dcScfn5/CIQYRXU8
 4BHf6eApcH7XxL3CEKt4Jg0xQHlQV8XR7vxba0YzxkWgg3Vx28Ok2mHLfAdZLxxx1AJva6
 bBvQd8+zSv5kSHvzCyb3f8SkHmUrfsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-B9dIumXdNd2sHIRzHKwfWA-1; Tue, 07 Jul 2020 01:32:56 -0400
X-MC-Unique: B9dIumXdNd2sHIRzHKwfWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C574818A8222;
 Tue,  7 Jul 2020 05:32:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-77.ams2.redhat.com [10.36.112.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 874E42DE6A;
 Tue,  7 Jul 2020 05:32:54 +0000 (UTC)
Subject: Re: Test failure with Smartfusion2 emac block (msf2-emac)
From: Thomas Huth <thuth@redhat.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>
References: <e010da48-cfbe-9616-d750-a922cb463a94@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f457f5d9-2405-4456-4a26-b3a9784e2cd9@redhat.com>
Date: Tue, 7 Jul 2020 07:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e010da48-cfbe-9616-d750-a922cb463a94@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 07.18, Thomas Huth wrote:
> 
>  Hi Subbaraya,
> 
> today, I noticed that there is a test failure with msf2-emac when
> running the device-introspect-test in slow mode. Either run:
> 
>  make check-qtest-aarch64 SPEED=slow
> 
> or as a shortcut:
> 
>  make tests/qtest/device-introspect-test
>  QTEST_QEMU_BINARY="aarch64-softmmu/qemu-system-aarch64" \
>   ./tests/qtest/device-introspect-test -m slow
> 
> Then the test fails with:
> 
> Unexpected error in error_set_from_qdev_prop_error() at
> hw/core/qdev-properties.c:1251:
> Property 'msf2-emac.netdev' can't take value 'hub0port0', it's in use
> 
> Could you please have a look?

The problem might be related to m2sxxx_soc_initfn() in msf2-soc.c. Looks
like you are using nd_table in an instance_init function. This is almost
always wrong, and should be done by the machine code instead (e.g. in
msf2-som.c).

 Thomas


PS: Maybe also have a look at this article, it might help to understand
the idea behind instance_init a little bit:
http://people.redhat.com/~thuth/blog/qemu/2018/09/10/instance-init-realize.html


