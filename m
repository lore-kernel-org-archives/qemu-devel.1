Received: from eggs.gnu.org ([2001:4830:134:3::10]:41194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ejPem-000714-M2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1ejPej-00036I-En
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 08:21:00 -0500
Resent-Message-Id: <E1ejPej-00036I-En@eggs.gnu.org>
In-Reply-To: <20180207125037.13510-1-vsementsov@virtuozzo.com>
Reply-To: <qemu-devel@nongnu.org>
Message-ID: <151800962781.204.820918804384569617@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 7 Feb 2018 05:20:28 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: vsementsov@virtuozzo.com
Cc: famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

SGksCgpUaGlzIHNlcmllcyBmYWlsZWQgYnVpbGQgdGVzdCBvbiBwcGMgaG9zdC4gUGxlYXNlIGZp
bmQgdGhlIGRldGFpbHMgYmVsb3cuCgpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxd
IFtQQVRDSCB2MiAwLzJdIGJsb2NrIGxhdGVuY3kgaGlzdG9ncmFtCk1lc3NhZ2UtaWQ6IDIwMTgw
MjA3MTI1MDM3LjEzNTEwLTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCiMgVGVzdGluZyBzY3JpcHQgd2lsbCBiZSBpbnZva2Vk
IHVuZGVyIHRoZSBnaXQgY2hlY2tvdXQgd2l0aAojIEhFQUQgcG9pbnRpbmcgdG8gYSBjb21taXQg
dGhhdCBoYXMgdGhlIHBhdGNoZXMgYXBwbGllZCBvbiB0b3Agb2YgImJhc2UiCiMgYnJhbmNoCnNl
dCAtZQplY2hvICI9PT0gRU5WID09PSIKZW52CmVjaG8gIj09PSBQQUNLQUdFUyA9PT0iCnJwbSAt
cWEKZWNobyAiPT09IFRFU1QgQkVHSU4gPT09IgpJTlNUQUxMPSRQV0QvaW5zdGFsbApCVUlMRD0k
UFdEL2J1aWxkCm1rZGlyIC1wICRCVUlMRCAkSU5TVEFMTApTUkM9JFBXRApjZCAkQlVJTEQKJFNS
Qy9jb25maWd1cmUgLS1wcmVmaXg9JElOU1RBTEwKbWFrZSAtajEwMAojIFhYWDogd2UgbmVlZCBy
ZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWoxMDAgVj0xCm1ha2UgaW5zdGFsbAo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NAplcnJvcjogUlBDIGZhaWxlZDsgcmVzdWx0PTE4LCBIVFRQIGNvZGUgPSAy
MDAKZmF0YWw6IFRoZSByZW1vdGUgZW5kIGh1bmcgdXAgdW5leHBlY3RlZGx5CmVycm9yOiBDb3Vs
ZCBub3QgZmV0Y2ggM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApUcmFj
ZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiL2hvbWUvcGF0Y2hldy9wYXRj
aGV3L3BhdGNoZXctY2xpIiwgbGluZSA1MDQsIGluIHRlc3Rfb25lCiAgICBnaXRfY2xvbmVfcmVw
byhjbG9uZSwgclsicmVwbyJdLCByWyJoZWFkIl0sIGxvZ2YpCiAgRmlsZSAiL2hvbWUvcGF0Y2hl
dy9wYXRjaGV3L3BhdGNoZXctY2xpIiwgbGluZSA0OCwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN0
ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhvbjMuNC9zdWJw
cm9jZXNzLnB5IiwgbGluZSA1NTgsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0tbWlycm9yPWZldGNoJywgJzNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDEKCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAZnJlZWxpc3RzLm9yZw==
