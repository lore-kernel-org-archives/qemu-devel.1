Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C62C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C233206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va9gcqLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C233206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADo9-00060e-Nq
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADn5-0004Ki-Hp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:49:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55078
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kADn3-000686-Os
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598280580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PY/OigNdGuq0YE01pv7N5G6cU06xFxtbmqnIACNSCBo=;
 b=Va9gcqLZLKooPBeeW/3/LSPAlSoyAkuWegx1BgTUPdONdRpsjXj83b6pWCxTyzbrZQcogZ
 YvoY3zhami0Nmh6U2wpxfYLcp9PuESWCUnXGEloupxyB7xcd80IlS9/1awEpTF4/Ht/rco
 akweWxhXPDyUwQ5y1oksHGxOPWIy9zQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-yPZhgfJqPgC03KiayUO5RA-1; Mon, 24 Aug 2020 10:49:35 -0400
X-MC-Unique: yPZhgfJqPgC03KiayUO5RA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B121381F01A;
 Mon, 24 Aug 2020 14:49:34 +0000 (UTC)
Received: from [10.3.112.126] (ovpn-112-126.phx2.redhat.com [10.3.112.126])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D9F2808A7;
 Mon, 24 Aug 2020 14:49:34 +0000 (UTC)
Subject: Re: [PATCH 3/4] configure: Prefer gmake on darwin
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-4-r.bolshakov@yadro.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <051b2296-f656-9488-f66a-1e74fdd53dc7@redhat.com>
Date: Mon, 24 Aug 2020 09:49:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200822212129.97758-4-r.bolshakov@yadro.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:21:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.25, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/22/20 4:21 PM, Roman Bolshakov wrote:
> New meson/make build requires GNU make 3.82+ but macOS ships 3.81 even
> on Big Sur while homebrew provides GNU make 4.3 as 'gmake' in $PATH.

Does this line up with our development policies on supported platforms? 
Should we be fixing the creation of Makefile.ninja to avoid constructs 
not understood by older GNU make, if that is what is shipped out of the 
box on MacOS as one of our supported platforms?  Or is MacOS on the 
fringe for what counts as supported, where we are okay mandating that 
users must install a separate newer GNU make than what comes by default?

> 
> With the change, 'make' switches over to gmake implicitly.

If gmake ships new enough by default, then this seems like a slick 
trick, although I am not in a position to test it.

> @@ -916,6 +917,27 @@ Darwin)
>     # won't work when we're compiling with gcc as a C compiler.
>     QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
>     HOST_VARIANT_DIR="darwin"
> +  cat > GNUmakefile <<'EOF'
> +# This file is auto-generated by configure to implicitly switch from a 'make'
> +# invocation to 'gmake'

Are we going to run into issues with an in-tree build trying to create 
GNUmakefile to switch over to build/, while also creating 
build/GNUmakefile to switch from make to gmake?


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


