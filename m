Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD93DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 808992166E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 09:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEMHlVh+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 808992166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFa0e-0007ak-Lj
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 05:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyJ-0003P5-AQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22887
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kFZyG-0001vW-CW
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 05:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599557482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/kwpCGtCNpeoNdp7A5E/IVZ7MTOOResHJ+MCxJ1Nrbs=;
 b=jEMHlVh+pHyIHO5OlxHk5xx/sKYXi0zJpSWaIQyEELLkSvWs2LhKOtbvno+c+VNpf8+Tap
 gjyY4oNug2OqgR8eGOurzvLLkrKDHUc50M+V/iU18X+v8fhEPh78KCgqW74NqSQhDI2woH
 34TOPZxAzWLiZ1SRb9Z0gbGl3nC+DEA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-aKZF6WoIP-usfzmdxAmYuw-1; Tue, 08 Sep 2020 05:31:19 -0400
X-MC-Unique: aKZF6WoIP-usfzmdxAmYuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 960791074642;
 Tue,  8 Sep 2020 09:31:18 +0000 (UTC)
Received: from localhost (ovpn-114-244.ams2.redhat.com [10.36.114.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6FDE811BC;
 Tue,  8 Sep 2020 09:31:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/4] docs: add qemu-storage-daemon documentation
Date: Tue,  8 Sep 2020 10:31:09 +0100
Message-Id: <20200908093113.47564-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=205.139.110.61; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 01:08:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSBxZW11LXN0b3JhZ2UtZGFlbW9uIHByb2dyYW0gYW5k
IGl0cyBRTVAgY29tbWFuZHMuDQoNClRoZSBtYW4gcGFnZSBsb29rcyBsaWtlIHRoaXM6DQoNClFF
TVUtU1RPUkFHRS1EQUVNT04oMSkgICAgICAgUUVNVSAgICAgICAgICAgICAgICAgICAgUUVNVS1T
VE9SQUdFLURBRU1PTigxKQ0KDQpOQU1FDQogICAgICAgcWVtdS1zdG9yYWdlLWRhZW1vbiAtIFFF
TVUgc3RvcmFnZSBkYWVtb24NCg0KU1lOT1BTSVMNCiAgICAgICBxZW11LXN0b3JhZ2UtZGFlbW9u
IFtvcHRpb25zXQ0KDQpERVNDUklQVElPTg0KICAgICAgIHFlbXUtc3RvcmFnZS1kYWVtb24gIHBy
b3ZpZGVzICBkaXNrIGltYWdlIGZ1bmN0aW9uYWxpdHkgZnJvbSBRRU1VLA0KICAgICAgIHFlbXUt
aW1nLCBhbmQgcWVtdS1uYmQgaW4gYSBsb25nLXJ1bm5pbmcgcHJvY2VzcyBjb250cm9sbGVkIHZp
YSBRTVANCiAgICAgICBjb21tYW5kcyB3aXRob3V0IHJ1bm5pbmcgYSB2aXJ0dWFsIG1hY2hpbmUu
DQoNCiAgICAgICBJdCBjYW4gZXhwb3J0IGRpc2sgaW1hZ2VzIG92ZXIgTkJELCBydW4gYmxvY2sg
am9iIG9wZXJhdGlvbnMsIGFuZA0KICAgICAgIHBlcmZvcm0gb3RoZXIgZGlzay1yZWxhdGVkIG9w
ZXJhdGlvbnMuIFRoZSBkYWVtb24gaXMgY29udHJvbGxlZCB2aWEgYQ0KICAgICAgIFFNUCBtb25p
dG9yIHNvY2tldCBhbmQgaW5pdGlhbCBjb25maWd1cmF0aW9uIGZyb20gdGhlIGNvbW1hbmQtbGlu
ZS4NCg0KICAgICAgIFRoZSBkYWVtb24gb2ZmZXJzIHRoZSBmb2xsb3dpbmcgc3Vic2V0IG9mIFFF
TVUgZmVhdHVyZXM6DQoNCiAgICAgICA9QzI9QjcgQmxvY2tkZXYgbm9kZXMNCg0KICAgICAgID1D
Mj1CNyBCbG9jayBqb2JzDQoNCiAgICAgICA9QzI9QjcgTkJEIHNlcnZlcg0KDQogICAgICAgPUMy
PUI3IENoYXJhY3RlciBkZXZpY2VzDQoNCiAgICAgICA9QzI9QjcgQ3J5cHRvIGFuZCBzZWNyZXRz
DQoNCiAgICAgICA9QzI9QjcgUU1QDQoNCiAgICAgICBDb21tYW5kcyBjYW4gYmUgc2VudCBvdmVy
IGEgUUVNVSBNb25pdG9yIFByb3RvY29sIChRTVApIGNvbm5lY3Rpb24uIFNlZQ0KICAgICAgIHRo
ZSBxZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYoNykgbWFudWFsIHBhZ2UgZm9yIGEgZGVzY3Jp
cHRpb24gb2YgdGhlDQogICAgICAgY29tbWFuZHMuDQoNCiAgICAgICBUaGUgZGFlbW9uIHJ1bnMg
dW50aWwgaXQgaXMgc3RvcHBlZCB1c2luZyB0aGUgcXVpdCBRTVAgY29tbWFuZCBvcg0KICAgICAg
IFNJR0lOVC9TSUdIVVAvU0lHVEVSTS4NCg0KICAgICAgIFdhcm5pbmc6IE5ldmVyIG1vZGlmeSBp
bWFnZXMgaW4gdXNlIGJ5IGEgcnVubmluZyB2aXJ0dWFsIG1hY2hpbmUgb3IgYW55DQogICAgICAg
b3RoZXIgcHJvY2VzczsgdGhpcyBtYXkgZGVzdHJveSB0aGUgaW1hZ2UuIEFsc28sIGJlIGF3YXJl
IHRoYXQgcXVlcnlpbj0NCmcgYW4NCiAgICAgICBpbWFnZSB0aGF0IGlzIGJlaW5nIG1vZGlmaWVk
IGJ5IGFub3RoZXIgcHJvY2VzcyBtYXkgZW5jb3VudGVyDQogICAgICAgaW5jb25zaXN0ZW50IHN0
YXRlLg0KDQpPUFRJT05TDQogICAgICAgU3RhbmRhcmQgb3B0aW9uczoNCg0KICAgICAgIC1oLCAt
LWhlbHANCiAgICAgICAgICAgICAgRGlzcGxheSB0aGlzIGhlbHAgYW5kIGV4aXQNCg0KICAgICAg
IC1WLCAtLXZlcnNpb24NCiAgICAgICAgICAgICAgRGlzcGxheSB2ZXJzaW9uIGluZm9ybWF0aW9u
IGFuZCBleGl0DQoNCiAgICAgICAtVCwgLS10cmFjZSBbW2VuYWJsZT0zRF1QQVRURVJOXVssZXZl
bnRzPTNERklMRV1bLGZpbGU9M0RGSUxFXQ0KICAgICAgICAgICAgICBTcGVjaWZ5IHRyYWNpbmcg
b3B0aW9ucy4NCg0KICAgICAgICAgICAgICBbZW5hYmxlPTNEXVBBVFRFUk4NCiAgICAgICAgICAg
ICAgICAgICAgIEltbWVkaWF0ZWx5IGVuYWJsZSBldmVudHMgbWF0Y2hpbmcgUEFUVEVSTiAoZWl0
aGVyIGV2ZW50PQ0KIG5hbWUgb3IgYSBnbG9iYmluZyBwYXR0ZXJuKS4gIFRoaXMgb3B0aW9uIGlz
IG9ubHkgYXZhaWxhYmxlIGlmIFFFTVUgaGFzIGJlZW49DQogY29tcGlsZWQgd2l0aCB0aGUgc2lt
cGxlLCAgbG9nDQogICAgICAgICAgICAgICAgICAgICBvciBmdHJhY2UgdHJhY2luZyBiYWNrZW5k
LiAgVG8gc3BlY2lmeSBtdWx0aXBsZSBldmVudHMgbz0NCnIgcGF0dGVybnMsIHNwZWNpZnkgdGhl
IC10cmFjZSBvcHRpb24gbXVsdGlwbGUgdGltZXMuDQoNCiAgICAgICAgICAgICAgICAgICAgIFVz
ZSAtdHJhY2UgaGVscCB0byBwcmludCBhIGxpc3Qgb2YgbmFtZXMgb2YgdHJhY2UgcG9pbnRzLg0K
DQogICAgICAgICAgICAgIGV2ZW50cz0zREZJTEUNCiAgICAgICAgICAgICAgICAgICAgIEltbWVk
aWF0ZWx5ICBlbmFibGUgIGV2ZW50cyAgbGlzdGVkIGluIEZJTEUuICBUaGUgZmlsZSBtPQ0KdXN0
IGNvbnRhaW4gb25lIGV2ZW50IG5hbWUgKGFzIGxpc3RlZCBpbiB0aGUgdHJhY2UtZXZlbnRzLWFs
bCBmaWxlKSBwZXIgbGluZTs9DQogZ2xvYmJpbmcgcGF0dGVybnMgYXJlIGFjY2VwdGVkDQogICAg
ICAgICAgICAgICAgICAgICB0b28uICBUaGlzIG9wdGlvbiBpcyBvbmx5IGF2YWlsYWJsZSBpZiBR
RU1VIGhhcyBiZWVuIGNvbT0NCnBpbGVkIHdpdGggdGhlIHNpbXBsZSwgbG9nIG9yIGZ0cmFjZSB0
cmFjaW5nIGJhY2tlbmQuDQoNCiAgICAgICAgICAgICAgZmlsZT0zREZJTEUNCiAgICAgICAgICAg
ICAgICAgICAgIExvZyBvdXRwdXQgdHJhY2VzIHRvIEZJTEUuICBUaGlzIG9wdGlvbiBpcyBvbmx5
IGF2YWlsYWJsPQ0KZSBpZiBRRU1VIGhhcyBiZWVuIGNvbXBpbGVkIHdpdGggdGhlIHNpbXBsZSB0
cmFjaW5nIGJhY2tlbmQuDQoNCiAgICAgICAtLWJsb2NrZGV2IEJMT0NLREVWREVGDQogICAgICAg
ICAgICAgIGlzIGEgYmxvY2tkZXYgbm9kZSBkZWZpbml0aW9uLiBTZWUgdGhlIHFlbXUoMSkgbWFu
dWFsIHBhZ2UgZm9yID0NCmEgZGVzY3JpcHRpb24gb2YgYmxvY2tkZXYgbm9kZSBwcm9wZXJ0aWVz
IGFuZCB0aGUgcWVtdS1ibG9jay1kcml2ZXJzKDcpIG1hbnVhPQ0KbCBwYWdlICBmb3IgIGEgIGRl
c2NyaXB0aW9uICBvZg0KICAgICAgICAgICAgICBkcml2ZXItc3BlY2lmaWMgcGFyYW1ldGVycy4N
Cg0KICAgICAgIC0tY2hhcmRldiBDSEFSREVWREVGDQogICAgICAgICAgICAgIGlzICBhICBjaGFy
YWN0ZXIgIGRldmljZSAgZGVmaW5pdGlvbi4gIFNlZSB0aGUgcWVtdSgxKSBtYW51YWwgcD0NCmFn
ZSBmb3IgYSBkZXNjcmlwdGlvbiBvZiBjaGFyYWN0ZXIgZGV2aWNlIHByb3BlcnRpZXMuIEEgY29t
bW9uIGNoYXJhY3RlciBkZXZpPQ0KY2UgZGVmaW5pdGlvbiBjb25maWd1cmVzIGEgVU5JWA0KICAg
ICAgICAgICAgICBkb21haW4gc29ja2V0Og0KDQogICAgICAgICAgICAgICAgIC0tY2hhcmRldiBz
b2NrZXQsaWQ9M0RjaGFyMSxwYXRoPTNEL3RtcC9xbXAuc29jayxzZXJ2ZXIsbm93YT0NCml0DQoN
CiAgICAgICAtLW1vbml0b3IgTU9OSVRPUkRFRg0KICAgICAgICAgICAgICBpcyBhIFFNUCBtb25p
dG9yIGRlZmluaXRpb24uIFNlZSB0aGUgcWVtdSgxKSBtYW51YWwgcGFnZSBmb3IgYSA9DQpkZXNj
cmlwdGlvbiBvZiBRTVAgbW9uaXRvciBwcm9wZXJ0aWVzLiBBIGNvbW1vbiBRTVAgbW9uaXRvciBk
ZWZpbml0aW9uIGNvbmZpZz0NCnVyZXMgIGEgIG1vbml0b3IgIG9uICBjaGFyYWN0ZXINCiAgICAg
ICAgICAgICAgZGV2aWNlIGNoYXIxOg0KDQogICAgICAgICAgICAgICAgIC0tbW9uaXRvciBjaGFy
ZGV2PTNEY2hhcjENCg0KICAgICAgIC0tbmJkLXNlcnZlciBhZGRyLnR5cGU9M0RpbmV0LGFkZHIu
aG9zdD0zRDxob3N0PixhZGRyLnBvcnQ9M0Q8cG9ydD5bLHQ9DQpscy1jcmVkcz0zRDxpZD5dWyx0
bHMtYXV0aHo9M0Q8aWQ+XQ0KDQogICAgICAgLS1uYmQtc2VydmVyIGFkZHIudHlwZT0zRHVuaXgs
YWRkci5wYXRoPTNEPHBhdGg+Wyx0bHMtY3JlZHM9M0Q8aWQ+XVssdD0NCmxzLWF1dGh6PTNEPGlk
Pl0NCiAgICAgICAgICAgICAgaXMgYSBOQkQgc2VydmVyIGRlZmluaXRpb24uIEJvdGggVENQIGFu
ZCBVTklYIGRvbWFpbiBzb2NrZXRzIGFyPQ0KZSBzdXBwb3J0ZWQuICBUTFMgZW5jcnlwdGlvbiBj
YW4gYmUgY29uZmlndXJlZCB1c2luZyAtLW9iamVjdCB0bHMtY3JlZHMtKiBhbmQ9DQogYXV0aHot
KiBzZWNyZXRzIChzZWUgYmVsb3cpLg0KDQogICAgICAgICAgICAgIFRvIGNvbmZpZ3VyZSBhbiBO
QkQgc2VydmVyIG9uIFVOSVggZG9tYWluIHNvY2tldCBwYXRoIC90bXAvbmJkLj0NCnNvY2s6DQoN
CiAgICAgICAgICAgICAgICAgLS1uYmQtc2VydmVyIGFkZHIudHlwZT0zRHVuaXgsYWRkci5wYXRo
PTNEL3RtcC9uYmQuc29jaw0KDQogICAgICAgLS1vYmplY3QgaGVscA0KDQogICAgICAgLS1vYmpl
Y3QgPHR5cGU+LGhlbHANCg0KICAgICAgIC0tb2JqZWN0IDx0eXBlPlssPHByb3BlcnR5Pj0zRDx2
YWx1ZT4uLi5dDQogICAgICAgICAgICAgIGlzICBhICBRRU1VICB1c2VyICBjcmVhdGFibGUgb2Jq
ZWN0IGRlZmluaXRpb24uIExpc3Qgb2JqZWN0IHR5cD0NCmVzIHdpdGggaGVscC4gIExpc3Qgb2Jq
ZWN0IHByb3BlcnRpZXMgd2l0aCA8dHlwZT4saGVscC4gU2VlIHRoZSBxZW11KDEpIG1hbnVhPQ0K
bCBwYWdlIGZvciBhIGRlc2NyaXB0aW9uIG9mIHRoZQ0KICAgICAgICAgICAgICBvYmplY3QgcHJv
cGVydGllcy4gVGhlIG1vc3QgY29tbW9uIG9iamVjdCB0eXBlIGlzIGEgc2VjcmV0LCB3aGk9DQpj
aCBpcyB1c2VkIHRvIHN1cHBseSBwYXNzd29yZHMgYW5kL29yIGVuY3J5cHRpb24ga2V5cy4NCg0K
U0VFIEFMU08NCiAgICAgICBxZW11KDEpLCBxZW11LWJsb2NrLWRyaXZlcnMoNyksIHFlbXUtc3Rv
cmFnZS1kYWVtb24tcW1wLXJlZig3KQ0KDQpDT1BZUklHSFQNCiAgICAgICAyMDIwLCBUaGUgUUVN
VSBQcm9qZWN0IERldmVsb3BlcnMNCg0KNS4xLjUwICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFNlcCAwOCwgMjAyMCAgICAgICAgUUVNVS1TVE9SQUdFLURBRU1PTigxKQ0KDQpTdGVmYW4gSGFq
bm9jemkgKDQpOg0KICBkb2NzOiBsaWZ0IGJsb2NrLWNvcmUuanNvbiByU1QgaGVhZGVyIGludG8g
cGFyZW50cw0KICBkb2NzOiBnZW5lcmF0ZSBxZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYoNykg
bWFuIHBhZ2UNCiAgZG9jczogYWRkIHFlbXUtc3RvcmFnZS1kYWVtb24oMSkgbWFuIHBhZ2UNCiAg
TUFJTlRBSU5FUlM6IGFkZCBLZXZpbiBXb2xmIGFzIHN0b3JhZ2UgZGFlbW9uIG1haW50YWluZXIN
Cg0KIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOSAr
Kw0KIGRvY3MvaW50ZXJvcC9maXJtd2FyZS5qc29uICAgICAgICAgICAgICAgICAgICB8ICAgNCAr
DQogcWFwaS9ibG9jay1jb3JlLmpzb24gICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA0IC0N
CiBxYXBpL2Jsb2NrLmpzb24gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0K
IGRvY3MvaW50ZXJvcC9xZW11LXN0b3JhZ2UtZGFlbW9uLXFtcC1yZWYudGV4aSB8ICA4MCArKysr
KysrKysrKysrDQogZG9jcy90b29scy9jb25mLnB5ICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAyICsNCiBkb2NzL3Rvb2xzL2luZGV4LnJzdCAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDEgKw0KIGRvY3MvdG9vbHMvcWVtdS1zdG9yYWdlLWRhZW1vbi5yc3QgICAgICAgICAgICB8
IDEwNSArKysrKysrKysrKysrKysrKysNCiBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDkgKysNCiBzdG9yYWdlLWRhZW1vbi9xYXBpL21lc29uLmJ1aWxk
ICAgICAgICAgICAgICAgfCAgIDIgKw0KIDEwIGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkb2NzL2ludGVyb3AvcWVt
dS1zdG9yYWdlLWRhZW1vbi1xbXAtcmVmLnRleGkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy90
b29scy9xZW11LXN0b3JhZ2UtZGFlbW9uLnJzdA0KDQotLT0yMA0KMi4yNi4yDQoNCg==


