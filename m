Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75D9C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E62B21E70
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E62B21E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMvJ-0006GI-UL
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40007)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvMui-0004dt-Vv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sebastien.boeuf@intel.com>) id 1hvMuh-0002To-VM
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:40 -0400
Received: from mga04.intel.com ([192.55.52.120]:55153)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sebastien.boeuf@intel.com>)
 id 1hvMuh-0002Ns-ME
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:27:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Aug 2019 07:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
 d="scan'208,223";a="198683676"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
 by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2019 07:27:31 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 7 Aug 2019 07:27:30 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.6]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.86]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 07:27:30 -0700
From: "Boeuf, Sebastien" <sebastien.boeuf@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: libvhost-user: Fix the VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
Thread-Index: AQHVTSw+I7kmgADAmUOtvYF7P6PObQ==
Date: Wed, 7 Aug 2019 14:27:30 +0000
Message-ID: <8df105774471bc72bca1397b4058ecc66d963848.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.199.52]
Content-Type: text/plain; charset="utf-8"
Content-ID: <003861F2EF38D24C942BA3DEB02163C0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: [Qemu-devel] libvhost-user: Fix the
 VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD check
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbSAwYTUzYTgxZGI2ZGQwNjlmOWI3YmNkY2QzODY4NDViY2ViM2EyYWM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogU2ViYXN0aWVuIEJvZXVmIDxzZWJhc3RpZW4uYm9ldWZAaW50
ZWwuY29tPg0KRGF0ZTogV2VkLCA3IEF1ZyAyMDE5IDA3OjE1OjMyIC0wNzAwDQpTdWJqZWN0OiBb
UEFUQ0hdIGxpYnZob3N0LXVzZXI6IEZpeCB0aGUNClZIT1NUX1VTRVJfUFJPVE9DT0xfRl9TTEFW
RV9TRU5EX0ZEDQogY2hlY2sNCg0KVmhvc3QgdXNlciBwcm90b2NvbCBmZWF0dXJlcyBhcmUgc2V0
IGFzIGEgYml0bWFzay4gQW5kIHRoZSBmb2xsb3dpbmcNCmNvbnN0YW50IFZIT1NUX1VTRVJfUFJP
VE9DT0xfRl9TTEFWRV9TRU5EX0ZEIHZhbHVlIGlzIDEwIGJlY2F1c2UgdGhlDQpiaXQNCjEwIGlu
ZGljYXRlcyBpZiB0aGUgZmVhdHVyZXMgaXMgc2V0IG9yIG5vdC4NCg0KVGhlIHByb3BlciB3YXkg
dG8gY2hlY2sgZm9yIHRoZSBwcmVzZW5jZSBvciBhYnNlbmNlIG9mIHRoaXMgZmVhdHVyZSBpcw0K
dG8gc2hpZnQgMSBieSB0aGUgdmFsdWUgb2YgdGhpcyBjb25zdGFudCBhbmQgdGhlbiBtYXNrIGl0
IHdpdGggdGhlDQphY3R1YWwgYml0bWFzayByZXByZXNlbnRpbmcgdGhlIHN1cHBvcnRlZCBwcm90
b2NvbCBmZWF0dXJlcy4NCg0KVGhpcyBwYXRjaCBhaW1zIHRvIGZpeCB0aGUgY3VycmVudCBjb2Rl
IGFzIGl0IHdhcyBub3QgZG9pbmcgdGhlDQpzaGlmdGluZywgYnV0IGluc3RlYWQgaXQgd2FzIG1h
c2tpbmcgZGlyZWN0bHkgd2l0aCB0aGUgdmFsdWUgb2YgdGhlDQpjb25zdGFudCBpdHNlbGYuDQoN
ClNpZ25lZC1vZmYtYnk6IFNlYmFzdGllbiBCb2V1ZiA8c2ViYXN0aWVuLmJvZXVmQGludGVsLmNv
bT4NCi0tLQ0KIGNvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMgfCA0ICsrLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuYyBiL2NvbnRyaWIv
bGlidmhvc3QtDQp1c2VyL2xpYnZob3N0LXVzZXIuYw0KaW5kZXggZmI2MTE0MmJjYy4uMTE5MDlm
YjdjMSAxMDA2NDQNCi0tLSBhL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMN
CisrKyBiL2NvbnRyaWIvbGlidmhvc3QtdXNlci9saWJ2aG9zdC11c2VyLmMNCkBAIC0xMTEyLDcg
KzExMTIsNyBAQCBib29sIHZ1X3NldF9xdWV1ZV9ob3N0X25vdGlmaWVyKFZ1RGV2ICpkZXYsDQpW
dVZpcnRxICp2cSwgaW50IGZkLA0KIA0KICAgICB2bXNnLmZkX251bSA9IGZkX251bTsNCiANCi0g
ICAgaWYgKChkZXYtPnByb3RvY29sX2ZlYXR1cmVzICYgVkhPU1RfVVNFUl9QUk9UT0NPTF9GX1NM
QVZFX1NFTkRfRkQpDQo9PSAwKSB7DQorICAgIGlmICgoZGV2LT5wcm90b2NvbF9mZWF0dXJlcyAm
ICgxVUxMIDw8DQpWSE9TVF9VU0VSX1BST1RPQ09MX0ZfU0xBVkVfU0VORF9GRCkpID09IDApIHsN
CiAgICAgICAgIHJldHVybiBmYWxzZTsNCiAgICAgfQ0KIA0KQEAgLTI1MzcsNyArMjUzNyw3IEBA
IGludDY0X3QgdnVfZnNfY2FjaGVfcmVxdWVzdChWdURldiAqZGV2LA0KVmhvc3RVc2VyU2xhdmVS
ZXF1ZXN0IHJlcSwgaW50IGZkLA0KIA0KICAgICB2bXNnLmZkX251bSA9IGZkX251bTsNCiANCi0g
ICAgaWYgKChkZXYtPnByb3RvY29sX2ZlYXR1cmVzICYgVkhPU1RfVVNFUl9QUk9UT0NPTF9GX1NM
QVZFX1NFTkRfRkQpDQo9PSAwKSB7DQorICAgIGlmICgoZGV2LT5wcm90b2NvbF9mZWF0dXJlcyAm
ICgxVUxMIDw8DQpWSE9TVF9VU0VSX1BST1RPQ09MX0ZfU0xBVkVfU0VORF9GRCkpID09IDApIHsN
CiAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KICAgICB9DQogDQotLSANCjIuMTcuMQ0K

