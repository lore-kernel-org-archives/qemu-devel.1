Return-Path: <SRS0=PST1=DE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20785C4346E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66FA321775
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2020 13:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66FA321775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMWj6-0001ns-EE
	for qemu-devel@archiver.kernel.org; Sun, 27 Sep 2020 09:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMWiG-0001NL-GC
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:27:36 -0400
Resent-Date: Sun, 27 Sep 2020 09:27:36 -0400
Resent-Message-Id: <E1kMWiG-0001NL-GC@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMWiD-0005qU-3N
 for qemu-devel@nongnu.org; Sun, 27 Sep 2020 09:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601213229; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=JSP7S4TSGhO9BAge43V9EEMOIqtIztJ5auVWNmUJBeQbXOZBk8VyK/IBIBJ7+lN3mgbPyozBgUksOLWXKxF6XiP3cz4YiRRAM8uzh1yzZW+Ka0ar3mfR5fY1GLFAG7StXztBY8FNEuOypaelF+6vIv1q7JgjC7TYfro480NFpYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601213229;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xLaGoJ19HtYs/6vVIe7TBJtN7mg3qnKsv1p8Sz4FzXE=; 
 b=lYjCz7+6vrE6gjtR8E1WjcyG/mXrbkIICgjy+JA9VIfwMQqyi/k1unfaYdJW47U0libQQu1src2xPdfVoRTWms8YeMVBxke0axi3kfHcTkqpfdfiyr+EgKLwbQFYhnDOHAkGdnDNHfN2pPVakvWKd6FwwApY1hmUmCfog2xgzpM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601213227460895.3415333887567;
 Sun, 27 Sep 2020 06:27:07 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] block-backend: Introduce I/O hang
Message-ID: <160121322563.10465.3212908504726492132@66eaa9a8a123>
In-Reply-To: <20200927130420.1095-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: fangying1@huawei.com
Date: Sun, 27 Sep 2020 06:27:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/27 09:27:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, fangying1@huawei.com, mreitz@redhat.com,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNzEzMDQyMC4xMDk1
LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBkb2NrZXIt
aW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZl
ZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKSG9zdCBtYWNoaW5l
IGNwdTogeDg2XzY0ClRhcmdldCBtYWNoaW5lIGNwdSBmYW1pbHk6IHg4NgpUYXJnZXQgbWFjaGlu
ZSBjcHU6IHg4Nl82NAouLi9zcmMvbWVzb24uYnVpbGQ6MTA6IFdBUk5JTkc6IE1vZHVsZSB1bnN0
YWJsZS1rZXl2YWwgaGFzIG5vIGJhY2t3YXJkcyBvciBmb3J3YXJkcyBjb21wYXRpYmlsaXR5IGFu
ZCBtaWdodCBub3QgZXhpc3QgaW4gZnV0dXJlIHJlbGVhc2VzLgpQcm9ncmFtIHNoIGZvdW5kOiBZ
RVMKUHJvZ3JhbSBweXRob24zIGZvdW5kOiBZRVMgKC91c3IvYmluL3B5dGhvbjMpCkNvbmZpZ3Vy
aW5nIG5pbmphdG9vbCB1c2luZyBjb25maWd1cmF0aW9uCi0tLQpDb21waWxpbmcgQyBvYmplY3Qg
bGliYmxvY2suZmEucC9ibG9ja192ZGkuYy5vYmoKQ29tcGlsaW5nIEMgb2JqZWN0IGxpYmJsb2Nr
LmZhLnAvYmxvY2tfY2xvb3AuYy5vYmoKLi4vc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzogSW4g
ZnVuY3Rpb24gJ2Jsa19uZXcnOgouLi9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOjM4Njo1OiBl
cnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2F0b21pY19zZXQnOyBkaWQg
eW91IG1lYW4gJ3FhdG9taWNfc2V0Jz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFy
YXRpb25dCiAgMzg2IHwgICAgIGF0b21pY19zZXQoJmJsay0+cmVpbmZvLmluX2ZsaWdodCwgMCk7
CiAgICAgIHwgICAgIF5+fn5+fn5+fn4KICAgICAgfCAgICAgcWF0b21pY19zZXQKLi4vc3JjL2Js
b2NrL2Jsb2NrLWJhY2tlbmQuYzozODY6NTogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFyYXRp
b24gb2YgJ2F0b21pY19zZXQnIFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lzLXJvb3QvbWluZ3cvbGliL2dsaWIt
Mi4wL2luY2x1ZGUvZ2xpYmNvbmZpZy5oOjksCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL3g4
Nl82NC13NjQtbWluZ3czMi9zeXMtcm9vdC9taW5ndy9pbmNsdWRlL2dsaWItMi4wL2dsaWIvZ3R5
cGVzLmg6MzIsCiAgICAgICAgICAgICAgICAgZnJvbSAvdXNyL3g4Nl82NC13NjQtbWluZ3czMi9z
eXMtcm9vdC9taW5ndy9pbmNsdWRlL2dsaWItMi4wL2dsaWIvZ2FsbG9jYS5oOjMyLAotLS0KICAg
ICAgICAgICAgICAgICBmcm9tIC90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL3FlbXUvb3NkZXAu
aDoxMjYsCiAgICAgICAgICAgICAgICAgZnJvbSAuLi9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5j
OjEzOgouLi9zcmMvYmxvY2svYmxvY2stYmFja2VuZC5jOiBJbiBmdW5jdGlvbiAnYmxrX2RlbGV0
ZSc6Ci4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6NDc5OjEyOiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2F0b21pY19yZWFkJzsgZGlkIHlvdSBtZWFuICdxYXRv
bWljX3JlYWQnPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KICA0Nzkg
fCAgICAgYXNzZXJ0KGF0b21pY19yZWFkKCZibGstPnJlaW5mby5pbl9mbGlnaHQpID09IDApOwog
ICAgICB8ICAgICAgICAgICAgXn5+fn5+fn5+fn4KL3Vzci94ODZfNjQtdzY0LW1pbmd3MzIvc3lz
LXJvb3QvbWluZ3cvaW5jbHVkZS9nbGliLTIuMC9nbGliL2dtYWNyb3MuaDo5Mjg6ODogbm90ZTog
aW4gZGVmaW5pdGlvbiBvZiBtYWNybyAnX0dfQk9PTEVBTl9FWFBSJwotLS0KLi4vc3JjL2Jsb2Nr
L2Jsb2NrLWJhY2tlbmQuYzo0Nzk6NTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdhc3Nl
cnQnCiAgNDc5IHwgICAgIGFzc2VydChhdG9taWNfcmVhZCgmYmxrLT5yZWluZm8uaW5fZmxpZ2h0
KSA9PSAwKTsKICAgICAgfCAgICAgXn5+fn5+Ci4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6
NDc5OjEyOiBlcnJvcjogbmVzdGVkIGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYXRvbWljX3JlYWQn
IFstV2Vycm9yPW5lc3RlZC1leHRlcm5zXQogIDQ3OSB8ICAgICBhc3NlcnQoYXRvbWljX3JlYWQo
JmJsay0+cmVpbmZvLmluX2ZsaWdodCkgPT0gMCk7CiAgICAgIHwgICAgICAgICAgICBefn5+fn5+
fn5+fgovdXNyL3g4Nl82NC13NjQtbWluZ3czMi9zeXMtcm9vdC9taW5ndy9pbmNsdWRlL2dsaWIt
Mi4wL2dsaWIvZ21hY3Jvcy5oOjkyODo4OiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICdf
R19CT09MRUFOX0VYUFInCi0tLQogIDQ3OSB8ICAgICBhc3NlcnQoYXRvbWljX3JlYWQoJmJsay0+
cmVpbmZvLmluX2ZsaWdodCkgPT0gMCk7CiAgICAgIHwgICAgIF5+fn5+fgouLi9zcmMvYmxvY2sv
YmxvY2stYmFja2VuZC5jOiBJbiBmdW5jdGlvbiAnYmxrX3JlaGFuZGxlX2luc2VydF9haW9jYic6
Ci4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6MjQ1OTo1OiBlcnJvcjogaW1wbGljaXQgZGVj
bGFyYXRpb24gb2YgZnVuY3Rpb24gJ2F0b21pY19pbmMnOyBkaWQgeW91IG1lYW4gJ3FhdG9taWNf
aW5jJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAyNDU5IHwgICAg
IGF0b21pY19pbmMoJmJsay0+cmVpbmZvLmluX2ZsaWdodCk7CiAgICAgIHwgICAgIF5+fn5+fn5+
fn4KICAgICAgfCAgICAgcWF0b21pY19pbmMKLi4vc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzoy
NDU5OjU6IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdhdG9taWNfaW5jJyBb
LVdlcnJvcj1uZXN0ZWQtZXh0ZXJuc10KLi4vc3JjL2Jsb2NrL2Jsb2NrLWJhY2tlbmQuYzogSW4g
ZnVuY3Rpb24gJ2Jsa19yZWhhbmRsZV9yZW1vdmVfYWlvY2InOgouLi9zcmMvYmxvY2svYmxvY2st
YmFja2VuZC5jOjI0Njg6NTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9u
ICdhdG9taWNfZGVjJzsgZGlkIHlvdSBtZWFuICdxYXRvbWljX2RlYyc/IFstV2Vycm9yPWltcGxp
Y2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogMjQ2OCB8ICAgICBhdG9taWNfZGVjKCZibGstPnJl
aW5mby5pbl9mbGlnaHQpOwogICAgICB8ICAgICBefn5+fn5+fn5+CiAgICAgIHwgICAgIHFhdG9t
aWNfZGVjCi4uL3NyYy9ibG9jay9ibG9jay1iYWNrZW5kLmM6MjQ2ODo1OiBlcnJvcjogbmVzdGVk
IGV4dGVybiBkZWNsYXJhdGlvbiBvZiAnYXRvbWljX2RlYycgWy1XZXJyb3I9bmVzdGVkLWV4dGVy
bnNdCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBb
TWFrZWZpbGUubmluamE6ODg4OiBsaWJibG9jay5mYS5wL2Jsb2NrX2Jsb2NrLWJhY2tlbmQuYy5v
YmpdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KVHJh
Y2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2Rv
Y2tlci5weSIsIGxpbmUgNzA5LCBpbiA8bW9kdWxlPgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLXJtJywgJy0tbGFiZWwnLCAn
Y29tLnFlbXUuaW5zdGFuY2UudXVpZD00YzNhYmExZWIzNWI0MjhjYTkxZTc5YTYxMGU4OTJhNics
ICctdScsICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTFwbV9lbm82L3NyYy9kb2NrZXItc3JjLjIwMjAtMDktMjct
MDkuMjEuNTUuMzAzMzE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NGMzYWJh
MWViMzViNDI4Y2E5MWU3OWE2MTBlODkyYTYKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtMXBtX2VubzYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgNW0xMS4wMTZzCnVzZXIgICAgMG0xOS43NzVzCgoKVGhlIGZ1bGwg
bG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyNzEzMDQy
MC4xMDk1LTEtZmFuZ3lpbmcxQGh1YXdlaS5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3Jh
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

