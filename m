Received: from eggs.gnu.org ([2001:4830:134:3::10]:57560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dG4Qi-0003vf-IZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1dG4Qh-0002rJ-EQ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:16:56 -0400
Resent-Message-Id: <E1dG4Qh-0002rJ-EQ@eggs.gnu.org>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20170531092516.5112-1-lvivier@redhat.com>
Message-ID: <149624018334.1610.2494574605273755928@f98a8425f76e>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Wed, 31 May 2017 07:16:24 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2] spapr: manage hotplugged devices while
 the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lvivier@redhat.com
Cc: famz@redhat.com, david@gibson.dropbear.id.au, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org

SGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1z
LiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUt
ZGV2ZWxdIFtQQVRDSCB2Ml0gc3BhcHI6IG1hbmFnZSBob3RwbHVnZ2VkIGRldmljZXMgd2hpbGUg
dGhlIFZNIGlzIG5vdCBzdGFydGVkClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE3MDUzMTA5
MjUxNi41MTEyLTEtbHZpdmllckByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09
CiMhL2Jpbi9iYXNoCgpCQVNFPWJhc2UKbj0xCnRvdGFsPSQoZ2l0IGxvZyAtLW9uZWxpbmUgJEJB
U0UuLiB8IHdjIC1sKQpmYWlsZWQ9MAoKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGlt
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKCmNvbW1pdHM9IiQoZ2l0
IGxvZyAtLWZvcm1hdD0lSCAtLXJldmVyc2UgJEJBU0UuLikiCmZvciBjIGluICRjb21taXRzOyBk
bwogICAgZWNobyAiQ2hlY2tpbmcgUEFUQ0ggJG4vJHRvdGFsOiAkKGdpdCBsb2cgLW4gMSAtLWZv
cm1hdD0lcyAkYykuLi4iCiAgICBpZiAhIGdpdCBzaG93ICRjIC0tZm9ybWF0PWVtYWlsIHwgLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayAtOyB0aGVuCiAgICAgICAgZmFpbGVkPTEK
ICAgICAgICBlY2hvCiAgICBmaQogICAgbj0kKChuKzEpKQpkb25lCgpleGl0ICRmYWlsZWQKPT09
IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3
ZjQ0YmQ4ODg3MTMzODQKZmF0YWw6IHVuYWJsZSB0byBhY2Nlc3MgJ2h0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdS8nOiBGYWlsZWQgdG8gY29ubmVjdCB0byBnaXRodWIuY29t
IHBvcnQgNDQzOiBDb25uZWN0aW9uIHRpbWVkIG91dAplcnJvcjogQ291bGQgbm90IGZldGNoIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJl
Y2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi91c3IvYmluL3BhdGNoZXciLCBsaW5lIDQwOSwgaW4g
dGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNsb25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwg
bG9nZikKICBGaWxlICIvdXNyL2Jpbi9wYXRjaGV3IiwgbGluZSA0OCwgaW4gZ2l0X2Nsb25lX3Jl
cG8KICAgIHN0ZG91dD1sb2dmLCBzdGRlcnI9bG9nZikKICBGaWxlICIvdXNyL2xpYjY0L3B5dGhv
bjMuNS9zdWJwcm9jZXNzLnB5IiwgbGluZSA1ODEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENh
bGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vy
cm9yOiBDb21tYW5kICdbJ2dpdCcsICdyZW1vdGUnLCAnYWRkJywgJy1mJywgJy0tbWlycm9yPWZl
dGNoJywgJzNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQnLCAnaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11J10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDEKCgoKLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHA6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAZnJlZWxpc3RzLm9yZw==
