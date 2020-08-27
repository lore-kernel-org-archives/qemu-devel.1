Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB709C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:07:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D82207F7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 10:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7IsCCkE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D82207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBEox-0006Fc-TA
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 06:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBEoS-0005pX-87
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22172)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBEoQ-0000X3-GQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598522837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pzUtds8a6om1mNJDSlOzg5oKuNvRgXCu9yBTcB8LwC0=;
 b=g7IsCCkEnouwPcO2/8N2IuJyu2Z8KUuV+kN4ZEZnhBMfMgBt48352qwbPjAzTy9QzYMPe3
 TuBd6fTCGO0KDkEFbKYxNwBbMJz56HI+NR+QBS2rRCa4RObJMh1oKcPZll4dOmhyH28/1Q
 8xEWqQOyheaoE42IrZrIKw3Q17V+irM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-XcoLbuxhMmaL-_klM0V8xg-1; Thu, 27 Aug 2020 06:07:13 -0400
X-MC-Unique: XcoLbuxhMmaL-_klM0V8xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890B31008567;
 Thu, 27 Aug 2020 10:07:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B8FC5D9E8;
 Thu, 27 Aug 2020 10:07:08 +0000 (UTC)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: jjherne@linux.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
 <896302f7-ec21-6108-6dde-f5a7439d87ab@redhat.com>
 <caefcdbf-e68c-ba05-2ec4-17f127109434@de.ibm.com>
 <d9891265-2254-ee64-c009-0105f7a8b02b@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <12e6fb00-bf1c-268b-baee-ccf1eb73bece@redhat.com>
Date: Thu, 27 Aug 2020 12:07:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d9891265-2254-ee64-c009-0105f7a8b02b@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 07/02/2020 15.02, Jason J. Herne wrote:
> On 2/7/20 6:28 AM, Christian Borntraeger wrote:
>> Jason,
>>
>> can you run objdump -Sdr on jump2ipl.o on a broken variant?
>>
>>
> To keep the volume lower, I've only pasted the output that I think
> you're interested in. If you want to see the entire thing just let me know.
> 
> static void jump_to_IPL_2(void)
> {
>  1d0:    eb bf f0 58 00 24     stmg    %r11,%r15,88(%r15)
>  1d6:    a7 fb ff 50           aghi    %r15,-176
>  1da:    b9 04 00 bf           lgr    %r11,%r15
>     ResetInfo *current = 0;
>  1de:    a7 19 00 00           lghi    %r1,0
>  1e2:    e3 10 b0 a8 00 24     stg    %r1,168(%r11)
> 
>     void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
>  1e8:    e3 10 b0 a8 00 04     lg    %r1,168(%r11)
>  1ee:    58 10 10 08           l    %r1,8(%r1)
>  1f2:    b9 16 00 11           llgfr    %r1,%r1
>  1f6:    e3 10 b0 a0 00 24     stg    %r1,160(%r11)
>     *current = save;
>  1fc:    e3 10 b0 a8 00 04     lg    %r1,168(%r11)
>  202:    c0 20 00 00 00 00     larl    %r2,202 <jump_to_IPL_2+0x32>
>             204: R_390_PC32DBL    .bss+0x2
>  208:    eb 23 20 00 00 04     lmg    %r2,%r3,0(%r2)
>  20e:    eb 23 10 00 00 24     stmg    %r2,%r3,0(%r1)
>     ipl(); /* should not return */
>  214:    e3 10 b0 a0 00 04     lg    %r1,160(%r11)
>  21a:    0d e1                 basr    %r14,%r1
> }
>  21c:    18 00                 lr    %r0,%r0
>  21e:    eb bf b1 08 00 04     lmg    %r11,%r15,264(%r11)
>  224:    07 fe                 br    %r14
>  226:    07 07                 nopr    %r7

I'm currently looking through the past s390-ccw bios patches that still
might need attention ... was there ever a follow up on this discussion?
Do we need to clear the registers before jumping to the OS?
And looking at the disassembly, should we declar the ipl function
pointer with __attribute__((noreturn)) ?

 Thomas


