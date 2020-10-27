Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE89C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016B420878
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vm4kNdSY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016B420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXSqD-0002nb-Vu
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXSpD-0001ua-8q
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kXSp8-0002ew-Il
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603819913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzpV15ZkjFIWNxmcG6FY5LOIPy/0YsiNiNoNJDNXNog=;
 b=Vm4kNdSYswtVKz/VxWej6C7Fah3tmguOXsybbD8isV/4W6QbJlIb1i8etIKQsqHTl7MZXt
 LudStQiONoRLXvSrjD8ncVZVnl9px4p011sT2fQ+RC4RVzNLTIDnqaRCcRTw5GyTYO29cP
 ZH+8SFqfi8/W7xcaDk2GBbz3i83YjU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-oRsgGdg7OGinrlFMefyf4Q-1; Tue, 27 Oct 2020 13:31:50 -0400
X-MC-Unique: oRsgGdg7OGinrlFMefyf4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BA280EDA5;
 Tue, 27 Oct 2020 17:31:49 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBBF12C31E;
 Tue, 27 Oct 2020 17:31:48 +0000 (UTC)
Subject: Re: [PATCH 1/3] iotests.py: Fix type check errors in wait_migration()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20201027163806.290960-1-kwolf@redhat.com>
 <20201027163806.290960-2-kwolf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <866a8334-781a-ee91-d631-a52b0fc8da7a@redhat.com>
Date: Tue, 27 Oct 2020 13:31:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201027163806.290960-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/27/20 12:38 PM, Kevin Wolf wrote:
> Commit 1847a4a8c20 clarified that event_wait() can return None (though
> only with timeout=0) and commit f12a282ff47 annotated it as returning
> Optional[QMPMessage].
> 
> Type checks in wait_migration() fail because of the unexpected optional
> return type:
> 
> iotests.py:750: error: Value of type variable "Msg" of "log" cannot be "Optional[Dict[str, Any]]"
> iotests.py:751: error: Value of type "Optional[Dict[str, Any]]" is not indexable
> iotests.py:754: error: Value of type "Optional[Dict[str, Any]]" is not indexable
> 
> Fortunately, the non-zero default timeout is used in the event_wait()
> call, so we can make mypy happy by just asserting this.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   tests/qemu-iotests/iotests.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 63d2ace93c..28388a0fbc 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -747,6 +747,10 @@ class VM(qtest.QEMUQtestMachine):
>       def wait_migration(self, expect_runstate: Optional[str]) -> bool:
>           while True:
>               event = self.event_wait('MIGRATION')
> +            # We use the default timeout, and with a timeout, event_wait()
> +            # never returns None
> +            assert event
> +
>               log(event, filters=[filter_qmp_event])
>               if event['data']['status'] in ('completed', 'failed'):
>                   break
> 

I tried, briefly, to see if I could overload the function to mypy to 
make it Do The Right Thing, but I don't think mypy supports overloading 
on float literals, or not well.

I tried to do this:

@overload
def events_wait(self, events: Sequence[Tuple[str, Any]]) -> QMPMessage: ...

@overload
def events_wait(self, events: Sequence[Tuple[str, Any]],
                 timeout: Literal[0]) -> Optional[QMPMessage]: ...

@overload
def events_wait(self, events: Sequence[Tuple[str, Any]],
                 timeout: float = 60.0) -> QMPMessage: ...

but ultimately mypy doesn't like this:

qemu/machine/machine.py:655: error: Overloaded function implementation 
does not accept all possible arguments of signature 2
Found 1 error in 1 file (checked 7 source files)

Trying literal 0.0 works even less well, because the Literal system does 
not appear to like floats at all. Hmph.

... So much for trying to be clever about this, I guess.

(The event system is pretty wonky anyway; especially type-wise. I think 
it's in need of an overhaul, so I'll put it on the list of things to 
investigate at some point. There might be something nice that can be 
done with asyncio and events that might make more sense type-wise. 
Problems for later.)


