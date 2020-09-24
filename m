Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A97C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:59:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60F7D23741
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 08:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60F7D23741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLN5y-0001HQ-CF
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 04:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLN4o-0000QB-Ft
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:58:06 -0400
Resent-Date: Thu, 24 Sep 2020 04:58:06 -0400
Resent-Message-Id: <E1kLN4o-0000QB-Ft@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21369)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kLN4m-0002Vo-3A
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 04:58:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600937876; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ILgNu4l1g5XkRCosJuX5IPIdb0fHmgiIomRYI/IY2HzrCfULedsx912FW0P60t/SqP4Hdf8FXpoakCsjL+yGtEcJ4Pieg4+KhUXSrHy8wXBm3RAXQ/D5QOesPmRhv5TjFVKatFz9ftRKkv7KAWGRxwm/ORrDPdBCoJYM9NHx5gk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600937876;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=N8tQjUCIpi3fXB3/USHBWgsBS183f0+TsgiPmvbxUTY=; 
 b=QX9s/5I6keyHb9Ilcnr396FhKN5zv8yJZUSgT14u80zuFe0Eaf5qVMTlsYA/zvKeKitC48TCmQG5L1Z5TlI+3LkPDNeoEEclIWAhwmxuXsjs+VfAIUWg+4hkFuJQj244tWAK7VcbtTxYeIfhJuJFcBz8yrY/KNhWDqL5kQwcrLw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600937875100509.4177889816857;
 Thu, 24 Sep 2020 01:57:55 -0700 (PDT)
Subject: Re: [RFC PATCH v3 0/7] Use ACPI PCI hot-plug for Q35
Message-ID: <160093787371.759.4025981908391637660@66eaa9a8a123>
In-Reply-To: <20200924070013.165026-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jusual@redhat.com
Date: Thu, 24 Sep 2020 01:57:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 04:58:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: ani@anisinha.ca, imammedo@redhat.com, jusual@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyNDA3MDAxMy4xNjUw
MjYtMS1qdXN1YWxAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtlIGRvY2tlci1p
bWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVk
b3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpIb3N0IG1hY2hpbmUg
Y3B1OiB4ODZfNjQKVGFyZ2V0IG1hY2hpbmUgY3B1IGZhbWlseTogeDg2ClRhcmdldCBtYWNoaW5l
IGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklORzogTW9kdWxlIHVuc3Rh
YmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNvbXBhdGliaWxpdHkgYW5k
IG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dyYW0gc2ggZm91bmQ6IFlF
UwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0aG9uMykKQ29uZmlndXJp
bmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tClRoZSBtYW51YWwgcGFnZXMgYXJl
IGluIGRvY3MuCi91c3IvbGliL2djYy94ODZfNjQtdzY0LW1pbmd3MzIvOS4yLjEvLi4vLi4vLi4v
Li4veDg2XzY0LXc2NC1taW5ndzMyL2Jpbi9sZDogbGliY29tbW9uLmZhLnAvaHdfcGNpX3BjaWUu
Yy5vYmo6IGluIGZ1bmN0aW9uIGBhY3BpX3BjaWhwX2VuYWJsZWQnOgovdG1wL3FlbXUtdGVzdC9i
dWlsZC8uLi9zcmMvaHcvcGNpL3BjaWUuYzo1MjI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYG9i
amVjdF9yZXNvbHZlX3R5cGVfdW5hbWJpZ3VvdXMnCmNvbGxlY3QyOiBlcnJvcjogbGQgcmV0dXJu
ZWQgMSBleGl0IHN0YXR1cwptYWtlOiAqKiogW01ha2VmaWxlLm5pbmphOjE4Nzg6IHFlbXUtc3lz
dGVtLWFhcmNoNjR3LmV4ZV0gRXJyb3IgMQptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hl
ZCBqb2JzLi4uLgovdXNyL2xpYi9nY2MveDg2XzY0LXc2NC1taW5ndzMyLzkuMi4xLy4uLy4uLy4u
Ly4uL3g4Nl82NC13NjQtbWluZ3czMi9iaW4vbGQ6IGxpYmNvbW1vbi5mYS5wL2h3X3BjaV9wY2ll
LmMub2JqOiBpbiBmdW5jdGlvbiBgYWNwaV9wY2locF9lbmFibGVkJzoKL3RtcC9xZW11LXRlc3Qv
YnVpbGQvLi4vc3JjL2h3L3BjaS9wY2llLmM6NTIyOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBv
YmplY3RfcmVzb2x2ZV90eXBlX3VuYW1iaWd1b3VzJwpjb2xsZWN0MjogZXJyb3I6IGxkIHJldHVy
bmVkIDEgZXhpdCBzdGF0dXMKbWFrZTogKioqIFtNYWtlZmlsZS5uaW5qYToxODc2OiBxZW11LXN5
c3RlbS1hYXJjaDY0LmV4ZV0gRXJyb3IgMQpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFz
dCk6CiAgRmlsZSAiLi90ZXN0cy9kb2NrZXIvZG9ja2VyLnB5IiwgbGluZSA3MDksIGluIDxtb2R1
bGU+CiAgICBzeXMuZXhpdChtYWluKCkpCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9y
KHJldGNvZGUsIGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1sn
c3VkbycsICctbicsICdkb2NrZXInLCAncnVuJywgJy0tcm0nLCAnLS1sYWJlbCcsICdjb20ucWVt
dS5pbnN0YW5jZS51dWlkPTM0MmJjMTQ3YTUwODQ3Zjg4NmRhOWIwMWMwY2E1ZWM5JywgJy11Jywg
JzEwMDMnLCAnLS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy1lJywgJ1RB
UkdFVF9MSVNUPScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAn
LWUnLCAnSj0xNCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9JywgJy1lJywgJ0ND
QUNIRV9ESVI9L3Zhci90bXAvY2NhY2hlJywgJy12JywgJy9ob21lL3BhdGNoZXcyLy5jYWNoZS9x
ZW11LWRvY2tlci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0
Y2hldy10ZXN0ZXItdG1wLXZtc2Fva25oL3NyYy9kb2NrZXItc3JjLjIwMjAtMDktMjQtMDQuNTMu
MTAuMzAwMTY6L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvZmVkb3JhJywgJy92YXIvdG1wL3Fl
bXUvcnVuJywgJ3Rlc3QtbWluZ3cnXScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4K
ZmlsdGVyPS0tZmlsdGVyPWxhYmVsPWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9MzQyYmMxNDdhNTA4
NDdmODg2ZGE5YjAxYzBjYTVlYzkKbWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1h
a2VbMV06IExlYXZpbmcgZGlyZWN0b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtdm1z
YW9rbmgvc3JjJwptYWtlOiAqKiogW2RvY2tlci1ydW4tdGVzdC1taW5nd0BmZWRvcmFdIEVycm9y
IDIKCnJlYWwgICAgNG00Mi44MzdzCnVzZXIgICAgMG0xOC44MjlzCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyNDA3MDAxMy4xNjUw
MjYtMS1qdXN1YWxAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=

