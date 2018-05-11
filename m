Received: from eggs.gnu.org ([2001:4830:134:3::10]:50279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fH5JR-0005DD-O3
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fH5JQ-00054d-W3
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:30:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38726
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fH5JQ-00053Q-RT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 06:30:08 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4BASkGf002613
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 06:30:05 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hw95arsf0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 06:30:05 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 11 May 2018 11:30:03 +0100
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-5-git-send-email-akrowiak@linux.vnet.ibm.com>
	<c36ec83f-8cba-cf7b-3054-35cf4cd65c14@linux.ibm.com>
	<1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 11 May 2018 12:29:58 +0200
MIME-Version: 1.0
In-Reply-To: <1806faa3-dc46-f638-5c87-8a7415c9025a@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <59037385-06ae-e7e6-97a0-73b8acb4bee1@linux.ibm.com>
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH v5 4/6] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

DQoNCk9uIDA1LzEwLzIwMTggMDM6MTAgUE0sIFRvbnkgS3Jvd2lhayB3cm90ZToNCj4+IElm
wqBJwqBkaWTCoG5vdC7CoEnCoHRoaW5rwqB0aGlzwqBpc8KgYcKgYmlnwqBwcm9ibGVtLsKg
V2XCoG5lZWTCoHRvwqBhdMKgbGVhc3QNCj4+IHplcm9pemXCoHRoZcKgcXVldWVzwqAoZS5n
LsKgb27CoHN5c3RlbcKgcmVzZXQpwqDCoHRvwqBhdm9pZMKgbGVha2luZw0KPj4gc2Vuc2l0
aXZlwqBpbmZvcm1hdGlvbi7CoFdpdGhvdXTCoHRoaXMswqB0aGVyZcKgaXPCoG5vwqBzYW5l
wqB3YXnCoHRvwqB1c2UNCj4+IGFwLXBhc3N0aHJvdWdoLsKgT3LCoGFtwqBJwqB3cm9uZz8N
Cj4gDQo+IEnCoGRvwqBub3TCoGhhdmXCoGHCoGRlZmluaXRpdmXCoGFuc3dlcizCoEnCoHdp
bGzCoGhhdmXCoHRvwqBsb29rwqBpbnRvwqBpdC4NCj4gSSdtwqB0aGlua2luZ8KgdGhhdMKg
c2luY2XCoHdlwqBhcmXCoHVzaW5nwqBhcC1wYXNzdGhyb3VnaCzCoHRoZcKgQVDCoGJ1cw0K
PiBydW5uaW5nwqBvbsKgdGhlwqBndWVzdMKgd291bGTCoGJlwqByZXNwb25zaWJsZcKgZm9y
wqBoYW5kbGluZ8KgcmVzZXTCoHBvc3NpYmx5DQo+IGJ5wqByZXNldHRpbmfCoG9ywqB6ZXJv
aXppbmfCoGl0c8KgcXVldWVzLsKgSSdsbMKgZ2V0wqBiYWNrwqB0b8KgeW91wqBvbsKgdGhp
cy4NCg0KWW91IGFyZSBvbiB0aGUgd3JvbmcgdHJhY2suIFdoYXQgSSdtIHRhbGtpbmcgYWJv
dXQgaXMgdGhlIHJlc3BvbnNpYmlsaXR5DQpvZiB0aGUgaHlwZXJ2aXNvciBhbmQgbm90IHRo
ZSByZXNwb25zaWJpbGl0eSBvZiB0aGUgZ3Vlc3QuDQoNClJlZ2FyZHMsDQpIYWxpbA0KDQoN
Cg==
