Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B1C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A044A206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A044A206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQtJ-0008AM-Sw
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQqW-0000Hl-UF
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTQoH-00047P-MB
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:04:18 -0400
Resent-Date: Tue, 28 Apr 2020 10:04:18 -0400
Resent-Message-Id: <E1jTQoH-00047P-MB@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTQb7-0007GR-5D; Tue, 28 Apr 2020 09:48:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588081703; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=n6unSk1Iy2AODttM59bjdQYfGzGf5JP7pjGF0PCouqKbXSoY96e9JpF2FYwVEJvVppSLxsgV0wDePu4mMCK1eYyK5eLCU2yTX/qC1jWQ1oLQsXgL+QjujGmcwYUZySa/6ABrNH2U44gBHURwFRVrHY7Rlv8zOtyzf6ec9V9JFOY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588081703;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=c6w4VT+f2qrvrKmAHszv5Z4PFscts1lcgZAjKo8qY4s=; 
 b=bSl8KDlkYpWFLY5oba19Jo5WQcZAZS2wT89jKBNZxbrO6kJd5TBJ2kLbX9HKBS1/vXTiB7Iif6NG3wAfVhHneDdAyfiClTQ2tbU9bLu7byYaVHU3FCHz5iUqkIaa9vVMITCmkLgdHzunQTMaT4gBBZtdQMqbYl9jO9Ly3m57Irc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588081702503111.85697174591508;
 Tue, 28 Apr 2020 06:48:22 -0700 (PDT)
In-Reply-To: <20200428132629.796753-1-mreitz@redhat.com>
Subject: Re: [PATCH 0/4] block: Do not call BlockDriver.bdrv_make_empty()
 directly
Message-ID: <158808170135.30407.7002209344321514508@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Tue, 28 Apr 2020 06:48:22 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 09:39:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.57
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyODEzMjYyOS43OTY3
NTMtMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIENDICAgICAgYWFy
Y2g2NC1zb2Z0bW11L2V4ZWMtdmFyeS5vCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRtbXUvdGNnL3Rj
Zy5vCi90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOiBJbiBmdW5jdGlvbiAnaW1nX2NvbW1p
dCc6Ci90bXAvcWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6Mjc6IGVycm9yOiBpbXBsaWNp
dCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnYmxrX25ld193aXRoX2JzJzsgZGlkIHlvdSBtZWFu
ICdibGtfZ2V0X3N0YXRzJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25d
CiAgICAgICAgIG9sZF9iYWNraW5nX2JsayA9IGJsa19uZXdfd2l0aF9icyhicywgQkxLX1BFUk1f
V1JJVEUsIEJMS19QRVJNX0FMTCwKICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+
fn5+fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgIGJsa19nZXRfc3RhdHMKL3RtcC9xZW11
LXRlc3Qvc3JjL3FlbXUtaW1nLmM6MTA3MToyNzogZXJyb3I6IG5lc3RlZCBleHRlcm4gZGVjbGFy
YXRpb24gb2YgJ2Jsa19uZXdfd2l0aF9icycgWy1XZXJyb3I9bmVzdGVkLWV4dGVybnNdCi90bXAv
cWVtdS10ZXN0L3NyYy9xZW11LWltZy5jOjEwNzE6MjU6IGVycm9yOiBhc3NpZ25tZW50IHRvICdC
bG9ja0JhY2tlbmQgKicge2FrYSAnc3RydWN0IEJsb2NrQmFja2VuZCAqJ30gZnJvbSAnaW50JyBt
YWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2FzdCBbLVdlcnJvcj1pbnQtY29u
dmVyc2lvbl0KICAgICAgICAgb2xkX2JhY2tpbmdfYmxrID0gYmxrX25ld193aXRoX2JzKGJzLCBC
TEtfUEVSTV9XUklURSwgQkxLX1BFUk1fQUxMLAogICAgICAgICAgICAgICAgICAgICAgICAgXgpj
YzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycwptYWtlOiAqKiogWy90bXAv
cWVtdS10ZXN0L3NyYy9ydWxlcy5tYWs6Njk6IHFlbXUtaW1nLm9dIEVycm9yIDEKbWFrZTogKioq
IFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4KICBDQyAgICAgIGFhcmNoNjQtc29mdG1t
dS90Y2cvdGNnLW9wLm8KICBDQyAgICAgIGFhcmNoNjQtc29mdG1tdS90Y2cvdGNnLW9wLXZlYy5v
Ci0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUsIGNtZCkKc3VicHJvY2Vz
cy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICctbicsICdkb2NrZXInLCAn
cnVuJywgJy0tbGFiZWwnLCAnY29tLnFlbXUuaW5zdGFuY2UudXVpZD03ZTMzNzk3ZTI4NTE0YzQ4
YTFjY2U3MDIxZDhiMDRmZCcsICctdScsICcxMDAzJywgJy0tc2VjdXJpdHktb3B0JywgJ3NlY2Nv
bXA9dW5jb25maW5lZCcsICctLXJtJywgJy1lJywgJ1RBUkdFVF9MSVNUPScsICctZScsICdFWFRS
QV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0xNCcsICctZScsICdERUJV
Rz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0NDQUNIRV9ESVI9L3Zhci90bXAvY2NhY2hl
JywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9xZW11LWRvY2tlci1jY2FjaGU6L3Zhci90
bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLWRoOGlrMzc3
L3NyYy9kb2NrZXItc3JjLjIwMjAtMDQtMjgtMDkuNDQuMTcuMjI1ODE6L3Zhci90bXAvcWVtdTp6
LHJvJywgJ3FlbXU6ZmVkb3JhJywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScg
cmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNv
bS5xZW11Lmluc3RhbmNlLnV1aWQ9N2UzMzc5N2UyODUxNGM0OGExY2NlNzAyMWQ4YjA0ZmQKbWFr
ZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5
IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtZGg4aWszNzcvc3JjJwptYWtlOiAqKiogW2Rv
Y2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9yIDIKCnJlYWwgICAgNG00Ljk2N3MKdXNl
ciAgICAwbTguMzQ5cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDA0MjgxMzI2MjkuNzk2NzUzLTEtbXJlaXR6QHJlZGhhdC5jb20vdGVz
dGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFz
ZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

