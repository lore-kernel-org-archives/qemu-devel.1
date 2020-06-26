Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:05:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB517207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB517207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jormu-0007q4-3s
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jordB-0003TU-SG; Fri, 26 Jun 2020 12:55:13 -0400
Resent-Date: Fri, 26 Jun 2020 12:55:13 -0400
Resent-Message-Id: <E1jordB-0003TU-SG@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jord8-0002Lr-Vo; Fri, 26 Jun 2020 12:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593190502; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n7zyYJ/mA8MN4LyNgZQyQnHSoyEbJBxHcfDV75Q4a0Qgl83RID6aFIb0pH9c4bZu36ktld1KQ0xZmQ8mMZwllUDNrxrrUQLL34yyplUPs1XlRLZdypCf6sKbp5LMoQf8hV3/rZgdILBJIoYh7o8Zgwyy+QZqk9e91k8Qz/OCBmk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593190502;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=/G1HHTAn9Erj73s7iIjWVj8DrCNS2L53zb+WH9bCDG4=; 
 b=aXv0A7EfH14S/AkRyohq1kbFPqvqy2wYn/qTyDsQhPEDRlfBNlsp/xA8crcDAd7IGm7mpLcsTilb26qvglpSbeitXMlm3FIIlCRLIiCf3SsDzJjcLZX/Psfyn07LLpANCopVnp0iOlxCESALjHpiMLW0/jlo+pbFdspXAdJU69Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593190498586714.4483658571467;
 Fri, 26 Jun 2020 09:54:58 -0700 (PDT)
Message-ID: <159319049741.28361.678833118142958021@d1fd068a5071>
Subject: Re: [PATCH v4 00/14] hw/sd/sdcard: Fix CVE-2020-13253 & cleanups
In-Reply-To: <20200626162818.25840-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Fri, 26 Jun 2020 09:54:58 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 11:53:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyNjE2MjgxOC4yNTg0
MC0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRvY2tl
ci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0xIE5FVFdP
Uks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0xIEo9MTQg
TkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
L3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvcWVtdS9vc2RlcC5oOjEwMTowLAogICAgICAgICAg
ICAgICAgIGZyb20gL3RtcC9xZW11LXRlc3Qvc3JjL2h3L3NkL3NkLmM6MzM6Ci90bXAvcWVtdS10
ZXN0L3NyYy9ody9zZC9zZC5jOiBJbiBmdW5jdGlvbiAnc2RfYWRkcl90b193cG51bSc6Ci90bXAv
cWVtdS10ZXN0L3NyYy9ody9zZC9zZC5jOjU0NjoxOTogZXJyb3I6ICdzZCcgdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pCiAgICAgYXNzZXJ0KGFkZHIgPCBzZC0+c2l6ZSk7
CiAgICAgICAgICAgICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9zZC9zZC5jOjU0Njox
OTogbm90ZTogZWFjaCB1bmRlY2xhcmVkIGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQgb25seSBvbmNl
IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4KbWFrZTogKioqIFtody9zZC9zZC5vXSBF
cnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uClRyYWNlYmFj
ayAobW9zdCByZWNlbnQgY2FsbCBsYXN0KToKICBGaWxlICIuL3Rlc3RzL2RvY2tlci9kb2NrZXIu
cHkiLCBsaW5lIDY2OSwgaW4gPG1vZHVsZT4KLS0tCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJy
b3IocmV0Y29kZSwgY21kKQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAn
WydzdWRvJywgJy1uJywgJ2RvY2tlcicsICdydW4nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0
YW5jZS51dWlkPWVhNmNkZWQwMTcxYzRiYzRiZDNmZTk3MWZlMGI4NmJiJywgJy11JywgJzEwMDMn
LCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy0tcm0nLCAnLWUnLCAn
VEFSR0VUX0xJU1Q9JywgJy1lJywgJ0VYVFJBX0NPTkZJR1VSRV9PUFRTPScsICctZScsICdWPScs
ICctZScsICdKPTE0JywgJy1lJywgJ0RFQlVHPScsICctZScsICdTSE9XX0VOVj0xJywgJy1lJywg
J0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNo
ZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAv
cGF0Y2hldy10ZXN0ZXItdG1wLWZ2eDE0eWVmL3NyYy9kb2NrZXItc3JjLjIwMjAtMDYtMjYtMTIu
NTIuNDguMTY4NzovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1w
L3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMg
Mi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZWE2Y2RlZDAx
NzFjNGJjNGJkM2ZlOTcxZmUwYjg2YmIKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAx
Cm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAt
ZnZ4MTR5ZWYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBF
cnJvciAyCgpyZWFsICAgIDJtMTAuMDAycwp1c2VyICAgIDBtNy45NzhzCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyNjE2MjgxOC4y
NTg0MC0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3Lz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t

