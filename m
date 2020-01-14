Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB11EC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:32:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853692467D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kly/Vh8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853692467D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irOBX-0000xv-6R
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irNyO-0000Ru-79
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irNyJ-00009f-I0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:19:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55403
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irNyI-000066-V9
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579015149;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type; bh=7Av0EBC0wUnvR4uT/GA5tywrrcCx0R1RquP+AjiCYvQ=;
 b=Kly/Vh8zswlXigXTdxh6AihsKpabxESbYJ4oiM21yEA/bMbcV1NJbzOMnEgeMv3YCiHgXD
 hjVbe/W206r4JUJR3LU6iMdJcy6e442Q7FFRrvTJMV30tGQ+1SumaKA7xLu8yUMpDCdHOJ
 gQi3JfdzuSyurtpjlQvLUWWaraS4wso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-w55Pz8RfMd6pfpM9iq-rKQ-1; Tue, 14 Jan 2020 10:19:06 -0500
X-MC-Unique: w55Pz8RfMd6pfpM9iq-rKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 080D3DB20;
 Tue, 14 Jan 2020 15:19:05 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D62C60BE0;
 Tue, 14 Jan 2020 15:19:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: KVM call minutes for 2020-01-14
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 14 Jan 2020 16:19:02 +0100
Message-ID: <87imlecbh5.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi

This notes are very terse because the discussion was quite technical and
I am not familiar with this part of qemu.  Feel free to fill this.


- libmuser:
    * Take all the complication of implementing the device
    * support several transport types?
    * mediated devices
    * tcp or rdma connection
    * VMI vs VMF
    * SPDK
    * Oracle move from unix socket to muser
    * Will we use it over kernel or over userspace?
    * For polling we are single process
    * How do handle recovery, outside process can have quite a bit of state
- multi-process
   * trying to integrate multiuser + muser
   * look if their vision is ok with qemu expectations
   * one continue with muser kernel module
   * other is vfio over unix socket
   * preferrence is going vfio over unix socket
     this allows all implementations work
- out of tree device
   * problematic
   * require to link with qemu
   * what about dpdk and other external
   * other appoarch: vfio with outside device
- vfio over sockets
   * who is doing that work?
   * felipe prototype it long ago
- best way to get this multiprocess in
  * they have worked on this for a long time
  * no idea about how to go from there

Later, Juan.


