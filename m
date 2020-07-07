Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D31C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B7DC206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoU1eUrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B7DC206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstiy-0001ft-OD
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jstiL-00014q-PG
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:57:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56871
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jstiK-0001U2-4V
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594151830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JMpC/hLGlbH54FbCDDUDa5Gqsa0zcfzruK+j5fgi82c=;
 b=BoU1eUrWnVOldzBD9TUCbtzR/jmZKo+4UvtMQ01m6qmmkphLl3wvDemlQElKX2nVcryo5H
 uFvln5mIuSvshe+td+0EbMp4ZcWZnFs6JVyOvM+AzZosYhPEavGRcoER4i6JHJNElgLr0G
 Uhi5lGdRG1G4w7J8aKl9iMfZiJmsVQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-TyfL4MohOBWbH_sAYam42w-1; Tue, 07 Jul 2020 15:57:09 -0400
X-MC-Unique: TyfL4MohOBWbH_sAYam42w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4842A800406;
 Tue,  7 Jul 2020 19:57:08 +0000 (UTC)
Received: from [10.3.115.46] (ovpn-115-46.phx2.redhat.com [10.3.115.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BACE1797F1;
 Tue,  7 Jul 2020 19:57:04 +0000 (UTC)
Subject: Re: [PATCH v6 08/10] iotests: Specify explicit backing format where
 sensible
To: Kevin Wolf <kwolf@redhat.com>
References: <20200706203954.341758-1-eblake@redhat.com>
 <20200706203954.341758-9-eblake@redhat.com>
 <20200707160701.GE7002@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <8cef9936-4373-db92-90f0-ee208b203a47@redhat.com>
Date: Tue, 7 Jul 2020 14:57:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707160701.GE7002@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:31:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, kchamart@redhat.com,
 libvir-list@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/7/20 11:07 AM, Kevin Wolf wrote:
> Am 06.07.2020 um 22:39 hat Eric Blake geschrieben:
>> There are many existing qcow2 images that specify a backing file but
>> no format.  This has been the source of CVEs in the past, but has
>> become more prominent of a problem now that libvirt has switched to
>> -blockdev.  With older -drive, at least the probing was always done by
>> qemu (so the only risk of a changed format between successive boots of
>> a guest was if qemu was upgraded and probed differently).  But with
>> newer -blockdev, libvirt must specify a format; if libvirt guesses raw
>> where the image was formatted, this results in data corruption visible
>> to the guest; conversely, if libvirt guesses qcow2 where qemu was
>> using raw, this can result in potential security holes, so modern
>> libvirt instead refuses to use images without explicit backing format.
>>
>> The change in libvirt to reject images without explicit backing format
>> has pointed out that a number of tools have been far too reliant on
>> probing in the past.  It's time to set a better example in our own
>> iotests of properly setting this parameter.
>>
>> iotest calls to create, rebase, and convert are all impacted to some
>> degree.  It's a bit annoying that we are inconsistent on command line
>> - while all of those accept -o backing_file=...,backing_fmt=..., the
>> shortcuts are different: create and rebase have -b and -F, while
>> convert has -B but no -F.  (amend has no shortcuts, but the previous
>> patch just deprecated the use of amend to change backing chains).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> This breaks at least 024 and 043 for qed because qemu-img info can't
> print the backing file format there (qed only saves a flag whether it's
> raw or non-raw).

Shoot.  I tend to avoid tests of qed and qcow (because they take so 
long), so while I may have tested them around v1 or v2 of the series, 
all the rebasing has changed the results by now.  Such is life.

> 
> We can fix the output filtering during the freeze, though.

Yes indeed, and I'll post such patches soon, now that you've pointed it out.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


