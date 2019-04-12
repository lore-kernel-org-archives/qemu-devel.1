Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0384FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C643B2082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 11:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C643B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ewerk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEuod-00058b-0f
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 07:57:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <s.vogel@ewerk.com>) id 1hEunM-0004Gu-8l
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <s.vogel@ewerk.com>) id 1hEunI-0001D0-TL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:56:36 -0400
Received: from gate5.ewerk.com ([212.122.40.189]:50841 helo=mail.ewerk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <s.vogel@ewerk.com>) id 1hEunI-0001Bm-D2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:56:32 -0400
Received: from [192.168.64.251] (port=11461 helo=MSX01.intranet.ewerk.com)
	by mail.ewerk.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <S.Vogel@ewerk.com>)
	id 1hEun7-0006gU-2z; Fri, 12 Apr 2019 13:56:21 +0200
Received: from MSX01.intranet.ewerk.com ([fe80::11e8:751f:2e95:45a7]) by
	MSX01.intranet.ewerk.com ([fe80::11e8:751f:2e95:45a7%11]) with mapi id
	14.03.0439.000; Fri, 12 Apr 2019 13:56:21 +0200
From: Sven Vogel <S.Vogel@ewerk.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: CentOS | OpenvSwitch problem with local bridge 
Thread-Index: AQHU8Sa+zIp/N0WH6UKHy03NMYPRWQ==
Date: Fri, 12 Apr 2019 11:56:20 +0000
Message-ID: <B08130C1-0F79-48FD-B5A7-E3824D20C9FC@ewerk.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.112.37]
x-c2processedorg: 985c5e6e-844c-4233-8704-32735636d600
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 212.122.40.189
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] CentOS | OpenvSwitch problem with local bridge
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
Cc: "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412115620.GmfAJ18fFU-9zgfUljawMZRuRvvY6z8feRY7OFWtsxU@z>

SGkgRGV2cywNCg0KV2UgdXNlIFJIRUwvQ2VudE9TIGFuZCBzaW5jZSBRRU1VIFZlcnNpb24gMi4x
Mi4wIHdlIGhhdmUgcHJvYmxlbXMgd2l0aCBPcGVudlN3aXRjaCBhbmQgYSBsb2NhbCBicmlkZ2Uu
DQoNCk5ldyBWZXJzaW9uOg0KLS0tLS0tLS0tLS0tLS0tLS0NCk9TIHZlcnNpb246ICAgICAgICAg
ICAgIDcuNi4xODEwDQprZXJuZWwgdmVyc2lvbjogICAgICAgICAzLjEwLjAtOTU3LjUuMS5lbDcu
eDg2XzY0DQpxZW11IHZlcnNpb246ICAgICAgICAgICAyLjEyLjANCmxpYnZpcnRkIHZlcnNpb246
ICAgICAgIDUuMC4wDQpvcGVudnN3aXRjaCB2ZXJzaW9uOiAgICAyLjEwLjENCm9wZW52c3dpdGNo
IGRiIHZlcnNpb246IDcuMTYuMQ0KDQpPbGQgVmVyc2lvbjoNCi0tLS0tLS0tLS0tLS0tLS0NCk9T
IHZlcnNpb246IDcuNi4xODEwDQprZXJuZWwgdmVyc2lvbjogMy4xMC4wLTk1Ny41LjEuZWw3Lng4
Nl82NA0KcWVtdSB2ZXJzaW9uOiAyLjEwLjAtMjEuZWw3XzUuNy4xDQpsaWJ2aXJ0ZCB2ZXJzaW9u
OiA1LjAuMA0Kb3BlbnZzd2l0Y2ggdmVyc2lvbjogMi4xMC4xDQpvcGVudnN3aXRjaCBkYiB2ZXJz
aW9uOiA3LjE2LjENCg0KV2UgdXNlIENsb3Vkc3RhY2sgYW5kIHRoZSB2aXJ0dWFsIHJvdXRlciB3
aWxsIGNyZWF0ZSBhIHZuZXQgZm9yIGludGVybmFsIGNvbW11bmljYXRpb24gb24gYSBsb2NhbCBi
cmlkZ2UgbmFtZWQgY2xvdWQwLiBUaGV5IHVzZSBhcGlwYSBhZGRyZXNzZXMuDQoNCkUuZy4gaG9z
dCBhZGRyZXNzIG9uIHRoZSBsb2NhbCBjbG91ZDAgYnJpZGdlIGFyZSAxNjkuMjU0LjAuMSBhbmQg
dGhlIHZpcnR1YWwgcm91dGVyIHRyeSB0byBjcmVhdGUgYSB2bmV0IDE2OS4yNTQuMC4yNTEgZm9y
IGNvbW11bmljYXRpb24uDQoNCjIwMTktMDQtMDkgMTQ6Mjg6MjksOTc5IERFQlVHIFtrdm0ucmVz
b3VyY2UuTGlidmlydENvbXB1dGluZ1Jlc291cmNlXSAoYWdlbnRSZXF1ZXN0LUhhbmRsZXItMTpu
dWxsKSAobG9naWQ6ZWQ3YzVkMmEpIEV4ZWN1dGluZyB3aGlsZSB3aXRoIHRpbWVvdXQgOiA1MDAw
DQoyMDE5LTA0LTA5IDE0OjI4OjMwLDAwNyBERUJVRyBba3ZtLnJlc291cmNlLkxpYnZpcnRDb21w
dXRpbmdSZXNvdXJjZV0gKGFnZW50UmVxdWVzdC1IYW5kbGVyLTE6bnVsbCkgKGxvZ2lkOmVkN2M1
ZDJhKSBFeGVjdXRpb24gaXMgc3VjY2Vzc2Z1bC4NCjIwMTktMDQtMDkgMTQ6Mjg6MzAsMDA3IERF
QlVHIFtyZXNvdXJjZS52aXJ0dWFsbmV0d29yay5WaXJ0dWFsUm91dGluZ1Jlc291cmNlXSAoYWdl
bnRSZXF1ZXN0LUhhbmRsZXItMTpudWxsKSAobG9naWQ6ZWQ3YzVkMmEpIFRyeWluZyB0byBjb25u
ZWN0IHRvIDE2OS4yNTQuMC4yNTENCjIwMTktMDQtMDkgMTQ6Mjg6MzMsMDEzIERFQlVHIFtyZXNv
dXJjZS52aXJ0dWFsbmV0d29yay5WaXJ0dWFsUm91dGluZ1Jlc291cmNlXSAoYWdlbnRSZXF1ZXN0
LUhhbmRsZXItMTpudWxsKSAobG9naWQ6ZWQ3YzVkMmEpIENvdWxkIG5vdCBjb25uZWN0IHRvIDE2
OS4yNTQuMC4yNTENCjIwMTktMDQtMDkgMTQ6Mjg6MzgsMDEzIERFQlVHIFtyZXNvdXJjZS52aXJ0
dWFsbmV0d29yay5WaXJ0dWFsUm91dGluZ1Jlc291cmNlXSAoYWdlbnRSZXF1ZXN0LUhhbmRsZXIt
MTpudWxsKSAobG9naWQ6ZWQ3YzVkMmEpIFRyeWluZyB0byBjb25uZWN0IHRvIDE2OS4yNTQuMC4y
NTENCjIwMTktMDQtMDkgMTQ6Mjg6NDEsMDIwIERFQlVHIFtyZXNvdXJjZS52aXJ0dWFsbmV0d29y
ay5WaXJ0dWFsUm91dGluZ1Jlc291cmNlXSAoYWdlbnRSZXF1ZXN0LUhhbmRsZXItMTpudWxsKSAo
bG9naWQ6ZWQ3YzVkMmEpIENvdWxkIG5vdCBjb25uZWN0IHRvIDE2OS4yNTQuMC4yNTENCg0KSXQg
c2VlbXMgdGhlIGludGVyZmFjZSB3aWxsIG5vdCBjb21lIHVwIGlmIHdlIHVzZSBlbXUgMi4xMi4w
LiBpZiB3ZSB1c2UgdGhlIG9sZGVyIHZlcnNpb24gMi4xMC4wIHdlIGRvbuKAmXQgaGF2ZSB0aGUg
cHJvYmxlbS4NCg0KSXMgdGhlcmUgYW55IGNoYW5nZSBpbiB0aGUgbmV3IHZlcnNpb24/IEkgaG9w
ZSB0aGVyZSBpcyBzb21lb25lIHdobyBjYW4gc2F5IHRoZXJlIGlzIGEgd29ya2Fyb3VuZOKApg0K
DQp0aGFua3MNCg0KU3Zlbg0KDQpfXw0KDQpTdmVuIFZvZ2VsDQpUZWFtbGVhZCBQbGF0Zm9ybQ0K
DQpFV0VSSyBSWiBHbWJIDQpCcsO8aGwgMjQsIEQtMDQxMDkgTGVpcHppZw0KUCArNDkgMzQxIDQy
NjQ5IC0gMTENCkYgKzQ5IDM0MSA0MjY0OSAtIDE4DQpTLlZvZ2VsQGV3ZXJrLmNvbQ0Kd3d3LmV3
ZXJrLmNvbQ0KDQpHZXNjaMOkZnRzZsO8aHJlcjoNCkRyLiBFcmlrIFdlbmRlLCBIZW5kcmlrIFNj
aHViZXJ0LCBGcmFuayBSaWNodGVyLCBHZXJoYXJkIEhveWVyDQpSZWdpc3RlcmdlcmljaHQ6IExl
aXB6aWcgSFJCIDE3MDIzDQoNClplcnRpZml6aWVydCBuYWNoOg0KSVNPL0lFQyAyNzAwMToyMDEz
DQpESU4gRU4gSVNPIDkwMDE6MjAxNQ0KRElOIElTTy9JRUMgMjAwMDAtMToyMDExDQoNCkVXRVJL
LUJsb2c8aHR0cHM6Ly9ibG9nLmV3ZXJrLmNvbS8+IHwgTGlua2VkSW48aHR0cHM6Ly93d3cubGlu
a2VkaW4uY29tL2NvbXBhbnkvZXdlcmstZ3JvdXA+IHwgWGluZzxodHRwczovL3d3dy54aW5nLmNv
bS9jb21wYW55L2V3ZXJrPiB8IFR3aXR0ZXI8aHR0cHM6Ly90d2l0dGVyLmNvbS9FV0VSS19Hcm91
cD4gfCBGYWNlYm9vazxodHRwczovL2RlLWRlLmZhY2Vib29rLmNvbS9FV0VSSy5JVC8+DQoNCkF1
c2vDvG5mdGUgdW5kIEFuZ2Vib3RlIHBlciBNYWlsIHNpbmQgZnJlaWJsZWliZW5kIHVuZCB1bnZl
cmJpbmRsaWNoLg0KDQpEaXNjbGFpbWVyIFByaXZhY3k6DQpEZXIgSW5oYWx0IGRpZXNlciBFLU1h
aWwgKGVpbnNjaGxpZcOfbGljaCBldHdhaWdlciBiZWlnZWbDvGd0ZXIgRGF0ZWllbikgaXN0IHZl
cnRyYXVsaWNoIHVuZCBudXIgZsO8ciBkZW4gRW1wZsOkbmdlciBiZXN0aW1tdC4gU29sbHRlbiBT
aWUgbmljaHQgZGVyIGJlc3RpbW11bmdzZ2Vtw6TDn2UgRW1wZsOkbmdlciBzZWluLCBpc3QgSWhu
ZW4gamVnbGljaGUgT2ZmZW5sZWd1bmcsIFZlcnZpZWxmw6RsdGlndW5nLCBXZWl0ZXJnYWJlIG9k
ZXIgTnV0enVuZyBkZXMgSW5oYWx0cyB1bnRlcnNhZ3QuIEJpdHRlIGluZm9ybWllcmVuIFNpZSBp
biBkaWVzZW0gRmFsbCB1bnZlcnrDvGdsaWNoIGRlbiBBYnNlbmRlciB1bmQgbMO2c2NoZW4gU2ll
IGRpZSBFLU1haWwgKGVpbnNjaGxpZcOfbGljaCBldHdhaWdlciBiZWlnZWbDvGd0ZXIgRGF0ZWll
bikgdm9uIElocmVtIFN5c3RlbS4gVmllbGVuIERhbmsuDQoNClRoZSBjb250ZW50cyBvZiB0aGlz
IGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgYXJlIGNvbmZpZGVudGlhbCBhbmQg
bWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJl
Y2lwaWVudCBvZiB0aGlzIGUtbWFpbCwgYW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcsIGRpc3RyaWJ1
dGlvbiBvciB1c2Ugb2YgaXRzIGNvbnRlbnRzIGlzIHN0cmljdGx5IHByb2hpYml0ZWQsIGFuZCB5
b3Ugc2hvdWxkIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgdGhlbiBk
ZWxldGUgaXQgKGluY2x1ZGluZyBhbnkgYXR0YWNobWVudHMpIGZyb20geW91ciBzeXN0ZW0uIFRo
YW5rIHlvdS4NCg==
