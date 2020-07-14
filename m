Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB70BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBCC2242B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBCC2242B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvO9r-000587-Ue
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvO87-0003RU-IZ; Tue, 14 Jul 2020 12:50:07 -0400
Resent-Date: Tue, 14 Jul 2020 12:50:07 -0400
Resent-Message-Id: <E1jvO87-0003RU-IZ@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jvO84-0007jX-TD; Tue, 14 Jul 2020 12:50:07 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594745384; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ckNfL97PpBRTwrNCwUngucORUyi8FkG4qWZds4HqGKZcs6fJmPufY51nWAZ7phqc5krqzs53UYl0EdOk/1r+QCikulDb7oLYYVsj2iRjckp9kJfgrTDL6djKxJc0qnai/x86OGEwSFbuxVD9AiQuPE5vtal6DZnFokfALwHz2MQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594745384;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Cgg4DiCLKae9zPREeIY8NxSl5zaPjVrND2Naz04HD74=; 
 b=dJauAscXDL0DZlzHJ741APnmNZ5hWYv9hhMCKCF481cLOn/3c/xOfqCrj9tt95g3v3/lKny/DY8u/p7+q8/z9G7QzZyHDaq+r6EYBxpX28FaUyecqq80n/TvDRjY5Vk9nsARDzCXMu5ZEtczYt7nm9/EhTcVw6Sdxm3s+9qbJPY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594745382041462.7678445644432;
 Tue, 14 Jul 2020 09:49:42 -0700 (PDT)
Subject: Re: [PATCH v3 for-5.1 0/2] Fix crash due to NBD export leak
Message-ID: <159474538053.11884.16567641221376136360@07a7f0d89f7d>
In-Reply-To: <20200714162234.13113-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Tue, 14 Jul 2020 09:49:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:50:01
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxNDE2MjIzNC4xMzEx
My0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAwMjIKICBURVNUICAgIGNoZWNrLXVuaXQ6IHRlc3RzL3Rlc3QtY2hhcgoqKgpF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvdGVzdC1jaGFyLmM6MTIwNDpjaGFyX3Nlcmlh
bF90ZXN0OiAnY2hyJyBzaG91bGQgbm90IGJlIE5VTEwKRVJST1IgdGVzdC1jaGFyIC0gQmFpbCBv
dXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy90ZXN0LWNoYXIuYzoxMjA0OmNoYXJf
c2VyaWFsX3Rlc3Q6ICdjaHInIHNob3VsZCBub3QgYmUgTlVMTAptYWtlOiAqKiogW2NoZWNrLXVu
aXRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBU
RVNUICAgIGlvdGVzdC1xY293MjogMDI0CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyNQotLS0K
ICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2Fs
bGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bics
ICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9OWRjMmM3YTZlM2ViNDU4Yzg4ZmRk
NmJlNmEwM2M2ZWInLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVu
Y29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09O
RklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9Jywg
Jy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAn
LXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9j
Y2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZnp2aXhraW8vc3Jj
L2RvY2tlci1zcmMuMjAyMC0wNy0xNC0xMi4zMi41My4xOTY5NzovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdS9jZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9OWRjMmM3YTZlM2ViNDU4Yzg4ZmRkNmJlNmEwM2M2ZWIKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZnp2aXhraW8vc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE2bTQ4LjM5NnMKdXNl
ciAgICAwbTguNzQxcwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDA3MTQxNjIyMzQuMTMxMTMtMS12c2VtZW50c292QHZpcnR1b3p6by5j
b20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

