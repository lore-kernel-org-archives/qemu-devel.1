Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ABCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:33:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34723204EF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 20:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihzCjdku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34723204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je2kF-0000ac-CP
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 16:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je2jT-0008IE-RB
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:32:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59386
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1je2jS-0006BD-8T
 for qemu-devel@nongnu.org; Wed, 27 May 2020 16:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590611576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x3qAVKWQeAyGu2yVoDGxQAbTY0cR/FFSka/cdeevAQ4=;
 b=ihzCjdkuFn5kzAYBr0eqgaMZkTVgTaPabMmPVauPcw5cbG+H4EqjdN3Ca3Ikkdss/PxTmN
 7tdQvS4WE8PvR2vP3+1YC/ChrJfWyILVihz0NsNONGWo/0E1zl6en8sqHBmPYMUkt2GswY
 oQXCrVqOZ8KLZ9StQuVxJavbRIAaQeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-IL5JbJkJOUKDlFaqa7bbRw-1; Wed, 27 May 2020 16:32:49 -0400
X-MC-Unique: IL5JbJkJOUKDlFaqa7bbRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 949C4800053;
 Wed, 27 May 2020 20:32:48 +0000 (UTC)
Received: from [10.3.112.88] (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 534ED98A21;
 Wed, 27 May 2020 20:32:48 +0000 (UTC)
Subject: Re: [PULL 00/11] bitmaps patches for 2020-05-26
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200526164211.1569366-1-eblake@redhat.com>
 <CAFEAcA_zO06wPw=iZ-AGMF1YJp1htMJOy0_Nensn3GhWafr=EQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b2bd3045-c49b-132f-b0c8-d928135dd226@redhat.com>
Date: Wed, 27 May 2020 15:32:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zO06wPw=iZ-AGMF1YJp1htMJOy0_Nensn3GhWafr=EQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/27/20 3:07 PM, Peter Maydell wrote:

> 
> iotest 190 failed on freebsd:
> 

> +++ /home/qemu/qemu-test.BE3Bvf/build/tests/qemu-iotests/190.out.bad
>   2020-05-27 15:30:50.377759533 +0000
> @@ -17,7 +17,7 @@
>   fully allocated size: 10813440
>   required size: 2199023255552
>   fully allocated size: 2199023255552
> -required size: 7012352
> +required size: 17170432
>   fully allocated size: 17170432

Thanks for the heads up.  That was on:

# No bitmap output, since no bitmaps on raw source
$QEMU_IMG measure -O qcow2 -f raw "$TEST_IMG"

and indicates that on FreeBSD, the qcow2 image is not as sparse as it is 
on other platforms.  Where Linux was able to punch holes in the 
underlying filesystem, FreeBSD did not.  But even though I'm not sure if 
that is due to file system hole granularity, choice of APIs used to 
write all-zero bitmaps, or something else, I am certain that it less 
important (the qcow2 file is still quite sparse in comparison to the 2T 
guest-visible data it is representing, even if it differs in sparseness 
between the systems).

I'll post a v2 that filters out the required size for just that command, 
as viewing a qcow2 file as if raw is unusual.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


