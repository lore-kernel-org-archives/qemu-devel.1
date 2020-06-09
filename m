Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E01C433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF3820734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF3820734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiiUM-0004B2-AH
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jii8L-0007KE-Al; Tue, 09 Jun 2020 13:33:57 -0400
Resent-Date: Tue, 09 Jun 2020 13:33:57 -0400
Resent-Message-Id: <E1jii8L-0007KE-Al@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jii8I-0004Dt-Lw; Tue, 09 Jun 2020 13:33:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591724028; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TOKyYx16lOy4l/pRzv/kaEerUx8NuSLyOi4dOgn+mgm/y3/X57R4ZpybzWRELjQWv3EQPohMAUru7gjybt74XhC3jnHJXh1RRF2Jd27O3UQLdj3XqY2C/i1J9gbTHsDEboVOfhJheHJgbcXVPz/ZCOLJlr3CR9xabT4hUYeXGPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591724028;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=mnW2MVPZYNdgfYl0ICSjboG80BvQnB2/G3+i3zDWgoQ=; 
 b=LoNuPpe0tDoSRP4EOaweM/UVw5Wy6no3c+BE4PfAEB/uUfbsAnSgIGAiX7OiT8pcJc8iG8ivCeZ5vUw9+btsket6+pI6GTxFxLW/U1KfyEVybmRlhaFpgBlMj+GHBnNHYzAAmycZdOumFffAPpoq3f1+xLw6rISPAxPbYULWs9M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591724026548264.4181294856311;
 Tue, 9 Jun 2020 10:33:46 -0700 (PDT)
Message-ID: <159172402544.16186.646924471583906715@45ef0f9c86ae>
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
Subject: Re: [PATCH 0/7] target/arm: Convert Neon 3-reg-diff to decodetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: peter.maydell@linaro.org
Date: Tue, 9 Jun 2020 10:33:46 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 13:01:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwOTE2MDIwOS4yOTk2
MC0xLXBldGVyLm1heWRlbGxAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRv
Y2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWlu
Z3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAg
ICAgYWFyY2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vcHNjaS5vCiAgQ0MgICAgICBhYXJjaDY0LXNv
ZnRtbXUvdGFyZ2V0L2FybS90cmFuc2xhdGUtYTY0Lm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS90YXJnZXQvYXJtL2hlbHBlci1hNjQubwovdG1wL3FlbXUtdGVzdC9zcmMvdGFyZ2V0L2FybS9u
ZW9uLWRwLmRlY29kZTo0MTk6IGVycm9yOiAoJ2RlZmluaXRpb24gaGFzIDAgYml0cycsKQptYWtl
WzFdOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQvYXJtL01ha2VmaWxlLm9ianM6Mjc6
IHRhcmdldC9hcm0vZGVjb2RlLW5lb24tZHAuaW5jLmNdIEVycm9yIDEKbWFrZVsxXTogKioqIFdh
aXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBHRU4gICAgIHg4Nl82NC1zb2Z0bW11L3Fl
bXUtc3lzdGVtLXg4Nl82NC5leGUKbWFrZTogKioqIFtNYWtlZmlsZTo1Mjc6IGFhcmNoNjQtc29m
dG1tdS9hbGxdIEVycm9yIDIKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZp
bGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY1LCBpbiA8bW9kdWxlPgogICAg
c3lzLmV4aXQobWFpbigpKQotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2Rl
LCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAn
LW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9
NjllYjY1YjQ4MTNkNDA4Mjk3NGUxOTQ1ZTMxYWRjMjInLCAnLXUnLCAnMTAwMScsICctLXNlY3Vy
aXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElT
VD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9
MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElS
PS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tl
ci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLW9razdyNGp5L3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMDktMTMuMzAuMjAuMjEwNDU6
L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywg
J3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0t
ZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NjllYjY1YjQ4MTNkNDA4Mjk3NGUx
OTQ1ZTMxYWRjMjIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtb2trN3I0ankvc3Jj
JwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwg
ICAgM20yNS4yMjNzCnVzZXIgICAgMG05LjEwNnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjA5MTYwMjA5LjI5OTYwLTEtcGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

