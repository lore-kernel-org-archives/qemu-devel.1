Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C6FC38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 20:46:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0843721473
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 20:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiZdRd6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0843721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQGpe-0005d3-5D
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 16:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40872 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQF0t-00074i-Tp
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:49:56 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <igotti@gmail.com>) id 1jQF0t-0003vX-C9
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:49:55 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:41638)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <igotti@gmail.com>) id 1jQF0s-0003lo-S4
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 14:49:55 -0400
Received: by mail-lf1-x131.google.com with SMTP id u10so6031453lfo.8
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2020 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=Z2LbNe/Tu+L4zwlPq2h4g7NIrXxdN73k1tz+wyfWJkk=;
 b=DiZdRd6LZ+3BmHLHQrbigWntgPv9PIp7GEo7L+AZDuNVJ2ClpdVY1w1iNPl2LAf4MB
 +wfN/eMFlJCU4B6XRg6afKmUPC7+m/wxFF4rs86DihF2/u9tCqWBGH60MjxhKA+UrDXu
 Xhe9qiSu/mtm/Ju12GWuyyxsQYq+uDq8Q2b5wRF/NxMAGTiwsq4mQAZssb1KvCpZasoC
 Xskc9yi/sz88bzjmuCpTH8FIz2GKJhV5/U4Xx5ZpnvH8EYerWar1AP7TO8d+3IFDNoA6
 eK8dCzpJ8kdwP0NcbpGPVuqS2lzJp8Phu56IMsxU1twZJwj15+VJ3T2jRRc5aDYQCBWF
 GbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=Z2LbNe/Tu+L4zwlPq2h4g7NIrXxdN73k1tz+wyfWJkk=;
 b=XSI73Zb8uFymPB0Dixa0AlFz0qhHwDryOuST2k9sR1f8cXePx2dK4kqe+EX/Z37gzR
 GSXp8ZdiX5dUTqnazST2shqtYJfKYr6U4EeOiCqeM8wlJ9YOkb83/tKO/HjLXbO+ciw1
 LgxD2aFmR03JZthwCFxir6jgbGj//WzXF1buXF2E4jRAFoGHsAt2FGR2MHU4Ln6+1tHa
 V+saa1UB0rHBhaCJTJey2gOtFDng74+889G5gDz7pzmod0l02TMPDKk5bj0Pp/da0zu2
 SvHOTcQVXyMrRxzuVYwjr2R4OPQx1x4CtgQFJrcVNAEGUSyshgXKOq2qv2X9SfbqEKNB
 h8dg==
X-Gm-Message-State: AGi0PuY6tzDrlw+ZHVLJVPOkpcCCchC9KWF0Vl6BrCYktDeayW9edPoM
 HQVQJ/wp9galwbWUglWVuUU7ovGXaDhftIzcKKM=
X-Google-Smtp-Source: APiQypJ6F8To8/Vqy8vewIS0DUDdMPqf+x+uihSeBL1g7Za2sisacc2grATXn2VB1czhgwf41GD5odRhmx762VvC+14=
X-Received: by 2002:a19:f611:: with SMTP id x17mr8379668lfe.51.1587322192383; 
 Sun, 19 Apr 2020 11:49:52 -0700 (PDT)
MIME-Version: 1.0
From: Nikolay Igotti <igotti@gmail.com>
Date: Sun, 19 Apr 2020 21:49:41 +0300
Message-ID: <CAEme+7GBNRc+Lc2QP894ZmYDaoC-hpDxvvUDx+mMuXGOfOxiNw@mail.gmail.com>
Subject: several patches around Linux userland emulator
To: riku.voipio@iki.fi, laurent@vivier.eu
Content-Type: multipart/mixed; boundary="0000000000006c090205a3a93f6e"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=igotti@gmail.com; helo=mail-lf1-x131.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::131
X-Mailman-Approved-At: Sun, 19 Apr 2020 16:45:36 -0400
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006c090205a3a93f6e
Content-Type: multipart/alternative; boundary="0000000000006c090105a3a93f6c"

--0000000000006c090105a3a93f6c
Content-Type: text/plain; charset="UTF-8"

   Hi,

Attached 3 relatively trivial patches helping with running userland Linux
emulation.

  Best regards,
    Nikolay

--0000000000006c090105a3a93f6c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 =C2=A0Hi,<div><br></div><div>Attached 3 relatively =
trivial patches helping with running userland Linux emulation.</div><div><b=
r></div><div>=C2=A0 Best regards,</div><div>=C2=A0 =C2=A0 Nikolay</div><div=
>=C2=A0</div></div>

--0000000000006c090105a3a93f6c--

--0000000000006c090205a3a93f6e
Content-Type: application/octet-stream; 
	name="0001-plugins-avoid-failing-plugin-when-CPU-is-inited-seve.patch"
Content-Disposition: attachment; 
	filename="0001-plugins-avoid-failing-plugin-when-CPU-is-inited-seve.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k97ellv40>
X-Attachment-Id: f_k97ellv40

RnJvbSA0MGE1NGY0ZThmMTcyNjYxMzdlZDUwYTQ4MzFkNDg0MDlhNGQ1ZjNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGF5IElnb3R0aSA8aWdvdHRpQGdtYWlsLmNvbT4KRGF0
ZTogU3VuLCAxOSBBcHIgMjAyMCAyMTo0MzozNCArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIHBsdWdp
bnM6IGF2b2lkIGZhaWxpbmcgcGx1Z2luIHdoZW4gQ1BVIGlzIGluaXRlZCBzZXZlcmFsCiB0aW1l
cwoKSW4gbGludXgtdXNlciBtdWx0aXRocmVhZGVkIHNjZW5hcmlvdXMgQ1BVIGNvdWxkIGJlIGlu
aXRlZCBtYW55IHRpbWVzIHdpdGggdGhlIHNhbWUgaWQsCnNvIGF2b2lkIGFzc2VydGlvbnMgb24g
YWxyZWFkeSBwcmVzZW50IGhhc2h0YWJsZSBlbnRyeS4KLS0tCiBwbHVnaW5zL2NvcmUuYyB8IDUg
Ky0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9wbHVnaW5zL2NvcmUuYyBiL3BsdWdpbnMvY29yZS5jCmluZGV4IDUxYmZjOTQ3
ODcuLjg4OWNjNjQ0MWEgMTAwNjQ0Ci0tLSBhL3BsdWdpbnMvY29yZS5jCisrKyBiL3BsdWdpbnMv
Y29yZS5jCkBAIC0xOTYsMTMgKzE5NiwxMCBAQCBwbHVnaW5fcmVnaXN0ZXJfY2JfdWRhdGEocWVt
dV9wbHVnaW5faWRfdCBpZCwgZW51bSBxZW11X3BsdWdpbl9ldmVudCBldiwKIAogdm9pZCBxZW11
X3BsdWdpbl92Y3B1X2luaXRfaG9vayhDUFVTdGF0ZSAqY3B1KQogewotICAgIGJvb2wgc3VjY2Vz
czsKLQogICAgIHFlbXVfcmVjX211dGV4X2xvY2soJnBsdWdpbi5sb2NrKTsKICAgICBwbHVnaW5f
Y3B1X3VwZGF0ZV9fbG9ja2VkKCZjcHUtPmNwdV9pbmRleCwgTlVMTCwgTlVMTCk7Ci0gICAgc3Vj
Y2VzcyA9IGdfaGFzaF90YWJsZV9pbnNlcnQocGx1Z2luLmNwdV9odCwgJmNwdS0+Y3B1X2luZGV4
LAorICAgIGdfaGFzaF90YWJsZV9pbnNlcnQocGx1Z2luLmNwdV9odCwgJmNwdS0+Y3B1X2luZGV4
LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZjcHUtPmNwdV9pbmRleCk7Ci0g
ICAgZ19hc3NlcnQoc3VjY2Vzcyk7CiAgICAgcWVtdV9yZWNfbXV0ZXhfdW5sb2NrKCZwbHVnaW4u
bG9jayk7CiAKICAgICBwbHVnaW5fdmNwdV9jYl9fc2ltcGxlKGNwdSwgUUVNVV9QTFVHSU5fRVZf
VkNQVV9JTklUKTsKLS0gCjIuMjQuMiAoQXBwbGUgR2l0LTEyNykKCg==
--0000000000006c090205a3a93f6e
Content-Type: application/octet-stream; 
	name="0001-linux-user-fix-page-table-trashing-when-mmap-munmap-.patch"
Content-Disposition: attachment; 
	filename="0001-linux-user-fix-page-table-trashing-when-mmap-munmap-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k97ellw82>
X-Attachment-Id: f_k97ellw82

RnJvbSAzNTYxMzIxMTFkNjkwYTRjOWVlNzQ0OTA4MDVlNmNmYjEzNGRiYTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGF5IElnb3R0aSA8aWdvdHRpQGdtYWlsLmNvbT4KRGF0
ZTogU3VuLCAxOSBBcHIgMjAyMCAyMTozMTo0MSArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4
LXVzZXI6IGZpeCBwYWdlIHRhYmxlIHRyYXNoaW5nIHdoZW4gbW1hcC9tdW5tYXAgY2FsbGVkCiBm
cmVxdWVudGx5IG9uIGxhcmdlIHJlZ2lvbnMKClNvbWUgYXBwbGljYXRpb25zLCBmb3IgZXhhbXBs
ZSBXYXNtZXIgV2ViQXNzZW1ibHkgVk0sIHBlcmZvcm0gZnJlcXVlbnQgbWFwL3VubWFwIG9mCmh1
Z2UgKDZHKSByZWdpb25zLCBzbyB3aGVuIGV4ZWN1dGVkIHVuZGVyIGxpbnV4LXVzZXIgaXQgbGVh
ZHMgdG8gY3JlYXRpb24gb2YgbWFueSBQVEUvUERFCmZvciB0aGUgcmVnaW9uLCBhbmQgdGhleSBu
ZXZlciBnZXQgcmVjbGFpbWVkLiBBcyByZXN1bHQsIGVtdWxhdG9yIHByb2Nlc3MgY29uc3VtZXMg
YSBsb3QKb2YgUkFNLiBUbyBmaXggdGhpcyBwcm9ibGVtIHdlIHRyeSB0byByZXVzZSBWTUEsIHdo
ZW4gcG9zc2libGUuCi0tLQogbGludXgtdXNlci9tbWFwLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9tbWFwLmMgYi9saW51
eC11c2VyL21tYXAuYwppbmRleCBlMzc4MDMzNzk3Li5jMWQ2MTYzZDdhIDEwMDY0NAotLS0gYS9s
aW51eC11c2VyL21tYXAuYworKysgYi9saW51eC11c2VyL21tYXAuYwpAQCAtNjUwLDYgKzY1MCw4
IEBAIGludCB0YXJnZXRfbXVubWFwKGFiaV91bG9uZyBzdGFydCwgYWJpX3Vsb25nIGxlbikKICAg
ICBpZiAocmV0ID09IDApIHsKICAgICAgICAgcGFnZV9zZXRfZmxhZ3Moc3RhcnQsIHN0YXJ0ICsg
bGVuLCAwKTsKICAgICAgICAgdGJfaW52YWxpZGF0ZV9waHlzX3JhbmdlKHN0YXJ0LCBzdGFydCAr
IGxlbik7CisgICAgICAgIGlmIChzdGFydCA8IG1tYXBfbmV4dF9zdGFydCkKKyAgICAgICAgICAg
IG1tYXBfbmV4dF9zdGFydCA9IHN0YXJ0OwogICAgIH0KICAgICBtbWFwX3VubG9jaygpOwogICAg
IHJldHVybiByZXQ7Ci0tIAoyLjI0LjIgKEFwcGxlIEdpdC0xMjcpCgo=
--0000000000006c090205a3a93f6e
Content-Type: application/octet-stream; 
	name="0001-linux-user-strace-better-format-mmap-logs-support-mr.patch"
Content-Disposition: attachment; 
	filename="0001-linux-user-strace-better-format-mmap-logs-support-mr.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k97ellw11>
X-Attachment-Id: f_k97ellw11

RnJvbSA3MGY5MTg2ZTMwYmU0YWYyMDZmZTg5Zjg4MmE4MGJiOTE0ZWIyZjJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWtvbGF5IElnb3R0aSA8aWdvdHRpQGdtYWlsLmNvbT4KRGF0
ZTogU3VuLCAxOSBBcHIgMjAyMCAyMTo0MTowNCArMDMwMApTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4
LXVzZXI6IHN0cmFjZTogYmV0dGVyIGZvcm1hdCBtbWFwIGxvZ3MsIHN1cHBvcnQgbXJlbWFwCgpP
biA2NC1iaXQgcGxhdGZvcm1zIHN0cmFjZSBlbnRyaWVzIHdlcmUgbm90IHByb3Blcmx5IGZvcm1h
dHRlZCwgYWxzbyBzb21lIGFkZHJlc3NlcyB3ZXJlIHByaW50ZWQgYXMgaW50ZWdlcnMuCkFsc28g
bXJlbWFwIHN5c2NhbGwgc3VwcG9ydCBpcyBhZGRlZC4KLS0tCiBsaW51eC11c2VyL3N0cmFjZS5j
ICAgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQogbGludXgtdXNlci9zdHJh
Y2UubGlzdCB8ICAyICstCiAyIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDUgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9zdHJhY2UuYyBiL2xpbnV4LXVzZXIv
c3RyYWNlLmMKaW5kZXggMGQ5MDk1YzY3NC4uM2U2NWZmZTM1NiAxMDA2NDQKLS0tIGEvbGludXgt
dXNlci9zdHJhY2UuYworKysgYi9saW51eC11c2VyL3N0cmFjZS5jCkBAIC05NjksNiArOTY5LDE0
IEBAIFVOVVNFRCBzdGF0aWMgc3RydWN0IGZsYWdzIG1tYXBfZmxhZ3NbXSA9IHsKICAgICBGTEFH
X0VORCwKIH07CiAKKyNpZmRlZiBUQVJHRVRfTlJfbXJlbWFwCitVTlVTRUQgc3RhdGljIHN0cnVj
dCBmbGFncyBtcmVtYXBfZmxhZ3NbXSA9IHsKKyAgICBGTEFHX0dFTkVSSUMoTVJFTUFQX01BWU1P
VkUpLAorICAgIEZMQUdfR0VORVJJQyhNUkVNQVBfRklYRUQpLAorICAgIEZMQUdfRU5ELAorfTsK
KyNlbmRpZgorCiBVTlVTRUQgc3RhdGljIHN0cnVjdCBmbGFncyBjbG9uZV9mbGFnc1tdID0gewog
ICAgIEZMQUdfR0VORVJJQyhDTE9ORV9WTSksCiAgICAgRkxBR19HRU5FUklDKENMT05FX0ZTKSwK
QEAgLTI2NTQsMTEgKzI2NjIsMTEgQEAgcHJpbnRfbW1hcChjb25zdCBzdHJ1Y3Qgc3lzY2FsbG5h
bWUgKm5hbWUsCiB7CiAgICAgcHJpbnRfc3lzY2FsbF9wcm9sb2d1ZShuYW1lKTsKICAgICBwcmlu
dF9wb2ludGVyKGFyZzAsIDApOwotICAgIHByaW50X3Jhd19wYXJhbSgiJWQiLCBhcmcxLCAwKTsK
KyAgICBwcmludF9yYXdfcGFyYW0oIiVsbGQiLCAobG9uZyBsb25nKWFyZzEsIDApOwogICAgIHBy
aW50X2ZsYWdzKG1tYXBfcHJvdF9mbGFncywgYXJnMiwgMCk7CiAgICAgcHJpbnRfZmxhZ3MobW1h
cF9mbGFncywgYXJnMywgMCk7CiAgICAgcHJpbnRfcmF3X3BhcmFtKCIlZCIsIGFyZzQsIDApOwot
ICAgIHByaW50X3Jhd19wYXJhbSgiJSN4IiwgYXJnNSwgMSk7CisgICAgcHJpbnRfcmF3X3BhcmFt
KCIlI2xseCIsIChsb25nIGxvbmcpYXJnNSwgMSk7CiAgICAgcHJpbnRfc3lzY2FsbF9lcGlsb2d1
ZShuYW1lKTsKIH0KICNkZWZpbmUgcHJpbnRfbW1hcDIgICAgIHByaW50X21tYXAKQEAgLTI2NzIs
MTIgKzI2ODAsMjcgQEAgcHJpbnRfbXByb3RlY3QoY29uc3Qgc3RydWN0IHN5c2NhbGxuYW1lICpu
YW1lLAogewogICAgIHByaW50X3N5c2NhbGxfcHJvbG9ndWUobmFtZSk7CiAgICAgcHJpbnRfcG9p
bnRlcihhcmcwLCAwKTsKLSAgICBwcmludF9yYXdfcGFyYW0oIiVkIiwgYXJnMSwgMCk7CisgICAg
cHJpbnRfcmF3X3BhcmFtKCIlbGxkIiwgKGxvbmcgbG9uZylhcmcxLCAwKTsKICAgICBwcmludF9m
bGFncyhtbWFwX3Byb3RfZmxhZ3MsIGFyZzIsIDEpOwogICAgIHByaW50X3N5c2NhbGxfZXBpbG9n
dWUobmFtZSk7CiB9CiAjZW5kaWYKIAorI2lmZGVmIFRBUkdFVF9OUl9tcmVtYXAKK3N0YXRpYyB2
b2lkCitwcmludF9tcmVtYXAoY29uc3Qgc3RydWN0IHN5c2NhbGxuYW1lICpuYW1lLAorICAgIGFi
aV9sb25nIGFyZzAsIGFiaV9sb25nIGFyZzEsIGFiaV9sb25nIGFyZzIsCisgICAgYWJpX2xvbmcg
YXJnMywgYWJpX2xvbmcgYXJnNCwgYWJpX2xvbmcgYXJnNSkKK3sKKyAgICBwcmludF9zeXNjYWxs
X3Byb2xvZ3VlKG5hbWUpOworICAgIHByaW50X3BvaW50ZXIoYXJnMCwgMCk7CisgICAgcHJpbnRf
cmF3X3BhcmFtKCIlbGxkIiwgKGxvbmcgbG9uZylhcmcxLCAwKTsKKyAgICBwcmludF9yYXdfcGFy
YW0oIiVsbGQiLCAobG9uZyBsb25nKWFyZzIsIDApOworICAgIHByaW50X2ZsYWdzKG1yZW1hcF9m
bGFncywgYXJnMywgMSk7CisgICAgcHJpbnRfc3lzY2FsbF9lcGlsb2d1ZShuYW1lKTsKK30KKyNl
bmRpZgorCiAjaWZkZWYgVEFSR0VUX05SX211bm1hcAogc3RhdGljIHZvaWQKIHByaW50X211bm1h
cChjb25zdCBzdHJ1Y3Qgc3lzY2FsbG5hbWUgKm5hbWUsCkBAIC0yNjg2LDcgKzI3MDksNyBAQCBw
cmludF9tdW5tYXAoY29uc3Qgc3RydWN0IHN5c2NhbGxuYW1lICpuYW1lLAogewogICAgIHByaW50
X3N5c2NhbGxfcHJvbG9ndWUobmFtZSk7CiAgICAgcHJpbnRfcG9pbnRlcihhcmcwLCAwKTsKLSAg
ICBwcmludF9yYXdfcGFyYW0oIiVkIiwgYXJnMSwgMSk7CisgICAgcHJpbnRfcmF3X3BhcmFtKCIl
bGxkIiwgKGxvbmcgbG9uZylhcmcxLCAxKTsKICAgICBwcmludF9zeXNjYWxsX2VwaWxvZ3VlKG5h
bWUpOwogfQogI2VuZGlmCmRpZmYgLS1naXQgYS9saW51eC11c2VyL3N0cmFjZS5saXN0IGIvbGlu
dXgtdXNlci9zdHJhY2UubGlzdAppbmRleCBkNDlhMWU5MmE4Li5iM2JkMWM2MjI5IDEwMDY0NAot
LS0gYS9saW51eC11c2VyL3N0cmFjZS5saXN0CisrKyBiL2xpbnV4LXVzZXIvc3RyYWNlLmxpc3QK
QEAgLTYxMiw3ICs2MTIsNyBAQAogeyBUQVJHRVRfTlJfbXFfdW5saW5rLCAibXFfdW5saW5rIiAs
IE5VTEwsIHByaW50X21xX3VubGluaywgTlVMTCB9LAogI2VuZGlmCiAjaWZkZWYgVEFSR0VUX05S
X21yZW1hcAoteyBUQVJHRVRfTlJfbXJlbWFwLCAibXJlbWFwIiAsIE5VTEwsIE5VTEwsIE5VTEwg
fSwKK3sgVEFSR0VUX05SX21yZW1hcCwgIm1yZW1hcCIgLCBOVUxMLCBwcmludF9tcmVtYXAsIHBy
aW50X3N5c2NhbGxfcmV0X2FkZHIgfSwKICNlbmRpZgogI2lmZGVmIFRBUkdFVF9OUl9tc2djdGwK
IHsgVEFSR0VUX05SX21zZ2N0bCwgIm1zZ2N0bCIgLCBOVUxMLCBOVUxMLCBOVUxMIH0sCi0tIAoy
LjI0LjIgKEFwcGxlIEdpdC0xMjcpCgo=
--0000000000006c090205a3a93f6e--

