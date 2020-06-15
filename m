Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252AFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3555206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 14:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GtSmoCtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3555206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqNd-00049q-By
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 10:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqMm-0003Qk-Ds
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:45:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqMk-0000vV-LE
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 10:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592232337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j37lmMbn1ckYt7Z9zT107PjMlK+2E6AxNMUOs+HQVsk=;
 b=GtSmoCtc3FYqf+MEjIlk1OCT09xfBu6Tch82btGUljfepCAKGjHvRF4+wUYVdfU3gzGvnr
 F10TlIqzPivRmjQerw4BwD1Q19R1tYRRSUuLvUGPsLwxesgsLGa0TuEk+cR6leRgMWPweH
 TY3lBNmg8vpOHDpnhaDcqJHwyTDazN0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-KgxEAJA1M3mB1RnG5Zpk4w-1; Mon, 15 Jun 2020 10:45:29 -0400
X-MC-Unique: KgxEAJA1M3mB1RnG5Zpk4w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D31B610AEA07;
 Mon, 15 Jun 2020 14:45:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79B1360BF1;
 Mon, 15 Jun 2020 14:45:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1BFFA17449; Mon, 15 Jun 2020 16:45:27 +0200 (CEST)
Date: Mon, 15 Jun 2020 16:45:27 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v7 2/5] softmmu/vl: Let -fw_cfg option take a 'gen_id'
 argument
Message-ID: <20200615144527.w2637fq5jzpk7jtt@sirius.home.kraxel.org>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-3-philmd@redhat.com>
 <f3f6154e-bbc1-98bd-0f44-77b28c74915f@redhat.com>
 <20200609155050.GT2880@minyard.net>
 <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6e4b9540-7d5b-0951-2870-bada03e29d83@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, minyard@acm.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > I can explain the rationale for that change, but I'm not sure of the
> > answer to your question.  That changes makes sure that the fw_cfg data
> > remains exactly the same even on newer versions of qemu if the machine
> > is set the same.  This way you can do migrations to newer qemu versions
> > and anything using fw_cfg won't get confused because the data changes.
> > 
> > The reason that change was so complex was preserving the order for
> > migrating from older versions.
> > 
> > This is only about migration.  I'm not sure what gen_id is, but if it's
> > migrated, it better be future proof.
> 
> Whenever introducing a new fw_cfg file (*any* new named file), how do we
> decide whether we need fw_cfg_set_order_override()?

The whole point of the sorting is to make sure the fw_cfg directory
listing entry (FW_CFG_FILE_DIR) is stable and doesn't change underneath
the guest when it gets live-migrated.

That sorting was added in qemu 2.6, to make sure things don't chance by
accident in case the initialization order changes.  Now you've got a
problem when you migrate from qemu 2.5 (+older) to qemu 2.6 (+newer),
because 2.5 has the entries in initialization order and 2.6 has the
entries in alphabetical order.  To deal with that machine types for 2.5
& older keep the old sort order.  This is the reason why
legacy_fw_cfg_order exists.

For new features and files you can completely ignore the whole legacy
sorting mess.  cross-version live migration works only for features
supported by both qemu versions, therefore the legacy sorting is only
relevant for features & files already supported by qemu 2.5.

HTH,
  Gerd


