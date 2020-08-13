Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2525AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E060420855
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E060420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GIT-0007s8-2C
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6GFq-0002Ch-Gj; Thu, 13 Aug 2020 12:39:02 -0400
Resent-Date: Thu, 13 Aug 2020 12:39:02 -0400
Resent-Message-Id: <E1k6GFq-0002Ch-Gj@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6GFk-0002Uc-Un; Thu, 13 Aug 2020 12:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597336721; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aOHQU7E6uv05GZEqku2TAJ2C6ZnNMXDuqARqtKNtmFh8BohXxOQfBJMB3IuEXzcVY4e0W8P0UZ9lSC+ZJE8TGsd3Wvf6F4lQqkv5cfpxd+FDS1LiQSMZpaImwQN3+udFm/e6/ygStTwUfnOEAlYUXI6/To8Y4tHkpK2TFVCkx1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597336721;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=cEJexteia1ydPDabafGK3z8ADJa7J97Kd+S5lqcUZKY=; 
 b=Q0ykR9tkVI94isyh+2awiLYVdOfxwPR/PUGy+cvfdS5PSrieTiqzEW+8JUseMTFc5O3peHjjk0PELlIHi9RzhKwR0/SA76QNDjiNzMCOvX5iwO8dG1Rd92QBoadTheK9pqsuemJdaMY/AT/D2ESnyeRY7nALgSoQb2KnKn0jibE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597336718467522.5794212143501;
 Thu, 13 Aug 2020 09:38:38 -0700 (PDT)
Subject: Re: [RFC 0/9] Support disable/enable CPU features for AArch64
Message-ID: <159733671752.15736.14773440514228826219@66eaa9a8a123>
In-Reply-To: <20200813102657.2588720-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liangpeng10@huawei.com
Date: Thu, 13 Aug 2020 09:38:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:17:15
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, liangpeng10@huawei.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzEwMjY1Ny4yNTg4
NzIwLTEtbGlhbmdwZW5nMTBAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L3RhcmdldC9hcm0vZ2Ric3R1YjY0Lm8KICBDQyAgICAgIGFhcmNoNjQtc29m
dG1tdS90YXJnZXQvYXJtL21hY2hpbmUubwovdG1wL3FlbXUtdGVzdC9zcmMvdGFyZ2V0L2FybS9j
cHUuYzogSW4gZnVuY3Rpb24gJ2FybV9jcHVfc2V0X2JpdF9wcm9wJzoKL3RtcC9xZW11LXRlc3Qv
c3JjL3RhcmdldC9hcm0vY3B1LmM6MTU4Njo1OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24g
b2YgZnVuY3Rpb24gJ2t2bV9hcm1fY3B1X2ZlYXR1cmVfc3VwcG9ydGVkJyBbLVdlcnJvcj1pbXBs
aWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICAgICBpZiAoIWt2bV9hcm1fY3B1X2ZlYXR1cmVf
c3VwcG9ydGVkKCkpIHsKICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy90YXJnZXQvYXJtL2NwdS5j
OjE1ODY6NTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRpb24gb2YgJ2t2bV9hcm1fY3B1
X2ZlYXR1cmVfc3VwcG9ydGVkJyBbLVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KY2MxOiBhbGwgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90
YXJnZXQvYXJtL2FyY2hfZHVtcC5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvdGFyZ2V0L2Fy
bS9tb25pdG9yLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90YXJnZXQvYXJtL2FybS1wb3dl
cmN0bC5vCm1ha2VbMV06ICoqKiBbdGFyZ2V0L2FybS9jcHUub10gRXJyb3IgMQptYWtlWzFdOiAq
KiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgogIENDICAgICAgYWFyY2g2NC1zb2Z0
bW11L3RhcmdldC9hcm0va3ZtLXN0dWIubwptYWtlOiAqKiogW2FhcmNoNjQtc29mdG1tdS9hbGxd
IEVycm9yIDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9NjZjODBjODcyYmY1NGQ1MDg0ZGU1NGZiY2NjNDM1M2MnLCAnLXUnLCAnMTAw
MScsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScs
ICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9
JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2Fj
aGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1w
L3BhdGNoZXctdGVzdGVyLXRtcC14em1fbDlrZi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA4LTEzLTEy
LjM1LjIzLjU1MTk6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3Rt
cC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVz
IDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTY2YzgwYzg3
MmJmNTRkNTA4NGRlNTRmYmNjYzQzNTNjCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3Ig
MQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1w
LXh6bV9sOWtmL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10g
RXJyb3IgMgoKcmVhbCAgICAzbTE1LjAwM3MKdXNlciAgICAwbTguOTU5cwoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTMxMDI2NTcu
MjU4ODcyMC0xLWxpYW5ncGVuZzEwQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2Vu
dG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkg
UGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNr
IHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

