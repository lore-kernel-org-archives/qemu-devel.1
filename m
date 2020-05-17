Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B812C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E29292067D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 18:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E29292067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaNi9-0003h8-2l
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 14:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNgy-00026r-HP
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:07:16 -0400
Resent-Date: Sun, 17 May 2020 14:07:16 -0400
Resent-Message-Id: <E1jaNgy-00026r-HP@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jaNgw-00072S-W2
 for qemu-devel@nongnu.org; Sun, 17 May 2020 14:07:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589738810; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=QITGww6gUPSwg0lduSq1AT4tNXfe1F0mFCin3q96QRX7eJ1qPNCntu42HNDh3+iNIkmIZTnx55MIVqansTa7ni1jXjGZ/eXVRxLneZW5pbaPhfctjArJtO/JSkZHpN3DoJt41sr8Vv4fWC5gvLg6ptdADuPHWs/kBnuamZQFTpo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589738810;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fFTVA3uDlFSjXBdP+Uwnak/4v1iOTExLl9XJJTVlEKs=; 
 b=F5S5ymZmGHFzFlR4Wd7pLvYxD2sbaA6EwpHELlXF/VbdmDWUtRuEFXlRpBWtGdTdHCnuNTkaYaDaEFtnWrfEQ+HYTRAoxPM8U/zFPc2zltkgO35N3WUzz5TGoUa/leQ8VEAY/tDvN8B9vvSMlBMfExUdwhyix5D3mKhoFmpxAko=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589738808371124.9092043316416;
 Sun, 17 May 2020 11:06:48 -0700 (PDT)
Message-ID: <158973880660.15373.16733828203560921365@45ef0f9c86ae>
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 17 May 2020 11:06:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 14:07:12
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
Cc: peter.maydell@linaro.org, lizhijian@cn.fujitsu.com, mst@redhat.com,
 aik@ozlabs.ru, jasowang@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 f4bug@amsat.org, tony.nguyen@bt.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNzE2NDgxNy41Mzcx
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVUV09S
Sz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0xNCBO
RVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBody9jcHUvY29yZS5v
CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdG1wL3FlbXUtdGVzdC9zcmMvaHcvY29yZS9sb2FkZXIu
YzozMjc6MDoKL3RtcC9xZW11LXRlc3Qvc3JjL2luY2x1ZGUvaHcvZWxmX29wcy5oOiBJbiBmdW5j
dGlvbiAnbG9hZF9lbGY2NCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3L2VsZl9vcHMu
aDo1NTY6NDA6IGVycm9yOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2YgJ2FkZHJlc3Nfc3BhY2Vf
d3JpdGUnLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQgWy1XZXJy
b3I9dW51c2VkLXJlc3VsdF0KICAgICAgICAgICAgICAgICAgICAgYWRkcmVzc19zcGFjZV93cml0
ZShhcyA/IGFzIDogJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LAogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3RtcC9xZW11LXRlc3Qv
c3JjL2h3L2NvcmUvbG9hZGVyLmM6MzA1OjA6Ci90bXAvcWVtdS10ZXN0L3NyYy9pbmNsdWRlL2h3
L2VsZl9vcHMuaDogSW4gZnVuY3Rpb24gJ2xvYWRfZWxmMzInOgovdG1wL3FlbXUtdGVzdC9zcmMv
aW5jbHVkZS9ody9lbGZfb3BzLmg6NTU2OjQwOiBlcnJvcjogaWdub3JpbmcgcmV0dXJuIHZhbHVl
IG9mICdhZGRyZXNzX3NwYWNlX3dyaXRlJywgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgd2Fybl91
bnVzZWRfcmVzdWx0IFstV2Vycm9yPXVudXNlZC1yZXN1bHRdCiAgICAgICAgICAgICAgICAgICAg
IGFkZHJlc3Nfc3BhY2Vfd3JpdGUoYXMgPyBhcyA6ICZhZGRyZXNzX3NwYWNlX21lbW9yeSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KL3RtcC9xZW11LXRlc3Qvc3Jj
L2h3L2NvcmUvbG9hZGVyLmM6IEluIGZ1bmN0aW9uICdyb21fcmVzZXQnOgovdG1wL3FlbXUtdGVz
dC9zcmMvaHcvY29yZS9sb2FkZXIuYzoxMTQ5OjM2OiBlcnJvcjogaWdub3JpbmcgcmV0dXJuIHZh
bHVlIG9mICdhZGRyZXNzX3NwYWNlX3dyaXRlX3JvbScsIGRlY2xhcmVkIHdpdGggYXR0cmlidXRl
IHdhcm5fdW51c2VkX3Jlc3VsdCBbLVdlcnJvcj11bnVzZWQtcmVzdWx0XQogICAgICAgICAgICAg
YWRkcmVzc19zcGFjZV93cml0ZV9yb20ocm9tLT5hcywgcm9tLT5hZGRyLCBNRU1UWEFUVFJTX1VO
U1BFQ0lGSUVELAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCmNjMTogYWxs
IHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCm1ha2U6ICoqKiBbaHcvY29yZS9sb2Fk
ZXIub10gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpU
cmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIv
ZG9ja2VyLnB5IiwgbGluZSA2NjQsIGluIDxtb2R1bGU+Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJv
Y2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENv
bW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFl
bXUuaW5zdGFuY2UudXVpZD1mMjk1NWIwMDVmNDU0M2Q4YTI4YjcxOTdhZjljMzdhMCcsICctdScs
ICcxMDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywg
Jy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUn
LCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScs
ICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3
Ly5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zh
ci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLW92MmNqMGw2L3NyYy9kb2NrZXItc3JjLjIwMjAtMDUt
MTctMTQuMDMuMDkuMjEzMjA6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcv
dmFyL3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQg
c3RhdHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPWYy
OTU1YjAwNWY0NTQzZDhhMjhiNzE5N2FmOWMzN2EwCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0g
RXJyb3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLW92MmNqMGw2L3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2Vu
dG9zN10gRXJyb3IgMgoKcmVhbCAgICAzbTM3LjYxOHMKdXNlciAgICAwbTkuNjg5cwoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTcx
NjQ4MTcuNTM3MS0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

