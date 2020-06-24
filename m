Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F115C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591A52081A
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="di+I61FZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591A52081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joCMq-0002ZT-Ll
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCM3-0001lk-Vg
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:50:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52820
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joCM1-0006Jx-Pc
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593031844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sl65k5nhTZQigiA3GQOONXmRcdmyuoEwViqMwb6maiM=;
 b=di+I61FZMwm0NiyCW3tQmR8lIwhNf1ryVbBCqJbGQCjC5/wYy3M4YI+wbj0+5xXLL4xjoe
 94Msw5BWW6I7gJs2o1tT4e1T4K5/a5+tNva4R93X8TDOhhLAT2ZBhRYb2R2+rthI5re0W+
 n267lCg+ULce2JB9WTRW2b/HJrIYlek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-7SPeOJhkNOibKvDx627nTg-1; Wed, 24 Jun 2020 16:50:42 -0400
X-MC-Unique: 7SPeOJhkNOibKvDx627nTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC1C8015F4;
 Wed, 24 Jun 2020 20:50:41 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76AEE51C50;
 Wed, 24 Jun 2020 20:50:40 +0000 (UTC)
Subject: Re: [PATCH 23/46] qapi: Smooth error checking with Coccinelle
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200624164344.3778251-1-armbru@redhat.com>
 <20200624164344.3778251-24-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c1fed52d-ff57-c366-c35d-271a0a1d724c@redhat.com>
Date: Wed, 24 Jun 2020 15:50:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624164344.3778251-24-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gNi8yNC8yMCAxMTo0MyBBTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IFRoZSBwcmV2
aW91cyBjb21taXQgZW5hYmxlcyBjb252ZXJzaW9uIG9mDQo+IA0KPiAgICAgIHZpc2l0X2Zvbygu
Li4sICZlcnIpOw0KPiAgICAgIGlmIChlcnIpIHsNCj4gCS4uLg0KPiAgICAgIH0NCj4gDQo+IHRv
DQo+IA0KPiAgICAgIGlmICghdmlzaXRfZm9vKC4uLiwgZXJycCkpIHsNCj4gCS4uLg0KPiAgICAg
IH0NCj4gDQo+IGZvciB2aXNpdG9yIGZ1bmN0aW9ucyB0aGF0IG5vdyByZXR1cm4gdHJ1ZSAvIGZh
bHNlIG9uIHN1Y2Nlc3MgLyBlcnJvci4NCj4gQ29jY2luZWxsZSBzY3JpcHQ6DQo+IA0KPiAgICAg
IEBADQo+ICAgICAgaWRlbnRpZmllciBmdW4gPX4gImNoZWNrX2xpc3R8aW5wdXRfdHlwZV9lbnVt
fGx2X3N0YXJ0X3N0cnVjdHxsdl90eXBlX2Jvb2x8bHZfdHlwZV9pbnQ2NHxsdl90eXBlX3N0cnxs
dl90eXBlX3VpbnQ2NHxvdXRwdXRfdHlwZV9lbnVtfHBhcnNlX3R5cGVfYm9vbHxwYXJzZV90eXBl
X2ludDY0fHBhcnNlX3R5cGVfbnVsbHxwYXJzZV90eXBlX251bWJlcnxwYXJzZV90eXBlX3NpemV8
cGFyc2VfdHlwZV9zdHJ8cGFyc2VfdHlwZV91aW50NjR8cHJpbnRfdHlwZV9ib29sfHByaW50X3R5
cGVfaW50NjR8cHJpbnRfdHlwZV9udWxsfHByaW50X3R5cGVfbnVtYmVyfHByaW50X3R5cGVfc2l6
ZXxwcmludF90eXBlX3N0cnxwcmludF90eXBlX3VpbnQ2NHxxYXBpX2Nsb25lX3N0YXJ0X2FsdGVy
bmF0ZXxxYXBpX2Nsb25lX3N0YXJ0X2xpc3R8cWFwaV9jbG9uZV9zdGFydF9zdHJ1Y3R8cWFwaV9j
bG9uZV90eXBlX2Jvb2x8cWFwaV9jbG9uZV90eXBlX2ludDY0fHFhcGlfY2xvbmVfdHlwZV9udWxs
fHFhcGlfY2xvbmVfdHlwZV9udW1iZXJ8cWFwaV9jbG9uZV90eXBlX3N0cnxxYXBpX2Nsb25lX3R5
cGVfdWludDY0fHFhcGlfZGVhbGxvY19zdGFydF9saXN0fHFhcGlfZGVhbGxvY19zdGFydF9zdHJ1
Y3R8cWFwaV9kZWFsbG9jX3R5cGVfYW55dGhpbmd8cWFwaV9kZWFsbG9jX3R5cGVfYm9vbHxxYXBp
X2RlYWxsb2NfdHlwZV9pbnQ2NHxxYXBpX2RlYWxsb2NfdHlwZV9udWxsfHFhcGlfZGVhbGxvY190
eXBlX251bWJlcnxxYXBpX2RlYWxsb2NfdHlwZV9zdHJ8cWFwaV9kZWFsbG9jX3R5cGVfdWludDY0
fHFvYmplY3RfaW5wdXRfY2hlY2tfbGlzdHxxb2JqZWN0X2lucHV0X2NoZWNrX3N0cnVjdHxxb2Jq
ZWN0X2lucHV0X3N0YXJ0X2FsdGVybmF0ZXxxb2JqZWN0X2lucHV0X3N0YXJ0X2xpc3R8cW9iamVj
dF9pbnB1dF9zdGFydF9zdHJ1Y3R8cW9iamVjdF9pbnB1dF90eXBlX2FueXxxb2JqZWN0X2lucHV0
X3R5cGVfYm9vbHxxb2JqZWN0X2lucHV0X3R5cGVfYm9vbF9rZXl2YWx8cW9iamVjdF9pbnB1dF90
eXBlX2ludDY0fHFvYmplY3RfaW5wdXRfdHlwZV9pbnQ2NF9rZXl2YWx8cW9iamVjdF9pbnB1dF90
eXBlX251bGx8cW9iamVjdF9pbnB1dF90eXBlX251bWJlcnxxb2JqZWN0X2lucHV0X3R5cGVfbnVt
YmVyX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5cGVfc2l6ZV9rZXl2YWx8cW9iamVjdF9pbnB1dF90
eXBlX3N0cnxxb2JqZWN0X2lucHV0X3R5cGVfc3RyX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5cGVf
dWludDY0fHFvYmplY3RfaW5wdXRfdHlwZV91aW50NjRfa2V5dmFsfHFvYmplY3Rfb3V0cHV0X3N0
YXJ0X2xpc3R8cW9iamVjdF9vdXRwdXRfc3RhcnRfc3RydWN0fHFvYmplY3Rfb3V0cHV0X3R5cGVf
YW55fHFvYmplY3Rfb3V0cHV0X3R5cGVfYm9vbHxxb2JqZWN0X291dHB1dF90eXBlX2ludDY0fHFv
YmplY3Rfb3V0cHV0X3R5cGVfbnVsbHxxb2JqZWN0X291dHB1dF90eXBlX251bWJlcnxxb2JqZWN0
X291dHB1dF90eXBlX3N0cnxxb2JqZWN0X291dHB1dF90eXBlX3VpbnQ2NHxzdGFydF9saXN0fHZp
c2l0X2NoZWNrX2xpc3R8dmlzaXRfY2hlY2tfc3RydWN0fHZpc2l0X3N0YXJ0X2FsdGVybmF0ZXx2
aXNpdF9zdGFydF9saXN0fHZpc2l0X3N0YXJ0X3N0cnVjdHx2aXNpdF90eXBlXy4qIjsNCg0KTG9u
ZyBsaW5lLiBEb2VzIGNvY2NpbmVsbGUgdW5kZXJzdGFuZCBcLW5ld2xpbmUgd3JhcHBpbmc/DQoN
Cj4gICAgICBleHByZXNzaW9uIGxpc3QgYXJncywgYXJnczI7DQo+ICAgICAgdHlwZWRlZiBFcnJv
cjsNCj4gICAgICBFcnJvciAqZXJyOw0KPiAgICAgIGlkZW50aWZpZXIgZXJycDsNCj4gICAgICBA
QA0KPiAgICAgIC0gICAgICBmdW4oYXJncywgJmVyciwgYXJnczIpOw0KPiAgICAgIC0gICAgICBp
ZiAoZXJyKSB7DQo+ICAgICAgKyAgICAgIGlmICghZnVuKGFyZ3MsIGVycnAsIGFyZ3MyKSkgew0K
PiAJICAgICAgIC4uLiB3aGVuICE9IGVycg0KPiAgICAgIC0JICAgZXJyb3JfcHJvcGFnYXRlKGVy
cnAsIGVycik7DQo+IAkgICAgICAgLi4uDQo+IAkgICB9DQo+IA0KPiAgICAgIEBADQo+ICAgICAg
aWRlbnRpZmllciBmdW4gPX4gImNoZWNrX2xpc3R8aW5wdXRfdHlwZV9lbnVtfGx2X3N0YXJ0X3N0
cnVjdHxsdl90eXBlX2Jvb2x8bHZfdHlwZV9pbnQ2NHxsdl90eXBlX3N0cnxsdl90eXBlX3VpbnQ2
NHxvdXRwdXRfdHlwZV9lbnVtfHBhcnNlX3R5cGVfYm9vbHxwYXJzZV90eXBlX2ludDY0fHBhcnNl
X3R5cGVfbnVsbHxwYXJzZV90eXBlX251bWJlcnxwYXJzZV90eXBlX3NpemV8cGFyc2VfdHlwZV9z
dHJ8cGFyc2VfdHlwZV91aW50NjR8cHJpbnRfdHlwZV9ib29sfHByaW50X3R5cGVfaW50NjR8cHJp
bnRfdHlwZV9udWxsfHByaW50X3R5cGVfbnVtYmVyfHByaW50X3R5cGVfc2l6ZXxwcmludF90eXBl
X3N0cnxwcmludF90eXBlX3VpbnQ2NHxxYXBpX2Nsb25lX3N0YXJ0X2FsdGVybmF0ZXxxYXBpX2Ns
b25lX3N0YXJ0X2xpc3R8cWFwaV9jbG9uZV9zdGFydF9zdHJ1Y3R8cWFwaV9jbG9uZV90eXBlX2Jv
b2x8cWFwaV9jbG9uZV90eXBlX2ludDY0fHFhcGlfY2xvbmVfdHlwZV9udWxsfHFhcGlfY2xvbmVf
dHlwZV9udW1iZXJ8cWFwaV9jbG9uZV90eXBlX3N0cnxxYXBpX2Nsb25lX3R5cGVfdWludDY0fHFh
cGlfZGVhbGxvY19zdGFydF9saXN0fHFhcGlfZGVhbGxvY19zdGFydF9zdHJ1Y3R8cWFwaV9kZWFs
bG9jX3R5cGVfYW55dGhpbmd8cWFwaV9kZWFsbG9jX3R5cGVfYm9vbHxxYXBpX2RlYWxsb2NfdHlw
ZV9pbnQ2NHxxYXBpX2RlYWxsb2NfdHlwZV9udWxsfHFhcGlfZGVhbGxvY190eXBlX251bWJlcnxx
YXBpX2RlYWxsb2NfdHlwZV9zdHJ8cWFwaV9kZWFsbG9jX3R5cGVfdWludDY0fHFvYmplY3RfaW5w
dXRfY2hlY2tfbGlzdHxxb2JqZWN0X2lucHV0X2NoZWNrX3N0cnVjdHxxb2JqZWN0X2lucHV0X3N0
YXJ0X2FsdGVybmF0ZXxxb2JqZWN0X2lucHV0X3N0YXJ0X2xpc3R8cW9iamVjdF9pbnB1dF9zdGFy
dF9zdHJ1Y3R8cW9iamVjdF9pbnB1dF90eXBlX2FueXxxb2JqZWN0X2lucHV0X3R5cGVfYm9vbHxx
b2JqZWN0X2lucHV0X3R5cGVfYm9vbF9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBlX2ludDY0fHFv
YmplY3RfaW5wdXRfdHlwZV9pbnQ2NF9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBlX251bGx8cW9i
amVjdF9pbnB1dF90eXBlX251bWJlcnxxb2JqZWN0X2lucHV0X3R5cGVfbnVtYmVyX2tleXZhbHxx
b2JqZWN0X2lucHV0X3R5cGVfc2l6ZV9rZXl2YWx8cW9iamVjdF9pbnB1dF90eXBlX3N0cnxxb2Jq
ZWN0X2lucHV0X3R5cGVfc3RyX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5cGVfdWludDY0fHFvYmpl
Y3RfaW5wdXRfdHlwZV91aW50NjRfa2V5dmFsfHFvYmplY3Rfb3V0cHV0X3N0YXJ0X2xpc3R8cW9i
amVjdF9vdXRwdXRfc3RhcnRfc3RydWN0fHFvYmplY3Rfb3V0cHV0X3R5cGVfYW55fHFvYmplY3Rf
b3V0cHV0X3R5cGVfYm9vbHxxb2JqZWN0X291dHB1dF90eXBlX2ludDY0fHFvYmplY3Rfb3V0cHV0
X3R5cGVfbnVsbHxxb2JqZWN0X291dHB1dF90eXBlX251bWJlcnxxb2JqZWN0X291dHB1dF90eXBl
X3N0cnxxb2JqZWN0X291dHB1dF90eXBlX3VpbnQ2NHxzdGFydF9saXN0fHZpc2l0X2NoZWNrX2xp
c3R8dmlzaXRfY2hlY2tfc3RydWN0fHZpc2l0X3N0YXJ0X2FsdGVybmF0ZXx2aXNpdF9zdGFydF9s
aXN0fHZpc2l0X3N0YXJ0X3N0cnVjdHx2aXNpdF90eXBlXy4qIjsNCg0KVGhlIHNhbWUgbGlzdCB0
d2ljZS4gIElzIHRoZXJlIGEgd2F5IHRvIHdyaXRlIGl0IG9ubHkgb25jZSwgdGhlbiByZWZlciAN
CnRvIGl0IGJ5IHJlZmVyZW5jZSBpbiB0aGUgdHdvIGhhbHZlcyBvZiB0aGUgc2NyaXB0Pw0KDQo+
ICAgNDYgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgMzMxIGRlbGV0aW9ucygtKQ0K
DQpOaWNlIHRvIHNlZSB0aGUgc2l6ZSByZWR1Y3Rpb24uDQoNClJldmlld2VkLWJ5OiBFcmljIEJs
YWtlIDxlYmxha2VAcmVkaGF0LmNvbT4NCg0KLS0gDQpFcmljIEJsYWtlLCBQcmluY2lwYWwgU29m
dHdhcmUgRW5naW5lZXINClJlZCBIYXQsIEluYy4gICAgICAgICAgICsxLTkxOS0zMDEtMzIyNg0K
VmlydHVhbGl6YXRpb246ICBxZW11Lm9yZyB8IGxpYnZpcnQub3JnDQo=


