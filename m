Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CABC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA7A21D90
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 19:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA7A21D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTsCG-0005kf-0i
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 15:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTsAw-0004a5-JA
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:15:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTsAv-0005Yi-Tg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 15:15:18 -0400
Resent-Date: Wed, 29 Apr 2020 15:15:18 -0400
Resent-Message-Id: <E1jTsAv-0005Yi-Tg@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTsAq-0005Qo-QM; Wed, 29 Apr 2020 15:15:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588187706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V9OB7vNBgLVIKXY0BwZ01ZEZp8LKPYn28RjvZrZxrR/RQY+xhfdkYfiHoEg76qfN9hDiCGX+NBGmraLP7I/XLY8HRByqHsmhR0dU8VIfyQdFv7G4SSmFnXzI0EGnli2LVY6lnuDpQcunzuFkdpIXxklC3RFRUQk4TFGvHDdhC40=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588187706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=O3v8GQfFczft5Av+xqb9VzhVqMNp6nmhwMv5shgazMc=; 
 b=n8LkRu8zGcxXGSyRtnTC5jDmwOwt60ZqoCf72YoXsRkzpS0nm3zM4zt8qqc1EI6eSJmOkdPT0+BmsF8/kZXXYh47j6joVuwZhwTy0BSjEIk0RGfFQ4vcsZdpUnaX+ysPcOfwfbNrf9dE4bg0tzpp7WYDPPFA+D9Npe08HFd9HJg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158818770545786.47608538731868;
 Wed, 29 Apr 2020 12:15:05 -0700 (PDT)
Message-ID: <158818770418.4471.17201168064003266394@45ef0f9c86ae>
In-Reply-To: <20200429141126.85159-1-mreitz@redhat.com>
Subject: Re: [PATCH v2 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Wed, 29 Apr 2020 12:15:05 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 02:03:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyOTE0MTEyNi44NTE1
OS0xLW1yZWl0ekByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojISAvYmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWlt
YWdlLWZlZG9yYSBWPTEgTkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgTElOSyAgICBxZW11
LWVkaWQuZXhlCiAgTElOSyAgICBxZW11LWdhLmV4ZQovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1p
bWcuYzogSW4gZnVuY3Rpb24gJ2ltZ19jb21taXQnOgovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1p
bWcuYzoxMDcxOjI3OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24gJ2Js
a19uZXdfd2l0aF9icyc7IGRpZCB5b3UgbWVhbiAnYmxrX2dldF9zdGF0cyc/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogICAgICAgICBvbGRfYmFja2luZ19ibGsgPSBi
bGtfbmV3X3dpdGhfYnMoYnMsIEJMS19QRVJNX1dSSVRFLCBCTEtfUEVSTV9BTEwsCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fgogICAgICAgICAgICAgICAgICAgICAg
ICAgICBibGtfZ2V0X3N0YXRzCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6Mjc6
IGVycm9yOiBuZXN0ZWQgZXh0ZXJuIGRlY2xhcmF0aW9uIG9mICdibGtfbmV3X3dpdGhfYnMnIFst
V2Vycm9yPW5lc3RlZC1leHRlcm5zXQovdG1wL3FlbXUtdGVzdC9zcmMvcWVtdS1pbWcuYzoxMDcx
OjI1OiBlcnJvcjogYXNzaWdubWVudCB0byAnQmxvY2tCYWNrZW5kIConIHtha2EgJ3N0cnVjdCBC
bG9ja0JhY2tlbmQgKid9IGZyb20gJ2ludCcgbWFrZXMgcG9pbnRlciBmcm9tIGludGVnZXIgd2l0
aG91dCBhIGNhc3QgWy1XZXJyb3I9aW50LWNvbnZlcnNpb25dCiAgICAgICAgIG9sZF9iYWNraW5n
X2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1fV1JJVEUsIEJMS19QRVJNX0FMTCwK
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMKbWFrZTogKioqIFsvdG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBx
ZW11LWltZy5vXSBFcnJvciAxCm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMu
Li4uCiAgR0VOICAgICB4ODZfNjQtc29mdG1tdS9obXAtY29tbWFuZHMuaAogIEdFTiAgICAgeDg2
XzY0LXNvZnRtbXUvaG1wLWNvbW1hbmRzLWluZm8uaAotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11
Lmluc3RhbmNlLnV1aWQ9ZTBhMTZiMjM5OTc3NGJjY2JmN2NmMDY4MDgxYTllZmQnLCAnLXUnLCAn
MTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICct
ZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywg
J1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPScsICct
ZScsICdDQ0FDSEVfRElSPS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Mi8u
Y2FjaGUvcWVtdS1kb2NrZXItY2NhY2hlOi92YXIvdG1wL2NjYWNoZTp6JywgJy12JywgJy92YXIv
dG1wL3BhdGNoZXctdGVzdGVyLXRtcC1ldG03YmxkNi9zcmMvZG9ja2VyLXNyYy4yMDIwLTA0LTI5
LTE1LjEyLjE3LjM4ODU6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9ZTBhMTZi
MjM5OTc3NGJjY2JmN2NmMDY4MDgxYTllZmQKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtZXRtN2JsZDYvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFd
IEVycm9yIDIKCnJlYWwgICAgMm00Ny4wOTJzCnVzZXIgICAgMG03Ljc1MnMKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDI5MTQxMTI2
Ljg1MTU5LTEtbXJlaXR6QHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90
eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3
IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0
Y2hldy1kZXZlbEByZWRoYXQuY29t

