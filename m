Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B442C4CECD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030F92070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 20:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030F92070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTA6A-00051H-26
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 16:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTA5Y-0004Tj-HC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:10:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jTA5X-00040g-91
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:10:48 -0400
Resent-Date: Mon, 27 Apr 2020 16:10:48 -0400
Resent-Message-Id: <E1jTA5X-00040g-91@eggs.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21724)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jTA5W-0003zc-OG
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 16:10:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588018239; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ckJuJX7CrsJtU+RBmOxnAs7BwMBUqkft7/Zj2D2YBbZKVLift+36JjDxc7wG+lUKX3J+miHyOgLmifYOO7YYJuo52xHrnzq0XjUPjY59CkFUndXu26nqnrLfandvb9dYwcnA4MfzKr4dMrzgWRJ8elJkVFRF7S/uIeyvwGljljY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588018239;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=s011sQwfm0kqWqtvYwqmy69Uwc1QRVl3VyPRwcipNt4=; 
 b=Cnh5FdSkYrGZYlT01IesoouVBqKutVgu5hGRADDMZYtcP/MGAPg/1pZmLV+5l19oa7WFsDPoSi+U9ssYNFyKD2L9j2r2EBJ1RSRdAzygcRNCOv6Oq4ZDTc7Uy1komMVFymrZkybL6SFeWMbd4ZfOwemJHaJq7sK0JPMKNXaMOMk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588018236943709.814880313882;
 Mon, 27 Apr 2020 13:10:36 -0700 (PDT)
In-Reply-To: <20200427182440.92433-1-jusual@redhat.com>
Subject: Re: [PATCH v2 0/2] hw/pci/pcie: Forbid hot-plug if it's disabled on
 the slot
Message-ID: <158801823561.15667.6932995854888702598@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jusual@redhat.com
Date: Mon, 27 Apr 2020 13:10:36 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 16:10:44
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
Cc: imammedo@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 jusual@redhat.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyNzE4MjQ0MC45MjQz
My0xLWp1c3VhbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9j
a2VyLXF1aWNrQGNlbnRvczcgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtY2VudG9zNyBWPTEgTkVU
V09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1xdWlja0BjZW50b3M3IFNIT1dfRU5WPTEgSj0x
NCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgVEVTVCAgICBjaGVjay11bml0
OiB0ZXN0cy90ZXN0LXFodApzb2NrZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJp
bHkgdW5hdmFpbGFibGUKKioKRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xp
YnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24g
ZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKL3RtcC9xZW11LXRlc3Qvc3Jj
L3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5h
dGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAw
KQpFUlJPUiAtIEJhaWwgb3V0ISBFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3Qv
bGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlv
biBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+PSAwKQptYWtlOiAqKiogW2NoZWNr
LXF0ZXN0LWFhcmNoNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KICBURVNUICAgIGlvdGVzdC1xY293MjogMDIyCiAgVEVTVCAgICBjaGVjay11bml0
OiB0ZXN0cy90ZXN0LXFodC1wYXIKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAzOQpzb2Nr
ZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUKKioKRVJS
T1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2lu
aXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAm
JiBzLT5xbXBfZmQgPj0gMCkKL3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0
LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBl
bmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJPUiAtIEJhaWwgb3V0ISBF
UlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3Rf
aW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAw
ICYmIHMtPnFtcF9mZCA+PSAwKQptYWtlOiAqKiogW2NoZWNrLXF0ZXN0LXg4Nl82NF0gRXJyb3Ig
MQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwNDAKICBURVNUICAgIGlvdGVzdC1xY293MjogMDQx
CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDA0MgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NF
cnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5k
ICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywgJ3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmlu
c3RhbmNlLnV1aWQ9YzY2ZjYwMjY0MjYxNDQxZTg3Yjk3M2IxMzdhYjU2ZDcnLCAnLXUnLCAnMTAw
MycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNjb21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScs
ICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhUUkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9
JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVCVUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUn
LCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2FjaGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNh
Y2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFyL3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3Rt
cC9wYXRjaGV3LXRlc3Rlci10bXAta3NzaGdzZHgvc3JjL2RvY2tlci1zcmMuMjAyMC0wNC0yNy0x
NS41NC4yNS4yNjE5MDovdmFyL3RtcC9xZW11Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIv
dG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2snXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0
dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YzY2ZjYw
MjY0MjYxNDQxZTg3Yjk3M2IxMzdhYjU2ZDcKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJv
ciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAta3NzaGdzZHgvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3
XSBFcnJvciAyCgpyZWFsICAgIDE2bTExLjI3MnMKdXNlciAgICAwbTkuODgwcwoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MjcxODI0
NDAuOTI0MzMtMS1qdXN1YWxAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1xdWlja0BjZW50b3M3
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

