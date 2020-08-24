Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F943C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:47:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097BE2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097BE2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACos-0005eJ-9Y
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kACoG-000593-35; Mon, 24 Aug 2020 09:46:52 -0400
Resent-Date: Mon, 24 Aug 2020 09:46:52 -0400
Resent-Message-Id: <E1kACoG-000593-35@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kACoC-0005Dg-WA; Mon, 24 Aug 2020 09:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1598276788; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WDhWXs7DV9TfITk8mmergaS/CMi7Q6NNRWWoe7mFaQBYi/GSsxTkoULp24cnvhOIdCTNY56OVnfiw0O1c13rZ55Q6UqorAgvYlPrOBazfMaMvg+MCPi9J9p9tqOlWHAcHJ4+pwvAoW/GxBhQ+MgZnR2EzUAuQzLDIVTjRBTBkxI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1598276788;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Xzb3CATqXQ8P82QK2uh0Pe8f1Loq6kauZvpfLM1wGu8=; 
 b=R7wEoUMvRIRdMrVaWffQU0PmQjb+JYhmPl27IYzSr1BbJvwI0cbRFjMDgNMFYVpHuBSFAClIocWtspQaVHz5hhmCAr1eSUCYcbAbCQTnxMaNGYl9y5/jGGimkOnqar1+ZicPpqsGTNIkRf1m0t9St6C0TQ/1okewzohTWBC/cDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1598276779606663.9780897068258;
 Mon, 24 Aug 2020 06:46:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] vhost-user-blk: fix the migration issue and
 enhance qtests
Message-ID: <159827677810.4840.11660607816285381932@66eaa9a8a123>
In-Reply-To: <cover.1598257838.git.dimastep@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dimastep@yandex-team.ru
Date: Mon, 24 Aug 2020 06:46:19 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 09:46:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 fengli@smartx.com, yc-core@yandex-team.ru, pbonzini@redhat.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTk4MjU3ODM4Lmdp
dC5kaW1hc3RlcEB5YW5kZXgtdGVhbS5ydS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpDIGxpbmtlciBmb3IgdGhl
IGhvc3QgbWFjaGluZTogY2MgbGQuYmZkIDIuMjctNDMKSG9zdCBtYWNoaW5lIGNwdSBmYW1pbHk6
IHg4Nl82NApIb3N0IG1hY2hpbmUgY3B1OiB4ODZfNjQKLi4vc3JjL21lc29uLmJ1aWxkOjk6IFdB
Uk5JTkc6IE1vZHVsZSB1bnN0YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJk
cyBjb21wYXRpYmlsaXR5IGFuZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQ
cm9ncmFtIHNoIGZvdW5kOiBZRVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmlu
L3B5dGhvbjMpCkMrKyBjb21waWxlciBmb3IgdGhlIGhvc3QgbWFjaGluZTogYysrIChnY2MgNC44
LjUgImMrKyAoR0NDKSA0LjguNSAyMDE1MDYyMyAoUmVkIEhhdCA0LjguNS0zOSkiKQotLS0KICAg
ICAgICAgICAgIExpbnV4IGtleXJpbmc6IFlFUwoKRm91bmQgbmluamF0b29sLTEuOCBhdCAvdG1w
L3FlbXUtdGVzdC9idWlsZC9uaW5qYXRvb2wKV0FSTklORzogY3VzdG9tX3RhcmdldCAnc2hhcmVk
IFFBUEkgc291cmNlIGZpbGVzJyBoYXMgbW9yZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBm
aXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90YXJnZXQgJ1FHQSBRQVBJIGZpbGVzJyBoYXMgbW9y
ZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBmaXJzdCBvbmUuCldBUk5JTkc6IGN1c3RvbV90
YXJnZXQgJ1FBUEkgZmlsZXMgZm9yIHFlbXUtc3RvcmFnZS1kYWVtb24nIGhhcyBtb3JlIHRoYW4g
b25lIG91dHB1dCEgVXNpbmcgdGhlIGZpcnN0IG9uZS4KV0FSTklORzogY3VzdG9tX3RhcmdldCAn
UUFQSSBkb2MnIGhhcyBtb3JlIHRoYW4gb25lIG91dHB1dCEgVXNpbmcgdGhlIGZpcnN0IG9uZS4K
V0FSTklORzogY3VzdG9tX3RhcmdldCAnZGJ1cy12bXN0YXRlIGRlc2NyaXB0aW9uJyBoYXMgbW9y
ZSB0aGFuIG9uZSBvdXRwdXQhIFVzaW5nIHRoZSBmaXJzdCBvbmUuCkNvbW1hbmQgbGluZSBmb3Ig
YnVpbGRpbmcgWydsaWJjb21tb24uZmEnXSBpcyBsb25nLCB1c2luZyBhIHJlc3BvbnNlIGZpbGUK
Q29tbWFuZCBsaW5lIGZvciBidWlsZGluZyBbJ2xpYnFlbXUtYWFyY2g2NC1zb2Z0bW11LmZhJ10g
aXMgbG9uZywgdXNpbmcgYSByZXNwb25zZSBmaWxlCkNvbW1hbmQgbGluZSBmb3IgYnVpbGRpbmcg
WydxZW11LXN5c3RlbS1hYXJjaDY0J10gaXMgbG9uZywgdXNpbmcgYSByZXNwb25zZSBmaWxlCi0t
LQpMaW5raW5nIHN0YXRpYyB0YXJnZXQgaHcvY29yZS9saWJod2NvcmUuZmEKTGlua2luZyBzdGF0
aWMgdGFyZ2V0IGNoYXJkZXYvbGliY2hhcmRldi5mYQouLi9zcmMvdGVzdHMvcXRlc3Qvdmhvc3Qt
dXNlci10ZXN0LmM6IEluIGZ1bmN0aW9uICd0ZXN0X3JlY29ubmVjdCc6Ci4uL3NyYy90ZXN0cy9x
dGVzdC92aG9zdC11c2VyLXRlc3QuYzo5MzU6OTogZXJyb3I6ICducScgbWF5IGJlIHVzZWQgdW5p
bml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFstV2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRd
CiAgICAgaW50IG5xOwogICAgICAgICBeCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQg
YXMgZXJyb3JzCm1ha2U6ICoqKiBbdGVzdHMvcXRlc3QvcW9zLXRlc3QucC92aG9zdC11c2VyLXRl
c3QuYy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4u
ClRyYWNlYmFjayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tl
ci9kb2NrZXIucHkiLCBsaW5lIDcwOSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPWIzYWRkYjE5MGNhNzRjMzZhY2RiYjcyMDU3OTIyNjRhJywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0x
JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNo
ZXcvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtYjZpeGxwZXUvc3JjL2RvY2tlci1zcmMuMjAyMC0w
OC0yNC0wOS40MS40OC4xMTY1ODovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3Jywg
Jy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhp
dCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
YjNhZGRiMTkwY2E3NGMzNmFjZGJiNzIwNTc5MjI2NGEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVu
XSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRl
c3Rlci10bXAtYjZpeGxwZXUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0Bj
ZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDRtMjkuODIxcwp1c2VyICAgIDBtMjEuMTU5cwoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIu
MTU5ODI1NzgzOC5naXQuZGltYXN0ZXBAeWFuZGV4LXRlYW0ucnUvdGVzdGluZy5kb2NrZXItcXVp
Y2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

