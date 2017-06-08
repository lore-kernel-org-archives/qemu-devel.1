Received: from eggs.gnu.org ([2001:4830:134:3::10]:33551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dItXk-0004Hj-KE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dItXh-0007Td-8w
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:15:52 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60555)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yong155@zte.com.cn>) id 1dItXg-0007TF-Bz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:15:49 -0400
Date: Thu, 8 Jun 2017 17:14:38 +0800 (CST)
Message-ID: <201706081714384829069@zte.com.cn>
References: 1496659493-1105-1-git-send-email-wang.yong155@zte.com.cn,
	cb49290e-9dcf-6ee0-2824-f283659f87e2@redhat.com
Mime-Version: 1.0
From: <wang.yong155@zte.com.cn>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiBSZTogW1BBVENIdjIgMDEvMDRdIGNv?=
 =?utf-8?q?lo-compare=3A_Use_IOThread_context_timer_to_Checkold_packet_reg?=
 =?utf-8?q?ularly?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, wang.guang55@zte.com.cn

77ye77yeIEZyb206IFdhbmcgWW9uZ++8nHdhbmcueW9uZzE1NUB6dGUuY29tLmNu77yeDQoNCu+8
nu+8ng0KDQrvvJ7vvJ4gUmVtb3ZlIHRoZSB0YXNrIHdoaWNoIGNoZWNrIG9sZCBwYWNrZXQgaW4g
dGhlIGNvbXBhcmluZyB0aHJlYWQsDQoNCu+8nu+8niB0aGVuIHVzZSBJT3RocmVhZCBjb250ZXh0
IHRpbWVyIHRvIGhhbmRsZSBpdC4NCg0K77ye77yeDQoNCu+8nu+8niBTaWduZWQtb2ZmLWJ5OiBX
YW5nIFlvbmfvvJx3YW5nLnlvbmcxNTVAenRlLmNvbS5jbu+8ng0KDQrvvJ7vvJ4gU2lnbmVkLW9m
Zi1ieTogV2FuZyBHdWFuZ++8nHdhbmcuZ3Vhbmc1NUB6dGUuY29tLmNu77yeDQoNCu+8nu+8niAt
LS0NCg0K77ye77yeICAgbmV0L2NvbG8tY29tcGFyZS5jIHwgNjIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tDQoNCu+8nu+8niAgIDEgZmlsZSBj
aGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCg0KDQoNCg0K77yeSSBz
dWdnZXN0IHRvIHNxdWFzaCB0aGlzIGludG8gcGF0Y2ggMiwgc2luY2Ugd2Ugd2lsbCBoYXZlIDIg
dGhyZWFkcyBub3cuDQoNCk9LLCBJJ2xsIGRvIHRoYXQuDQoNCg0KDQoNClRoYW5rcw0KDQoNCg0K
DQoNCg0KDQoNCg0KDQoNCg0KDQoNCg0K5Y6f5aeL6YKu5Lu2DQoNCg0KDQrlj5Hku7bkurrvvJog
77ycamFzb3dhbmdAcmVkaGF0LmNvbe+8ng0K5pS25Lu25Lq677ya546L5YuHMTAxNzA1MzAg77yc
emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29t77yeIO+8nHpoYW5nY2hlbi5mbnN0QGNuLmZ1
aml0c3UuY29t77yeDQrmioTpgIHkurrvvJog77ycbGl6aGlqaWFuQGNuLmZ1aml0c3UuY29t77ye
IO+8nHFlbXUtZGV2ZWxAbm9uZ251Lm9yZ++8nueOi+W5vzEwMTY1OTkyDQrml6Ug5pyfIO+8mjIw
MTflubQwNuaciDA35pelIDE2OjMwDQrkuLsg6aKYIO+8mlJlOiBbUEFUQ0h2MiAwMS8wNF0gY29s
by1jb21wYXJlOiBVc2UgSU9UaHJlYWQgY29udGV4dCB0aW1lciB0byBDaGVja29sZCBwYWNrZXQg
cmVndWxhcmx5DQoNCg0KDQoNCg0KDQoNCk9uIDIwMTflubQwNuaciDA15pelIDE4OjQ0LCBZb25n
IFdhbmcgd3JvdGU6DQrvvJ4gRnJvbTogV2FuZyBZb25n77ycd2FuZy55b25nMTU1QHp0ZS5jb20u
Y27vvJ4NCu+8ng0K77yeIFJlbW92ZSB0aGUgdGFzayB3aGljaCBjaGVjayBvbGQgcGFja2V0IGlu
IHRoZSBjb21wYXJpbmcgdGhyZWFkLA0K77yeIHRoZW4gdXNlIElPdGhyZWFkIGNvbnRleHQgdGlt
ZXIgdG8gaGFuZGxlIGl0Lg0K77yeDQrvvJ4gU2lnbmVkLW9mZi1ieTogV2FuZyBZb25n77ycd2Fu
Zy55b25nMTU1QHp0ZS5jb20uY27vvJ4NCu+8niBTaWduZWQtb2ZmLWJ5OiBXYW5nIEd1YW5n77yc
d2FuZy5ndWFuZzU1QHp0ZS5jb20uY27vvJ4NCu+8niAtLS0NCu+8niAgIG5ldC9jb2xvLWNvbXBh
cmUuYyB8IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLS0tLQ0K77yeICAgMSBmaWxlIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDEyIGRlbGV0
aW9ucygtKQ0KDQpJIHN1Z2dlc3QgdG8gc3F1YXNoIHRoaXMgaW50byBwYXRjaCAyLCBzaW5jZSB3
ZSB3aWxsIGhhdmUgMiB0aHJlYWRzIG5vdy4NCg0KVGhhbmtz
