Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094C6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:47:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D3920656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 21:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D3920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8Yw-0005JQ-2o
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 17:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8Xc-0004q6-IA; Wed, 10 Jun 2020 17:45:48 -0400
Resent-Date: Wed, 10 Jun 2020 17:45:48 -0400
Resent-Message-Id: <E1jj8Xc-0004q6-IA@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21723)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jj8Xa-0003Q0-OP; Wed, 10 Jun 2020 17:45:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591825512; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NL9EGRtMnBXXB/l7ouJiOsmSMZAhNl+jizlFw+0jRaULaVLWOpoEJTIKKOSdYQGvcnhUUN7YwB98zMlllcn0IaX5IL5FI3HuC/MPkw8jb3rVG1CBpm/ZjKWLBLBluKzBSVZ/T7vvhsai071EvphqpANj5jDtiOUGJ96OGOCnHhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591825512;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8mnqv85NzxmTpX+5mbp4duklVeHdvR1H/IxMUkULCpE=; 
 b=CEKALNcSIumTzCxG1LGuqX5pu76lQYen4E8V30TLRuzdw7vDRoKAAtP31vmLQBja5CTPwJRa+ckUfj273UIh0/WvMj8GrgA1ISUxSc8evOBGKZI+obnXdvIIBLN3sC7k6jThnt3Cxb9Sf8tdq6YNHGk/sicmJKZbQAR1ZlM2i/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 159182550897387.3303959993907;
 Wed, 10 Jun 2020 14:45:08 -0700 (PDT)
Message-ID: <159182550752.21115.6563901076401435753@45ef0f9c86ae>
In-Reply-To: <cover.1591801197.git.berto@igalia.com>
Subject: Re: [PATCH v8 00/34] Add subcluster allocation to qcow2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Wed, 10 Jun 2020 14:45:08 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 16:25:39
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, dereksu@qnap.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTkxODAxMTk3Lmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBibG9jay92aGR4Lm8K
ICBDQyAgICAgIGJsb2NrL3ZoZHgtZW5kaWFuLm8KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fj
b3cyLWNsdXN0ZXIuYzogSW4gZnVuY3Rpb24gJ3Fjb3cyX2dldF9ob3N0X29mZnNldCc6Ci90bXAv
cWVtdS10ZXN0L3NyYy9ibG9jay9xY293Mi1jbHVzdGVyLmM6NDczOjE5OiBlcnJvcjogJ2V4cGVj
dGVkX3R5cGUnIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdl
cnJvcj1tYXliZS11bmluaXRpYWxpemVkXQogICAgICAgICB9IGVsc2UgaWYgKHR5cGUgIT0gZXhw
ZWN0ZWRfdHlwZSkgewogICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svcWNvdzItY2x1c3Rlci5jOjQ0OToyNTogbm90ZTogJ2V4cGVjdGVkX3R5cGUnIHdhcyBkZWNs
YXJlZCBoZXJlCiAgICAgUUNvdzJTdWJjbHVzdGVyVHlwZSBleHBlY3RlZF90eXBlLCB0eXBlOwog
ICAgICAgICAgICAgICAgICAgICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzIt
Y2x1c3Rlci5jOjQ3NToxOTogZXJyb3I6ICdjaGVja19vZmZzZXQnIG1heSBiZSB1c2VkIHVuaW5p
dGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVdlcnJvcj1tYXliZS11bmluaXRpYWxpemVkXQog
ICAgICAgICB9IGVsc2UgaWYgKGNoZWNrX29mZnNldCkgewogICAgICAgICAgICAgICAgICAgXgov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0NzoxMDogbm90ZTogJ2No
ZWNrX29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAgICBib29sIGNoZWNrX29mZnNldDsKICAg
ICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3Fjb3cyLWNsdXN0ZXIuYzo0NzY6Mjk6
IGVycm9yOiAnZXhwZWN0ZWRfb2Zmc2V0JyBtYXkgYmUgdXNlZCB1bmluaXRpYWxpemVkIGluIHRo
aXMgZnVuY3Rpb24gWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0KICAgICAgICAgICAgIGV4
cGVjdGVkX29mZnNldCArPSBzLT5jbHVzdGVyX3NpemU7CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXgovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svcWNvdzItY2x1c3Rlci5jOjQ0ODoxNDog
bm90ZTogJ2V4cGVjdGVkX29mZnNldCcgd2FzIGRlY2xhcmVkIGhlcmUKICAgICB1aW50NjRfdCBl
eHBlY3RlZF9vZmZzZXQ7CiAgICAgICAgICAgICAgXgpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogW2Jsb2NrL3Fjb3cyLWNsdXN0ZXIub10gRXJyb3Ig
MQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpUcmFjZWJhY2sgKG1v
c3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5Iiwg
bGluZSA2NjUsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJl
dGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3Vk
bycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2Uu
dXVpZD0wODA0NDdlMTYwNDc0NGZiOTM0YzZlOWEwMjEwZWQzNicsICctdScsICcxMDAzJywgJy0t
c2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdF
VF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUn
LCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FD
SEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVt
dS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNo
ZXctdGVzdGVyLXRtcC15cnE5cDZici9zcmMvZG9ja2VyLXNyYy4yMDIwLTA2LTEwLTE3LjQyLjIw
LjI0ODUwOi92YXIvdG1wL3FlbXU6eixybycsICdxZW11OmNlbnRvczcnLCAnL3Zhci90bXAvcWVt
dS9ydW4nLCAndGVzdC1xdWljayddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAyLgpm
aWx0ZXI9LS1maWx0ZXI9bGFiZWw9Y29tLnFlbXUuaW5zdGFuY2UudXVpZD0wODA0NDdlMTYwNDc0
NGZiOTM0YzZlOWEwMjEwZWQzNgptYWtlWzFdOiAqKiogW2RvY2tlci1ydW5dIEVycm9yIDEKbWFr
ZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15cnE5
cDZici9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LXF1aWNrQGNlbnRvczddIEVycm9y
IDIKCnJlYWwgICAgMm00Ny42MDFzCnVzZXIgICAgMG04LjM4NHMKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1OTE4MDExOTcuZ2l0
LmJlcnRvQGlnYWxpYS5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

