Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FCEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F19C2225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 06:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/mWhWyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F19C2225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCkM-0005F3-8z
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 02:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCjl-0004ni-Cs
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:09:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCjj-00041x-Pq
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 02:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603519746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsMERggQiq2YyWHSdi0zIeysXIlwH4cOMffQGRcOBt8=;
 b=W/mWhWyObJEUC+iJbyp36bn+StR9LMxr4qi1vWvEhbaRPgczw0Ey5TXZbprs2FpK1IFlYZ
 7/XJSwii8NrawIgrii4s6jTVrRW4b9K2UPNY5+x/AEjhBAC8k6lnbP+xH8WHP+y/fXHTvs
 +7aYO9DiwDX0v679buUawMHDnvuWM2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-KR0Hbfe7MxOSY7JmuDKAoA-1; Sat, 24 Oct 2020 02:09:04 -0400
X-MC-Unique: KR0Hbfe7MxOSY7JmuDKAoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52113804B8A;
 Sat, 24 Oct 2020 06:09:03 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB0255762;
 Sat, 24 Oct 2020 06:09:00 +0000 (UTC)
Subject: Re: [PATCH v4 01/12] libqos/qgraph: add qemu_name to QOSGraphNode
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
References: <cover.1602182956.git.qemu_oss@crudebyte.com>
 <c9a6671914385d0ec6dcd3aee1371d73e09ee33a.1602182956.git.qemu_oss@crudebyte.com>
 <1689234.NbIpsrJQyj@silver>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a3f22a0d-ad06-d227-e9ee-ce0e9c629f96@redhat.com>
Date: Sat, 24 Oct 2020 08:08:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1689234.NbIpsrJQyj@silver>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:17:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?RGFuaWVsIFAuIEJlcnJhbmfDg8Kp?= <berrange@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 12.35, Christian Schoenebeck wrote:
> On Donnerstag, 8. Oktober 2020 20:34:56 CEST Christian Schoenebeck wrote:
>> Add new member variable 'qemu_name' to struct QOSGraphNode.
>>
>> This new member may be optionally set in case a different
>> name for the node (which must always be a unique name) vs.
>> its actually associated QEMU (QMP) device name is required.
>>
>> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>> ---
>>  tests/qtest/libqos/qgraph.c          | 1 +
>>  tests/qtest/libqos/qgraph_internal.h | 1 +
>>  2 files changed, 2 insertions(+)
> 
> So what shall happen with these libqos patches 1..7? Is that a nack, or 
> postpone for now?

I was hoping to see a review by Paolo or Laurent, who are much more familiar
with qos than I am ... but after having a look at the patches, I think I can
also give some feedback, too:

Patch 1 and 2 sound basically ok to me (should maybe be squashed together,
though), but the qos_node_create_driver_named() function currently seems to
be unused so far? So I'd postpone these two patches to the point in time
when you really need the qos_node_create_driver_named() function.

The other patches are basically fine with me, too, but please avoid the
hard-coded ESC codes that only work with certain terminals.

 Thomas


