Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834AAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEFB20772
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNwkKdz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEFB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh8ca-0002tu-EN
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 05:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jh8bZ-0002Kr-5d
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:25:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20693
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jh8bY-0002rF-Cn
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 05:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591349135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8+w04hxN4uaFLOpwHXLi+6GV2IxvnbBXsM2dA6gGn9Y=;
 b=QNwkKdz+jAD00bUli0S9N9jNycflkMapwct2DlnHn3R6T8m2/OflGBTgbf7J6KLH6eziqW
 LiDbmBFTPoIVvxaApPlPeJpjSNJ/V/sKFyPSlojZAxkSoNkVfWGKB5U9Nh7z784IDoGrXo
 TKyYIgAoj65BBj5eOTMri8cqItv9wc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-jQOiPzWLPay9v8XYV6jFzw-1; Fri, 05 Jun 2020 05:25:33 -0400
X-MC-Unique: jQOiPzWLPay9v8XYV6jFzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C382F1009440;
 Fri,  5 Jun 2020 09:25:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-70.ams2.redhat.com [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E123E19C58;
 Fri,  5 Jun 2020 09:25:27 +0000 (UTC)
Subject: Re: [PATCH v8 4/4] new qTest case to test the vhost-user-blk-server
To: Coiby Xu <coiby.xu@gmail.com>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-5-coiby.xu@gmail.com>
 <b8b6c706-e726-e7db-8a1c-ad6fce6ce461@redhat.com>
 <20200605062238.bkpcfd7rl2h5d3md@r>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9c5e6e80-4ba3-dae0-1314-5eebf7cacd2b@redhat.com>
Date: Fri, 5 Jun 2020 11:25:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200605062238.bkpcfd7rl2h5d3md@r>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, bharatlkmlkvm@gmail.com, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2020 08.22, Coiby Xu wrote:
> On Fri, Jun 05, 2020 at 07:01:33AM +0200, Thomas Huth wrote:
>>> diff --git a/tests/qtest/libqos/vhost-user-blk.h
>>> b/tests/qtest/libqos/vhost-user-blk.h
>>> new file mode 100644
>>> index 0000000000..ef4ef09cca
>>> --- /dev/null
>>> +++ b/tests/qtest/libqos/vhost-user-blk.h
>>> @@ -0,0 +1,44 @@
>>> +/*
>>> + * libqos driver framework
>>> + *
>>> + * Copyright (c) 2018 Emanuele Giuseppe Esposito
>>> <e.emanuelegiuseppe@gmail.com>
>>> + *
>>> + * This library is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU Lesser General Public
>>> + * License version 2 as published by the Free Software Foundation.
>>
>> ... but you've missed the header here :-(
> 
> Thank you for reminding me of this issue!
> 
>>> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
>>> index 49075b55a1..a7b7c96206 100644
>>> --- a/tests/qtest/libqtest.c
>>> +++ b/tests/qtest/libqtest.c
>>> @@ -31,40 +31,9 @@
>>>  #include "qapi/qmp/qlist.h"
>>>  #include "qapi/qmp/qstring.h"
>>>
>>> -#define MAX_IRQ 256
>>>  #define SOCKET_TIMEOUT 50
>>>  #define SOCKET_MAX_FDS 16
>>>
>>> -
>>> -typedef void (*QTestSendFn)(QTestState *s, const char *buf);
>>> -typedef void (*ExternalSendFn)(void *s, const char *buf);
>>> -typedef GString* (*QTestRecvFn)(QTestState *);
>>> -
>>> -typedef struct QTestClientTransportOps {
>>> -    QTestSendFn     send;      /* for sending qtest commands */
>>> -
>>> -    /*
>>> -     * use external_send to send qtest command strings through
>>> functions which
>>> -     * do not accept a QTestState as the first parameter.
>>> -     */
>>> -    ExternalSendFn  external_send;
>>> -
>>> -    QTestRecvFn     recv_line; /* for receiving qtest command
>>> responses */
>>> -} QTestTransportOps;
>>> -
>>> -struct QTestState
>>> -{
>>> -    int fd;
>>> -    int qmp_fd;
>>> -    pid_t qemu_pid;  /* our child QEMU process */
>>> -    int wstatus;
>>> -    int expected_status;
>>> -    bool big_endian;
>>> -    bool irq_level[MAX_IRQ];
>>> -    GString *rx;
>>> -    QTestTransportOps ops;
>>> -};
>>
>> Why do you have to move struct QTestState and friends to the header
>> instead? I'd prefer if we could keep it here if possible?
> 
> tests/qtest/vhost-user-blk-test.c needs to talk to qemu-storage-daemon's
> QMP. Thus I g_new0 a QTestState struct to make use of related functions
> like qtest_qmp and this requires the QTestState struct definition.

Hm, ok, could that maybe be solved by introducing a wrapper function to
libqtest.c instead? Something like qtest_create_state_with_qmp_fd() or so?
Moving a define with a generic name like MAX_IRQ to a header really does
not sound like a good idea to me, so if that idea with the wrapper
function does not work out, could you please at least rename MAX_IRQ to
QTEST_MAX_IRQ or something similar?

 Thanks,
  Thomas


