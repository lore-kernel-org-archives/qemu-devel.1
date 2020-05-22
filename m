Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07F8C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:19:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B898D2073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B898D2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcF4g-0005iV-US
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcF45-0005Df-8A; Fri, 22 May 2020 17:18:49 -0400
Resent-Date: Fri, 22 May 2020 17:18:49 -0400
Resent-Message-Id: <E1jcF45-0005Df-8A@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcF43-0005vd-Hb; Fri, 22 May 2020 17:18:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590182305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fYMJsCvciH8XT08/QpwK5SEcRh37/xibQl1Fv0PCyqE8uce6dnIPs0qpeqo5Hmfgt3qsYn4gFZi2HnozvzDylsgGgf9AFi8HBEvgnNy2B54leY7afAKhRk/Ub/NHohULnv9J8kOINQd3TQtqo9LOcaBoZwoqDaTrScIzPfMaBdY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590182305;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Q6DBPcIxoah6uYGXMrw6VR4JsyMS8RXDF+x3mlVeOJQ=; 
 b=C4s2lf9FGNKoUvCa0HzVqUsgqLQP622I/jfMMoE+b9LOYroUaDKtsMbOj8R6mrMd1f/B3ljSe9OYb6SDCBcGyk3/456tWF8v4dQET9LrChFE/9pqsrTnvuhmnN/wWSMDPQq3GCnIJmpYW4YLDVj0rn9TQhZvd1idqOrFEJaWHCE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590182303374416.53688131027207;
 Fri, 22 May 2020 14:18:23 -0700 (PDT)
Message-ID: <159018230171.1576.9474128734533672037@45ef0f9c86ae>
In-Reply-To: <20200522161950.2839-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 0/3] coroutines: generate wrapper code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 22 May 2020 14:18:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 17:18:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, crosa@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyMjE2MTk1MC4yODM5
LTEtdnNlbWVudHNvdkB2aXJ0dW96em8uY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0
aGUgZG9ja2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3Rp
bmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGlu
c3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBW
PTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5W
PTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCmJsb2NrL3ZoZHgtbG9n
Lm86IEluIGZ1bmN0aW9uIGB2aGR4X2xvZ193cml0ZV9hbmRfZmx1c2gnOgovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDQ5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2
X2ZsdXNoJwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDYxOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVk
IDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtxZW11LW5iZF0gRXJyb3IgMQptYWtlOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpibG9jay5vOiBJbiBmdW5jdGlvbiBgYmRydl9p
bnZhbGlkYXRlX2NhY2hlX2FsbCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay5jOjU2OTc6IHVu
ZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfaW52YWxpZGF0ZV9jYWNoZScKLS0tCmJsb2NrL3Zo
ZHgtbG9nLm86IEluIGZ1bmN0aW9uIGB2aGR4X2xvZ193cml0ZV9hbmRfZmx1c2gnOgovdG1wL3Fl
bXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDQ5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
IGBiZHJ2X2ZsdXNoJwovdG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDYxOiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJl
dHVybmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtxZW11LXN0b3JhZ2UtZGFlbW9uXSBFcnJv
ciAxCmJsb2NrLm86IEluIGZ1bmN0aW9uIGBiZHJ2X2ludmFsaWRhdGVfY2FjaGVfYWxsJzoKL3Rt
cC9xZW11LXRlc3Qvc3JjL2Jsb2NrLmM6NTY5NzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRy
dl9pbnZhbGlkYXRlX2NhY2hlJwpibG9jay5vOiBJbiBmdW5jdGlvbiBgYmRydl9jbG9zZSc6Ci0t
LQpibG9jay92aGR4LWxvZy5vOiBJbiBmdW5jdGlvbiBgdmhkeF9sb2dfd3JpdGVfYW5kX2ZsdXNo
JzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3ZoZHgtbG9nLmM6MTA0OTogdW5kZWZpbmVkIHJl
ZmVyZW5jZSB0byBgYmRydl9mbHVzaCcKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrL3ZoZHgtbG9n
LmM6MTA2MTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgYmRydl9mbHVzaCcKY29sbGVjdDI6IGVy
cm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbcWVtdS1pb10gRXJyb3Ig
MQogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvY29uZmlnLXRhcmdldC5oCiAgR0VOICAgICB4ODZf
NjQtc29mdG1tdS9obXAtY29tbWFuZHMuaAogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvaG1wLWNv
bW1hbmRzLWluZm8uaAotLS0KLi4vYmxvY2svdmhkeC1sb2cubzogSW4gZnVuY3Rpb24gYHZoZHhf
bG9nX3dyaXRlX2FuZF9mbHVzaCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay92aGR4LWxvZy5j
OjEwNDk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfZmx1c2gnCi90bXAvcWVtdS10ZXN0
L3NyYy9ibG9jay92aGR4LWxvZy5jOjEwNjE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZf
Zmx1c2gnCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFd
OiAqKiogW3FlbXUtc3lzdGVtLXg4Nl82NF0gRXJyb3IgMQptYWtlOiAqKiogW3g4Nl82NC1zb2Z0
bW11L2FsbF0gRXJyb3IgMgouLi9ibG9ja2Rldi5vOiBJbiBmdW5jdGlvbiBgZXh0ZXJuYWxfc25h
cHNob3RfcHJlcGFyZSc6Ci90bXAvcWVtdS10ZXN0L3NyYy9ibG9ja2Rldi5jOjE0ODA6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfZmx1c2gnCi4uL2Jsb2NrLm86IEluIGZ1bmN0aW9uIGBi
ZHJ2X2ludmFsaWRhdGVfY2FjaGVfYWxsJzoKLS0tCi4uL2Jsb2NrL3ZoZHgtbG9nLm86IEluIGZ1
bmN0aW9uIGB2aGR4X2xvZ193cml0ZV9hbmRfZmx1c2gnOgovdG1wL3FlbXUtdGVzdC9zcmMvYmxv
Y2svdmhkeC1sb2cuYzoxMDQ5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2ZsdXNoJwov
dG1wL3FlbXUtdGVzdC9zcmMvYmxvY2svdmhkeC1sb2cuYzoxMDYxOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvIGBiZHJ2X2ZsdXNoJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBz
dGF0dXMKbWFrZVsxXTogKioqIFtxZW11LXN5c3RlbS1hYXJjaDY0XSBFcnJvciAxCm1ha2U6ICoq
KiBbYWFyY2g2NC1zb2Z0bW11L2FsbF0gRXJyb3IgMgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNh
bGwgbGFzdCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA2NjQsIGlu
IDxtb2R1bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vz
c0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1h
bmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUu
aW5zdGFuY2UudXVpZD00ZDZkZDhhZjllM2Q0MTYxOGIzZWVmYzYxMzRiMDNjMicsICctdScsICcx
MDAxJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2NvbXA9dW5jb25maW5lZCcsICctLXJtJywgJy1l
JywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAn
Vj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5j
YWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90
bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWZvamFlcDQzL3NyYy9kb2NrZXItc3JjLjIwMjAtMDUtMjIt
MTcuMTUuMDUuMTg4NzE6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6Y2VudG9zNycsICcvdmFy
L3RtcC9xZW11L3J1bicsICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3Rh
dHVzIDIuCmZpbHRlcj0tLWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTRkNmRk
OGFmOWUzZDQxNjE4YjNlZWZjNjEzNGIwM2MyCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJy
b3IgMQptYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXIt
dG1wLWZvamFlcDQzL3NyYycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9z
N10gRXJyb3IgMgoKcmVhbCAgICAzbTE3LjE4MHMKdXNlciAgICAwbTguNjg2cwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MjIxNjE5
NTAuMjgzOS0xLXZzZW1lbnRzb3ZAdmlydHVvenpvLmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0Bj
ZW50b3M3Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

