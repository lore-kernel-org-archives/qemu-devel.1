Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1D2C433F7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06DE20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLmctj0n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06DE20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04L1-00024v-5M
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k04KE-0000jH-7W
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k04KB-0002aR-Re
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595860915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aahIWJN6bGY0QOATwBA6ZjwznaDmfE/SoQBCKs0NKug=;
 b=GLmctj0nmusYd12/cUAhsE3KLapy2+Wty28T03R3NMq3aaKzj+MPziSe5Wv3AXLauV60JF
 h0o+dBWbnN81c9zgQLyCdJHT3LUbKt/hbIjKhfMl1jPMt/wJ778PDyKH2soklVMKnP+KeN
 3jEVnaf+NgFJOU2q7FzzbMslfHUKxXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-uVWEZbg4N7Weo_Vvjj33SQ-1; Mon, 27 Jul 2020 10:41:51 -0400
X-MC-Unique: uVWEZbg4N7Weo_Vvjj33SQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED4C8106B245;
 Mon, 27 Jul 2020 14:41:50 +0000 (UTC)
Received: from [10.3.113.26] (ovpn-113-26.phx2.redhat.com [10.3.113.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C05361463;
 Mon, 27 Jul 2020 14:41:50 +0000 (UTC)
Subject: Re: [PATCH 2/2] qemu-iotests: Test convert to qcow2 compressed to NBD
To: Nir Soffer <nsoffer@redhat.com>
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-3-nsoffer@redhat.com>
 <b0e61f48-d272-0aa5-3698-5d17a1de0774@redhat.com>
 <b4c0408f-da30-259f-b175-15e709ee987c@redhat.com>
 <CAMRbyytButqSyqAXVFgMzMKoaRUYfCYWAUAoFQs9TXS0PSrX0Q@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <5e87add3-57ed-1c57-4ea3-07a77cda3882@redhat.com>
Date: Mon, 27 Jul 2020 09:41:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytButqSyqAXVFgMzMKoaRUYfCYWAUAoFQs9TXS0PSrX0Q@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 9:35 AM, Nir Soffer wrote:

>> I guess it's okay that you don't create a real tar file here, but
>> listing the commands to create it (even as a comment) is better than
>> just saying "trust me".  And it doesn't seem like that much more work -
>> it looks like the key to your test is that you created a tar file
>> containing two files, where the first file was less than 512 bytes and
>> the second file is your target destination that you will be rewriting.
> 
> The real code is more complicated, something like:
> 
>      offset = tar.fileobj.tell() + BLOCK_SIZE
> 
>      with open(tar.name, "r+") as f:
>          f.truncate(offset + measure["required"])
> 
>      convert_image(image, tar.name, offset)
> 
>      check = check_image(tar.name, offset)
>      size = check["image-end-offset"]
> 
>      member = tarfile.TarInfo(name)
>      member.size = size
>      tar.addfile(member)
> 
>      tar_size = offset + round_up(size)
> 
>      tar.fileobj.seek(tar_size)
>      with open(tar.name, "r+") as f:
>          f.truncate(tar_size)
> 
> I'm not sure it helps qemu developers working on these tests.

The closer the iotest is to reality, the more likely it will serve as a 
good regression test.  Cutting corners risks a test that passes in 
isolation even when we've done something that breaks the overall process 
in one of the corners you cut.


>>
>> At any rate, given the urgency of getting pull requests for -rc2 in
>> before slamming Peter tomorrow, I'll probably try to touch up the issues
>> Max pointed out and queue it today.
> 
> Thanks Max and Eric.
> 
> Should I post a fixed version later today?

A v2 would be helpful.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


