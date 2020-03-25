Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7DC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FBC420714
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 11:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBC420714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH4fA-00041Z-B0
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 07:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jH4eb-0003WF-Uv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jH4ea-0004eG-ST
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 07:57:01 -0400
Resent-Date: Wed, 25 Mar 2020 07:57:01 -0400
Resent-Message-Id: <E1jH4ea-0004eG-ST@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jH4eX-0004aA-Qq; Wed, 25 Mar 2020 07:56:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585137402; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kQibdiL949e0MwlWpNgAiq33aB84LemST6WAau+HTw4mvSWaxUUCGmj5U3JjIdDodqXVxbl2Wq5kuiDeEaGa9ewbyiWe3UKfVwBlbh+NVhQ3OyyPEDpqnZeuh0XzsU6rwVrOKde6FFHVeUN+XxRNVbJF6ZRk5x5cJKtRvvckez4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585137402;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NXkKv+aAHtup5vHkYx5J0SjN/nqv/OXmB3FzwUFjhl0=; 
 b=OuNXQOona55WmUUflSBh91kFicLTjj4VAFxEq7vFGBoEiOrD60hudWb19jt70yjSqVzqm74NdTkVLULWnXSfBSpBL8CnMOgeICTkA+/DjDL0aJrs5yQbEMd/V297SEXeq866xM9Y3FE5/7VE4nUV+M4SrqzRWm1Rs1EqJqt15wM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585137399882842.1460612833691;
 Wed, 25 Mar 2020 04:56:39 -0700 (PDT)
In-Reply-To: <20200325102131.23270-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 0/2] Rework iotests finding
Message-ID: <158513739843.20894.3765515992083292854@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Wed, 25 Mar 2020 04:56:39 -0700 (PDT)
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMyNTEwMjEzMS4yMzI3
MC0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQg
dGhlIGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcg
Vj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VO
Vj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgc19l
cTEyOC5vCi4vY2hlY2s6IGxpbmUgMTcxOiAuL2ZpbmRfdGVzdHMucHk6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKR3JvdXAgImF1dG8iIGlzIGVtcHR5IG9yIG5vdCBkZWZpbmVkPwptYWtlOiAq
KiogW2NoZWNrLXRlc3RzL2NoZWNrLWJsb2NrLnNoXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5n
IGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCiAgQ0MgICAgICBzX2xlMTI4Lm8KICBDQyAgICAgIHNf
bHQxMjgubwotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1
YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9j
a2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZWE3NjJjOTYx
YmVkNDZhZWE0N2NkNjBmZGExOGMwZGUnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcs
ICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUn
LCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUn
LCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3Rt
cC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNo
ZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
bmZfN3l5ZHAvc3JjL2RvY2tlci1zcmMuMjAyMC0wMy0yNS0wNy41My41Mi4yMDk1MTovdmFyL3Rt
cC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3Qt
cXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVy
PWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZWE3NjJjOTYxYmVkNDZhZWE0N2NkNjBmZGEx
OGMwZGUKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcg
ZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtbmZfN3l5ZHAvc3JjJwptYWtl
OiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJt
NDcuMTc4cwp1c2VyICAgIDBtOC4zODdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMyNTEwMjEzMS4yMzI3MC0xLXZzZW1lbnRzb3ZA
dmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

