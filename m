Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EB2C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED2B7206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx+AZBOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED2B7206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPmH5-000269-1x
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPmFJ-0000pC-Mp
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPmFG-0007ra-Ur
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601987945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woztGtAskR3puGICZfwx/ALjF4rhIDaBW07z+oIFN1w=;
 b=Bx+AZBOz5WHpq2OT56Xj2c4plosbOwD+Zsl1CuVnr3oMKjQhOQTYBsn+nBrwAhdLBtb4UE
 GdYU74GC2wOtpwdgsVpQJW5wBDf2tmEGGdLLvPphUl5fqIhkGDMTugu0LZ7c7+be+JiX8a
 wX/CKScGxv4SnTO/Fygqhj9DUBtWo1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-72xewIt-NjKnQfIeVS61iw-1; Tue, 06 Oct 2020 08:39:03 -0400
X-MC-Unique: 72xewIt-NjKnQfIeVS61iw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65384802B45;
 Tue,  6 Oct 2020 12:39:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-147.ams2.redhat.com [10.36.113.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C1B95D9EF;
 Tue,  6 Oct 2020 12:38:55 +0000 (UTC)
Date: Tue, 6 Oct 2020 14:38:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/1] hw/nvram: Always register
 FW_CFG_DATA_GENERATOR_INTERFACE
Message-ID: <20201006123854.GF4202@linux.fritz.box>
References: <20201006111909.2302081-1-philmd@redhat.com>
 <20201006111909.2302081-2-philmd@redhat.com>
 <20201006121507.GE4202@linux.fritz.box>
 <c36178f9-67f1-2d22-6537-15c73516cbbe@redhat.com>
MIME-Version: 1.0
In-Reply-To: <c36178f9-67f1-2d22-6537-15c73516cbbe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.10.2020 um 14:20 hat Paolo Bonzini geschrieben:
> On 06/10/20 14:15, Kevin Wolf wrote:
> > Am 06.10.2020 um 13:19 hat Philippe Mathieu-DaudÃ© geschrieben:
> >> While the FW_CFG_DATA_GENERATOR_INTERFACE is only consumed
> >> by a device only available using system-mode (fw_cfg), it is
> >> implemented by a crypto component (tls-cipher-suites) which
> >> is always available when crypto is used.
> >>
> >> Commit 69699f3055 introduced the following error in the
> >> qemu-storage-daemon binary:
> >>
> >>   $ echo -e \
> >>     '{"execute": "qmp_capabilities"}\r\n{"execute": "qom-list-types"}\r\n{"execute": "quit"}\r\n' \
> >>     | storage-daemon/qemu-storage-daemon --chardev stdio,id=qmp0  --monitor qmp0
> >>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 5}, "package": ""}, "capabilities": ["oob"]}}
> >>   {"return": {}}
> >>   missing interface 'fw_cfg-data-generator' for object 'tls-creds'
> >>   Aborted (core dumped)
> >>
> >> Since QOM dependencies are resolved at runtime, this issue
> >> could not be triggered at linktime, and we don't have test
> >> running the qemu-storage-daemon binary.
> >>
> >> Fix by always registering the QOM interface.
> >>
> >> Reported-by: Kevin Wolf <kwolf@redhat.com>
> >> Fixes: 69699f3055 ("crypto/tls-cipher-suites: Produce fw_cfg consumable blob")
> >> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@redhat.com>
> > 
> > This fails to build for me:
> > 
> > ../hw/nvram/meson.build:2:7: ERROR: Unknown method "add" in object.
> 
> It's
> 
>   Based-on: <20201006111219.2300921-1-philmd@redhat.com>
> 
> (which won't be applied in exactly that shape, but more or less it will
> be the same).

Oh, I see. Then I guess it's not supposed to be merged through my tree.

Kevin


