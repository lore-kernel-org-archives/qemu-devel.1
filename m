Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20BBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2CE20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C/R1QDCc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2CE20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPnf-0007w0-Pc
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:12:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPkp-0004Ow-CC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:09:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1joPkm-0000A4-Ch
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593083351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwybSxuOQi38oeMXnoOetN8x3DAu1vynd6mD58XrzTY=;
 b=C/R1QDCckoZ5kkGztgC53n5J/9inuUh2AcxTBQsqPTgFzY/l3ork+GlA2PKdr/xd6GTF7h
 nmilqL/cphmPyYWJbjIk1GVj5OUsYXvLyRkd4iZBvpJq7uqv/SlI6BZjoDwyke9qwPYnOp
 MSO7HAGbWKl9Gg4gCqrfg7MzpMz6yFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-Wy3DKbPdNBikss7xNNtw9Q-1; Thu, 25 Jun 2020 07:09:09 -0400
X-MC-Unique: Wy3DKbPdNBikss7xNNtw9Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A95A310059A4;
 Thu, 25 Jun 2020 11:09:08 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-150.ams2.redhat.com [10.36.112.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 338CE5C6BD;
 Thu, 25 Jun 2020 11:09:04 +0000 (UTC)
Subject: Re: [PATCH v5 05/12] pc-bios: s390x: Remove unneeded dasd-ipl.c reset
 psw mask changes
From: Thomas Huth <thuth@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200624075226.92728-1-frankja@linux.ibm.com>
 <20200624075226.92728-6-frankja@linux.ibm.com>
 <95c7fe36-02fe-d430-5ae7-04e3ce38e3fb@redhat.com>
Message-ID: <ea1ed9df-66d4-550e-1a86-58519aba7dec@redhat.com>
Date: Thu, 25 Jun 2020 13:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <95c7fe36-02fe-d430-5ae7-04e3ce38e3fb@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, borntraeger@de.ibm.com,
 cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/06/2020 12.57, Thomas Huth wrote:
> On 24/06/2020 09.52, Janosch Frank wrote:
>> jump_to_low_kernel() and the functions that it calls will already or
>> 64 bit addressing into the reset psw mask when executing
>> jump_to_IPL_2() after the diag308 subcode 1.
> 
> Hmm, the jump_to_IPL_code() also sets the 64-bit addressing bits ... but 
> jump_to_low_kernel() has some logic that tests for the bits before that 
> function is called:
> 
>      /* Trying to get PSW at zero address */
>      if (*((uint64_t *)0) & RESET_PSW_MASK) {
>          jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff);
>      }
> 
> Could it be that the code in dasd-ipl.c has been written with that 
> if-statement in mind?

... in that case, the code in dasd-ipl.c should maybe rather call 
jump_to_IPL_code((*((uint64_t *)0)) & 0x7fffffff) directly instead of 
going through jump_to_low_kernel(), I guess.

Jason, do you remember the intention here?

  Thomas


