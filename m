Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCD1C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D827020663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOZ2DD/X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D827020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPltX-0002Pz-PF
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPlsG-0001cf-8U
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30587)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPlsD-0004sN-Fg
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601986515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26xgIK7jbc1EPcc81EYzt3KKdARv/T8c8yaGc5r9LKA=;
 b=IOZ2DD/XhW3iyo5jXbzEdiJIiMMKe4j4/rND+UWxgt8mX9CxMGdN73m1GUK1HDghLPaJYD
 J8Li8NSNPTdF5C9j0PUSAHhwOH127ZUVuJgaYf3jtSJPpbLfnwjrl2l0DrahNMr08sCzve
 nqCOPtDHhcACMweH8jNLzmMB2hIYTeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-y0LPUX5_N72s_G3XV6SopQ-1; Tue, 06 Oct 2020 08:15:14 -0400
X-MC-Unique: y0LPUX5_N72s_G3XV6SopQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B4FC9CC12;
 Tue,  6 Oct 2020 12:15:13 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-147.ams2.redhat.com [10.36.113.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B56F91A837;
 Tue,  6 Oct 2020 12:15:08 +0000 (UTC)
Date: Tue, 6 Oct 2020 14:15:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
Message-ID: <20201006121507.GE4202@linux.fritz.box>
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201006111909.2302081-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.10.2020 um 13:19 hat Philippe Mathieu-Daudé geschrieben:
> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
> by a device only available using system-mode (fw_cfg), it is
> implemented by a crypto component (tls-cipher-suites) which
> is always available when crypto is used.
> 
> Commit 69699f3055 introduced the following error in the
> qemu-storage-daemon binary:
> 
>   $ echo -e \
>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
>   {"return": {}}
>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
>   Aborted (core dumped)
> 
> Since QOM dependencies are resolved at runtime, this issue
> could not be triggered at linktime, and we don't have test
> running the qemu-storage-daemon binary.
> 
> Fix by always registering the QOM interface.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This fails to build for me:

../hw/nvram/meson.build:2:7: ERROR: Unknown method "add" in object.

Kevin


