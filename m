Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1751C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:16:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D0552223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 11:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yg3V0T7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0552223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUpcU-00049I-VD
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 07:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUpao-0002so-E9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUpam-0008Ek-AJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 07:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603192451;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fc1CP0bbv/II5H06hMyj8ZaOHwbzRdLp1EfI9RKONuQ=;
 b=Yg3V0T7tgNfplMIFsS+Byih064abkLl2JCwtAwVVn9HzlWopP4JhKJMdbQOeNaAKKTU/BH
 DlEFLn5wks+r9lB3lH2FuYX4K2dHOdGctSN244mQHkgH4akwoVf6tc+p7/xCUCpIJb5rM5
 nojSuxXUTF9+KP1q8ORCajDuRa05e6c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-YWQ-Sg4mMpaRzX1M6OIciA-1; Tue, 20 Oct 2020 07:13:57 -0400
X-MC-Unique: YWQ-Sg4mMpaRzX1M6OIciA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E585B1009E26;
 Tue, 20 Oct 2020 11:13:54 +0000 (UTC)
Received: from redhat.com (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0728B1A3D6;
 Tue, 20 Oct 2020 11:13:48 +0000 (UTC)
Date: Tue, 20 Oct 2020 12:13:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gan Qixin <ganqixin@huawei.com>
Subject: Re: [PATCH 00/10] Fix line over 80 characters warning
Message-ID: <20201020111346.GH287149@redhat.com>
References: <20201019203023.658555-1-ganqixin@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20201019203023.658555-1-ganqixin@huawei.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, alistair.francis@wdc.com,
 kuhn.chenqun@huawei.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 04:30:13AM +0800, Gan Qixin wrote:
> Hi all,
>     I used scripts/checkpatch.pl to find that many files in the hw directory 
> contain lines with more than 80 characters. Therefore, I splited some lines to
> fix this warning.

Do we really need to still fix ourselves to a 80 col limit in the
year 2020 ?

Linux increased their max line length to 100 chars and even set
checkpatch.pl to not complain about that limit unless --strict
is given.

80 chars is fine as a "wish list" target, but IMHO the code often
benefits more from exceeding 80 chars, and not wrapping.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


