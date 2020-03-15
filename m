Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EF3C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E12820637
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E12820637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUHI-0000Wl-3l
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jDUFP-0008FT-MY
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jDUFN-0003GE-Kl
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:28:10 -0400
Resent-Date: Sun, 15 Mar 2020 10:28:10 -0400
Resent-Message-Id: <E1jDUFN-0003GE-Kl@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jDUFN-00031p-C9
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:28:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584282469; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YfHlUsQtoHX9Wwtqj5Z/g83UD+Fu8eWL5qgaLd8FOxr8jyY0lMSwFiqY29eSapd6t5rKOqG1EY4duUDvhIgwfezsgFkFP8cW39wcNyhTe/otnvXB0qRqqSxqX3z584ufg/uypulToKOFznFP4WdNbtJOcUwrdTJXCnxd7rJ8I6I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584282469;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=svpp2fM1Dxup8W9KQnePvSYJvdYxC+ihtS+1PnLMhdk=; 
 b=BL708RqVsBLUokuywiIH+nc8P5oINHh3G4k8uhOXyS+NKqc5Gi3bpBnWmQ7tlS5tOg9+6sawgxyAB2HwMoNOguLtx2yjkzb9z0A13LD7q5fZo0xUx4SCOHs3BSnZlgqYa+/8HaQ7k6QbacaHir1rbMqNVY8Du18yYufjBTjBlKs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584282467927470.0982075803738;
 Sun, 15 Mar 2020 07:27:47 -0700 (PDT)
In-Reply-To: <20200315132634.113632-1-liran.alon@oracle.com>
Subject: Re: [PATCH] hw/scsi/vmw_pvscsi: Remove assertion for kick after reset
Message-ID: <158428246664.6054.5545383030315021183@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liran.alon@oracle.com
Date: Sun, 15 Mar 2020 07:27:47 -0700 (PDT)
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
Cc: fam@euphon.net, dmitry.fleytman@gmail.com, elazar@vastdata.com,
 qemu-devel@nongnu.org, liran.alon@oracle.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxNTEzMjYzNC4xMTM2
MzItMS1saXJhbi5hbG9uQG9yYWNsZS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRo
ZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2Nr
ZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3
QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IHJlcGxheS9yZXBsYXkubwogIENDICAgICAgcmVwbGF5L3JlcGxheS1pbnRlcm5hbC5vCi90bXAv
cWVtdS10ZXN0L3NyYy9ody9zY3NpL3Ztd19wdnNjc2kuYzogSW4gZnVuY3Rpb24gJ3B2c2NzaV9w
cm9jZXNzX2lvJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3Njc2kvdm13X3B2c2NzaS5jOjcyMzo5
OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ3FlbXVfbG9nJzsgZGlk
IHlvdSBtZWFuICdxZW11X2ZvcmsnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0KICAgICAgICAgcWVtdV9sb2coIldBUk5JTkc6IFBWU0NTSTogQ2Fubm90IHByb2Nlc3Mg
SS9PIHdoZW4gIgogICAgICAgICBefn5+fn5+fgogICAgICAgICBxZW11X2ZvcmsKL3RtcC9xZW11
LXRlc3Qvc3JjL2h3L3Njc2kvdm13X3B2c2NzaS5jOjcyMzo5OiBlcnJvcjogbmVzdGVkIGV4dGVy
biBkZWNsYXJhdGlvbiBvZiAncWVtdV9sb2cnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpjYzE6
IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAvcWVt
dS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGh3L3Njc2kvdm13X3B2c2NzaS5vXSBFcnJvciAxCm1h
a2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFjayAobW9zdCBy
ZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5l
IDY2NCwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29k
ZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydzdWRvJywg
Jy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5jZS51dWlk
PWI2MGZlMGRmZmUyYjQ0N2ViMDZhN2Y5ZjQ2ZDlmNWFhJywgJy11JywgJzEwMDEnLCAnLS1zZWN1
cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAnVEFSR0VUX0xJ
U1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScsICctZScsICdK
PTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0nLCAnLWUnLCAnQ0NBQ0hFX0RJ
Uj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldy8uY2FjaGUvcWVtdS1kb2Nr
ZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVz
dGVyLXRtcC1zYWtnMXBrcC9zcmMvZG9ja2VyLXNyYy4yMDIwLTAzLTE1LTEwLjI1LjM4LjY2Nzc6
L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywg
J3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0t
ZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YjYwZmUwZGZmZTJiNDQ3ZWIwNmE3
ZjlmNDZkOWY1YWEKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExl
YXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtc2FrZzFwa3Avc3Jj
JwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwg
ICAgMm04LjE4MHMKdXNlciAgICAwbTguOTM3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTUxMzI2MzQuMTEzNjMyLTEtbGlyYW4u
YWxvbkBvcmFjbGUuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

