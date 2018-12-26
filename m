Received: from eggs.gnu.org ([208.118.235.92]:51347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gc4UL-0000Q7-IC
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gc4UH-0007qf-Jc
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:24:25 -0500
Resent-Message-Id: <E1gc4UH-0007qf-Jc@eggs.gnu.org>
In-Reply-To: <20181221124410.11920-1-pbonzini@redhat.com>
Message-ID: <154581264856.18047.14025269685634947747@02a1dbf831e2>
Reply-To: <qemu-devel@nongnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 26 Dec 2018 00:24:09 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com
Cc: fam@euphon.net, qemu-devel@nongnu.org, ehabkost@redhat.com, qemu-stable@nongnu.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE4MTIyMTEyNDQxMC4xMTky
MC0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBj
b21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFs
bGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2Vu
dG9zNyBTSE9XX0VOVj0xIEo9OAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbGlicG1lbSBzdXBw
b3J0ICAgbm8KbGlidWRldiAgICAgICAgICAgbm8KCldBUk5JTkc6IFVzZSBvZiBTREwgMS4yIGlz
IGRlcHJlY2F0ZWQgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbgpXQVJOSU5HOiBmdXR1cmUgcmVsZWFz
ZXMuIFBsZWFzZSBzd2l0Y2ggdG8gdXNpbmcgU0RMIDIuMAoKTk9URTogY3Jvc3MtY29tcGlsZXJz
IGVuYWJsZWQ6ICAnY2MnCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9jb25maWctZGV2aWNlcy5t
YWsudG1wCi0tLQogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vdHJhbnNsYXRl
Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL29wX2hlbHBlci5vCiAgQ0Mg
ICAgICBhYXJjaDY0LXNvZnRtbXUvdGFyZ2V0L2FybS9oZWxwZXIubwovdG1wL3FlbXUtdGVzdC9z
cmMvdGFyZ2V0L2kzODYvY3B1LmM6MTAxNTo5OiBlcnJvcjogdW5rbm93biBmaWVsZCAndW5taWdy
YXRhYmxlX2ZlYXR1cmVzJyBzcGVjaWZpZWQgaW4gaW5pdGlhbGl6ZXIKICAgICAgICAgLnVubWln
cmF0YWJsZV9mZWF0dXJlcyA9IENQVUlEXzdfMF9FQlhfSU5URUxfUFQsCiAgICAgICAgIF4KbWFr
ZVsxXTogKioqIFt0YXJnZXQvaTM4Ni9jcHUub10gRXJyb3IgMQoKClRoZSBmdWxsIGxvZyBpcyBh
dmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxODEyMjExMjQ0MTAuMTE5MjAt
MS1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==
