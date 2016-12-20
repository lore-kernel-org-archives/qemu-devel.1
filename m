Received: from eggs.gnu.org ([2001:4830:134:3::10]:34394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTRH-00082B-IC
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cJTRD-0004dI-3e
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 18:03:19 -0500
Resent-Message-Id: <E1cJTRD-0004dI-3e@eggs.gnu.org>
In-Reply-To: <1482187106-85065-1-git-send-email-sochin.jiang@huawei.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <148227498932.73.3882301413995014194@790289a7ca88>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Tue, 20 Dec 2016 15:03:10 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] mirror: prevent 'top' mode mirroring when
 no backing file specified on the destination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sochin.jiang@huawei.com
Cc: famz@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, xieyingtai@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, qemu-devel@nongnu.org, wangjie88@huawei.com

SGksCgpZb3VyIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSF0gbWlycm9yOiBwcmV2ZW50ICd0b3AnIG1vZGUgbWlycm9yaW5nIHdoZW4g
bm8gYmFja2luZyBmaWxlIHNwZWNpZmllZCBvbiB0aGUgZGVzdGluYXRpb24KTWVzc2FnZS1pZDog
MTQ4MjE4NzEwNi04NTA2NS0xLWdpdC1zZW5kLWVtYWlsLXNvY2hpbi5qaWFuZ0BodWF3ZWkuY29t
ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAoKQkFT
RT1iYXNlCm49MQp0b3RhbD0kKGdpdCBsb2cgLS1vbmVsaW5lICRCQVNFLi4gfCB3YyAtbCkKZmFp
bGVkPTAKCiMgVXNlZnVsIGdpdCBvcHRpb25zCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCgpjb21taXRzPSIk
KGdpdCBsb2cgLS1mb3JtYXQ9JUggLS1yZXZlcnNlICRCQVNFLi4pIgpmb3IgYyBpbiAkY29tbWl0
czsgZG8KICAgIGVjaG8gIkNoZWNraW5nIFBBVENIICRuLyR0b3RhbDogJChnaXQgbG9nIC1uIDEg
LS1mb3JtYXQ9JXMgJGMpLi4uIgogICAgaWYgISBnaXQgc2hvdyAkYyAtLWZvcm1hdD1lbWFpbCB8
IC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgLTsgdGhlbgogICAgICAgIGZhaWxl
ZD0xCiAgICAgICAgZWNobwogICAgZmkKICAgIG49JCgobisxKSkKZG9uZQoKZXhpdCAkZmFpbGVk
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMDVlM2Y1
MiBtaXJyb3I6IHByZXZlbnQgJ3RvcCcgbW9kZSBtaXJyb3Jpbmcgd2hlbiBubyBiYWNraW5nIGZp
bGUgc3BlY2lmaWVkIG9uIHRoZSBkZXN0aW5hdGlvbgoKPT09IE9VVFBVVCBCRUdJTiA9PT0KQ2hl
Y2tpbmcgUEFUQ0ggMS8xOiBtaXJyb3I6IHByZXZlbnQgJ3RvcCcgbW9kZSBtaXJyb3Jpbmcgd2hl
biBubyBiYWNraW5nIGZpbGUgc3BlY2lmaWVkIG9uIHRoZSBkZXN0aW5hdGlvbi4uLgpFUlJPUjog
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCiMyNzogRklM
RTogYmxvY2svbWlycm9yLmM6MTA0MToKKyAgICBpZiAobW9kZSA9PSBNSVJST1JfU1lOQ19NT0RF
X1RPUCAmJiAhYmFja2luZ19icyh0YXJnZXQpKQorICAgIHsKCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMTIgbGluZXMgY2hlY2tlZAoKWW91ciBwYXRjaCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQGZyZWVsaXN0cy5vcmc=
