Received: from eggs.gnu.org ([2001:4830:134:3::10]:58613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc7cj-0000RM-Jz
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1cc7ch-0001dV-Mn
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 04:36:13 -0500
Resent-Message-Id: <E1cc7ch-0001dV-Mn@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170210092724.6470-1-lvivier@redhat.com>
Message-ID: <148671936015.57.11103321999455503256@eba24e3a0d7f>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Fri, 10 Feb 2017 01:36:00 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH 0/3] ppc: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lvivier@redhat.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, agraf@suse.de, david@gibson.dropbear.id.au

SGksCgpZb3VyIHNlcmllcyBmYWlsZWQgYXV0b21hdGljIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5k
IHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZl
IGRvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHku
CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvM10gcHBjOiByZXBsYWNlIGRlYnVnIHBy
aW50ZiB3aXRoIHRyYWNlIHBvaW50cwpNZXNzYWdlLWlkOiAyMDE3MDIxMDA5MjcyNC42NDcwLTEt
bHZpdmllckByZWRoYXQuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApzZXQgLWUKZ2l0IHN1Ym1vZHVsZSB1cGRhdGUgLS1pbml0IGR0YwojIExl
dCBkb2NrZXIgdGVzdHMgZHVtcCBlbnZpcm9ubWVudCBpbmZvCmV4cG9ydCBTSE9XX0VOVj0xCmV4
cG9ydCBKPTE2Cm1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNgptYWtlIGRvY2tlci10ZXN0
LW1pbmd3QGZlZG9yYQptYWtlIGRvY2tlci10ZXN0LWJ1aWxkQG1pbi1nbGliCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNzJjMjNjNCBzcGFwcjogcmVw
bGFjZSBkZWJ1ZyBwcmludGYgd2l0aCB0cmFjZSBwb2ludHMKMTlhNTE3OSBwcGM0eHg6IHJlcGxh
Y2UgZGVidWcgcHJpbnRmIHdpdGggdHJhY2UgcG9pbnRzCjYzYTk1YmQgbWFjOTk6IHJlcGxhY2Ug
ZGVidWcgcHJpbnRmIHdpdGggdHJhY2UgcG9pbnRzCgo9PT0gT1VUUFVUIEJFR0lOID09PQpTdWJt
b2R1bGUgJ2R0YycgKGdpdDovL2dpdC5xZW11LXByb2plY3Qub3JnL2R0Yy5naXQpIHJlZ2lzdGVy
ZWQgZm9yIHBhdGggJ2R0YycKZmF0YWw6IHJlYWQgZXJyb3I6IENvbm5lY3Rpb24gcmVzZXQgYnkg
cGVlcgpDbG9uaW5nIGludG8gJ2R0YycuLi4KQ2xvbmUgb2YgJ2dpdDovL2dpdC5xZW11LXByb2pl
Y3Qub3JnL2R0Yy5naXQnIGludG8gc3VibW9kdWxlIHBhdGggJ2R0YycgZmFpbGVkCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cDovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBmcmVlbGlzdHMub3Jn
