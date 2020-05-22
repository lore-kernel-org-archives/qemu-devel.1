Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50392C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288C5207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 21:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288C5207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcFGJ-0002eE-6j
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 17:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcFFD-00023J-1D; Fri, 22 May 2020 17:30:19 -0400
Resent-Date: Fri, 22 May 2020 17:30:19 -0400
Resent-Message-Id: <E1jcFFD-00023J-1D@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21707)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jcFFB-0007oT-8v; Fri, 22 May 2020 17:30:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590183001; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=euzHzTyu1WwxqCbQOfq2iXwiJBzuW33kK50OwIaiZOEgXSChr+pcaf3ejgmWqUXgCs4/aQ0wnzOw00xl7mzfZ6zn/d6jWz0ydEvDVJIzTwz9gihBaHPCAnHkfR59O/WD82owuCJLBj0cG3P4MY/1F52XsYIG4r436cgH01+J6WU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590183001;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RTDOXgHldAq1GtDstghdrSU3Okpf9FeZAHIUcWvsw+o=; 
 b=CaGW0ahXS6quaZudqX3EgajpN31XLHiB+rQL6b5gMuEcmSMMELvDc41WKoRQbjGTocZiXS1Xx5TWQj400srxc73V1cPwOlwtCvak3aN/7s4kB3ks/DLZRUCpVjN7GDhcRtH3EpgoV70orrsgPvgkFRTlteXHcDoFTE+a2bSKel0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590182999119640.5714990130464;
 Fri, 22 May 2020 14:29:59 -0700 (PDT)
Message-ID: <159018299751.1576.17307532560511340047@45ef0f9c86ae>
In-Reply-To: <20200522161950.2839-1-vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 0/3] coroutines: generate wrapper code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: vsementsov@virtuozzo.com
Date: Fri, 22 May 2020 14:29:59 -0700 (PDT)
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
aGUgZG9ja2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGlu
ZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5z
dGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1Qg
U0NSSVBUIEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9j
a2VyLWltYWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5n
d0BmZWRvcmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCi90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9pby5jOjEwMjU6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZf
Zmx1c2gnCmJsb2NrL2lvLm86IEluIGZ1bmN0aW9uIGBiZHJ2X2ZsdXNoX2FsbCc6Ci90bXAvcWVt
dS10ZXN0L3NyYy9ibG9jay9pby5jOjIxNzA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZf
Zmx1c2gnCmJsb2NrL2NvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJuZWQgMSBleGl0IHN0YXR1cwpp
by5vOiBJbiBmdW5jdGlvbiBgYmRydl9ibG9ja19zdGF0dXNfYWJvdmUnOgovdG1wL3FlbXUtdGVz
dC9zcmMvYmxvY2svaW8uYzoyNDM1OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBiZHJ2X2NvbW1v
bl9ibG9ja19zdGF0dXNfYWJvdmUnCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9pby5jOjI0MzU6
IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfY29tbW9uX2Jsb2NrX3N0YXR1c19hYm92ZScK
LS0tCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9pby5jOjI1ODQ6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGJkcnZfcndfdm1zdGF0ZScKbmJkL3NlcnZlci5vOiBJbiBmdW5jdGlvbiBgbmJkX2V4
cG9ydF9uZXcnOgovdG1wL3FlbXUtdGVzdC9zcmMvbmJkL3NlcnZlci5jOjE1MDQ6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYGJkcnZfaW52YWxpZGF0ZV9jYWNoZScKY29sbGVjdDI6IGVycm9yOiBs
ZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1
bGVzLm1hazoxMjQ6IHFlbXUtaW8uZXhlXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1
bmZpbmlzaGVkIGpvYnMuLi4uCm1ha2U6ICoqKiBbL3RtcC9xZW11LXRlc3Qvc3JjL3J1bGVzLm1h
azoxMjQ6IHFlbXUtaW1nLmV4ZV0gRXJyb3IgMQogIEdFTiAgICAgeDg2XzY0LXNvZnRtbXUvaG1w
LWNvbW1hbmRzLmgKICBHRU4gICAgIHg4Nl82NC1zb2Z0bW11L2htcC1jb21tYW5kcy1pbmZvLmgK
ICBHRU4gICAgIHg4Nl82NC1zb2Z0bW11L2NvbmZpZy1kZXZpY2VzLmgKLS0tCi90bXAvcWVtdS10
ZXN0L3NyYy9ibG9jay9pby5jOjI1ODQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfcndf
dm1zdGF0ZScKLi4vbmJkL3NlcnZlci5vOiBJbiBmdW5jdGlvbiBgbmJkX2V4cG9ydF9uZXcnOgov
dG1wL3FlbXUtdGVzdC9zcmMvbmJkL3NlcnZlci5jOjE1MDQ6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYGJkcnZfaW52YWxpZGF0ZV9jYWNoZScKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAx
IGV4aXQgc3RhdHVzCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MjA4OiBxZW11LXN5c3RlbS14ODZf
NjR3LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjUzMzogeDg2XzY0LXNvZnRtbXUv
YWxsXSBFcnJvciAyCiAgTElOSyAgICBhYXJjaDY0LXNvZnRtbXUvcWVtdS1zeXN0ZW0tYWFyY2g2
NHcuZXhlCi4uL2Jsb2NrZGV2Lm86IEluIGZ1bmN0aW9uIGBleHRlcm5hbF9zbmFwc2hvdF9wcmVw
YXJlJzoKL3RtcC9xZW11LXRlc3Qvc3JjL2Jsb2NrZGV2LmM6MTQ4MDogdW5kZWZpbmVkIHJlZmVy
ZW5jZSB0byBgYmRydl9mbHVzaCcKLS0tCi90bXAvcWVtdS10ZXN0L3NyYy9ibG9jay9pby5jOjI1
ODQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfcndfdm1zdGF0ZScKLi4vbmJkL3NlcnZl
ci5vOiBJbiBmdW5jdGlvbiBgbmJkX2V4cG9ydF9uZXcnOgovdG1wL3FlbXUtdGVzdC9zcmMvbmJk
L3NlcnZlci5jOjE1MDQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGJkcnZfaW52YWxpZGF0ZV9j
YWNoZScKY29sbGVjdDI6IGVycm9yOiBsZCByZXR1cm5lZCAxIGV4aXQgc3RhdHVzCm1ha2VbMV06
ICoqKiBbTWFrZWZpbGU6MjA4OiBxZW11LXN5c3RlbS1hYXJjaDY0dy5leGVdIEVycm9yIDEKbWFr
ZTogKioqIFtNYWtlZmlsZTo1MzM6IGFhcmNoNjQtc29mdG1tdS9hbGxdIEVycm9yIDIKVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQotLS0KICAg
IHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVk
UHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICct
LWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9NWExZjAzMzRmNDNlNDRjZWE5M2I0ZjFm
YTg1ZDdhMDgnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29u
ZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklH
VVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1l
JywgJ1NIT1dfRU5WPScsICctZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdics
ICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNo
ZTp6JywgJy12JywgJy92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC15MGJkN25vMC9zcmMvZG9j
a2VyLXNyYy4yMDIwLTA1LTIyLTE3LjI1LjQyLjgwNTU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3Fl
bXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQg
bm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9NWExZjAzMzRmNDNlNDRjZWE5M2I0ZjFmYTg1ZDdhMDgKbWFrZVsxXTogKioq
IFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAteTBiZDdubzAvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4t
dGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG0xNS4wODVzCnVzZXIgICAgMG04
LjI2OXMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMjAwNTIyMTYxOTUwLjI4MzktMS12c2VtZW50c292QHZpcnR1b3p6by5jb20vdGVzdGlu
Zy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

