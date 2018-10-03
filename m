Received: from eggs.gnu.org ([2001:4830:134:3::10]:51383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7lR4-0006Ai-G7
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7lQz-0007Yg-BE
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:59:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 3 Oct 2018 17:59:29 +0000
Message-ID: <a6a5cfb4-bfad-a4f5-fb86-e9329da851b6@virtuozzo.com>
References: <20181003170228.95973-1-vsementsov@virtuozzo.com>
	<bccd1e94-431f-c7cf-4a0c-599dcf345e73@redhat.com>
In-Reply-To: <bccd1e94-431f-c7cf-4a0c-599dcf345e73@redhat.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Subject: Re: [Qemu-devel] [PATCH 0/2] nbd server: drop old-style negotiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "rjones@redhat.com" <rjones@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>

MDMuMTAuMjAxOCAyMDozMiwgRXJpYyBCbGFrZSB3cm90ZToNCk9uIDEwLzMvMTggMTI6MDIgUE0s
IFZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgd3JvdGU6DQpJdCdzIHVuZXhwZWN0ZWQgYmVo
YXZpb3IgdGhhdCB3aXRob3V0IC14IG9wdGlvbiBxZW11LW5iZCBkbyBvbGQtc3R5bGUNCm5lZ290
aWF0aW9uLiBMZXQncyB1c2UgIiIgYXMgYSBkZWZhdWx0IG5hbWUgaW5zdGVhZCAoYXMgaXQgaXMg
YWxyZWFkeQ0KZG9uZSBpZiB0bHMgaXMgdXNlZCkgYW5kIHRoZXJlZm9yZSwgZHJvcCBvbGQtc3R5
bGUgbmVnb3RpYXRpb24gZnJvbQ0KUWVtdSBOQkQgc2VydmVyLg0KDQpPZGRseSBlbm91Z2gsIEkg
d3JvdGUgYSBzaW1pbGFyIHBhdGNoIGluIHBhcmFsbGVsLCBhbmQgYW0gb25seSBub3cganVzdCBz
ZWVpbmcgeW91ciBtYWlsLiBZb3VycyBpcyBhIGJpdCBzdHJvbmdlciB0aGFuIG1pbmUgKEkgYWRk
ZWQgJ3FlbXUtbmJkIC1PJyB0byBhbGxvdyBleHBsaWNpdCBmYWxsYmFjayB0byBvbGRzdHlsZSwg
d2hpbGUgeW91IHJpcHBlZCBpdCBvdXQgYWx0b2dldGhlcikuICBUaGUgY2xpZW50IGNhbiBuZWdv
dGlhdGUgZWl0aGVyIHN0eWxlLCBzbyB3ZSBkb24ndCBuZWVkIGFuIG9wdGlvbiBvbiB0aGUgY2xp
ZW50IHNpZGU7IHJhdGhlciwgdGhpcyBpcyBhbGwgYWJvdXQgd2hhdCB0aGUgc2VydmVyIHNob3Vs
ZCBkbyBieSBkZWZhdWx0Lg0KDQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3Fl
bXUtZGV2ZWwvMjAxOC0xMC9tc2cwMDU2OC5odG1sDQoNCkRvZXMgYW55b25lIGhhdmUgYSBwcmVm
ZXJlbmNlIGJldHdlZW4gdGhlIHR3bz8gSGVyZSdzIHRoZSBsYXN0IHRpbWUgaXQgd2FzIGRpc2N1
c3NlZDoNCg0KaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIw
MTgtMDgvbXNnMDMyNTIuaHRtbA0KDQpIbSwgSSB0aGluayBldmVyeW9uZSB3aG8gbGlrZSBuZXct
c3R5bGUgc2hvdWxkIGFuc3dlciB0aGF0IGhlIGRvbid0IGNhcmUgKGV4Y2VwdCBzdHJpY3RlciB3
YXkgaXMgYSBiaXQgYmV0dGVyOiBkb24ndCBoYXZlIG9wdGlvbnMgYW5kIGNvZGUgd2hpY2ggd2Ug
ZG9uJ3QgbmVlZCkuDQpCdXQgaWYgdGhlcmUgaXMgc29tZW9uZSB3aG8gaGFzIGNsaWVudCB3aGlj
aCBzdXBwb3J0IG9ubHkgb2xkLXN0eWxlIG5lZ290aWF0aW9uIGhpcyB1bmhhcHBpbmVzcyAoaW4g
Y2FzZSBvZiBzdHJpY3Qgd2F5KSB3aWxsIG91dHdlaWdoIGFsbCBvdXIgImJpdHMiOikNCg0KSSdt
IGZyb20gdGhlIGZpcnN0IGdyb3VwKS4gQnV0IGxldCdzIGNob3NlIHlvdXIgcGF0Y2gNCg0KDQoN
ClZsYWRpbWlyIFNlbWVudHNvdi1PZ2lldnNraXkgKDIpOg0KICAgcWVtdS1uYmQ6IGRyb3Agb2xk
LXN0eWxlIG5lZ290aWF0aW9uDQogICBuYmQvc2VydmVyOiBkcm9wIG9sZC1zdHlsZSBuZWdvdGlh
dGlvbg0KDQogIGluY2x1ZGUvYmxvY2svbmJkLmggfCAgMyArLS0NCiAgYmxvY2tkZXYtbmJkLmMg
ICAgICB8ICAyICstDQogIG5iZC9zZXJ2ZXIuYyAgICAgICAgfCA1MyArKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgcWVtdS1uYmQuYyAgICAgICAgICB8IDI1
ICsrKysrLS0tLS0tLS0tLS0tLS0tLQ0KICA0IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMo
KyksIDYwIGRlbGV0aW9ucygtKQ0KDQoNCg0KDQoNCi0tDQpCZXN0IHJlZ2FyZHMsDQpWbGFkaW1p
cg0K
