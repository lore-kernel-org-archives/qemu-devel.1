Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449C0C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B6F20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B6F20725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw9J-000771-C1
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtw8e-0006EB-3x; Fri, 10 Jul 2020 12:44:40 -0400
Resent-Date: Fri, 10 Jul 2020 12:44:40 -0400
Resent-Message-Id: <E1jtw8e-0006EB-3x@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jtw8b-0001Dy-Qk; Fri, 10 Jul 2020 12:44:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594399441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SSF1qLFv1HgqyCO6C77RFwE7DiKZbazb2aqp+X9KJAbO6eWYYVOn/mdCT8XRmkeC/O8C9vDJHlhV6SUnhqWD/1E+/l5YnKJFeQSqgnvo+E9Rq+lXYME7AbzpGZ6/hsRItDebmWC4df1dS3azzUBQLNQOBIi+B/2M2/XvsHLLDUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594399441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=SOt8y5D6j3cwQlAlMUHSuXLAcEd12HHLwssoL22+tmY=; 
 b=m1yRobwJ0qRAipnykr85k0ay7k0yZ+5qvKXXQgKVsoQ2DezXeNjk3Bplx1olAk44NyDh4F3b+5pBY7C60GNK8h408mlLBtXng8Ev8wumGNd7nzDPy0aYpJbaxxmmQdMGSNsRns14SM+pnXaUIuAx0x4Gkbz17Ai5BO3+AO+9Kws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594399439508874.9946948004671;
 Fri, 10 Jul 2020 09:43:59 -0700 (PDT)
Subject: Re: [PATCH v11 00/34] Add subcluster allocation to qcow2
Message-ID: <159439943791.29400.15842099914457064806@07a7f0d89f7d>
In-Reply-To: <cover.1594396418.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Fri, 10 Jul 2020 09:43:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 12:44:35
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTk0Mzk2NDE4Lmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay9zbmFwc2hv
dC5vCiAgQ0MgICAgICBibG9jay9xYXBpLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cy
LWNsdXN0ZXIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2dldF9ob3N0X29mZnNldCc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDczOjE5OiBlcnJvcjogJ2V4cGVjdGVk
X3R5cGUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJv
cj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYgKHR5cGUgIT0gZXhwZWN0
ZWRfdHlwZSkgewogICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2sv
cWNvdzItY2x1c3Rlci5jOjQ0OToyNTogbm90ZTogJ2V4cGVjdGVkX3R5cGUnIHdhcyBkZWNsYXJl
ZCBoZXJlCiAgICAgUUNvdzJTdWJjbHVzdGVyVHlwZSBleHBlY3RlZF90eXBlLCB0eXBlOwogICAg
ICAgICAgICAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFz
IGVycm9ycwptYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLWNsdXN0ZXIub10gRXJyb3IgMQptYWtlOiAq
KiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50
IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2Njks
IGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNt
ZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbics
ICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD0xMDYy
MzE0M2VlZjA0MTZiOWMzYjk4N2VmYTY2MjFhMScsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHkt
b3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScs
ICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcs
ICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElSPS92
YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXIt
Y2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVy
LXRtcC16ZDZwMWU4Zy9zcmMvZG9ja2VyLXNyYy4yMDIwLTA3LTEwLTEyLjQwLjQ1LjI3MDU2Oi92
YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVtdS9ydW4nLCAn
dGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpmaWx0ZXI9LS1m
aWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0xMDYyMzE0M2VlZjA0MTZiOWMzYjk4
N2VmYTY2MjFhMQptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFrZVsxXTogTGVh
dmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC16ZDZwMWU4Zy9zcmMn
Cm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9yIDIKCnJlYWwg
ICAgM20xMy4zOTVzCnVzZXIgICAgMG04Ljc3OHMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTQzOTY0MTguZ2l0LmJlcnRvQGln
YWxpYS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==

