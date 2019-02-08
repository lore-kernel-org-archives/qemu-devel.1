Received: from eggs.gnu.org ([209.51.188.92]:38834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gsDiB-0001Xt-LA
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1gsDi9-0007v2-Nl
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:29:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1gsDi7-0007tH-QF
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 16:29:24 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x18LORpL015463
	for <qemu-devel@nongnu.org>; Fri, 8 Feb 2019 16:29:20 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qhfgmwey5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 16:29:20 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Fri, 8 Feb 2019 21:29:19 -0000
From: Stefan Berger <stefanb@linux.ibm.com>
References: <1548859550-32019-1-git-send-email-liam.merwick@oracle.com>
	<3b98dc38-fe11-87fb-d846-4001f64c0b33@linux.ibm.com>
	<00ba3ef0-896a-81bd-6e89-1761e983881a@oracle.com>
	<cf016219-65e7-a768-91a8-9a674a1ddba4@linux.ibm.com>
Date: Fri, 8 Feb 2019 16:29:16 -0500
MIME-Version: 1.0
In-Reply-To: <cf016219-65e7-a768-91a8-9a674a1ddba4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <00ecb179-65e9-2bb3-5199-b7d26af7069c@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH] tpm_tis: validate locality values don't
 overrun array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, qemu-devel@nongnu.org

T24gMi84LzE5IDM6MzggUE0sIFN0ZWZhbiBCZXJnZXIgd3JvdGU6DQo+IE9uIDIvOC8xOSAz
OjEwIFBNLCBMaWFtIE1lcndpY2sgd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiBGcm9tIHN0YXJp
bmcgYXQgdGhlIGNvZGUsIEkgZG8gaGF2ZSBvbmUgb3RoZXIgcXVlc3Rpb24gLSB3aHkgZG9l
cyB0aGUgDQo+PiBjaGVjayBvZiB0aGUgbG93ZXIgbG9jYWxpdGllcyBiZWxvdyBvbmx5IGNo
ZWNrICdsIDwgbG9jdHkgLSAxJyBiZWZvcmUgDQo+PiBzZXR0aW5nIHMtPmxvY1tsb2N0eV0g
LSBpdCBzZWVtcyBsaWtlIHMtPmxvY1tsb2N0eSAtIDFdIGlzIHNraXBwZWQuDQo+Pg0KPj4N
Cj4+IMKgNjI3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogY2FuY2VsIGFu
eSBzZWl6ZSBieSBhIGxvd2VyIGxvY2FsaXR5ICovDQo+PiDCoDYyOMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGZvciAobCA9IDA7IGwgPCBsb2N0eSAtIDE7IGwrKykgew0K
Pj4gwqA2MjnCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmxv
Y1tsXS5hY2Nlc3MgJj0gflRQTV9USVNfQUNDRVNTX1NFSVpFOw0KPj4gwqA2MzDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+DQo+DQo+IFV1dWguIFRoZSBsb29wIGlz
IGNsZWFyaW5nIHRoZSBTRUlaRSBmbGFnIG9uIGxvY2FsaXRpZXMgbG93ZXIgdGhhbiB0aGUg
DQo+IGN1cnJlbnQgb25lLiBUaGlzIHdvcmtzIGZpbmUgZm9yIGxvY3R5ID49IDEsIGJ1dCBu
b3QgZm9yIGxvY3R5ID0gMC4gSSANCj4gdGhpbmsgdGhlcmUncyBhIGJ1ZyBoZXJlLg0KDQoN
CkFjdHVhbGx5LCB0aGUgY29tcGlsZXIgaXMgc21hcnRlciB0aGFuIHRoYXQuIFdpdGggbG9j
dHkgPSAwLCBhbmQgbCA9IDAswqAgDQpsIDwgbG9jdHkgLSAxIGV2YWx1YXRlcyB0byAnZmFs
c2UnIGFuZCB0aGUgbG9vcCBkb2Vzbid0IGdldCBleGVjdXRlZCEgDQpMdWNreSBtZS4NCg0K
IMKgwqAgU3RlZmFuDQoNCg==
