Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7269AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E672076E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E672076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joXXb-0004iM-5u
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joXWx-000495-Mb; Thu, 25 Jun 2020 15:27:27 -0400
Resent-Date: Thu, 25 Jun 2020 15:27:27 -0400
Resent-Message-Id: <E1joXWx-000495-Mb@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1joXWv-0006hP-1N; Thu, 25 Jun 2020 15:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593113230; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JAJDibsMHKqw249qJgCjqMS6dKVzUKJSgER1UXu9s6UdVolTkvadBLuCb8tgrANicvR48NsQvo9pOb0dV/Zpy3M2uS0w8I6z5b+ppQ7vnJaAaiayiOKTA1rF2L29P24XvUXJ/BWXMBOe9/iCvy3H3KYNW6/9L756fRPYOQswyQM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593113230;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=PKlQIMn1HNsoooLu//TLxgR4c+DUicsUg5EhawXvCOc=; 
 b=fvxfW6ouwMPsQs+Lpyp4gMKT+VV6gu1LiY3RqybtjlNgE+08LewwRhqFl1O0NlbspjSmMf7zCoC2TQ2yH6RR8la5FQeI4tNmRHfGV5ssb9/zVcVi5Heg2h6M2uQsgxZBDTs/Eg89FK05UYpSK8RKejnlUPbUSlEOIOkTeo/weRc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593113227508728.4050489268816;
 Thu, 25 Jun 2020 12:27:07 -0700 (PDT)
Message-ID: <159311322605.25974.4543808913481072992@d1fd068a5071>
Subject: Re: [PATCH 00/17] block/nvme: Various cleanups required to use
 multiple queues
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 25 Jun 2020 12:27:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 15:27:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com,
 mlevitsk@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNTE4NDgzOC4yODE3
Mi0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay93cml0
ZS10aHJlc2hvbGQubwogIENDICAgICAgYmxvY2svYmFja3VwLm8KL3RtcC9xZW11LXRlc3Qvc3Jj
L2Jsb2NrL252bWUuYzogSW4gZnVuY3Rpb24gJ252bWVfaWRlbnRpZnknOgovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svbnZtZS5jOjQ1NTo1OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2Yg
ZnVuY3Rpb24gJ01BWF9DT05TVCcgWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRp
b25dCiAgICAgaWRzel9tYXggPSBNQVhfQ09OU1Qoc2l6ZW9mKE52bWVJZEN0cmwpLCBzaXplb2Yo
TnZtZUlkTnMpKTsKICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9udm1lLmM6NDU1OjU6
IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdNQVhfQ09OU1QnIFstV2Vycm9y
PW5lc3RlZC1leHRlcm5zXQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9y
cwptYWtlOiAqKiogW2Jsb2NrL252bWUub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3Ig
dW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAg
RmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjksIGluIDxtb2R1bGU+Ci0t
LQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5D
YWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVu
JywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0zMGM3MmY3ODI1MTM0ZjViYTY5
ZDQ1YjBjZWM2ZjcyYScsICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9
dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9D
T05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0n
LCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScs
ICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAv
Y2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWhubjgyeXdyL3Ny
Yy9kb2NrZXItc3JjLjIwMjAtMDYtMjUtMTUuMjQuMTEuNjU4NjovdmFyL3RtcC9xZW11Onoscm8n
LCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0
dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5x
ZW11Lmluc3RhbmNlLnV1aWQ9MzBjNzJmNzgyNTEzNGY1YmE2OWQ0NWIwY2VjNmY3MmEKbWFrZVsx
XTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAv
dmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtaG5uODJ5d3Ivc3JjJwptYWtlOiAqKiogW2RvY2tl
ci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDJtNTUuMjMwcwp1c2Vy
ICAgIDBtOC41MTdzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hl
dy5vcmcvbG9ncy8yMDIwMDYyNTE4NDgzOC4yODE3Mi0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3Rp
bmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

