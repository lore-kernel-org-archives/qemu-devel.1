Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7A8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:58:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DB72206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 14:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DB72206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvirC-0003iZ-ON
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 10:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jviqG-0003Fo-Tc
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:57:04 -0400
Resent-Date: Wed, 15 Jul 2020 10:57:04 -0400
Resent-Message-Id: <E1jviqG-0003Fo-Tc@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jviqC-00031H-6u
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 10:57:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594824995; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MOl0W2eDXoRpuuerY56bjS8LD+5v2196g/YKQewuh5WHQyRZ4iUSSCD/ZATP3VXafRdPk0l37UE+G/FLoGLJNiYZ1gbbridh5/v10D21c992OVB87oKP/nCGr5BeGFq5tS2glYfosCTNLAyiXKM74xozK3fEOuOAbfzqJmTkBnM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594824995;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=aVOdD/Qk7lU+C5c0hHDinVRA0WADLneWcXMAEDCX7FU=; 
 b=RIfXPmkwAP9w3N5fV5ww3YK4wA+uYHWrh9FdISNeVlo1/7cP+NYWI23/wdbrwLfwvJnqffGs8cDUEipKjNToyYiyZ/j8rac6nGJre+481Y7mnn5BYHU5C5XdAL+9Fk+1ltUn7HHG5NHyrw0F/FWTZ/nFNybm8X1zsacCbXp5um8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594824992378784.1708087183192;
 Wed, 15 Jul 2020 07:56:32 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] net/colo: Remove unused trace event
Message-ID: <159482499077.11884.3340115804865619987@07a7f0d89f7d>
In-Reply-To: <20200715143130.11164-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Wed, 15 Jul 2020 07:56:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 10:31:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com,
 jasowang@redhat.com, qemu-devel@nongnu.org, chen.zhang@intel.com,
 r.bolshakov@yadro.com, stefanha@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNTE0MzEzMC4xMTE2
NC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkluIGZpbGUgaW5jbHVkZWQgZnJv
bSAvdG1wL3FlbXUtdGVzdC9idWlsZC9uZXQvdHJhY2UuaDo2OjAsCiAgICAgICAgICAgICAgICAg
ZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvbmV0L2NvbG8tY29tcGFyZS5jOjE4OgovdG1wL3FlbXUt
dGVzdC9zcmMvbmV0L2NvbG8tY29tcGFyZS5jOiBJbiBmdW5jdGlvbiAnY29sb19jb21wYXJlX3Bh
Y2tldF9wYXlsb2FkJzoKL3RtcC9xZW11LXRlc3Qvc3JjL25ldC9jb2xvLWNvbXBhcmUuYzozMzA6
NDA6IGVycm9yOiAnVFJBQ0VfQ09MT19DT01QQVJFX01JU0NPTVBBUkVfRU5BQkxFRCcgdW5kZWNs
YXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgICAgaWYgKHRyYWNlX2V2ZW50X2dl
dF9zdGF0ZV9iYWNrZW5kcyhUUkFDRV9DT0xPX0NPTVBBUkVfTUlTQ09NUEFSRSkpIHsKICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3Ry
YWNlL2NvbnRyb2wuaDoxMjA6Nzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAndHJhY2Vf
ZXZlbnRfZ2V0X3N0YXRlX2JhY2tlbmRzJwotLS0KL3RtcC9xZW11LXRlc3Qvc3JjL3RyYWNlL2Nv
bnRyb2wuaDoxMjA6Nzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAndHJhY2VfZXZlbnRf
Z2V0X3N0YXRlX2JhY2tlbmRzJwogICAgICgoaWQgIyNfRU5BQkxFRCkgJiYgaWQgIyNfQkFDS0VO
RF9EU1RBVEUoKSkKICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL25ldC9jb2xvLWNvbXBhcmUu
YzozMzA6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdUUkFDRV9D
T0xPX0NPTVBBUkVfTUlTQ09NUEFSRV9CQUNLRU5EX0RTVEFURScgWy1XZXJyb3I9aW1wbGljaXQt
ZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICAgaWYgKHRyYWNlX2V2ZW50X2dldF9zdGF0ZV9iYWNr
ZW5kcyhUUkFDRV9DT0xPX0NPTVBBUkVfTUlTQ09NUEFSRSkpIHsKICAgICBeCi90bXAvcWVtdS10
ZXN0L3NyYy9uZXQvY29sby1jb21wYXJlLmM6MzMwOjU6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRl
Y2xhcmF0aW9uIG9mICdUUkFDRV9DT0xPX0NPTVBBUkVfTUlTQ09NUEFSRV9CQUNLRU5EX0RTVEFU
RScgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3Fl
bXUtdGVzdC9idWlsZC9uZXQvdHJhY2UuaDo2OjAsCiAgICAgICAgICAgICAgICAgZnJvbSAvdG1w
L3FlbXUtdGVzdC9zcmMvbmV0L2NvbG8tY29tcGFyZS5jOjE4OgovdG1wL3FlbXUtdGVzdC9zcmMv
bmV0L2NvbG8tY29tcGFyZS5jOiBJbiBmdW5jdGlvbiAnY29sb19jb21wYXJlX3RjcCc6Ci90bXAv
cWVtdS10ZXN0L3NyYy9uZXQvY29sby1jb21wYXJlLmM6NDk1OjQ0OiBlcnJvcjogJ1RSQUNFX0NP
TE9fQ09NUEFSRV9NSVNDT01QQVJFX0VOQUJMRUQnIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0
aGlzIGZ1bmN0aW9uKQogICAgICAgICBpZiAodHJhY2VfZXZlbnRfZ2V0X3N0YXRlX2JhY2tlbmRz
KFRSQUNFX0NPTE9fQ09NUEFSRV9NSVNDT01QQVJFKSkgewogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL3RyYWNlL2NvbnRyb2wu
aDoxMjA6Nzogbm90ZTogaW4gZGVmaW5pdGlvbiBvZiBtYWNybyAndHJhY2VfZXZlbnRfZ2V0X3N0
YXRlX2JhY2tlbmRzJwogICAgICgoaWQgIyNfRU5BQkxFRCkgJiYgaWQgIyNfQkFDS0VORF9EU1RB
VEUoKSkKICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL25ldC9jb2xvLWNvbXBhcmUuYzogSW4g
ZnVuY3Rpb24gJ2NvbG9fcGFja2V0X2NvbXBhcmVfdWRwJzoKL3RtcC9xZW11LXRlc3Qvc3JjL25l
dC9jb2xvLWNvbXBhcmUuYzo1MzY6NDQ6IGVycm9yOiAnVFJBQ0VfQ09MT19DT01QQVJFX01JU0NP
TVBBUkVfRU5BQkxFRCcgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAg
ICAgICAgIGlmICh0cmFjZV9ldmVudF9nZXRfc3RhdGVfYmFja2VuZHMoVFJBQ0VfQ09MT19DT01Q
QVJFX01JU0NPTVBBUkUpKSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvdHJhY2UvY29udHJvbC5oOjEyMDo3OiBub3RlOiBp
biBkZWZpbml0aW9uIG9mIG1hY3JvICd0cmFjZV9ldmVudF9nZXRfc3RhdGVfYmFja2VuZHMnCiAg
ICAgKChpZCAjI19FTkFCTEVEKSAmJiBpZCAjI19CQUNLRU5EX0RTVEFURSgpKQogICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvbmV0L2NvbG8tY29tcGFyZS5jOiBJbiBmdW5jdGlvbiAnY29sb19w
YWNrZXRfY29tcGFyZV9pY21wJzoKL3RtcC9xZW11LXRlc3Qvc3JjL25ldC9jb2xvLWNvbXBhcmUu
Yzo1Nzk6NDQ6IGVycm9yOiAnVFJBQ0VfQ09MT19DT01QQVJFX01JU0NPTVBBUkVfRU5BQkxFRCcg
dW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgICAgICAgIGlmICh0cmFj
ZV9ldmVudF9nZXRfc3RhdGVfYmFja2VuZHMoVFJBQ0VfQ09MT19DT01QQVJFX01JU0NPTVBBUkUp
KSB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3Fl
bXUtdGVzdC9zcmMvdHJhY2UvY29udHJvbC5oOjEyMDo3OiBub3RlOiBpbiBkZWZpbml0aW9uIG9m
IG1hY3JvICd0cmFjZV9ldmVudF9nZXRfc3RhdGVfYmFja2VuZHMnCiAgICAgKChpZCAjI19FTkFC
TEVEKSAmJiBpZCAjI19CQUNLRU5EX0RTVEFURSgpKQogICAgICAgXgovdG1wL3FlbXUtdGVzdC9z
cmMvbmV0L2NvbG8tY29tcGFyZS5jOiBJbiBmdW5jdGlvbiAnY29sb19wYWNrZXRfY29tcGFyZV9v
dGhlcic6Ci90bXAvcWVtdS10ZXN0L3NyYy9uZXQvY29sby1jb21wYXJlLmM6NjAwOjQwOiBlcnJv
cjogJ1RSQUNFX0NPTE9fQ09NUEFSRV9NSVNDT01QQVJFX0VOQUJMRUQnIHVuZGVjbGFyZWQgKGZp
cnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKQogICAgIGlmICh0cmFjZV9ldmVudF9nZXRfc3RhdGVf
YmFja2VuZHMoVFJBQ0VfQ09MT19DT01QQVJFX01JU0NPTVBBUkUpKSB7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy90cmFjZS9jb250
cm9sLmg6MTIwOjc6IG5vdGU6IGluIGRlZmluaXRpb24gb2YgbWFjcm8gJ3RyYWNlX2V2ZW50X2dl
dF9zdGF0ZV9iYWNrZW5kcycKICAgICAoKGlkICMjX0VOQUJMRUQpICYmIGlkICMjX0JBQ0tFTkRf
RFNUQVRFKCkpCiAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJy
b3JzCm1ha2U6ICoqKiBbbmV0L2NvbG8tY29tcGFyZS5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0
aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBs
YXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDcwMiwgaW4gPG1v
ZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tl
cicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlkPWIzNjNjNTY2YzIx
MjQ2M2Q4OWZjNmJjNDdlZjYwY2Y5JywgJy11JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAn
c2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywg
J0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywg
J0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAv
Y2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTov
dmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNXB5
ZmwwX3cvc3JjL2RvY2tlci1zcmMuMjAyMC0wNy0xNS0xMC41My4zMi4xMDc2MTovdmFyL3RtcC9x
ZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVp
Y2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxh
YmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjM2M2M1NjZjMjEyNDYzZDg5ZmM2YmM0N2VmNjBj
ZjkKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGly
ZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNXB5ZmwwX3cvc3JjJwptYWtlOiAq
KiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtNTku
Njkycwp1c2VyICAgIDBtNy44ODlzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDcxNTE0MzEzMC4xMTE2NC0xLXBoaWxtZEByZWRoYXQu
Y29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

