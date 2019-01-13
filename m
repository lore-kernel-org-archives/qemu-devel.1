Received: from eggs.gnu.org ([209.51.188.92]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gijmJ-0002kG-43
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1gijmI-0004TL-2C
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:42:31 -0500
Resent-Message-Id: <E1gijmI-0004TL-2C@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1gijmH-0004SR-Ps
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 12:42:30 -0500
Message-ID: <154740129194.25737.15940119023914398964@2d170d368aaa>
Reply-To: <qemu-devel@nongnu.org>
In-Reply-To: <20190111063732.10484-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
From: no-reply@patchew.org
Date: Sun, 13 Jan 2019 09:41:34 -0800 (PST)
Subject: Re: [Qemu-devel] [PATCH v2 0/3] optimize waiting for free thread to
 do compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: fam@euphon.net, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, kvm@vger.kernel.org, quintela@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, cota@braap.org

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDExMTA2MzczMi4xMDQ4
NC0xLXhpYW9ndWFuZ3JvbmdAdGVuY2VudC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgYWFyY2g2NC1zb2Z0bW11L3RyYWNlL2dlbmVyYXRlZC1oZWxwZXJzLm8KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL3RyYW5zbGF0ZS1zdmUubwovdG1wL3FlbXUtdGVzdC9z
cmMvbWlncmF0aW9uL3JhbS5jOiBJbiBmdW5jdGlvbiAnY29tcHJlc3NfcGFnZV93aXRoX211bHRp
X3RocmVhZCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vcmFtLmM6MjA2NDoyNjogZXJy
b3I6IGNvbXBhcmlzb24gb2YgY29uc3RhbnQgJzInIHdpdGggYm9vbGVhbiBleHByZXNzaW9uIGlz
IGFsd2F5cyBmYWxzZSBbLVdlcnJvcj1ib29sLWNvbXBhcmVdCiAgICAgYWRhcHRpdmUgPSAoYWRh
cHRpdmUgPT0gQ09NUFJFU1NfV0FJVF9USFJFQURfQURBUFRJVkUpOwogICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+Ci90bXAvcWVtdS10ZXN0L3NyYy9taWdyYXRpb24vcmFtLmM6MjA2MDo5OiBl
cnJvcjogdW51c2VkIHZhcmlhYmxlICdjb21wcmVzc193YWl0X3RocmVhZCcgWy1XZXJyb3I9dW51
c2VkLXZhcmlhYmxlXQogICAgIGludCBjb21wcmVzc193YWl0X3RocmVhZCA9IG1pZ3JhdGVfY29t
cHJlc3Nfd2FpdF90aHJlYWQoKTsKICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn4KL3RtcC9x
ZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9yYW0uYzoyMDYzOjEwOiBlcnJvcjogJ2FkYXB0aXZlJyBp
cyB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj11bmluaXRpYWxp
emVkXQogICAgIHdhaXQgPSAoYWRhcHRpdmUgPT0gQ09NUFJFU1NfV0FJVF9USFJFQURfT04pOwog
ICAgIH5+fn5+Xn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2VbMV06ICoqKiBbL3RtcC9xZW11
LXRlc3Qvc3JjL3J1bGVzLm1hazo2OTogbWlncmF0aW9uL3JhbS5vXSBFcnJvciAxCm1ha2VbMV06
ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCi90bXAvcWVtdS10ZXN0L3NyYy9t
aWdyYXRpb24vcmFtLmM6IEluIGZ1bmN0aW9uICdjb21wcmVzc19wYWdlX3dpdGhfbXVsdGlfdGhy
ZWFkJzoKL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9yYW0uYzoyMDY0OjI2OiBlcnJvcjog
Y29tcGFyaXNvbiBvZiBjb25zdGFudCAnMicgd2l0aCBib29sZWFuIGV4cHJlc3Npb24gaXMgYWx3
YXlzIGZhbHNlIFstV2Vycm9yPWJvb2wtY29tcGFyZV0KICAgICBhZGFwdGl2ZSA9IChhZGFwdGl2
ZSA9PSBDT01QUkVTU19XQUlUX1RIUkVBRF9BREFQVElWRSk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn4KL3RtcC9xZW11LXRlc3Qvc3JjL21pZ3JhdGlvbi9yYW0uYzoyMDYwOjk6IGVycm9y
OiB1bnVzZWQgdmFyaWFibGUgJ2NvbXByZXNzX3dhaXRfdGhyZWFkJyBbLVdlcnJvcj11bnVzZWQt
dmFyaWFibGVdCiAgICAgaW50IGNvbXByZXNzX3dhaXRfdGhyZWFkID0gbWlncmF0ZV9jb21wcmVz
c193YWl0X3RocmVhZCgpOwogICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fgovdG1wL3FlbXUt
dGVzdC9zcmMvbWlncmF0aW9uL3JhbS5jOjIwNjM6MTA6IGVycm9yOiAnYWRhcHRpdmUnIGlzIHVz
ZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPXVuaW5pdGlhbGl6ZWRd
CiAgICAgd2FpdCA9IChhZGFwdGl2ZSA9PSBDT01QUkVTU19XQUlUX1RIUkVBRF9PTik7CiAgICAg
fn5+fn5efn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwMTExMDYzNzMyLjEwNDg0LTEteGlhb2d1
YW5ncm9uZ0B0ZW5jZW50LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHA6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==
