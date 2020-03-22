Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DBC4332E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:24:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6B42072E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="S2ButO8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6B42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG3OS-0000gQ-H8
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jG3Nl-0000EZ-CL
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jG3Nk-000445-06
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:23:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jG3Nj-00043b-N7
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 12:23:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id b2so13620833wrj.10
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 09:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=TlkvLQvZ1qn4FRJTnFFvr/g0Nw5gDr0bOnHpcyROG2A=;
 b=S2ButO8JAa81PXJtqxbWyGYjptfZ5CB/cYyJspS7lHlluh/s41NHlh3ewmYb0Lgz2Z
 3OM9C4lF/hFXLv7qOmz1AS0X+FGDRjPZ31LwyrshCQWyZedNqbEKopscOKzKh5jt0GN+
 B9iGzzmrGUovsiTWpfZ5T/lXZ9VTknEFWymok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=TlkvLQvZ1qn4FRJTnFFvr/g0Nw5gDr0bOnHpcyROG2A=;
 b=mIRuItPTh2oXJwyIOBn8Bom+fS9BvKCI2bzbhxzgfLGEIV8pXZVOaK6aPndoynvc2T
 DFl/hmK14wwq6I/tW5reAMXplDsyJ6c4sH0EqF2Wq5o66HRtTGQvRwoFfjZaJQvZrlyW
 Ssw1cvK7I4GV+NNQ5y4izSVVrUYBjm4zBsmaMOFDNFxwBEAlqE1cWlCrWwp5tNuhUwze
 /YqzDkb5JYewxL8fFHDtCgAbdw20KDF7u5h6FqgNn91x/azY2C02J3tMBvkrq/cxkHY9
 RglKicHAxeDnR7qb6C+zmEvFnZhn+FUp30gO8zW6UCFjBRVQYc9f+OkUo3HVtyBE5UFo
 noOA==
X-Gm-Message-State: ANhLgQ3KiyI6F+uG80ruvxwMJESdm1VydaDZ4WIMqi5JdeC7VlEXW8HD
 c+Bsolw4NIDsNhHUrkQ0E9oLuPBZt/20+qlCZUpgstftbZURow==
X-Google-Smtp-Source: ADFU+vusOYfEHscebN0/sfwwboqo4vauju1iGjK67cJvWauo7zkc4SxyMKn+3gjLR5I6pwiHhYgPMa8cx/Yb+hpgAqY=
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr24729416wrn.275.1584894202031; 
 Sun, 22 Mar 2020 09:23:22 -0700 (PDT)
MIME-Version: 1.0
From: Derek Su <dereksu@qnap.com>
Date: Mon, 23 Mar 2020 00:23:10 +0800
Message-ID: <CAKEOLWWbuZ5HmETnvQjfOftSJ9TEs=FnjvDAGJd02r_7U64RWg@mail.gmail.com>
Subject: [PATCH 1/1] net/colo-compare.c: Fix memory leak in packet_enqueue()
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000eb455505a173ef40"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: chen.zhang@intel.com, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eb455505a173ef40
Content-Type: text/plain; charset="UTF-8"

The patch is to fix the "pkt" memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7ee17f2cf8..cdd87b2aa8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -120,6 +120,10 @@ enum {
     SECONDARY_IN,
 };

+static const char *colo_mode[] = {
+    [PRIMARY_IN] = "primary",
+    [SECONDARY_IN] = "secondary",
+};

 static int compare_chr_send(CompareState *s,
                             const uint8_t *buf,
@@ -215,6 +219,7 @@ static int packet_enqueue(CompareState *s, int mode,
Connection **con)
     ConnectionKey key;




     Packet *pkt = NULL;
     Connection *conn;
+    int ret;

     if (mode == PRIMARY_IN) {
         pkt = packet_new(s->pri_rs.buf,
@@ -243,16 +248,18 @@ static int packet_enqueue(CompareState *s, int mode,
Connection **con)
     }

     if (mode == PRIMARY_IN) {
-        if (!colo_insert_packet(&conn->primary_list, pkt, &conn->pack)) {
-            error_report("colo compare primary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->primary_list, pkt, &conn->pack);
     } else {
-        if (!colo_insert_packet(&conn->secondary_list, pkt, &conn->sack)) {
-            error_report("colo compare secondary queue size too big,"
-                         "drop packet");
-        }
+        ret = colo_insert_packet(&conn->secondary_list, pkt, &conn->sack);
     }
+
+    if (!ret) {
+        error_report("colo compare %s queue size too big,"
+                     "drop packet", colo_mode[mode]);
+        packet_destroy(pkt, NULL);
+        pkt = NULL;
+    }
+
     *con = conn;

     return 0;
-- 
2.17.1

--000000000000eb455505a173ef40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfc2lnbmF0dXJl
IiBkYXRhLXNtYXJ0bWFpbD0iZ21haWxfc2lnbmF0dXJlIj48ZGl2IGRpcj0ibHRyIj48ZGl2IGRp
cj0ibHRyIj48ZGl2IGRpcj0ibHRyIj5UaGUgcGF0Y2ggaXMgdG8gZml4IHRoZSAmcXVvdDtwa3Qm
cXVvdDsgbWVtb3J5IGxlYWsgaW4gcGFja2V0X2VucXVldWUoKS48YnI+VGhlIGFsbG9jYXRlZCAm
cXVvdDtwa3QmcXVvdDsgbmVlZHMgdG8gYmUgZnJlZWQgaWYgdGhlIGNvbG8gY29tcGFyZTxicj5w
cmltYXJ5IG9yIHNlY29uZGFyeSBxdWV1ZSBpcyB0b28gYmlnLjxicj48YnI+U2lnbmVkLW9mZi1i
eTogRGVyZWsgU3UgJmx0OzxhIGhyZWY9Im1haWx0bzpkZXJla3N1QHFuYXAuY29tIj5kZXJla3N1
QHFuYXAuY29tPC9hPiZndDs8YnI+LS0tPGJyPsKgbmV0L2NvbG8tY29tcGFyZS5jIHwgMjMgKysr
KysrKysrKysrKysrLS0tLS0tLS08YnI+wqAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygr
KSwgOCBkZWxldGlvbnMoLSk8YnI+PGJyPmRpZmYgLS1naXQgYS9uZXQvY29sby1jb21wYXJlLmMg
Yi9uZXQvY29sby1jb21wYXJlLmM8YnI+aW5kZXggN2VlMTdmMmNmOC4uY2RkODdiMmFhOCAxMDA2
NDQ8YnI+LS0tIGEvbmV0L2NvbG8tY29tcGFyZS5jPGJyPisrKyBiL25ldC9jb2xvLWNvbXBhcmUu
Yzxicj5AQCAtMTIwLDYgKzEyMCwxMCBAQCBlbnVtIHs8YnI+wqAgwqAgwqBTRUNPTkRBUllfSU4s
PGJyPsKgfTs8YnI+wqA8YnI+K3N0YXRpYyBjb25zdCBjaGFyICpjb2xvX21vZGVbXSA9IHs8YnI+
KyDCoCDCoFtQUklNQVJZX0lOXSA9ICZxdW90O3ByaW1hcnkmcXVvdDssPGJyPisgwqAgwqBbU0VD
T05EQVJZX0lOXSA9ICZxdW90O3NlY29uZGFyeSZxdW90Oyw8YnI+K307PGJyPsKgPGJyPsKgc3Rh
dGljIGludCBjb21wYXJlX2Nocl9zZW5kKENvbXBhcmVTdGF0ZSAqcyw8YnI+wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCB1aW50OF90ICpidWYsPGJyPkBA
IC0yMTUsNiArMjE5LDcgQEAgc3RhdGljIGludCBwYWNrZXRfZW5xdWV1ZShDb21wYXJlU3RhdGUg
KnMsIGludCBtb2RlLCBDb25uZWN0aW9uICoqY29uKTxicj7CoCDCoCDCoENvbm5lY3Rpb25LZXkg
a2V5OyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA8YnI+wqAgwqAgwqBQYWNrZXQgKnBrdCA9IE5V
TEw7PGJyPsKgIMKgIMKgQ29ubmVjdGlvbiAqY29ubjs8YnI+KyDCoCDCoGludCByZXQ7PGJyPsKg
PGJyPsKgIMKgIMKgaWYgKG1vZGUgPT0gUFJJTUFSWV9JTikgezxicj7CoCDCoCDCoCDCoCDCoHBr
dCA9IHBhY2tldF9uZXcocy0mZ3Q7cHJpX3JzLmJ1Ziw8YnI+QEAgLTI0MywxNiArMjQ4LDE4IEBA
IHN0YXRpYyBpbnQgcGFja2V0X2VucXVldWUoQ29tcGFyZVN0YXRlICpzLCBpbnQgbW9kZSwgQ29u
bmVjdGlvbiAqKmNvbik8YnI+wqAgwqAgwqB9PGJyPsKgPGJyPsKgIMKgIMKgaWYgKG1vZGUgPT0g
UFJJTUFSWV9JTikgezxicj4tIMKgIMKgIMKgIMKgaWYgKCFjb2xvX2luc2VydF9wYWNrZXQoJmFt
cDtjb25uLSZndDtwcmltYXJ5X2xpc3QsIHBrdCwgJmFtcDtjb25uLSZndDtwYWNrKSkgezxicj4t
IMKgIMKgIMKgIMKgIMKgIMKgZXJyb3JfcmVwb3J0KCZxdW90O2NvbG8gY29tcGFyZSBwcmltYXJ5
IHF1ZXVlIHNpemUgdG9vIGJpZywmcXVvdDs8YnI+LSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAmcXVvdDtkcm9wIHBhY2tldCZxdW90Oyk7PGJyPi0gwqAgwqAgwqAgwqB9PGJy
PisgwqAgwqAgwqAgwqByZXQgPSBjb2xvX2luc2VydF9wYWNrZXQoJmFtcDtjb25uLSZndDtwcmlt
YXJ5X2xpc3QsIHBrdCwgJmFtcDtjb25uLSZndDtwYWNrKTs8YnI+wqAgwqAgwqB9IGVsc2Ugezxi
cj4tIMKgIMKgIMKgIMKgaWYgKCFjb2xvX2luc2VydF9wYWNrZXQoJmFtcDtjb25uLSZndDtzZWNv
bmRhcnlfbGlzdCwgcGt0LCAmYW1wO2Nvbm4tJmd0O3NhY2spKSB7PGJyPi0gwqAgwqAgwqAgwqAg
wqAgwqBlcnJvcl9yZXBvcnQoJnF1b3Q7Y29sbyBjb21wYXJlIHNlY29uZGFyeSBxdWV1ZSBzaXpl
IHRvbyBiaWcsJnF1b3Q7PGJyPi0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
JnF1b3Q7ZHJvcCBwYWNrZXQmcXVvdDspOzxicj4tIMKgIMKgIMKgIMKgfTxicj4rIMKgIMKgIMKg
IMKgcmV0ID0gY29sb19pbnNlcnRfcGFja2V0KCZhbXA7Y29ubi0mZ3Q7c2Vjb25kYXJ5X2xpc3Qs
IHBrdCwgJmFtcDtjb25uLSZndDtzYWNrKTs8YnI+wqAgwqAgwqB9PGJyPis8YnI+KyDCoCDCoGlm
ICghcmV0KSB7PGJyPisgwqAgwqAgwqAgwqBlcnJvcl9yZXBvcnQoJnF1b3Q7Y29sbyBjb21wYXJl
ICVzIHF1ZXVlIHNpemUgdG9vIGJpZywmcXVvdDs8YnI+KyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAmcXVvdDtkcm9wIHBhY2tldCZxdW90OywgY29sb19tb2RlW21vZGVdKTs8YnI+KyDC
oCDCoCDCoCDCoHBhY2tldF9kZXN0cm95KHBrdCwgTlVMTCk7PGJyPisgwqAgwqAgwqAgwqBwa3Qg
PSBOVUxMOzxicj4rIMKgIMKgfTxicj4rPGJyPsKgIMKgIMKgKmNvbiA9IGNvbm47PGJyPsKgPGJy
PsKgIMKgIMKgcmV0dXJuIDA7PGJyPi0tIDxicj4yLjE3LjE8YnI+PGJyPjwvZGl2PjwvZGl2Pjwv
ZGl2PjwvZGl2PjwvZGl2PjwvZGl2Pg0K
--000000000000eb455505a173ef40--

