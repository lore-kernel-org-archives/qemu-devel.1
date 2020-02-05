Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D26C33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:33:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB04D2082E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 10:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB04D2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izHzQ-0002px-4r
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 05:33:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1izHyf-000222-7A
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1izHyc-0000Qr-Gv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:32:12 -0500
Resent-Date: Wed, 05 Feb 2020 05:32:12 -0500
Resent-Message-Id: <E1izHyc-0000Qr-Gv@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1izHyc-0000F7-6y
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 05:32:10 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580898719245158.98863128422738;
 Wed, 5 Feb 2020 02:31:59 -0800 (PST)
In-Reply-To: <20200205095737.20153-1-felipe@nutanix.com>
Subject: Re: [PATCH v2] fence: introduce a file-based self-fence mechanism
Message-ID: <158089871764.7235.3552025439003901886@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: felipe@nutanix.com
Date: Wed, 5 Feb 2020 02:31:59 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 marcandre.lureau@gmail.com, stefanha@redhat.com, felipe@nutanix.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwNTA5NTczNy4yMDE1
My0xLWZlbGlwZUBudXRhbml4LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgaHcvYWNwaS9u
dmRpbW0ubwogIENDICAgICAgaHcvYWNwaS92bWdlbmlkLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jh
Y2tlbmRzL2ZpbGUtZmVuY2UuYzogSW4gZnVuY3Rpb24gJ2ZpbGVfZmVuY2VfaW5zdGFuY2VfaW5p
dCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9iYWNrZW5kcy9maWxlLWZlbmNlLmM6MzQzOjM2OiBlcnJv
cjogJ09CSl9QUk9QX0ZMQUdfUkVBRFdSSVRFJyB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhp
cyBmdW5jdGlvbikKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKX1BST1Bf
RkxBR19SRUFEV1JJVEUsICZlcnJvcl9hYm9ydCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2JhY2tlbmRzL2ZpbGUtZmVuY2UuYzozNDM6
MzY6IG5vdGU6IGVhY2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25j
ZSBmb3IgZWFjaCBmdW5jdGlvbiBpdCBhcHBlYXJzIGluCi90bXAvcWVtdS10ZXN0L3NyYy9iYWNr
ZW5kcy9maWxlLWZlbmNlLmM6MzQzOjM2OiBlcnJvcjogdG9vIG1hbnkgYXJndW1lbnRzIHRvIGZ1
bmN0aW9uICdvYmplY3RfcHJvcGVydHlfYWRkX3VpbnQzMl9wdHInCkluIGZpbGUgaW5jbHVkZWQg
ZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0X2ludGVyZmFjZXMuaDo0
OjAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvYmFja2VuZHMvZmls
ZS1mZW5jZS5jOjI2OgovdG1wL3FlbXUtdGVzdC9zcmMvaW5jbHVkZS9xb20vb2JqZWN0Lmg6MTcw
OTo2OiBub3RlOiBkZWNsYXJlZCBoZXJlCiB2b2lkIG9iamVjdF9wcm9wZXJ0eV9hZGRfdWludDMy
X3B0cihPYmplY3QgKm9iaiwgY29uc3QgY2hhciAqbmFtZSwKICAgICAgXgovdG1wL3FlbXUtdGVz
dC9zcmMvYmFja2VuZHMvZmlsZS1mZW5jZS5jOjM0NTozNjogZXJyb3I6IHRvbyBtYW55IGFyZ3Vt
ZW50cyB0byBmdW5jdGlvbiAnb2JqZWN0X3Byb3BlcnR5X2FkZF91aW50MzJfcHRyJwogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpfUFJPUF9GTEFHX1JFQURXUklURSwgJmVy
cm9yX2Fib3J0KTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgpJbiBmaWxl
IGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdF9pbnRl
cmZhY2VzLmg6NDowLAotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcW9tL29iamVjdC5o
OjE3MDk6Njogbm90ZTogZGVjbGFyZWQgaGVyZQogdm9pZCBvYmplY3RfcHJvcGVydHlfYWRkX3Vp
bnQzMl9wdHIoT2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKm5hbWUsCiAgICAgIF4KbWFrZTogKioq
IFtiYWNrZW5kcy9maWxlLWZlbmNlLm9dIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVu
ZmluaXNoZWQgam9icy4uLi4Kcm0gdGVzdHMvcWVtdS1pb3Rlc3RzL3NvY2tldF9zY21faGVscGVy
Lm8KVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgotLS0KICAgIHJhaXNlIENhbGxl
ZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9y
OiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2Nv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9ZmQ0MWM3ZTE2NWI2NGU5ODgzMDdhZWE4ZGE2NDczZDgnLCAn
LXUnLCAnMTAwMScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1y
bScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9Jywg
Jy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5W
PTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0
Y2hldy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12Jywg
Jy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0wZzg1OXFlaC9zcmMvZG9ja2VyLXNyYy4yMDIw
LTAyLTA1LTA1LjI5LjU3LjcwNzk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycs
ICcvdmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4
aXQgc3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlk
PWZkNDFjN2UxNjViNjRlOTg4MzA3YWVhOGRhNjQ3M2Q4Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1
bl0gRXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTBnODU5cWVoL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tA
Y2VudG9zN10gRXJyb3IgMgoKcmVhbCAgICAybTAuOTg1cwp1c2VyICAgIDBtOC40OTJzCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDIw
NTA5NTczNy4yMDE1My0xLWZlbGlwZUBudXRhbml4LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0Bj
ZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

