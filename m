Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0710C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:44:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A5727CEA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A5727CEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59158 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXhdn-00014S-KG
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:44:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXhcx-0000d9-8m
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hXhcv-0007oG-F4
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:43:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:51529)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hXhcv-0007cK-4D
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 03:43:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	03 Jun 2019 00:43:21 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
	by fmsmga005.fm.intel.com with ESMTP; 03 Jun 2019 00:43:20 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
	FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 3 Jun 2019 00:43:20 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
	FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Mon, 3 Jun 2019 00:43:19 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.134]) by
	SHSMSX154.ccr.corp.intel.com ([169.254.7.247]) with mapi id
	14.03.0415.000; Mon, 3 Jun 2019 15:43:18 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: 'Li Zhijian' <lizhijian@cn.fujitsu.com>, "Dr. David Alan Gilbert"
	<dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang
	<zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>,
	qemu-dev <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 4/6] COLO-compare: Add colo-compare remote notify support
Thread-Index: AQHVGPXgIWl7ue6FxUie+pkm5PRVBqaIsVEAgACJSSA=
Date: Mon, 3 Jun 2019 07:43:17 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D780614C527@shsmsx102.ccr.corp.intel.com>
References: <20190602034239.23225-1-chen.zhang@intel.com>
	<20190602034239.23225-5-chen.zhang@intel.com>
	<23a2b7f5-a3b9-aee0-38c3-abe0fc00eca2@cn.fujitsu.com>
In-Reply-To: <23a2b7f5-a3b9-aee0-38c3-abe0fc00eca2@cn.fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZThlYTNjNTEtNmRkNy00ZDhiLTk4MjItOWQ0ZjNiMDBjZDY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieE15NU40S3B6UktGQ1wvK09uWEdIb2d0aHo1OVwva0lkd3dJRFRKXC9rRFBUSUhhTnBodUxVVDRQXC9OMzBQekhuMGIifQ==
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.65
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 4/6] COLO-compare: Add colo-compare remote
 notify support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpGcm9tOiBMaSBaaGlqaWFuIFttYWlsdG86bGl6aGlqaWFuQGNuLmZ1aml0c3UuY29tXQ0KU2Vu
dDogTW9uZGF5LCBKdW5lIDMsIDIwMTkgMTA6MzMgQU0NClRvOiBaaGFuZywgQ2hlbiA8Y2hlbi56
aGFuZ0BpbnRlbC5jb20+OyBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IDxkZ2lsYmVydEByZWRoYXQu
Y29tPjsgSnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT47IHpoYW5naGFpbGlhbmcg
PHpoYW5nLnpoYW5naGFpbGlhbmdAaHVhd2VpLmNvbT47IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+OyBxZW11LWRldiA8cWVtdS1kZXZlbEBub25nbnUub3JnPg0KQ2M6IFpoYW5nIENo
ZW4gPHpoYW5nY2tpZEBnbWFpbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIDQvNl0gQ09MTy1j
b21wYXJlOiBBZGQgY29sby1jb21wYXJlIHJlbW90ZSBub3RpZnkgc3VwcG9ydA0KDQoNCmhvdyBh
Ym91dCBkbyBzd2l0Y2ggaW5zaWRlIGNvbG9fY29tcGFyZV9pbmNvbnNpc3RlbmN5X25vdGlmeSgp
LCBsaWtlOg0KDQoNCg0KY29sb19jb21wYXJlX2luY29uc2lzdGVuY3lfbm90aWZ5KENvbXBhcmVT
dGF0ZSAqcykNCg0Kew0KDQogICAgICAgaWYgKHMtPnJlbW90ZV9ub3RpZnkpDQoNCiAgICAgICAg
ICAgICAgcmVtb3RlX25vdGlmeQ0KDQogICAgICAgZWxzZQ0KDQogICAgICAgICAgICAgIGxvY2Fs
X25vdGl0eQ0KDQp9DQoNCg0KDQoNCg0KTWFrZSBzZW5zZS4gSSB3aWxsIHVwZGF0ZSBpdCBpbiBu
ZXh0IHZlcnNpb24uDQoNClRoYW5rIHlvdSBaaGlqaWFufn4NCg0KDQpUaGFua3MNClpoYW5nIENo
ZW4NCg0KDQoNClRoYW5rcw0KDQpaaGlqaWFuDQoNCg0KT24gNi8yLzE5IDExOjQyIEFNLCBaaGFu
ZyBDaGVuIHdyb3RlOg0KDQpGcm9tOiBaaGFuZyBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT48
bWFpbHRvOmNoZW4uemhhbmdAaW50ZWwuY29tPg0KDQoNCg0KVGhpcyBwYXRjaCBtYWtlIGNvbG8t
Y29tcGFyZSBjYW4gc2VuZCBtZXNzYWdlIHRvIHJlbW90ZSBDT0xPIGZyYW1lKFhlbikgd2hlbiBv
Y2N1ciBjaGVja3BvaW50Lg0KDQoNCg0KU2lnbmVkLW9mZi1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56
aGFuZ0BpbnRlbC5jb20+PG1haWx0bzpjaGVuLnpoYW5nQGludGVsLmNvbT4NCg0KLS0tDQoNCiBu
ZXQvY29sby1jb21wYXJlLmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tDQoNCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCg0KDQoNCmRpZmYgLS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMgYi9uZXQvY29s
by1jb21wYXJlLmMNCg0KaW5kZXggMTYyODVmNGE5Ni4uMTkwNzVjN2E2NiAxMDA2NDQNCg0KLS0t
IGEvbmV0L2NvbG8tY29tcGFyZS5jDQoNCisrKyBiL25ldC9jb2xvLWNvbXBhcmUuYw0KDQpAQCAt
MjUxLDYgKzI1MSwxNyBAQCBzdGF0aWMgdm9pZCBjb2xvX3JlbGVhc2VfcHJpbWFyeV9wa3QoQ29t
cGFyZVN0YXRlICpzLCBQYWNrZXQgKnBrdCkNCg0KICAgICBwYWNrZXRfZGVzdHJveShwa3QsIE5V
TEwpOw0KDQogfQ0KDQoNCg0KK3N0YXRpYyB2b2lkIG5vdGlmeV9yZW1vdGVfZnJhbWUoQ29tcGFy
ZVN0YXRlICpzKQ0KDQorew0KDQorICAgIGNoYXIgbXNnW10gPSAiRE9fQ0hFQ0tQT0lOVCI7DQoN
CisgICAgaW50IHJldCA9IDA7DQoNCisNCg0KKyAgICByZXQgPSBjb21wYXJlX2Nocl9zZW5kKHMs
ICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNnKSwgMCwgdHJ1ZSk7DQoNCisgICAgaWYgKHJldCA8
IDApIHsNCg0KKyAgICAgICAgZXJyb3JfcmVwb3J0KCJOb3RpZnkgWGVuIENPTE8tZnJhbWUgZmFp
bGVkIik7DQoNCisgICAgfQ0KDQorfQ0KDQorDQoNCiAvKg0KDQogICogVGhlIElQIHBhY2tldHMg
c2VudCBieSBwcmltYXJ5IGFuZCBzZWNvbmRhcnkNCg0KICAqIHdpbGwgYmUgY29tcGFyZWQgaW4g
aGVyZQ0KDQpAQCAtNDM1LDcgKzQ0NiwxMSBAQCBzZWM6DQoNCiAgICAgICAgIHFlbXVfaGV4ZHVt
cCgoY2hhciAqKXNwa3QtPmRhdGEsIHN0ZGVyciwNCg0KICAgICAgICAgICAgICAgICAgICAgICJj
b2xvLWNvbXBhcmUgc3BrdCIsIHNwa3QtPnNpemUpOw0KDQoNCg0KLSAgICAgICAgY29sb19jb21w
YXJlX2luY29uc2lzdGVuY3lfbm90aWZ5KCk7DQoNCisgICAgICAgIGlmIChzLT5ub3RpZnlfZGV2
KSB7DQoNCisgICAgICAgICAgICBub3RpZnlfcmVtb3RlX2ZyYW1lKHMpOw0KDQorICAgICAgICB9
IGVsc2Ugew0KDQorICAgICAgICAgICAgY29sb19jb21wYXJlX2luY29uc2lzdGVuY3lfbm90aWZ5
KCk7DQoNCisgICAgICAgIH0NCg0KICAgICB9DQoNCiB9DQoNCg0KDQpAQCAtNTc3LDcgKzU5Miw3
IEBAIHZvaWQgY29sb19jb21wYXJlX3VucmVnaXN0ZXJfbm90aWZpZXIoTm90aWZpZXIgKm5vdGlm
eSkNCg0KIH0NCg0KDQoNCiBzdGF0aWMgaW50IGNvbG9fb2xkX3BhY2tldF9jaGVja19vbmVfY29u
bihDb25uZWN0aW9uICpjb25uLA0KDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKnVzZXJfZGF0YSkNCg0KKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIENvbXBhcmVTdGF0ZSAqcykNCg0KIHsNCg0KICAgICBHTGlzdCAqcmVz
dWx0ID0gTlVMTDsNCg0KICAgICBpbnQ2NF90IGNoZWNrX3RpbWUgPSBSRUdVTEFSX1BBQ0tFVF9D
SEVDS19NUzsNCg0KQEAgLTU4OCw3ICs2MDMsMTEgQEAgc3RhdGljIGludCBjb2xvX29sZF9wYWNr
ZXRfY2hlY2tfb25lX2Nvbm4oQ29ubmVjdGlvbiAqY29ubiwNCg0KDQoNCiAgICAgaWYgKHJlc3Vs
dCkgew0KDQogICAgICAgICAvKiBEbyBjaGVja3BvaW50IHdpbGwgZmx1c2ggb2xkIHBhY2tldCAq
Lw0KDQotICAgICAgICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoKTsNCg0KKyAg
ICAgICAgaWYgKHMtPm5vdGlmeV9kZXYpIHsNCg0KKyAgICAgICAgICAgIG5vdGlmeV9yZW1vdGVf
ZnJhbWUocyk7DQoNCisgICAgICAgIH0gZWxzZSB7DQoNCisgICAgICAgICAgICBjb2xvX2NvbXBh
cmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoKTsNCg0KKyAgICAgICAgfQ0KDQogICAgICAgICByZXR1
cm4gMDsNCg0KICAgICB9DQoNCg0KDQpAQCAtNjA4LDcgKzYyNyw3IEBAIHN0YXRpYyB2b2lkIGNv
bG9fb2xkX3BhY2tldF9jaGVjayh2b2lkICpvcGFxdWUpDQoNCiAgICAgICogSWYgd2UgZmluZCBv
bmUgb2xkIHBhY2tldCwgc3RvcCBmaW5kaW5nIGpvYiBhbmQgbm90aWZ5DQoNCiAgICAgICogQ09M
TyBmcmFtZSBkbyBjaGVja3BvaW50Lg0KDQogICAgICAqLw0KDQotICAgIGdfcXVldWVfZmluZF9j
dXN0b20oJnMtPmNvbm5fbGlzdCwgTlVMTCwNCg0KKyAgICBnX3F1ZXVlX2ZpbmRfY3VzdG9tKCZz
LT5jb25uX2xpc3QsIHMsDQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAoR0NvbXBhcmVGdW5j
KWNvbG9fb2xkX3BhY2tldF9jaGVja19vbmVfY29ubik7DQoNCiB9DQoNCg0KDQpAQCAtNjM3LDcg
KzY1NiwxMiBAQCBzdGF0aWMgdm9pZCBjb2xvX2NvbXBhcmVfcGFja2V0KENvbXBhcmVTdGF0ZSAq
cywgQ29ubmVjdGlvbiAqY29ubiwNCg0KICAgICAgICAgICAgICAqLw0KDQogICAgICAgICAgICAg
dHJhY2VfY29sb19jb21wYXJlX21haW4oInBhY2tldCBkaWZmZXJlbnQiKTsNCg0KICAgICAgICAg
ICAgIGdfcXVldWVfcHVzaF9oZWFkKCZjb25uLT5wcmltYXJ5X2xpc3QsIHBrdCk7DQoNCi0gICAg
ICAgICAgICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoKTsNCg0KKw0KDQorICAg
ICAgICAgICAgaWYgKHMtPm5vdGlmeV9kZXYpIHsNCg0KKyAgICAgICAgICAgICAgICBub3RpZnlf
cmVtb3RlX2ZyYW1lKHMpOw0KDQorICAgICAgICAgICAgfSBlbHNlIHsNCg0KKyAgICAgICAgICAg
ICAgICBjb2xvX2NvbXBhcmVfaW5jb25zaXN0ZW5jeV9ub3RpZnkoKTsNCg0KKyAgICAgICAgICAg
IH0NCg0KICAgICAgICAgICAgIGJyZWFrOw0KDQogICAgICAgICB9DQoNCiAgICAgfQ0KDQpAQCAt
OTg5LDcgKzEwMTMsMjQgQEAgc3RhdGljIHZvaWQgY29tcGFyZV9zZWNfcnNfZmluYWxpemUoU29j
a2V0UmVhZFN0YXRlICpzZWNfcnMpDQoNCg0KDQogc3RhdGljIHZvaWQgY29tcGFyZV9ub3RpZnlf
cnNfZmluYWxpemUoU29ja2V0UmVhZFN0YXRlICpub3RpZnlfcnMpDQoNCiB7DQoNCisgICAgQ29t
cGFyZVN0YXRlICpzID0gY29udGFpbmVyX29mKG5vdGlmeV9ycywgQ29tcGFyZVN0YXRlLCBub3Rp
ZnlfcnMpOw0KDQorDQoNCiAgICAgLyogR2V0IFhlbiBjb2xvLWZyYW1lJ3Mgbm90aWZ5IGFuZCBo
YW5kbGUgdGhlIG1lc3NhZ2UgKi8NCg0KKyAgICBjaGFyICpkYXRhID0gZ19tZW1kdXAobm90aWZ5
X3JzLT5idWYsIG5vdGlmeV9ycy0+cGFja2V0X2xlbik7DQoNCisgICAgY2hhciBtc2dbXSA9ICJD
T0xPX0NPTVBBUkVfR0VUX1hFTl9JTklUIjsNCg0KKyAgICBpbnQgcmV0Ow0KDQorDQoNCisgICAg
aWYgKCFzdHJjbXAoZGF0YSwgIkNPTE9fVVNFUlNQQUNFX1BST1hZX0lOSVQiKSkgew0KDQorICAg
ICAgICByZXQgPSBjb21wYXJlX2Nocl9zZW5kKHMsICh1aW50OF90ICopbXNnLCBzdHJsZW4obXNn
KSwgMCwgdHJ1ZSk7DQoNCisgICAgICAgIGlmIChyZXQgPCAwKSB7DQoNCisgICAgICAgICAgICBl
cnJvcl9yZXBvcnQoIk5vdGlmeSBYZW4gQ09MTy1mcmFtZSBJTklUIGZhaWxlZCIpOw0KDQorICAg
ICAgICB9DQoNCisgICAgfQ0KDQorDQoNCisgICAgaWYgKCFzdHJjbXAoZGF0YSwgIkNPTE9fQ0hF
Q0tQT0lOVCIpKSB7DQoNCisgICAgICAgIC8qIGNvbG8tY29tcGFyZSBkbyBjaGVja3BvaW50LCBm
bHVzaCBwcmkgcGFja2V0IGFuZCByZW1vdmUgc2VjIHBhY2tldCAqLw0KDQorICAgICAgICBnX3F1
ZXVlX2ZvcmVhY2goJnMtPmNvbm5fbGlzdCwgY29sb19mbHVzaF9wYWNrZXRzLCBzKTsNCg0KKyAg
ICB9DQoNCiB9DQoNCg0KDQogLyoNCg==
