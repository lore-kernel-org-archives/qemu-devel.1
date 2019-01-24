Received: from eggs.gnu.org ([209.51.188.92]:55499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmbPB-0000Ol-7A
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gmbP1-0005bN-70
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 04:34:31 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 24 Jan 2019 09:34:22 +0000
Message-ID: <813cf685-6338-cdd5-8f4f-4a184a67a5ec@virtuozzo.com>
References: <20190124074825.2327-1-dplotnikov@virtuozzo.com>
In-Reply-To: <20190124074825.2327-1-dplotnikov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <0404B40DCABC0A42A18C527BE3C7BEBB@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] block: skip initializer BDS on recursive
 aio context attachment/detachment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Denis Lunev <den@virtuozzo.com>

MjQuMDEuMjAxOSAxMDo0OCwgRGVuaXMgUGxvdG5pa292IHdyb3RlOg0KPiBXaGVuIHRoZXJlIGlz
IGEgQmFja3VwIEJsb2NrIEpvYiBydW5uaW5nIGFuZCBzaHV0ZG93biBjb21tYW5kIGlzIHNlbnQg
dG8NCj4gYSBndWVzdCwgdGhlIGd1ZXN0IGNydXNoZXMgZHVlIHRvIGFzc2VydCghYnMtPndhbGtp
bmdfYWlvX25vdGlmaWVycykuDQoNCkNsYXJpZmljYXRpb246IG5vdCBvcmRpbmFyeSBiYWNrdXAs
IGJ1dCBmbGVlY2luZyBzY2hlbWU6IGJhY2t1cCB3aXRoIHN5bmM9bm9uZSwNCndoZW4gc291cmNl
IGlzIGEgYmFja2luZyBmb3IgdGFyZ2V0Lg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxhZGlt
aXINCg==
