Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CBFC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:03:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED5D2208B8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 14:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVJbg6zB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5D2208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNGDq-0007et-L1
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 10:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNGCj-0006T8-Dd
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kNGCh-0004a6-FJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 10:02:05 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601388122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skNqyWqTWJhWLnvkKJjwZ5PvJ32qQDYLORVxUlGUynI=;
 b=UVJbg6zB+4izmAS4w/xuAN1ThN+Eh1FJ32rYamXKFXMTa+M6F17Yle4nehSZtAS3oK39ud
 p7l7wn2hutH2gCUS8SJWVI+Ky5XYT1yzDxXC9P/lkSTE8L2B7SMihmSDVYuLCuy7PKFYp6
 uh6u3K5lOyskRQwtYbYj1k2I9Uc31JI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-15BS9pJNOHifKhcGxXrRZQ-1; Tue, 29 Sep 2020 10:01:45 -0400
X-MC-Unique: 15BS9pJNOHifKhcGxXrRZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9169B56C20;
 Tue, 29 Sep 2020 14:01:42 +0000 (UTC)
Received: from [10.3.112.208] (ovpn-112-208.phx2.redhat.com [10.3.112.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E15D67E19A;
 Tue, 29 Sep 2020 14:01:41 +0000 (UTC)
Subject: Re: [PATCH v4] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
To: Ani Sinha <ani@anisinha.ca>, qemu-devel@nongnu.org
References: <20200924090925.18915-1-ani@anisinha.ca>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <afaacf00-ffba-a9d9-ec78-3a510bd4f108@redhat.com>
Date: Tue, 29 Sep 2020 09:01:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200924090925.18915-1-ani@anisinha.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/24/20 4:09 AM, Ani Sinha wrote:
> A comment is added in bios-tables-test.c that explains the reasoning
> behind the process of updating the ACPI table blobs when new tests are added
> or old tests are modified or code is committed that affect tests. The
> explanation would help future contributors follow the correct process when
> making code changes that affect ACPI tables.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   tests/qtest/bios-tables-test.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 

>    * 6. Now commit any changes to the expected binary, include diff from step 4
>    *    in commit log.
> + *    Expected binary updates needs to be a separate patch from the code that
> + *    introduces changes to ACPI tables. It lets maintainer to drop

s/maintainer to/the maintainer/

> + *    and regenerate binary updates in case of merge conflicts. Further, a code
> + *    change is easily reviewable but a binary blob is not (without doing a
> + *    diassemly).

disassembly

>    * 7. Before sending patches to the list (Contributor)
>    *    or before doing a pull request (Maintainer), make sure
>    *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


