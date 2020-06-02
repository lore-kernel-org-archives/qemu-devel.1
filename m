Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE3BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:57:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419A5206A2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419A5206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1nZ-0007wj-DT
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:57:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1mw-0007QT-Iy
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:56:47 -0400
Resent-Date: Tue, 02 Jun 2020 03:56:46 -0400
Resent-Message-Id: <E1jg1mw-0007QT-Iy@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jg1mu-00032R-UR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:56:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591084597; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WFzaXWNAXgKW1D19Kk2/Js3SccMdklBleioFLrSsby0rMWO5J7lVRR80E7LrgUbFq5KS1sXmJtVR3SSMXiOFKQPuT6oPR7W4kgyXX3DdMP7yiMofQ9pf5RVSBv9LZXYq29gBETD5gi0GW2k5UhOE0CMBB/u/hm2AdcUs/PGkHZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591084597;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O+p9U0v2mZ0qh8nFG8PRsdkVNeMPvUTqkJF+5+2DYvo=; 
 b=LhCNIR5qqsbjG1zkAgc8JmTUA+tt6C6iHCvrNzDQ81Jm2smob9DVbnBHSySsAxHi4cADitBa6j27LYy+HNthSsGSXxUxDYmLty/F1kl9sk4jK9Y4cHui9wVYFy+oa0dKwu9H+YZ4WZJOeMtF4uLrA3ZAEp1U9lCcilZem7h6o6U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591084595534167.6205385398215;
 Tue, 2 Jun 2020 00:56:35 -0700 (PDT)
Message-ID: <159108459438.18153.8235209596502644579@45ef0f9c86ae>
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
Subject: Re: [PATCH 0/4] Add Support for GET LBA STATUS 16 command in scsi
 emulation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lma@suse.com
Date: Tue, 2 Jun 2020 00:56:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 03:52:38
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 lma@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwMjA3NDIwMS4xMDg3
OS0xLWxtYUBzdXNlLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tlci1t
aW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMg
YW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91
IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJ
TiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1pbWFnZS1m
ZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIEo9
MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYmxvY2svcmVw
bGljYXRpb24ubwogIENDICAgICAgYmxvY2svdGhyb3R0bGUubwovdG1wL3FlbXUtdGVzdC9zcmMv
YmxvY2svYmxvY2stYmFja2VuZC5jOiBJbiBmdW5jdGlvbiAnYmxrX2RvX2dldF9sYmFfc3RhdHVz
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjY2OjEyOiBlcnJv
cjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2JkcnZfY29fZ2V0X2xiYV9zdGF0
dXMnOyBkaWQgeW91IG1lYW4gJ2Jsa19kb19nZXRfbGJhX3N0YXR1cyc/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgIHJldHVybiBiZHJ2X2NvX2dldF9sYmFfc3Rh
dHVzKGJsay0+cm9vdCwgb2Zmc2V0LCBieXRlcywgbnVtX2Jsb2NrcywKICAgICAgICAgICAgXn5+
fn5+fn5+fn5+fn5+fn5+fn5+fgogICAgICAgICAgICBibGtfZG9fZ2V0X2xiYV9zdGF0dXMKL3Rt
cC9xZW11LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjY2OjEyOiBlcnJvcjogbmVz
dGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYmRydl9jb19nZXRfbGJhX3N0YXR1cycgWy1XZXJy
b3I9bmVzdGVkLWV4dGVybnNdCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9ibG9jay1iYWNrZW5k
LmM6IEluIGZ1bmN0aW9uICdibGtfYWlvX2dldF9sYmFfc3RhdHVzX2VudHJ5JzoKL3RtcC9xZW11
LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjc2OjMzOiBlcnJvcjogZGVyZWZlcmVu
Y2luZyAndm9pZCAqJyBwb2ludGVyIFstV2Vycm9yXQogICAgIHVpbnQzMl90ICpudW1fYmxvY2tz
ID0gJmRhdGFbMF07CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11
LXRlc3Qvc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoxNjc3OjM3OiBlcnJvcjogZGVyZWZlcmVu
Y2luZyAndm9pZCAqJyBwb2ludGVyIFstV2Vycm9yXQogICAgIHVpbnQzMl90ICppc19kZWFsbG9j
YXRlZCA9ICZkYXRhW3NpemVvZih1aW50MzJfdCldOwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwpt
YWtlOiAqKiogWy90bXAvcWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IGJsb2NrL2Jsb2NrLWJh
Y2tlbmQub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4u
LgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzoyMTkwOjE6IGVycm9yOiBubyBwcmV2aW91
cyBwcm90b3R5cGUgZm9yICdiZHJ2X2NvX2dldF9sYmFfc3RhdHVzJyBbLVdlcnJvcj1taXNzaW5n
LXByb3RvdHlwZXNdCiBiZHJ2X2NvX2dldF9sYmFfc3RhdHVzKEJkcnZDaGlsZCAqY2hpbGQsIGlu
dDY0X3Qgb2Zmc2V0LCBpbnQ2NF90IGJ5dGVzLAogXn5+fn5+fn5+fn5+fn5+fn5+fn5+fgovdG1w
L3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzogSW4gZnVuY3Rpb24gJ2JkcnZfY29fZ2V0X2xiYV9z
dGF0dXMnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svaW8uYzoyMTk0Ojk6IGVycm9yOiAncmV0
JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRoaXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5
YmUtdW5pbml0aWFsaXplZF0KICAgICBpbnQgcmV0OwogICAgICAgICBefn4KY2MxOiBhbGwgd2Fy
bmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9z
cmMvcnVsZXMubWFrOjY5OiBibG9jay9pby5vXSBFcnJvciAxClRyYWNlYmFjayAobW9zdCByZWNl
bnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIucHkiLCBsaW5lIDY2
NSwgaW4gPG1vZHVsZT4KICAgIHN5cy5leGl0KG1haW4oKSkKLS0tCiAgICByYWlzZSBDYWxsZWRQ
cm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjog
Q29tbWFuZCAnWydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20u
cWVtdS5pbnN0YW5jZS51dWlkPTEzMGFiNzUyODg2YTRkOTE4MDhkMjVlZWYwZmIyYjE5JywgJy11
JywgJzEwMDEnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0n
LCAnLWUnLCAnVEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICct
ZScsICdWPScsICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0n
LCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hl
dy8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92
YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC1nN2MwcDBiZC9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2
LTAyLTAzLjU0LjI4LjIzOTA1Oi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmZlZG9yYScsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LW1pbmd3J10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTEz
MGFiNzUyODg2YTRkOTE4MDhkMjVlZWYwZmIyYjE5Cm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLWc3YzBwMGJkL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtbWluZ3dAZmVk
b3JhXSBFcnJvciAyCgpyZWFsICAgIDJtNS40MzRzCnVzZXIgICAgMG04LjAyOXMKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjAyMDc0
MjAxLjEwODc5LTEtbG1hQHN1c2UuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

