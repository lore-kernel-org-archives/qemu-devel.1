Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53732C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19AAB20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AAB20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR1H-0004ZD-9j
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbR02-0003Mf-AI; Wed, 20 May 2020 11:51:18 -0400
Resent-Date: Wed, 20 May 2020 11:51:18 -0400
Resent-Message-Id: <E1jbR02-0003Mf-AI@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbR01-0000x7-A1; Wed, 20 May 2020 11:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589989864; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Sq2IumZuMjuIkXavPiLjhmfzBV+alRxLtI9a1to5s2SvMro+260fQN5+p7zFPzRIK9uXHWdP85mtl0Zia6QjFPmfdtMwvOzVb1MwHs2ot/9wuizLLYsBA3z5Yn8nEaJxqN755XkTIAmJkKoR+Zw2pQVWjlSUif+GL0/wRVorMbg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589989864;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=kvG/xc8qLWNUixNV/yixiBZVw0nrnv0dTpj5BxZwcsc=; 
 b=fLOMMfXqVMOAdh2ZuclZh6XPpJnM3ZqfS/5Jznt7DL0I7dEKlbtdn+wTjaNaTFu4Fein3EQ8dE8kebAlIbk8GZD2tQvgig3GV+9hJJS2t7E+YSuHcpuvTd/xd6QcznGTeWxPSCl6lIBEvUMBQPucCDeM2bl3N2uAT44kIIhBJww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589989863036885.7347107396688;
 Wed, 20 May 2020 08:51:03 -0700 (PDT)
Message-ID: <158998986130.28633.17320473596623319635@45ef0f9c86ae>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
Subject: Re: [PATCH v3 00/22] microvm: add acpi support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 20 May 2020 08:51:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 11:46:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMDEzMjAwMy45NDky
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5F
VFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4
Nl82NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgeDg2XzY0LXNvZnRtbXUvaHcvaTM4Ni94ZW4veGVuX3B2ZGV2aWNlLm8KICBDQyAgICAg
IHg4Nl82NC1zb2Z0bW11L2h3L2kzODYveGVuL3hlbi1odm0ubwogIENDICAgICAgeDg2XzY0LXNv
ZnRtbXUvaHcvaTM4Ni94ZW4veGVuLW1hcGNhY2hlLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2h3L2kz
ODYvYWNwaS1taWNyb3ZtLmM6MTA5OjU6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBm
dW5jdGlvbiAnZndfY2ZnX2FkZF9hY3BpX2RzZHQnIGlzIGludmFsaWQgaW4gQzk5IFstV2Vycm9y
LC1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgICBmd19jZmdfYWRkX2FjcGlfZHNk
dChzYl9zY29wZSwgeDg2bXMtPmZ3X2NmZyk7CiAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9p
Mzg2L2FjcGktbWljcm92bS5jOjEwOTo1OiBlcnJvcjogdGhpcyBmdW5jdGlvbiBkZWNsYXJhdGlv
biBpcyBub3QgYSBwcm90b3R5cGUgWy1XZXJyb3IsLVdzdHJpY3QtcHJvdG90eXBlc10KMiBlcnJv
cnMgZ2VuZXJhdGVkLgptYWtlWzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6
Njk6IGh3L2kzODYvYWNwaS1taWNyb3ZtLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcg
Zm9yIHVuZmluaXNoZWQgam9icy4uLi4KbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IHg4Nl82NC1z
b2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+CiAg
ICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD0zNjIwZjBjZjYzNDk0NDVmYjQyYTA5OGVkNmVmNDBjOCcsICctdScsICcxMDAxJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPXg4Nl82NC1zb2Z0bW11JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScs
ICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAn
LWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1sYzBnYW84My9zcmMvZG9ja2VyLXNyYy4yMDIwLTA1LTIw
LTExLjQ3LjA1Ljk4MjU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtZGVidWcnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzYyMGYw
Y2Y2MzQ5NDQ1ZmI0MmEwOThlZDZlZjQwYzgKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtbGMwZ2FvODMvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1kZWJ1Z0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgM201Ni4yNjRzCnVzZXIgICAgMG04LjU1MXMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTIwMTMyMDAz
Ljk0OTItMS1rcmF4ZWxAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=

