Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:30:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF1220709
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 22:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF1220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8A84-0004Yf-Gq
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 18:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8A6w-0003yz-1t
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 18:29:45 -0400
Resent-Date: Tue, 18 Aug 2020 18:29:42 -0400
Resent-Message-Id: <E1k8A6w-0003yz-1t@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21360)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k8A6q-0003rc-4K
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 18:29:41 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597789768; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oFBnGeV5NbUoMnbBxxd/vhk5qeUoZqJ4uyt3hzzY8fM5bXeasxZiIyc0S4QYaZdZizKE3lPwMbrnpuydtRhzWLhMFiMVbK1iOpLBIzoBO+fPFGVLnh80xtWI+GLxLwdRf6uAEAaEoWkk05ZzktjnA6ZdXOeCoqgwJWguSc6SxI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597789768;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=K7QOtZnXf3qEBQUycBQtlphezV5xinrE9UcI6t8jqGc=; 
 b=MnMpgqJCJhyVMDanwC4IOLSNKFyqOR6fHreLLhyA/342Uy+fkztxUL3IIuy5a0h3Gpl+Oqnhe32TyP/n06rBHD7uaHaGqOK0X26GH0Wdjqm31UQSquu8/MgHU5rGkN4oRugxXxjPGl1xildEyB1FL/ky3Dqnt3mRLQPpcX7uGiY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597789765646912.4984699521467;
 Tue, 18 Aug 2020 15:29:25 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/4] Use ACPI PCI hot-plug for q35
Message-ID: <159778976444.22935.6701290302185889931@66eaa9a8a123>
In-Reply-To: <20200818215227.181654-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jusual@redhat.com
Date: Tue, 18 Aug 2020 15:29:25 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 18:29:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: imammedo@redhat.com, mst@redhat.com, jusual@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxODIxNTIyNy4xODE2
NTQtMS1qdXN1YWxAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgphY3BpLXRlc3Q6IFdhcm5pbmch
IERTRFQgYmluYXJ5IGZpbGUgbWlzbWF0Y2guIEFjdHVhbCBbYW1sOi90bXAvYW1sLUJGQkNQMF0s
IEV4cGVjdGVkIFthbWw6dGVzdHMvZGF0YS9hY3BpL3BjL0RTRFRdLgpTZWUgc291cmNlIGZpbGUg
dGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jIGZvciBpbnN0cnVjdGlvbnMgb24gaG93IHRv
IHVwZGF0ZSBleHBlY3RlZCBmaWxlcy4KdG8gc2VlIEFTTCBkaWZmIGJldHdlZW4gbWlzbWF0Y2hl
ZCBmaWxlcyBpbnN0YWxsIElBU0wsIHJlYnVpbGQgUUVNVSBmcm9tIHNjcmF0Y2ggYW5kIHJlLXJ1
biB0ZXN0cyB3aXRoIFY9MSBlbnZpcm9ubWVudCB2YXJpYWJsZSBzZXQqKgpFUlJPUjovdG1wL3Fl
bXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC5jOjQ5NDp0ZXN0X2FjcGlf
YXNsOiBhc3NlcnRpb24gZmFpbGVkOiAoYWxsX3RhYmxlc19tYXRjaCkKRVJST1IgYmlvcy10YWJs
ZXMtdGVzdCAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3Qv
Ymlvcy10YWJsZXMtdGVzdC5jOjQ5NDp0ZXN0X2FjcGlfYXNsOiBhc3NlcnRpb24gZmFpbGVkOiAo
YWxsX3RhYmxlc19tYXRjaCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRdIEVycm9yIDEK
bWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KcWVtdS1zeXN0ZW0tYWFy
Y2g2NDogLWFjY2VsIGt2bTogaW52YWxpZCBhY2NlbGVyYXRvciBrdm0KcWVtdS1zeXN0ZW0tYWFy
Y2g2NDogZmFsbGluZyBiYWNrIHRvIHRjZwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJv
cihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdb
J3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3Rh
bmNlLnV1aWQ9ODlhNzRjY2MxYmIwNDE5Nzg1NWFjMzQ4YmQ1YjEwNmEnLCAnLXUnLCAnMTAwMycs
ICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdU
QVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9Jywg
Jy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAn
Q0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hl
L3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9w
YXRjaGV3LXRlc3Rlci10bXAtMGhuMTJmMWUvc3JjL2RvY2tlci1zcmMuMjAyMC0wOC0xOC0xOC4x
Ni4zNy4yMTYwNDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ODlhNzRjY2Mx
YmIwNDE5Nzg1NWFjMzQ4YmQ1YjEwNmEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
MGhuMTJmMWUvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDEybTQ3LjQ4N3MKdXNlciAgICAwbTguNjY4cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTgyMTUyMjcu
MTgxNjU0LTEtanVzdWFsQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

