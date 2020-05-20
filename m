Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650AA20671
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650AA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbR4l-0003cz-Il
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 11:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbR2i-00083E-CE; Wed, 20 May 2020 11:54:04 -0400
Resent-Date: Wed, 20 May 2020 11:54:04 -0400
Resent-Message-Id: <E1jbR2i-00083E-CE@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21783)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbR2g-0001Hj-JU; Wed, 20 May 2020 11:54:04 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589990031; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gxoIY6Cty2fNGCjMW6sTd4pRms56rPkP2fEIL6pSHRQJPf9GBxtAv4j7QKhScEd5QnI5akBD/+vku6YZMu3dt91JBL0JKTEb1gpAxBIhZ58Ye4hQOR95FbRMwJvmajAWNOUMltVdC/5Vja3mv89QvwO6hkTxoDUFx9CzI/CsoQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589990031;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=tx6wVHsfw7OS+dFxLj6lZFIgNEjVcIm6KlEK7Sgzo64=; 
 b=NrFpNn8In5YWCnV2xJbewUkPdwx066YOidFuzooSLT/GIQW0NO+U4BqFM3sn5u6NpAfE7mcyF9oLGqhHpAAAb/ldX+nVRNipHFpJvAkFbjCXiu85e/hJYvA4K9c198cPLFSCO2gVKKWv5vZ2euf5KZEuS9t8PRstFL2SKadWzuo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589990029173269.8900933964204;
 Wed, 20 May 2020 08:53:49 -0700 (PDT)
Message-ID: <158999002740.28633.15086035982719918736@45ef0f9c86ae>
In-Reply-To: <20200520132003.9492-1-kraxel@redhat.com>
Subject: Re: [PATCH v3 00/22] microvm: add acpi support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 20 May 2020 08:53:49 -0700 (PDT)
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
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXItaW1h
Z2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAgIHg4Nl82
NC1zb2Z0bW11L3RhcmdldC9pMzg2L21weF9oZWxwZXIubwogIENDICAgICAgeDg2XzY0LXNvZnRt
bXUvdGFyZ2V0L2kzODYvc2VnX2hlbHBlci5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9pMzg2L2Fj
cGktbWljcm92bS5jOiBJbiBmdW5jdGlvbiAnYnVpbGRfZHNkdF9taWNyb3ZtJzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L2kzODYvYWNwaS1taWNyb3ZtLmM6MTA5OjU6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnZndfY2ZnX2FkZF9hY3BpX2RzZHQnOyBkaWQgeW91IG1l
YW4gJ2Z3X2NmZ19hZGRfZmlsZSc/IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQogICAgIGZ3X2NmZ19hZGRfYWNwaV9kc2R0KHNiX3Njb3BlLCB4ODZtcy0+ZndfY2ZnKTsK
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fgogICAgIGZ3X2NmZ19hZGRfZmlsZQovdG1wL3FlbXUt
dGVzdC9zcmMvaHcvaTM4Ni9hY3BpLW1pY3Jvdm0uYzoxMDk6NTogZXJyb3I6IG5lc3RlZCBleHRl
cm4gZGVjbGFyYXRpb24gb2YgJ2Z3X2NmZ19hZGRfYWNwaV9kc2R0JyBbLVdlcnJvcj1uZXN0ZWQt
ZXh0ZXJuc10KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKICBDQyAg
ICAgIHg4Nl82NC1zb2Z0bW11L3RhcmdldC9pMzg2L3NtbV9oZWxwZXIubwptYWtlWzFdOiAqKiog
Wy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L2kzODYvYWNwaS1taWNyb3ZtLm9d
IEVycm9yIDEKbWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBD
QyAgICAgIGFhcmNoNjQtc29mdG1tdS9ody9hcm0vZGlnaWNfYm9hcmRzLm8KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody9hcm0vZXh5bm9zNF9ib2FyZHMubwotLS0KICBDQyAgICAgIGFhcmNo
NjQtc29mdG1tdS9ody9hcm0vdmV4cHJlc3MubwogIENDICAgICAgYWFyY2g2NC1zb2Z0bW11L2h3
L2FybS94aWxpbnhfenlucS5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvaHcvYXJtL3NhYnJl
bGl0ZS5vCm1ha2U6ICoqKiBbTWFrZWZpbGU6NTI3OiB4ODZfNjQtc29mdG1tdS9hbGxdIEVycm9y
IDIKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFh
cmNoNjQtc29mdG1tdS9ody9hcm0vYXJtdjdtLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS9o
dy9hcm0vZXh5bm9zNDIxMC5vCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNv
ZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vkbycs
ICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVp
ZD04N2U3OTc0NWYyYWU0MmFlOTc0ZWI5YjI0N2Q0YWY3NicsICctdScsICcxMDAzJywgJy0tc2Vj
dXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9M
SVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAn
Sj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9E
SVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRv
Y2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10
ZXN0ZXItdG1wLTQzZmh2YTl0L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjAtMTEuNTAuNDUuMTY3
MTM6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVu
JywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVy
PS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ODdlNzk3NDVmMmFlNDJhZTk3
NGViOWIyNDdkNGFmNzYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06
IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtNDNmaHZhOXQv
c3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJl
YWwgICAgM20xLjYyMnMKdXNlciAgICAwbTcuNDIzcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjAxMzIwMDMuOTQ5Mi0xLWtyYXhl
bEByZWRoYXQuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgot
LS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVk
aGF0LmNvbQ==

