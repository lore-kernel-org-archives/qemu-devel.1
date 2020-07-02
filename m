Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14059C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:30:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D532B20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEwz2hvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D532B20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr32A-0002vl-4q
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr318-0001P2-Sr
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:28:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jr316-0004aW-08
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593710934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOHio64O5CfkvYDruE4WqT35+m0DsuYDhFpMmBngXr4=;
 b=CEwz2hvm7ktZXdo7kvJ9BWPvXdLh2rnhoeDRC3eGu0Cm6pgJP2id+XA4Fw0678TRz7Zj2v
 EXN5jrb9p3JHxjGzsdVPUA+FI5MEL+vhlRyFEv3c/5nOfacj7h7Zq/RHgKlrpeJaUAsb5a
 bP83rjOaWxBQllmRUFAi6ysAB2ziV3U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-CJ3b6LIUOIiwoC-g3Byetw-1; Thu, 02 Jul 2020 13:28:47 -0400
X-MC-Unique: CJ3b6LIUOIiwoC-g3Byetw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA90110506E2;
 Thu,  2 Jul 2020 17:28:45 +0000 (UTC)
Received: from [10.3.112.202] (ovpn-112-202.phx2.redhat.com [10.3.112.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 49B0C10002A2;
 Thu,  2 Jul 2020 17:28:45 +0000 (UTC)
Subject: Re: [PATCH v2 17/44] qapi: Use returned bool to check for failure,
 Coccinelle part
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200702155000.3455325-1-armbru@redhat.com>
 <20200702155000.3455325-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <da247352-2c93-8183-03c3-4c1a772d133a@redhat.com>
Date: Thu, 2 Jul 2020 12:28:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702155000.3455325-18-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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

T24gNy8yLzIwIDEwOjQ5IEFNLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4gVGhlIHByZXZp
b3VzIGNvbW1pdCBlbmFibGVzIGNvbnZlcnNpb24gb2YNCj4gDQo+ICAgICAgdmlzaXRfZm9vKC4u
LiwgJmVycik7DQo+ICAgICAgaWYgKGVycikgew0KPiAJLi4uDQo+ICAgICAgfQ0KPiANCj4gdG8N
Cj4gDQo+ICAgICAgaWYgKCF2aXNpdF9mb28oLi4uLCBlcnJwKSkgew0KPiAJLi4uDQo+ICAgICAg
fQ0KPiANCj4gZm9yIHZpc2l0b3IgZnVuY3Rpb25zIHRoYXQgbm93IHJldHVybiB0cnVlIC8gZmFs
c2Ugb24gc3VjY2VzcyAvIGVycm9yLg0KPiBDb2NjaW5lbGxlIHNjcmlwdDoNCj4gDQo+ICAgICAg
QEANCj4gICAgICBpZGVudGlmaWVyIGZ1biA9fiAiY2hlY2tfbGlzdHxpbnB1dF90eXBlX2VudW18
bHZfc3RhcnRfc3RydWN0fGx2X3R5cGVfYm9vbHxsdl90eXBlX2ludDY0fGx2X3R5cGVfc3RyfGx2
X3R5cGVfdWludDY0fG91dHB1dF90eXBlX2VudW18cGFyc2VfdHlwZV9ib29sfHBhcnNlX3R5cGVf
aW50NjR8cGFyc2VfdHlwZV9udWxsfHBhcnNlX3R5cGVfbnVtYmVyfHBhcnNlX3R5cGVfc2l6ZXxw
YXJzZV90eXBlX3N0cnxwYXJzZV90eXBlX3VpbnQ2NHxwcmludF90eXBlX2Jvb2x8cHJpbnRfdHlw
ZV9pbnQ2NHxwcmludF90eXBlX251bGx8cHJpbnRfdHlwZV9udW1iZXJ8cHJpbnRfdHlwZV9zaXpl
fHByaW50X3R5cGVfc3RyfHByaW50X3R5cGVfdWludDY0fHFhcGlfY2xvbmVfc3RhcnRfYWx0ZXJu
YXRlfHFhcGlfY2xvbmVfc3RhcnRfbGlzdHxxYXBpX2Nsb25lX3N0YXJ0X3N0cnVjdHxxYXBpX2Ns
b25lX3R5cGVfYm9vbHxxYXBpX2Nsb25lX3R5cGVfaW50NjR8cWFwaV9jbG9uZV90eXBlX251bGx8
cWFwaV9jbG9uZV90eXBlX251bWJlcnxxYXBpX2Nsb25lX3R5cGVfc3RyfHFhcGlfY2xvbmVfdHlw
ZV91aW50NjR8cWFwaV9kZWFsbG9jX3N0YXJ0X2xpc3R8cWFwaV9kZWFsbG9jX3N0YXJ0X3N0cnVj
dHxxYXBpX2RlYWxsb2NfdHlwZV9hbnl0aGluZ3xxYXBpX2RlYWxsb2NfdHlwZV9ib29sfHFhcGlf
ZGVhbGxvY190eXBlX2ludDY0fHFhcGlfZGVhbGxvY190eXBlX251bGx8cWFwaV9kZWFsbG9jX3R5
cGVfbnVtYmVyfHFhcGlfZGVhbGxvY190eXBlX3N0cnxxYXBpX2RlYWxsb2NfdHlwZV91aW50NjR8
cW9iamVjdF9pbnB1dF9jaGVja19saXN0fHFvYmplY3RfaW5wdXRfY2hlY2tfc3RydWN0fHFvYmpl
Y3RfaW5wdXRfc3RhcnRfYWx0ZXJuYXRlfHFvYmplY3RfaW5wdXRfc3RhcnRfbGlzdHxxb2JqZWN0
X2lucHV0X3N0YXJ0X3N0cnVjdHxxb2JqZWN0X2lucHV0X3R5cGVfYW55fHFvYmplY3RfaW5wdXRf
dHlwZV9ib29sfHFvYmplY3RfaW5wdXRfdHlwZV9ib29sX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5
cGVfaW50NjR8cW9iamVjdF9pbnB1dF90eXBlX2ludDY0X2tleXZhbHxxb2JqZWN0X2lucHV0X3R5
cGVfbnVsbHxxb2JqZWN0X2lucHV0X3R5cGVfbnVtYmVyfHFvYmplY3RfaW5wdXRfdHlwZV9udW1i
ZXJfa2V5dmFsfHFvYmplY3RfaW5wdXRfdHlwZV9zaXplX2tleXZhbHxxb2JqZWN0X2lucHV0X3R5
cGVfc3RyfHFvYmplY3RfaW5wdXRfdHlwZV9zdHJfa2V5dmFsfHFvYmplY3RfaW5wdXRfdHlwZV91
aW50NjR8cW9iamVjdF9pbnB1dF90eXBlX3VpbnQ2NF9rZXl2YWx8cW9iamVjdF9vdXRwdXRfc3Rh
cnRfbGlzdHxxb2JqZWN0X291dHB1dF9zdGFydF9zdHJ1Y3R8cW9iamVjdF9vdXRwdXRfdHlwZV9h
bnl8cW9iamVjdF9vdXRwdXRfdHlwZV9ib29sfHFvYmplY3Rfb3V0cHV0X3R5cGVfaW50NjR8cW9i
amVjdF9vdXRwdXRfdHlwZV9udWxsfHFvYmplY3Rfb3V0cHV0X3R5cGVfbnVtYmVyfHFvYmplY3Rf
b3V0cHV0X3R5cGVfc3RyfHFvYmplY3Rfb3V0cHV0X3R5cGVfdWludDY0fHN0YXJ0X2xpc3R8dmlz
aXRfY2hlY2tfbGlzdHx2aXNpdF9jaGVja19zdHJ1Y3R8dmlzaXRfc3RhcnRfYWx0ZXJuYXRlfHZp
c2l0X3N0YXJ0X2xpc3R8dmlzaXRfc3RhcnRfc3RydWN0fHZpc2l0X3R5cGVfLioiOw0KDQpMb25n
IGxpbmUsIGJ1dCB0b2xlcmFibGUNCg0KPiAgICAgIGV4cHJlc3Npb24gbGlzdCBhcmdzOw0KPiAg
ICAgIHR5cGVkZWYgRXJyb3I7DQo+ICAgICAgRXJyb3IgKmVycjsNCj4gICAgICBAQA0KPiAgICAg
IC0gICAgZnVuKGFyZ3MsICZlcnIpOw0KPiAgICAgIC0gICAgaWYgKGVycikNCj4gICAgICArICAg
IGlmICghZnVuKGFyZ3MsICZlcnIpKQ0KPiAgICAgICAgICAgew0KPiAgICAgICAgICAgICAgIC4u
Lg0KPiAgICAgICAgICAgfQ0KPiANCj4gQSBmZXcgbGluZSBicmVha3MgdGlkaWVkIHVwIG1hbnVh
bGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRo
YXQuY29tPg0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IEVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQu
Y29tPg0KDQotLSANCkVyaWMgQmxha2UsIFByaW5jaXBhbCBTb2Z0d2FyZSBFbmdpbmVlcg0KUmVk
IEhhdCwgSW5jLiAgICAgICAgICAgKzEtOTE5LTMwMS0zMjI2DQpWaXJ0dWFsaXphdGlvbjogIHFl
bXUub3JnIHwgbGlidmlydC5vcmcNCg==


