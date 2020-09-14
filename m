Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FFFC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:38:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C18D3214F1
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MErupESX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18D3214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHrUr-00088x-MO
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kHptX-0007Ka-M9
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:55:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kHptR-0005w2-A7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600095342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOkju+FiRSdrsm33DhLwx0UxHerzQmy8DNqldTJ5oco=;
 b=MErupESXVJYz1uOQARpiGFHVB6qwZC7cfn8w8lBnUlIptkc9snQ3FuGdHN0NHH/hbGC1g3
 vNsVV2Rd1uZWlKzNr28u0xtOaq+X1qvx0M/YS6vWmzFsbV1dGyzASW0wp182tI91jW/xax
 UcAZZmhTQYPG3Dac315PdGszL8+LJ6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-EROHQCefPE6rQSdQldz70w-1; Mon, 14 Sep 2020 10:55:40 -0400
X-MC-Unique: EROHQCefPE6rQSdQldz70w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1651913122;
 Mon, 14 Sep 2020 14:55:39 +0000 (UTC)
Received: from gondolin (ovpn-112-214.ams2.redhat.com [10.36.112.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 433D35DAA6;
 Mon, 14 Sep 2020 14:55:28 +0000 (UTC)
Date: Mon, 14 Sep 2020 16:55:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v2] cphp: remove deprecated cpu-add command(s)
Message-ID: <20200914165525.4503ee2e.cohuck@redhat.com>
In-Reply-To: <20200914074614.973112-1-imammedo@redhat.com>
References: <20200914074614.973112-1-imammedo@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 libvir-list@redhat.com, armbru@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 03:46:14 -0400
Igor Mammedov <imammedo@redhat.com> wrote:

> theses were deprecated since 4.0, remove both HMP and QMP variants.

s/theses/These/

> 
> Users should use device_add command instead. To get list of
> possible CPUs and options, use 'info hotpluggable-cpus' HMP
> or query-hotpluggable-cpus QMP command.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/hw/boards.h         |   1 -
>  include/hw/i386/pc.h        |   1 -
>  include/monitor/hmp.h       |   1 -
>  docs/system/deprecated.rst  |  25 +++++----
>  hmp-commands.hx             |  15 ------
>  hw/core/machine-hmp-cmds.c  |  12 -----
>  hw/core/machine-qmp-cmds.c  |  12 -----
>  hw/i386/pc.c                |  27 ----------
>  hw/i386/pc_piix.c           |   1 -
>  hw/s390x/s390-virtio-ccw.c  |  12 -----
>  qapi/machine.json           |  24 ---------
>  tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
>  tests/qtest/test-hmp.c      |   1 -
>  13 files changed, 21 insertions(+), 211 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>


