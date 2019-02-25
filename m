Received: from eggs.gnu.org ([209.51.188.92]:57899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyB0W-0006Vh-GY
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gyB0V-0007tK-Sp
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 02:49:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 25 Feb 2019 07:48:55 +0000
Message-ID: <1813423f-43d3-574c-8dd5-77953e1c0bf1@virtuozzo.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
	<20190223000614.13894-7-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-7-jsnow@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <F148F420700B754C9FDFBE589CDA83E2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 06/10] block/dirty-bitmap: explicitly
 lock bitmaps with successors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

MjMuMDIuMjAxOSAzOjA2LCBKb2huIFNub3cgd3JvdGU6DQo+IEluc3RlYWQgb2YgaW1wbHlpbmcg
YSB1c2VyX2xvY2tlZC9idXN5IHN0YXR1cywgbWFrZSBpdCBleHBsaWNpdC4NCj4gTm93LCBiaXRt
YXBzIGluIHVzZSBieSBtaWdyYXRpb24sIE5CRCBvciBiYWNrdXAgb3BlcmF0aW9ucw0KPiBhcmUg
YWxsIHRyZWF0ZWQgdGhlIHNhbWUgd2F5IHdpdGggdGhlIHNhbWUgY29kZSBwYXRocy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEpvaG4gU25vdzxqc25vd0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1i
eTogRXJpYyBCbGFrZTxlYmxha2VAcmVkaGF0LmNvbT4NCg0KaG1tLCB5b3UgZm9yZ2V0IG15IHIt
YjoNClJldmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292
QHZpcnR1b3p6by5jb20+DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==
