Received: from eggs.gnu.org ([2001:4830:134:3::10]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFE9Q-0000AZ-1A
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1cFE9K-0000Ew-Ud
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1cFE9K-0000Ep-Nv
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 00:55:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB95sWr5038464
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 00:55:14 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0b-001b2d01.pphosted.com with ESMTP id 277gu7dwsb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 00:55:13 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Fri, 9 Dec 2016 15:55:11 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
In-Reply-To: <20161208222618.GD13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161208222618.GD13139@umbus.fritz.box>
Date: Fri, 09 Dec 2016 11:24:52 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Message-Id: <87zik51wb7.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v1 3/9] target-ppc: implement stxvl
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

RGF2aWQgR2lic29uIDxkYXZpZEBnaWJzb24uZHJvcGJlYXIuaWQuYXU+IHdyaXRlczoNCg0KPiBb
IFVua25vd24gc2lnbmF0dXJlIHN0YXR1cyBdDQo+IE9uIFdlZCwgRGVjIDA3LCAyMDE2IGF0IDEx
OjU0OjU2UE0gKzA1MzAsIE5pa3VuaiBBIERhZGhhbmlhIHdyb3RlOg0KPj4gc3R4dmw6IFN0b3Jl
IFZTWCBWZWN0b3Igd2l0aCBMZW5ndGgNCj4+IA0KPj4gVmVjdG9yICg4LWJpdCBlbGVtZW50cykg
aW4gQkU6DQo+PiArLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSst
LS0rLS0tKy0tLSstLSstLSsNCj4+IHzigJxU4oCdfOKAnGjigJ184oCcaeKAnXzigJxz4oCdfOKA
nCDigJ184oCcaeKAnXzigJxz4oCdfOKAnCDigJ184oCcYeKAnXzigJwg4oCdfOKAnFTigJ184oCc
ReKAnXzigJxT4oCdfOKAnFTigJ18MDB8MDB8DQo+PiArLS0tKy0tLSstLS0rLS0tKy0tLSstLS0r
LS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLSstLSsNCj4+IA0KPj4gVmVjdG9yICg4
LWJpdCBlbGVtZW50cykgaW4gTEU6DQo+PiArLS0rLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0r
LS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSsNCj4+IHwwMHwwMHzigJxU4oCdfOKAnFPi
gJ184oCcReKAnXzigJxU4oCdfOKAnCDigJ184oCcYeKAnXzigJwg4oCdfOKAnHPigJ184oCcaeKA
nXzigJwg4oCdfOKAnHPigJ184oCcaeKAnXwiaCJ8IlQifA0KPj4gKy0tKy0tKy0tLSstLS0rLS0t
Ky0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rDQo+PiANCj4+IFN0
b3JpbmcgMTQgYnl0ZXMgd291bGQgcmVzdWx0IGluIGZvbGxvd2luZyBMaXR0bGUvQmlnLWVuZGlh
biBTdG9yYWdlOg0KPj4gKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSst
LS0rLS0tKy0tLSstLS0rLS0rLS0rDQo+PiB84oCcVOKAnXzigJxo4oCdfOKAnGnigJ184oCcc+KA
nXzigJwg4oCdfOKAnGnigJ184oCcc+KAnXzigJwg4oCdfOKAnGHigJ184oCcIOKAnXzigJxU4oCd
fOKAnEXigJ184oCcU+KAnXzigJxU4oCdfEZGfEZGfA0KPj4gKy0tLSstLS0rLS0tKy0tLSstLS0r
LS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0tKy0tLSstLS0rLS0rLS0rDQo+PiANCj4+IFNpZ25l
ZC1vZmYtYnk6IE5pa3VuaiBBIERhZGhhbmlhIDxuaWt1bmpAbGludXgudm5ldC5pYm0uY29tPg0K
Pg0KPiBBcyB3aXRoIGx4dmwvbHh2bGwgSSB0aGluayB5b3Ugc2hvdWxkIGJlIGFibGUgdG8gc2hh
cmUgdGhlIGhlbHBlciBmb3INCj4gc3R4dmwgYW5kIHN0eHZsbC4NCg0KU3VyZSwgd2lsbCBkbyB0
aGF0Lg0KDQpSZWdhcmRzDQpOaWt1bmoNCg==
