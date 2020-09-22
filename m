Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2067BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76ECC238D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPNeyAAQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76ECC238D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcqD-00074r-Et
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kKcpJ-0006YF-62
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:35:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36267)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kKcpH-0000G2-I5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600760098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XdHOSsdJBdCfhEV5R54DGmv+pkaBorJXVfsaYd2e+2Q=;
 b=OPNeyAAQx5+ttevvk+EV4NvITd++t3mpCE2U6NyH8z00HLFPBAH6bpKNR31P8bmErkKgf/
 OQcliSIcoTJ8fUxw3bbeTzQ+DYDN7zcUchWaxmsr9ZLRG0ztE8fRBWICYjk8LYpCgf4Quh
 TmnEciIjty4LaBf6pXJh74bbv9rWO0E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-DOFuFLtBPL2Fe8FexJPvwQ-1; Tue, 22 Sep 2020 03:34:56 -0400
X-MC-Unique: DOFuFLtBPL2Fe8FexJPvwQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D5C186DD23;
 Tue, 22 Sep 2020 07:34:55 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-3.ams2.redhat.com
 [10.36.112.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45B7B5DA30;
 Tue, 22 Sep 2020 07:34:51 +0000 (UTC)
Subject: Re: [PATCH 2/2] add maximum combined fw size as machine configuration
 option
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Erich Mcmillan <erich.mcmillan@hp.com>, dgilbert@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, imammedo@redhat.com
References: <20200918042339.3477-1-erich.mcmillan@hp.com>
 <c5961bff-811b-2895-a96e-867a4c160ddd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1951c176-4c62-d60e-fcb0-064601759669@redhat.com>
Date: Tue, 22 Sep 2020 09:34:50 +0200
MIME-Version: 1.0
In-Reply-To: <c5961bff-811b-2895-a96e-867a4c160ddd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/18/20 10:17, Philippe Mathieu-Daudé wrote:

> I'm very confused by pc_system_flash_map()... Why not check
> that no pflash exceeds 8MiB? Then 2 combined would be always
> <16MiB.

The requirement (limit) is on the total address range that is occupied
by the flash chips that are mapped in sequence. There is no size limit
that applies to an individual chip. It's also not required that chips
have the same size (or be limited by the same individual size).

Thanks
Laszlo


