Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF5C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F09206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 18:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F09206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMxsS-0006Xl-7H
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 14:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMxri-00066D-6Z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:27:10 -0400
Resent-Date: Mon, 28 Sep 2020 14:27:10 -0400
Resent-Message-Id: <E1kMxri-00066D-6Z@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kMxrf-0000J9-MA
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 14:27:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1601317620; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GyjLSMdn83NhfI+ywSkHA1K01Sejz9fr2pEAz9JkfhccMTkaj1l4a4AIHi/yuCAlRBAaYl7jsXiWGQZP6y1kMGxegyh75PY02mBErz19lVMZTROpeQZLCFhC9JtReXgofAKi5/VuhyN51FYbXQ5JyEip6Fr9wqwVY8/CarJE+m8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1601317620;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=fdTYKfy9IoNX0wUVdnO6QYjPmmOAo2EzKmz2NKlKXlM=; 
 b=JjfoNzeYSOT4A4e+7mMlKYJN9hCm3Guq5D+bawC6A/ubZ9l9WfGX8WjQXz+rCmXnGigajTk2mR9FUcEsrwYEfhp3qyoJeSAqsjK34ELy4JF/K2AAA3l2oIrMupZB3sj7FboJa5/D5zPEGNpUdmhoSZYw8cfYAPqSob/VDmYjkxw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1601317619859797.9103679111385;
 Mon, 28 Sep 2020 11:26:59 -0700 (PDT)
Subject: Re: [PULL 0/5] Usb 20200928 patches
Message-ID: <160131761873.11341.6952810964250272966@66eaa9a8a123>
In-Reply-To: <20200928131638.9486-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Mon, 28 Sep 2020 11:26:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 14:27:05
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
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyODEzMTYzOC45NDg2
LTEta3JheGVsQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKQyBsaW5rZXIgZm9yIHRoZSBob3N0
IG1hY2hpbmU6IGNjIGxkLmJmZCAyLjI3LTQzCkhvc3QgbWFjaGluZSBjcHUgZmFtaWx5OiB4ODZf
NjQKSG9zdCBtYWNoaW5lIGNwdTogeDg2XzY0Ci4uL3NyYy9tZXNvbi5idWlsZDoxMDogV0FSTklO
RzogTW9kdWxlIHVuc3RhYmxlLWtleXZhbCBoYXMgbm8gYmFja3dhcmRzIG9yIGZvcndhcmRzIGNv
bXBhdGliaWxpdHkgYW5kIG1pZ2h0IG5vdCBleGlzdCBpbiBmdXR1cmUgcmVsZWFzZXMuClByb2dy
YW0gc2ggZm91bmQ6IFlFUwpQcm9ncmFtIHB5dGhvbjMgZm91bmQ6IFlFUyAoL3Vzci9iaW4vcHl0
aG9uMykKQ29uZmlndXJpbmcgbmluamF0b29sIHVzaW5nIGNvbmZpZ3VyYXRpb24KLS0tCnFlbXUt
c3lzdGVtLWFhcmNoNjQ6IGNhbm5vdCBzZXQgdXAgZ3Vlc3QgbWVtb3J5ICdzYnNhLXJlZi5yYW0n
OiBDYW5ub3QgYWxsb2NhdGUgbWVtb3J5CkJyb2tlbiBwaXBlCi4uL3NyYy90ZXN0cy9xdGVzdC9s
aWJxdGVzdC5jOjE2Njoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFFTVUgcHJvY2Vz
cyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkKRVJST1IgcXRlc3Qt
YWFyY2g2NDogdGVzdC1obXAgLSB0b28gZmV3IHRlc3RzIHJ1biAoZXhwZWN0ZWQgNzIsIGdvdCAx
MikKbWFrZTogKioqIFtydW4tdGVzdC0xNzFdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9y
IHVuZmluaXNoZWQgam9icy4uLi4KTG9va2luZyBmb3IgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0
YS9hY3BpL3ZpcnQvR1REVCcKVXNpbmcgZXhwZWN0ZWQgZmlsZSAndGVzdHMvZGF0YS9hY3BpL3Zp
cnQvR1REVCcKLS0tClVzaW5nIGV4cGVjdGVkIGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS92aXJ0L0RT
RFQnCnNvY2tldF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJs
ZQoqKgpFUlJPUjouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93
aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMt
PnFtcF9mZCA+PSAwKQouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNjY6IGtpbGxfcWVt
dSgpIHRyaWVkIHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4aXQg
c3RhdHVzIDEgKGV4cGVjdGVkIDApCkVSUk9SIHF0ZXN0LXg4Nl82NDogYmlvcy10YWJsZXMtdGVz
dCAtIEJhaWwgb3V0ISBFUlJPUjouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRl
c3RfaW5pdF93aXRob3V0X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+
PSAwICYmIHMtPnFtcF9mZCA+PSAwKQptYWtlOiAqKiogW3J1bi10ZXN0LTEzOF0gRXJyb3IgMQog
IFRFU1QgICAgaW90ZXN0LXFjb3cyOiAwMTMKCkxvb2tpbmcgZm9yIGV4cGVjdGVkIGZpbGUgJ3Rl
c3RzL2RhdGEvYWNwaS92aXJ0L0ZBQ1AubnVtYW1lbScKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNv
dzI6IDAxOApzb2NrZXRfYWNjZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFp
bGFibGUKKioKRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2lu
aXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAm
JiBzLT5xbXBfZmQgPj0gMCkKLi4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxs
X3FlbXUoKSB0cmllZCB0byB0ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBl
eGl0IHN0YXR1cyAxIChleHBlY3RlZCAwKQpFUlJPUiBxdGVzdC14ODZfNjQ6IHB4ZS10ZXN0IC0g
QmFpbCBvdXQhIEVSUk9SOi4uL3NyYy90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjMwMTpxdGVzdF9p
bml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0aW9uIGZhaWxlZDogKHMtPmZkID49IDAg
JiYgcy0+cW1wX2ZkID49IDApCm1ha2U6ICoqKiBbcnVuLXRlc3QtMTEwXSBFcnJvciAxCnNvY2tl
dF9hY2NlcHQgZmFpbGVkOiBSZXNvdXJjZSB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQoqKgpFUlJP
UjouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0X3Ft
cF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9mZCA+
PSAwKQouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzoxNjY6IGtpbGxfcWVtdSgpIHRyaWVk
IHRvIHRlcm1pbmF0ZSBRRU1VIHByb2Nlc3MgYnV0IGVuY291bnRlcmVkIGV4aXQgc3RhdHVzIDEg
KGV4cGVjdGVkIDApCkVSUk9SIHF0ZXN0LXg4Nl82NDogbWlncmF0aW9uLXRlc3QgLSBCYWlsIG91
dCEgRVJST1I6Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0
aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5x
bXBfZmQgPj0gMCkKbWFrZTogKioqIFtydW4tdGVzdC0xNDhdIEVycm9yIDEKICBURVNUICAgIGlv
dGVzdC1xY293MjogMDE5CiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyMAogIFRFU1QgICAgaW90
ZXN0LXFjb3cyOiAwMjEKLS0tCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDAyNApzb2NrZXRfYWNj
ZXB0IGZhaWxlZDogUmVzb3VyY2UgdGVtcG9yYXJpbHkgdW5hdmFpbGFibGUKKioKRVJST1I6Li4v
c3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFu
ZHNoYWtlOiBhc3NlcnRpb24gZmFpbGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkK
Li4vc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0ZXN0LmM6MTY2OiBraWxsX3FlbXUoKSB0cmllZCB0byB0
ZXJtaW5hdGUgUUVNVSBwcm9jZXNzIGJ1dCBlbmNvdW50ZXJlZCBleGl0IHN0YXR1cyAxIChleHBl
Y3RlZCAwKQpFUlJPUiBxdGVzdC1hYXJjaDY0OiBtaWdyYXRpb24tdGVzdCAtIEJhaWwgb3V0ISBF
UlJPUjouLi9zcmMvdGVzdHMvcXRlc3QvbGlicXRlc3QuYzozMDE6cXRlc3RfaW5pdF93aXRob3V0
X3FtcF9oYW5kc2hha2U6IGFzc2VydGlvbiBmYWlsZWQ6IChzLT5mZCA+PSAwICYmIHMtPnFtcF9m
ZCA+PSAwKQptYWtlOiAqKiogW3J1bi10ZXN0LTE2NF0gRXJyb3IgMQogIFRFU1QgICAgaW90ZXN0
LXFjb3cyOiAwMjUKCkxvb2tpbmcgZm9yIGV4cGVjdGVkIGZpbGUgJ3Rlc3RzL2RhdGEvYWNwaS92
aXJ0L0ZBQ1AubWVtaHAnCi0tLQogICAgcmFpc2UgQ2FsbGVkUHJvY2Vzc0Vycm9yKHJldGNvZGUs
IGNtZCkKc3VicHJvY2Vzcy5DYWxsZWRQcm9jZXNzRXJyb3I6IENvbW1hbmQgJ1snc3VkbycsICct
bicsICdkb2NrZXInLCAncnVuJywgJy0tcm0nLCAnLS1sYWJlbCcsICdjb20ucWVtdS5pbnN0YW5j
ZS51dWlkPTBkZGJmYTgxY2RmNjQ5MDE4YjJjMTFmMzVhNTJiZTlhJywgJy11JywgJzEwMDEnLCAn
LS1zZWN1cml0eS1vcHQnLCAnc2VjY29tcD11bmNvbmZpbmVkJywgJy1lJywgJ1RBUkdFVF9MSVNU
PScsICctZScsICdFWFRSQV9DT05GSUdVUkVfT1BUUz0nLCAnLWUnLCAnVj0nLCAnLWUnLCAnSj0x
NCcsICctZScsICdERUJVRz0nLCAnLWUnLCAnU0hPV19FTlY9MScsICctZScsICdDQ0FDSEVfRElS
PS92YXIvdG1wL2NjYWNoZScsICctdicsICcvaG9tZS9wYXRjaGV3Ly5jYWNoZS9xZW11LWRvY2tl
ci1jY2FjaGU6L3Zhci90bXAvY2NhY2hlOnonLCAnLXYnLCAnL3Zhci90bXAvcGF0Y2hldy10ZXN0
ZXItdG1wLTBueHZubWZvL3NyYy9kb2NrZXItc3JjLjIwMjAtMDktMjgtMTQuMDkuNDQuMzE1MTQ6
L3Zhci90bXAvcWVtdTp6LHJvJywgJ3FlbXUvY2VudG9zNycsICcvdmFyL3RtcC9xZW11L3J1bics
ICd0ZXN0LXF1aWNrJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDIuCmZpbHRlcj0t
LWZpbHRlcj1sYWJlbD1jb20ucWVtdS5pbnN0YW5jZS51dWlkPTBkZGJmYTgxY2RmNjQ5MDE4YjJj
MTFmMzVhNTJiZTlhCm1ha2VbMV06ICoqKiBbZG9ja2VyLXJ1bl0gRXJyb3IgMQptYWtlWzFdOiBM
ZWF2aW5nIGRpcmVjdG9yeSBgL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTBueHZubWZvL3Ny
YycKbWFrZTogKioqIFtkb2NrZXItcnVuLXRlc3QtcXVpY2tAY2VudG9zN10gRXJyb3IgMgoKcmVh
bCAgICAxN20xNC4xNDZzCnVzZXIgICAgMG0yMi4zMjRzCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWls
YWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDkyODEzMTYzOC45NDg2LTEta3Jh
eGVsQHJlZGhhdC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

