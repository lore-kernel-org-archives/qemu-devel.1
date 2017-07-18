Received: from eggs.gnu.org ([2001:4830:134:3::10]:55321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHAE-0003ri-7Y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHAB-00018J-3V
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:19:02 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56933)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dXHAA-00011a-7z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 21:18:59 -0400
Date: Tue, 18 Jul 2017 09:18:38 +0800 (CST)
Message-ID: <201707180918381714420@zte.com.cn>
References: 1500099757-4184-1-git-send-email-wang.yi59@zte.com.cn,
	20170717151306.GA26923@work-vm
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: Re: [Qemu-devel]
 =?utf-8?q?=5BPATCH=5D_hmp=3A_allow_cpu_index_for_?=
 =?utf-8?q?=22info_lapic=22?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

SGkgRGF2aWQsDQoNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHJldmlldyBhbmQgc3VnZ2VzdGlv
biwgSSB3aWxsIHJlc2VuZCBhIG5ldyB2ZXJzaW9uIHJpZ2h0IG5vdy4NCg0KPiogWWkgV2FuZyAo
d2FuZy55aTU5QHp0ZS5jb20uY24pIHdyb3RlOg0KDQo+PiBBZGQgW3ZjcHUgaW5kZXhdIHN1cHBv
cnQgZm9yIGhtcCBjb21tYW5kICJpbmZvIGxhcGljIiwgd2hpY2ggaXMNCg0KPj4gdXNlZnVsIHdo
ZW4gZGVidWdnaW5nIGlwaSBhbmQgc28gb24uDQoNCj4+IA0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
aSBXYW5nIDx3YW5nLnlpNTlAenRlLmNvbS5jbj4NCg0KPj4gU2lnbmVkLW9mZi1ieTogWXVuIExp
dSA8bGl1Lnl1bmhAenRlLmNvbS5jbj4NCg0KPj4gLS0tDQoNCj4+ICBobXAtY29tbWFuZHMtaW5m
by5oeCAgfCA2ICsrKy0tLQ0KDQo+PiAgdGFyZ2V0L2kzODYvbW9uaXRvci5jIHwgNyArKysrKyst
DQoNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkN
Cg0KPj4gDQoNCj4+IGRpZmYgLS1naXQgYS9obXAtY29tbWFuZHMtaW5mby5oeCBiL2htcC1jb21t
YW5kcy1pbmZvLmh4DQoNCj4+IGluZGV4IDA3NTAwZWYuLjhhZDJmODEgMTAwNjQ0DQoNCj4+IC0t
LSBhL2htcC1jb21tYW5kcy1pbmZvLmh4DQoNCj4+ICsrKyBiL2htcC1jb21tYW5kcy1pbmZvLmh4
DQoNCj4+IEBAIC0xMTUsOSArMTE1LDkgQEAgRVRFWEkNCg0KPj4gICNpZiBkZWZpbmVkKFRBUkdF
VF9JMzg2KQ0KDQo+PiAgICAgIHsNCg0KPj4gICAgICAgICAgLm5hbWUgICAgICAgPSAibGFwaWMi
LA0KDQo+PiAtICAgICAgICAuYXJnc190eXBlICA9ICIiLA0KDQo+PiAtICAgICAgICAucGFyYW1z
ICAgICA9ICIiLA0KDQo+PiAtICAgICAgICAuaGVscCAgICAgICA9ICJzaG93IGxvY2FsIGFwaWMg
c3RhdGUiLA0KDQo+PiArICAgICAgICAuYXJnc190eXBlICA9ICJ2Y3B1Omk/IiwNCg0KPj4gKyAg
ICAgICAgLnBhcmFtcyAgICAgPSAiW3ZjcHUgaW5kZXhdIiwNCg0KPj4gKyAgICAgICAgLmhlbHAg
ICAgICAgPSAic2hvdyBsb2NhbCBhcGljIHN0YXRlIChkZWZhdWx0IHZjcHUgMCkiLA0KDQo+DQoN
Cj5Ob3JtYWxseSBJIHRoaW5rIHRoZSBzeW50YXggZm9yIHRoZSBoZWxwIGlzIA0KDQo+KHZjcHU6
IHZDUFUgdG8gcmVhZCwgZGVmYXVsdCBpcyAwKSINCg0KDQoNCg0KDQotLS0NCg0KQmVzdCB3aXNo
ZXMNCg0KWWkgV2FuZw==
